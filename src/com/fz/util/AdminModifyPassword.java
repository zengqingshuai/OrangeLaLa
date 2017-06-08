package com.fz.util;

import com.alibaba.fastjson.JSONObject;
import com.fz.db.MyDbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Wei Yinghang on 2017/5/20.
 */
@WebServlet("/pwd.do")
public class AdminModifyPassword extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        String name = req.getParameter("n");
        String pass = req.getParameter("p");
        String pass1 = req.getParameter("p1");
        PrintWriter out = resp.getWriter();
        MyDbUtil mu = new MyDbUtil();
        if (pass.equals(pass1)){
            int i = mu.update("update oll_admin set pass=? where admin='"+name+"'",new Object[]{mu.getPass(pass,name)});
            if (i>=1){
                out.print(JSONObject.toJSONString("修改成功"));
            }
        }else {
            out.print(JSONObject.toJSONString("两次密码不一致"));
        }
    }
}
