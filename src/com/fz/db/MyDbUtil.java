package com.fz.db;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.security.MessageDigest;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by webrx on 2017-04-24.
 */
public class MyDbUtil {
    private String driver = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/orange?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private String user = "root";
    private String password = "root";
    private Connection conn = null;
    private int pagesize = 5;
    private int pagecount = 0;
    private int recordcount = 0;
    private int currpage = 1;
    private static DataSource ds;

    public String getPass(String pass, String name) {
        String p = pass + name;
        StringBuilder ps1 = new StringBuilder();
        try {
            MessageDigest md = MessageDigest.getInstance("SHA1");
            md.update(p.getBytes());
            for (byte b : md.digest()) ps1.append(String.format("%x", b));
        } catch (Exception e) {
            e.printStackTrace();
        }

        StringBuilder ps2 = new StringBuilder();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(p.getBytes());
            for (byte b : md.digest()) ps2.append(String.format("%x", b));
        } catch (Exception e) {
            e.printStackTrace();
        }

        StringBuilder ps = new StringBuilder();
        ps.append(ps1.subSequence(0, 5));
        ps.append(ps2.subSequence(0, 5));
        ps.append(ps1.subSequence(10, 15));
        ps.append(ps2.subSequence(10, 15));
        ps.append(ps1.subSequence(15, 21));
        ps.append(ps2.subSequence(20, 26));
        return ps.toString().toLowerCase();
    }


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

    public MyDbUtil() {
        try {
            if (this.ds == null){
                Context ctx = new InitialContext();
                ds = (DataSource) ctx.lookup("java:comp/env/mysql");
            }
            this.conn = ds.getConnection();
        }catch(Exception e){
            try {
                Class.forName(this.driver);
                this.conn = DriverManager.getConnection(this.url, this.user, this.password);
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
    }

    public Connection getConn() {
        try {
            if(this.ds==null) {
                Context ctx = new InitialContext();
                this.ds = (DataSource) ctx.lookup("java:comp/env/mysql");
            }
            this.conn = ds.getConnection();
        }catch(Exception e){
            try {
                Class.forName(this.driver);
                this.conn = DriverManager.getConnection(this.url, this.user, this.password);
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        return this.conn;
    }

    public void close() {
        if (this.conn != null) {
            try {
                this.conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public int insert(String sql, Object[] param) {
        int num = 0;
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            for (int i = 1; i <= param.length; i++) {
                pst.setObject(i, param[i - 1]);
            }
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }

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

    public int update(String tablename, Map<String, Object> data) {
        String pk = this.getPk(tablename);
        String where = "where 1=1";
        if (data.containsKey(pk)) {
            where = String.format("where %s='%s'", pk, data.get(pk));
        }
        data.remove(pk);
        return this.update(tablename, data, where);
    }

    public int update(String tablename, Map<String, Object> data, String where) {
        int num = 0;
        StringBuilder s = new StringBuilder();
        for (String key : data.keySet()) {
            s.append(key + "=?,");
        }
        String dd = s.substring(0, s.length() - 1);
        String sql = String.format("update %s set %s %s", tablename, dd, where);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            int i = 1;
            for (String key : data.keySet()) {
                pst.setObject(i++, data.get(key));
            }
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }


    public String getPk(String tablename) {
        String pk = null;
        try {
            String sql = String.format("show full columns from %s", tablename);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                if ("PRI".equals(rs.getString("Key"))) {
                    pk = rs.getString("Field");
                    break;
                }
            }
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pk;
    }


    public int deleteById(String tablename, Object id) {
        int num = 0;
        try {
            String sql = String.format("delete from %s where %s=?", tablename, getPk(tablename));
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setObject(1, id);
            num = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }

    public int delete(String tablename) {
        return this.delete(tablename, "where 1=1");
    }

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

    public boolean exists(String tablename, String where) {
        boolean flag = false;
        try {
            String sql = String.format("select count(*) from %s %s", tablename, where);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) > 0) flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public int count(String tablename, String where) {
        int num = 0;
        try {
            String sql = String.format("select count(*) from %s %s", tablename, where);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                num = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }


    public Object queryByField(String tablename, String field, String where) {
        Object obj = null;
        try {
            String sql = String.format("select %s from %s %s", field, tablename, where);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.isBeforeFirst()) {
                rs.next();
                obj = rs.getObject(field);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return obj;
    }



    public List<Map<String, Object>> page(String tablename, String fields, String where, String order) {
        List<Map<String, Object>> list = null;
        this.recordcount = this.count(tablename, where);
        this.pagecount = this.recordcount % this.pagesize == 0 ? this.recordcount / this.pagesize : this.recordcount / this.pagesize + 1;
        if (this.currpage < 1) this.currpage = 1;
        if (this.currpage > this.pagecount) this.currpage = this.pagecount;
        try {
            String sql = String.format("select %s from %s %s %s limit ?,?", fields, tablename, where, order);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setInt(1, this.currpage * this.pagesize - this.pagesize);
            pst.setInt(2, this.pagesize);
            ResultSet rs = pst.executeQuery();
            list = this.ok(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String pageBootStrap() {
        StringBuilder s = new StringBuilder();
        s.append("<ul class=\"pagination\">");
        int start = 1;
        int end = 10;
        if (this.currpage >= 7) {
            start = this.currpage - 5;
            end = this.currpage + 4;
            if (this.currpage >= this.pagecount - 4) {
                start = this.pagecount - 9;
                end = this.pagecount;
            }
        }
        if (this.currpage == 1) {
            s.append(String.format("<li class=\"disabled\"><a href=\"javascript:void(0)\">上一页</a></li>"));

        } else {
            s.append(String.format("<li><a href=\"?p=%d\">上一页</a></li>", this.currpage - 1));
        }
        for (int i = start; i <= end; i++) {
            if (i > this.pagecount) break;
            if (this.currpage == i) {
                s.append(String.format("<li class=\"active\"><a href=\"?p=%d\">%d</a></li>", i, i));
                continue;
            }
            s.append(String.format("<li><a href=\"?p=%d\">%d</a></li>", i, i));
        }
        s.append("</ul>");
        return s.toString();
    }

    public String pageInfo() {
        StringBuilder s = new StringBuilder();
        s.append("<div class=\"page\">");
        int start = 1;
        int end = 10;
        if (this.currpage > 1) {
            s.append(String.format("<a href=\"?p=%d\">上一页</a>", this.currpage - 1));
        }

        if (this.currpage >= 7) {
            start = this.currpage - 5;
            end = this.currpage + 4;
            if (this.currpage >= this.pagecount - 4) {
                start = this.pagecount - 9;
                end = this.pagecount;
            }
        }

        if (start < 1) start = 1;
        for (int i = start; i <= end; i++) {
            if (i > this.pagecount) {
                break;
            }

            if (this.currpage == i) {
                s.append(String.format("<span>%d</span>", i));
                continue;
            }
            s.append(String.format("<a href=\"?p=%d\">%d</a>", i, i));
        }
        s.append(String.format("<a href=\"?p=%d\">下一页</a>", this.currpage + 1));
        s.append(String.format("<span>共 %d 页 %d 条</span>", this.pagecount, this.recordcount));
        s.append("</div>");
        return s.toString();
    }

    public List<Map<String, Object>> ok(ResultSet rs) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        try {
            while (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                Map<String, Object> mm = new HashMap<String, Object>();
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    String f = rsmd.getColumnLabel(i);
                    mm.put(f, rs.getObject(f));
                }
                list.add(mm);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * @param tablename 表名
     * @param fields    显示字段数
     * @param where     条件
     * @param order     排序
     * @param limit     限制行数
     * @return
     */
    public List<Map<String, Object>> query(String tablename, String fields, String where, String order, String limit) {
        List<Map<String, Object>> list = null;
        try {
            String sql = String.format("select %s from %s %s %s %s", fields, tablename, where, order, limit);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.isBeforeFirst()) {
                list = this.ok(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
