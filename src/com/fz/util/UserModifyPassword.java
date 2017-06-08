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

/**
 * Created by Wei Yinghang on 2017/5/23.
 */
@WebServlet("/update.do")
public class UserModifyPassword extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        ConnMysql mu = new ConnMysql();
        String user = req.getParameter("user");
        String pass = req.getParameter("password");
        String pass1 = req.getParameter("pass");
        PrintWriter out = resp.getWriter();
        if (pass.equals(pass1)) {
            String hashPassword = CryptoUtils.getHash(pass, user);
            int n = mu.update("update oll_user set pass='" + hashPassword + "'where account='" + user + "'");
            if (n >= 1) {
                out.print("修改成功");
            } else {
                out.print("修改失败,未知错误");
            }
        } else {
            out.print("密码输入不一致");
        }
    }
}
