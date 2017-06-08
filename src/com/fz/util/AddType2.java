package com.fz.util;

import com.fz.db.MyDbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/management/add.action")
public class AddType2 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        String level = req.getParameter("level");
        String name = req.getParameter("name");
        MyDbUtil m = new MyDbUtil();
        if ("first".equals(level)) {
            if (m.exists("oll_type1", "where name = '" + name + "'")) {
                out.print(name + "已存在");
            } else {
                int n = m.insert("insert into oll_type1 (id,name) value (null,?)", new Object[]{name});
                if (n == 1){
                    out.print(name+"创建成功");
                }else {
                    out.print(name+"创建失败，未知错误");
                }
            }
        }else {
            String nn = req.getParameter("fi");
            String id = m.queryByField("oll_type1","id","where name = '" +nn +"'").toString();
            int i = Integer.parseInt(id);
            if (m.exists("oll_type2", "where name = '" + name + "'")) {
                out.print(name + "已存在");
            }else {
                int n = m.insert("insert into oll_type2 value (null,?,?)", new Object[]{i,name});
                if (n == 1){
                    out.print(name+"创建成功");
                }else {
                    out.print(name+"创建失败，未知错误");
                }
            }
        }
    }
}
