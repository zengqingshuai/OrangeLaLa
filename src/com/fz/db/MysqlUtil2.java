package com.fz.db;

import javax.imageio.ImageIO;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by webrx on 2017/4/26.
 */

public class MysqlUtil2 {
    private String driver = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/orange?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private String user = "root";
    private String password = "root";
    private Connection conn = null;
    private  static DataSource ds;

    private int pagesize = 5;
    private  static int pagecount=0;
    private int recordcount = 0;
    private int currpage = 0;


    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public int getPagecount() {
        return pagecount;
    }

    public void setPagecount(int pagecount) {
        this.pagecount = pagecount;
    }

    public int getRecordcount() {
        return recordcount;
    }

    public void setRecordcount(int recordcount) {
        this.recordcount = recordcount;
    }

    public int getCurrpage() {
        return currpage;
    }

    public void setCurrpage(int currpage) {
        this.currpage = currpage;
    }

    public MysqlUtil2() {
        try {
            if (this.ds == null){
                Context ctx = new InitialContext();
                this.ds = (DataSource) ctx.lookup("java:comp/env/mysql");
            }
            this.conn = this.ds.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                Class.forName(this.driver);
                this.conn = DriverManager.getConnection(this.url, this.user, this.password);
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        }
    }
    //分页封装
    public List<Map<String, Object>> page(String tablename, String fidles, String where, String order) {
        List<Map<String, Object>> list = null;
        this.recordcount = this.count(tablename, where);
        this.pagecount = this.recordcount % this.pagesize == 0 ? this.recordcount / this.pagesize : this.recordcount / this.pagesize + 1;
        if (this.currpage < 1) this.currpage = 1;
        if (this.currpage > this.pagecount) this.currpage = this.pagecount;
        try {
            String sql = String.format("select %s from %s %s %s limit ?,?", fidles, tablename, where, order);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setInt(1, this.currpage * this.pagesize - this.pagesize);
            pst.setInt(2, this.pagesize);
            ResultSet re = pst.executeQuery();
            list = new ArrayList<Map<String, Object>>();
            while (re.next()) {
                ResultSetMetaData rsmd = re.getMetaData();
                Map<String, Object> m = new HashMap<String, Object>();
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    String f = rsmd.getColumnLabel(i);
                    m.put(f, re.getObject(f));
                }
                list.add(m);
            }
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //创建百度分页下标
    public String pageInfo() {
        StringBuilder s = new StringBuilder();
        s.append("<div class=\"page\">");
        int start = 1;
        int end = 10;
        if(this.currpage != 1){
            s.append(String.format("<a href=\"?p=%d\">首页</a>", 1));
        }
        if (this.currpage > 1) {
            s.append(String.format("<a href=\"?p=%d\">上一页</a>", this.currpage - 1));
        }
        if (this.currpage >= 6) {
            start = this.currpage - 4;
            end = this.currpage + 3;
            if (this.currpage >= this.pagecount - 4) {
                start = this.pagecount - 9;
                end = this.pagecount;
            }
        }
        if (start<1) start=1;
        for (int i = start; i <= end; i++) {
            if (i > this.pagecount) break;
            if (this.currpage == i) {
                s.append(String.format("<span >%d</span>", i));
                continue;
            }
            s.append(String.format("<a href=\"?p=%d\">%d</a>", i, i));
        }
        if (this.pagecount!=1) {
            s.append(String.format("<a href=\"?p=%d\">下一页</a>", this.currpage + 1));
        }
        if(this.currpage != this.pagecount){
            s.append(String.format("<a href=\"?p=%d\">尾页</a>", this.pagecount));
        }
        //s.append(String.format("<span>共 %d 页 %d 条</span>", this.pagecount, this.recordcount));
        s.append("</div>");
        return s.toString();
    }


    //conn 的get方法
    public Connection getConn() {
        return this.conn;
    }

    // 关闭数据库
    public void close() {
        if (this.conn != null) {
            try {
                this.conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    // 查询总条数
    public int count(String tablename, String where) {
        int sum = 0;
        try {
            String sql = String.format("select count(*) from %s %s", tablename, where);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet re = pst.executeQuery();
            while (re.next()) {
                sum = re.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sum;
    }

  //删除
    public int delete(String tablename, String where) {
        int num = 0;
        try {
            String sql = String.format("delete from %s %s", tablename, where);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            num = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }

    //修改数据
    public int update(String sql, Object[] data) {
        int num = 0;
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            for (int i = 0; i < data.length; i++) {
                pst.setObject(i + 1, data[i]);
            }
            num = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }
//修改
    public int update(String sql) {
        int num = 0;
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            num = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }
//缩略图
    public void thumb(String image,int newWidth,String newNAME){
        try {
            BufferedImage i = ImageIO.read(new File(image));//原图
            int w =i.getWidth();//原图宽
            int h =i.getHeight();//原图高
//            double d= .5;
//            int ww = (int) (w*d);
//            int hh = (int) (h*d);
            int ww =newWidth;//新图宽
            int hh= (int)(h*((double)ww/w));//新图高
            BufferedImage ii = new BufferedImage(ww,hh,1);
            Graphics2D g = (Graphics2D) ii.getGraphics();
            g.drawImage(i,0,0,ww,hh,0,0,w,h,null);
            ImageIO.write(ii,"jpeg",new File(newNAME));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
//新增

    public String pageIn(int r) {
        StringBuilder s = new StringBuilder();
        s.append("<div class=\"page\">");
        int start = 1;
        int end = 10;
        if(this.currpage != 1){
            s.append(String.format("<a href=\"?p"+r+"=%d\">首页</a>", 1));
        }
        if (this.currpage > 1) {
            s.append(String.format("<a href=\"?p"+r+"=%d\">上一页</a>", this.currpage - 1));
        }
        if (this.currpage >= 6) {
            start = this.currpage - 4;
            end = this.currpage + 3;
            if (this.currpage >= this.pagecount - 4) {
                start = this.pagecount - 9;
                end = this.pagecount;
            }
        }
        if (start<1) start=1;
        for (int i = start; i <= end; i++) {
            if (i > this.pagecount) break;
            if (this.currpage == i) {
                s.append(String.format("<span >%d</span>", i));
                continue;
            }
            s.append(String.format("<a href=\"?p"+r+"=%d\">%d</a>", i, i));
        }
        if (this.pagecount!=1) {
            s.append(String.format("<a href=\"?p"+r+"=%d\">下一页</a>", this.currpage + 1));
        }
        if(this.currpage != this.pagecount){
            s.append(String.format("<a href=\"?p"+r+"=%d\">尾页</a>", this.pagecount));
        }
        s.append(String.format("<span>共 %d 页 %d 条</span>", this.pagecount, this.recordcount));
        s.append("</div>");
        return s.toString();
    }






}

