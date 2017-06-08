package com.fz.util;

import com.fz.db.MyDbUtil;
import com.fz.db.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2017/5/19.
 */
@WebServlet("/person/address.do")
public class AddressSubmit extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String addr1 = req.getParameter("addr1");
        String addr2 = req.getParameter("addr2");
        String intro = req.getParameter("intro");
        String id = req.getParameter("id");
        String url=req.getHeader("Referer");
        //String rpsw = request.getParameter("rpsw");//得到表单输入的内容
        String uid = req.getSession().getAttribute("person_id").toString();
        if (id != null) {
            MyDbUtil mu = new MyDbUtil();
            mu.delete("oll_addr", "where id = " + id + " and uid=" + uid);
            resp.sendRedirect("address.jsp");
        } else {
            UserDao u = new UserDao();
            //调用addUser（）方法
            if (name != null && phone != null && intro != null && (!addr1.equals("--选择省份--")) && (!addr2.equals("--选择城市--"))) {
                if (u.finalize(uid,name, phone, addr1 + addr2, intro)) {
                    resp.sendRedirect("address.jsp?addrinfo=" + URLEncoder.encode("添加成功!", "utf-8"));
                } else {
                    resp.sendRedirect("address.jsp?addrinfo=" + URLEncoder.encode("添加失败请重试!", "utf-8"));
                }
            } else {
                if (url.contains("pay.jsp")){

                }else{
                    resp.sendRedirect("address.jsp?addrinfo=" + URLEncoder.encode("添加失败请重试!", "utf-8"));
                }
            }
        }
    }
}
