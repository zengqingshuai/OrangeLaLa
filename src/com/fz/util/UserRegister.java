package com.fz.util;

import com.alibaba.fastjson.JSONObject;
import com.fz.db.ConnMysql;
import com.fz.db.CryptoUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 * Created by Wei Yinghang on 2017/5/22.
 */
@WebServlet("/register.action")
public class UserRegister extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        String user = req.getParameter("user");
        String pass1 = req.getParameter("pass1");
        String pass2 = req.getParameter("pass2");
        String checkcode1 = req.getParameter("checkcode");
        String action = req.getParameter("action");
        String checkcode2 = req.getSession().getAttribute("checkcode").toString();
        ConnMysql mu = new ConnMysql();
        PrintWriter out = resp.getWriter();
        if (action.equals("ok")) {
            boolean f = mu.queryIfExists("oll_user", "where account ='" + user + "'");
            if (!f) {
                out.print(JSONObject.toJSONString("不存在"));
            } else {
                out.print(JSONObject.toJSONString("存在"));
            }
        }
        if (action.equals("submit")) {
            if (checkcode1.equalsIgnoreCase(checkcode2)) {
                if (pass1.equals(pass2)) {
                    String hashPassword = CryptoUtils.getHash(pass1, user); //生成密文 88位动态
                    int n = mu.insertInto("insert into oll_user values(?,?,?,?,?)", new Object[]{null, user, hashPassword, 1, new Date()});
                    if (n >= 1) {
                        out.print(JSONObject.toJSONString("注册成功"));
                    } else {
                        out.print(JSONObject.toJSONString("注册失败，请重试！"));
                    }
                } else {
                    out.print(JSONObject.toJSONString("两次密码输入不一致"));
                }
            } else {
                out.print(JSONObject.toJSONString("验证码错误！"));
            }
        }

    }
}
