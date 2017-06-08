package com.fz.db;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.util.*;

public class ConnMysql {

    private String driver = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/orange?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private String user = "root";
    private String password = "root";
    private Connection conn = null;
    private int pageSize = 5;
    private int pageCount = 0;
    private int rowCount = 0;
    private int currentPage = 1;
    private  static DataSource ds;

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public ConnMysql() {
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

    /**
     * 关闭连接
     */
    public void closeConnection() {
        try {
            if (this.conn!=null) {
                this.conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 关闭pst资源
     *
     * @param pst
     */
    public void closePST(PreparedStatement pst) {
        try {
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加数据
     *
     * @param sql
     * @param param
     * @return
     */
    public int insertInto(String sql, Object[] param) {
        int num = 0;
        PreparedStatement pst = null;
        try {
            pst = this.conn.prepareStatement(sql);
            for (int i = 1; i <= param.length; i++) {
                pst.setObject(i, param[i - 1]);
            }
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closePST(pst);
        }
        return num;
    }

    /**
     * 获取主键
     *
     * @param tableName 表名
     * @return
     */
    public String getPK(String tableName) {
        String pk = null;
        PreparedStatement pst = null;
        try {
            String sql = String.format("show full columns from %s", tableName);
            pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                if ("PRI".equals(rs.getString("Key"))) {
                    pk = rs.getString("Field");
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closePST(pst);
        }
        return pk;
    }

    /**
     * 删除数据
     *
     * @param tableName 表名
     * @param condition 条件
     * @return
     */
    public int delete(String tableName, String condition) {
        int num = 0;
        PreparedStatement pst = null;
        try {
            String sql = String.format("delete from %s %s", tableName, condition);
            pst = this.conn.prepareStatement(sql);
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closePST(pst);
        }
        return num;
    }

    /**
     * 通过主键删除数据
     *
     * @param tableName 表名
     * @param id        查询id
     * @return
     */
    public int deleteById(String tableName, Object id) {
        int num = 0;
        PreparedStatement pst = null;
        try {
            String sql = String.format("delete from %s where %s=?", tableName,
                    getPK(tableName));
            pst = this.conn.prepareStatement(sql);
            pst.setObject(1, id);
            num = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closePST(pst);
        }
        return num;
    }

    /**
     * 修改数据
     *
     * @param sql 更新语句
     * @return
     */
    public int update(String sql) {
        int num = 0;
        PreparedStatement pst = null;
        try {
            pst = this.conn.prepareStatement(sql);
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closePST(pst);
        }
        return num;
    }

    /**
     * @param sql  更新语句
     * @param data
     * @return
     */
    public int update(String sql, Object[] data) {
        int num = 0;
        PreparedStatement pst = null;
        try {
            pst = this.conn.prepareStatement(sql);
            for (int i = 0; i < data.length; i++) {
                pst.setObject(i + 1, data[i]);
            }
            num = pst.executeUpdate();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            this.closePST(pst);
        }
        return num;
    }

    /**
     * 修改数据
     *
     * @param tableName 表名
     * @param data      修改的数据（字段名=值）的Map集合
     * @param condition 条件
     * @return
     */
    public int update(String tableName, Map<String, Object> data, String condition) {
        int num = 0;
        PreparedStatement pst = null;
        StringBuilder s = new StringBuilder();
        for (String key : data.keySet()) {
            s.append(key + "=" + data.get(key) + ",");
        }
        try {
            String sql = String.format("update %s set %s  %s", tableName, s.substring(0, s.length() - 1), condition);
            pst = this.conn.prepareStatement(sql);
            int i = 1;
            for (String key : data.keySet()) {
                pst.setObject(i++, data.get(key));
            }
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closePST(pst);
        }
        return num;
    }

    /**
     * 数据查询
     *
     * @param sql 查询语句
     * @return
     */
    public List<Map<String, Object>> query(String sql) {
        List<Map<String, Object>> list = null;
        PreparedStatement pst = null;
        try {
            pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            list = this.getResultSet(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closePST(pst);
        }
        return list;
    }


    /**
     * 查询数据总条数
     *
     * @param tableName 表名
     * @param condition 查询条件
     * @return
     */
    public int queryCount(String tableName, String condition) {
        int num = 0;
        PreparedStatement pst = null;
        try {
            String sql = String.format("select count(*) from %s %s", tableName, condition);
            pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                num = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closePST(pst);
        }
        return num;
    }


    /**
     * 查询数据是否存在
     *
     * @param tableName 表名
     * @param condition 查询条件
     * @return
     */
    public boolean queryIfExists(String tableName, String condition) {
        if (this.queryCount(tableName, condition) > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 通过字段名查询数据
     *
     * @param tableName 表名
     * @param field     字段名
     * @param condition 查询条件
     * @return
     */
    public Object queryByField(String tableName, String field, String condition) {
        Object obj = null;
        PreparedStatement pst = null;
        try {
            String sql = String.format("select %s from %s %s", field, tableName, condition);
            pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.isBeforeFirst()) {
                rs.next();
                obj = rs.getObject(field);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closePST(pst);
        }
        return obj;
    }


    /**
     * 查询数据并分页显示
     *
     * @param p          页面参数
     * @param tableName  表名
     * @param fields     字段名
     * @param condition1 查询条件1
     * @param condition2 查询条件2
     * @return
     */
    public List<Map<String, Object>> showPage(String p, String tableName, String fields, String condition1, String condition2) {
        List<Map<String, Object>> list = null;
        PreparedStatement pst = null;
        this.rowCount = this.queryCount(tableName, condition1);
        this.pageCount = (int) Math.ceil(rowCount / (pageSize * 1.00));
        if (p != null) {
            if (Integer.parseInt(p) < 1) {
                this.currentPage = 1;
            }
            if (Integer.parseInt(p) > this.pageCount) {
                this.currentPage = this.pageCount;
            }
            if (Integer.parseInt(p) >= 1 & Integer.parseInt(p) <= this.pageCount) {
                this.currentPage = Integer.parseInt(p);
            }
        }
        try {
            String sql = String.format("select %s from %s %s limit " + (this.currentPage - 1) * this.pageSize
                    + "," + this.pageSize, fields, tableName, condition2);
            pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            list = this.getResultSet(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closePST(pst);
        }
        return list;
    }

    /**
     * BootStrap分页效果
     *
     * @return
     */
    public String pageBootStrap() {
        StringBuilder s = new StringBuilder();
        s.append("<ul class=\"pagination\">");
        int start = 1;
        int end = 10;
        if (this.currentPage >= 7) {
            start = this.currentPage - 5;
            end = this.currentPage + 4;
            if (this.currentPage >= this.pageCount - 4) {
                start = this.pageCount - 9;
                end = this.pageCount;
            }
        }
        s.append(String.format("<li><a href=\"?p=%d\">首页</a></li>", 1));
        if (end < 1) {
            end = 1;
        }
        if (this.currentPage == 1) {
            s.append("<li class=\"disabled\"><a href=\"javascript:void(0)\">上一页</a></li>");
        } else {
            s.append(String.format("<li><a href=\"?p=%d\">上一页</a></li>", this.currentPage - 1));
        }
        for (int i = start; i <= end; i++) {
            if (i > this.pageCount) break;
            if (this.currentPage == i) {
                s.append(String.format("<li class=\"active\"><a href=\"?p=%d\">%d</a></li>", i, i));
                continue;
            }
            s.append(String.format("<li><a href=\"?p=%d\">%d</a></li>", i, i));
        }
        if (this.currentPage == this.pageCount) {
            s.append("<li class=\"disabled\"><a href=\"javascript:void(0)\">下一页</a></li>");
        } else {
            s.append(String.format("<li><a href=\"?p=%d\">下一页</a></li>", this.currentPage + 1));
        }
        s.append(String.format("<li><a href=\"?p=%d\">尾页</a></li>", this.pageCount));
        s.append("</ul>");
        s.append("<br><div>");
        s.append("<form action=\"bootstrap.jsp\" method=\"post\">");
        s.append(String.format("第<input type=\"text\" name=\"p\" value=\"%d\" size=\"1\">页/共%d页", this.currentPage, this.pageCount));
        s.append("<input type=\"submit\" value=\"GO\"></form>");
        s.append(String.format("&nbsp;&nbsp;共%d条记录&nbsp;&nbsp;%d条/页", this.rowCount, this.pageSize));
        s.append("</div>");
        return s.toString();
    }

    /**
     * 将数据结果集放入List集合
     *
     * @param rs 结果集
     * @return
     */
    private List<Map<String, Object>> getResultSet(ResultSet rs) {
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            while (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                Map<String, Object> mm = new HashMap<>();
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
     * 页面页脚效果
     *
     * @return
     */
    public String pageInfo() {
        StringBuilder s = new StringBuilder();
        s.append("<div>");
        int start = 1;
        int end = 10;
        if (this.currentPage > 6) {
            start = this.currentPage - 5;
            end = this.currentPage + 4;
            if (this.currentPage > this.pageCount - 5) {
                start = this.pageCount - 9;
                end = this.pageCount;
            }
        }
        s.append(String.format("<a href=\"?p=%d\">首页</a>", 1));
        if (this.currentPage != 1) {
            s.append(String.format("<a href=\"?p=%d\">上一页</a>", this.currentPage - 1));
        }
        if (start < 1) {
            start = 1;
        }
        for (int i = start; i <= end; i++) {
            if (i > this.pageCount) {
                break;
            }
            if (this.currentPage == i) {
                s.append(String.format("<span>%d</span>", i));
                continue;
            }
            s.append(String.format("<a href=\"?p=%d\">%d</a>", i, i));
        }
        if (this.currentPage != this.pageCount) {
            s.append(String.format("<a href=\"?p=%d\">下一页</a>", this.currentPage + 1));
        }
        s.append(String.format("<a href=\"?p=%d\">尾页</a>", this.pageCount));
        s.append("</div>");
        s.append(String.format("<div>第%d页/共%d页 共%d条记录 %d条/页</div>", this.currentPage, this.pageCount, this.rowCount, this.pageSize));
        return s.toString();
    }

    //每页多少条
    private int yenum = 8;
    //当前页开始查询下标
    private  int begin;
    //当前页数
    private int p = 1 ;
    //总页数
    private int allpage;

    public int getAllnum() {
        return allnum;
    }

    public void setAllnum(int allnum) {
        this.allnum = allnum;
    }

    public int getAllpage() {
        return allpage;
    }

    public void setAllpage(int allpage) {
        this.allpage = allpage;
    }

    public int getP() {
        return p;
    }

    public void setP(int p) {
        this.p = p;
    }

    public int getBegin() {
        return begin;
    }

    public void setBegin(int begin) {
        this.begin = begin;
    }

    public int getYenum() {
        return yenum;
    }

    public void setYenum(int yenum) {
        this.yenum = yenum;
    }

    //总条数
    private int allnum ;
    private int i;

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }

    public List<Map<String, Object>> query(String tablename, String where, int p1 ){
        p = p1;
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            allnum = this.queryCount(tablename,where);
            allpage = allnum % yenum == 0 ? allnum / yenum : (int)(allnum / yenum) + 1 ;
            begin = p * yenum - yenum;
            String sql = "select oll_goods.* from "+tablename+" "+where+ " limit "+ begin + "," + yenum;
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            list = this.getResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }




}
