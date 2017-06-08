package com.fz.util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Wei Yinghang on 2017/5/12.
 */
@WebServlet("/servertime.do")
public class Time extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter o=resp.getWriter();
        o.write(new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date()));
        o.flush();
        o.close();
    }
}
