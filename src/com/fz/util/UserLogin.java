package com.fz.util;

import com.fz.db.ConnMysql;
import com.fz.db.CryptoUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * Created by Wei Yinghang on 2017/5/22.
 */
@WebServlet("/login.action")
public class UserLogin extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        ConnMysql mu = new ConnMysql();
        String user = req.getParameter("user");
        String pass = req.getParameter("password");
        PrintWriter out = resp.getWriter();
        if (mu.queryIfExists("oll_user", "where account='" + user + "' and status = 1")) {
            String password = mu.queryByField("oll_user","pass"," where account='" + user + "'").toString();
            if (CryptoUtils.verify(password,pass,user)) {
                out.print("yes");
                String uid= mu.queryByField("oll_user","id","where account = '" + user + "'").toString();
                req.getSession().setAttribute("person_admin",user);
                req.getSession().setAttribute("person_id",uid);
            } else {
                out.print("账号密码不正确");
            }
        } else {
            out.print("账号被冻结！");
        }
    }
}
