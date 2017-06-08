package com.fz.db;

import com.fz.db.MyDbUtil;

import java.sql.*;

public class UserDao {
    private Connection con = new MyDbUtil().getConn();
    private PreparedStatement pstmt = null;
    public boolean finalize(String uid,String name, String phone, String addr, String intro) {
        boolean f = false;
        try {
            String sql = "INSERT INTO oll_addr VALUES(null,?,?,?,?,?)";
            // String sql = "INSERT INTO user VALUES(?,?)";
            pstmt = this.con.prepareStatement(sql);
            pstmt.setString(1, uid);
            pstmt.setString(2, name);
            pstmt.setString(3, addr);
            pstmt.setString(4, intro);
            pstmt.setString(5, phone);
            if (pstmt.executeUpdate()>0){
                f=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean addUser(String username, String gender, String adress, String phone, String email, String birth,String account) {
        boolean i = false;
        try {
            String sql;
            ConnMysql mu=new ConnMysql();
            Object uid= mu.queryByField("oll_user","id","where account='"+account+"'");
            if(mu.queryIfExists("oll_user_info","where uid="+uid)){
                sql = "UPDATE oll_user_info SET name='"+username+"',gender="+gender+",address='"+adress+"',phone='"+phone+"',email='"+email+"',birth='"+birth+"' where uid="+uid;
            }else{
                sql = "INSERT INTO oll_user_info VALUES(null,?,?,?,?,?,?,?,null)";
                pstmt.setObject(1, uid);
                pstmt.setString(2, username);
                pstmt.setString(3, gender);
                pstmt.setString(4, adress);
                pstmt.setString(5, phone);
                pstmt.setString(6, email);
                pstmt.setString(7, birth);
            }
            pstmt = this.con.prepareStatement(sql);
            if (pstmt.executeUpdate() > 0) {
                i = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }


    //单独测试使用
    //public static void main(String[] args) {
    //String psw =new UserDao().findUsername("345");
    //System.out.println(psw);
    //UserDao u = new UserDao();
    //u.addUser("345", "345");
    //}

}


