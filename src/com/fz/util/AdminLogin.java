package com.fz.util;

import com.alibaba.fastjson.JSONObject;
import com.fz.db.CryptoUtils;
import com.fz.db.MyDbUtil;

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
 * Created by Wei Yinghang on 2017/5/18.
 */
@WebServlet("/login.do")//验证账号登陆
public class AdminLogin extends HttpServlet {
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String pass = req.getParameter("pass");
        MyDbUtil mu = new MyDbUtil();
        boolean resoult = mu.exists("oll_admin", "where admin='" + name + "' and pass='" + mu.getPass(pass,name) + "'");
        if (resoult) {
            req.getSession().setAttribute("admin", name);
            //上次登录时间
            Object admin_time1 = mu.queryByField("oll_admin", "addtime", "where admin='" + name + "'");
            //同时更新本次登录时间
            String admin_time2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            mu.update("update oll_admin set addtime =? where admin=?" ,new Object[]{admin_time2,name});
            req.getSession().setAttribute("admin_last_time",admin_time1.toString());
            out.print(JSONObject.toJSONString("/management/index.jsp"));
        } else {
            out.print(JSONObject.toJSONString("账号或密码错误,请重新输入"));
        }
    }
}
