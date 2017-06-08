package com.fz.util;

import com.fz.db.ConnMysql;
import com.fz.db.CryptoUtils;
import com.sun.org.apache.xpath.internal.SourceTree;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * Created by Wei Yinghang on 2017/5/25.
 */
@WebServlet("/person/person_updata_pass.do")
public class PersonResetPWD extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String user = req.getParameter("old_pass");
        String new_pass1 = req.getParameter("new_pass");
        String new_pass2 = req.getParameter("new_pass_2");
        ConnMysql mu = new ConnMysql();
        if (!user.equals("")&&!new_pass1.equals("")&&!new_pass2.equals("")) {
            if (new_pass1.equals(new_pass2)) {
                String hashPassword = CryptoUtils.getHash(new_pass1, user);
                int f = mu.update("update oll_user set pass='" + hashPassword + "'where account='" + user + "'");
                if (f >= 1) {
                    resp.sendRedirect("password.jsp?info=ok");
                } else {
                    resp.sendRedirect("password.jsp?info=no");
                }
            } else {
                resp.sendRedirect("password.jsp?info=success");
            }
        } else {
            resp.sendRedirect("password.jsp?info=nano");
        }

    }
}
