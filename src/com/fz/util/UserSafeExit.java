package com.fz.util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by weiyinghang on 2017/5/21.
 */
@WebServlet("/exit.action")
public class UserSafeExit extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.getSession().removeAttribute("person_admin");
        req.getSession().removeAttribute("person_id");
        resp.setHeader("refresh","0;url='home/index.jsp'");
    }
}
