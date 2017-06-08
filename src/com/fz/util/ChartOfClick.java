package com.fz.util;

import com.fz.db.MyDbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/management/datachart.html")
public class ChartOfClick extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MyDbUtil mu = new MyDbUtil();
        List<Map<String, Object>> l= mu.query("oll_type1 a,oll_type2 b,oll_goods c","a.`name`,sum(c.`clicknum`)"," where a.`id`=b.`t1id` and b.`id`=c.`t2id` "," group by a.`name`","");
        StringBuilder s1 = new StringBuilder();
        StringBuilder s2 = new StringBuilder();
        s1.append("[");
        s2.append("[");
        for (Map<String, Object> m:l) {
            s1.append(String.format("\"%s\",",m.get("name")));
            s2.append(m.get("sum(c.`clicknum`)")+",");
        }
        s1.replace(s1.length()-1,s1.length(),"]");
        s2.replace(s2.length()-1,s2.length(),"]");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        l.clear();
        List<String> list=new ArrayList<String>();
        list.add(s1.toString());
        list.add(s2.toString());
        req.setAttribute("list",list);
        req.getRequestDispatcher("datachart.jsp").forward(req,resp);
    }
}
