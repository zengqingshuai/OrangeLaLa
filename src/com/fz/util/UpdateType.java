package com.fz.util;
import com.fz.db.MyDbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Administrator on 2017/5/18.
 */
@WebServlet("/management/update.do")
public class UpdateType extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        MyDbUtil m = new MyDbUtil();
        String level = req.getParameter("level");
        String old = req.getParameter("oldname");
        String news = req.getParameter("newname");
        String newclass = req.getParameter("newclass");
        if ("first".equals(level)){
            if (!m.exists("oll_type1", "where name = '" + news + "'")) {//判断这个新分类是否存在
                String str = "update oll_type1 set name = '" + news + "' where name = '" + old + "'";
                int n = m.update(str);
                if (n >= 1) {
                    out.print("修改成功");
                } else {
                    out.print("修改失败，未知错误");
                }
            } else {
                out.print(news + "已存在！");
            }
        }else{
            if (!m.exists("oll_type2", "where name = '" + news + "'")) {//判断这个新分类是否存在
                String id = m.queryByField("oll_type1", "id", "where name = '" + newclass + "'").toString();
                String str = "update oll_type2 set t1id = " + id + ",name = '" + news + "' where name = '" + old + "'";
                int n = m.update(str);
                if (n >= 1) {
                    out.print("修改成功");
                } else {
                    out.print("修改失败，未知错误");
                }
            } else {
                out.print(news + "已存在！");
            }
        }
    }
}
