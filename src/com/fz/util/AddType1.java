package com.fz.util;

import com.fz.db.EditPic;
import com.fz.db.MyDbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.UUID;

/**
 * Created by weiyinghang on 2017/5/25.
 */
@WebServlet("/management/addClass.do")
@MultipartConfig
public class AddType1 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        MyDbUtil m = new MyDbUtil();
        String name = req.getParameter("name");//获取名称
        String descr = req.getParameter("descr");//获取介绍
        Part uf = req.getPart("picsname");//获取修改商品图片
        String url = "/management/class_add.jsp";//跳转地址
        String fn = uf.getSubmittedFileName();
        //String tid = m.queryByField("oll_type1", "id", "where name='" + name + "'").toString();
        if (!"".equals(fn) && name != null && descr != null) {
            if (!m.exists("oll_type1", "where name = '" + name)) {
                String ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
                if (".jpg".equals(ext) || ".png".equals(ext) || ".jpeg".equals(ext)) {
                    String uu = UUID.randomUUID().toString();
                    String path_ = getServletContext().getRealPath("images/");
                    String uploadname = path_ + uu + ext;
                    uf.write(uploadname);
                    if (m.insert("insert into oll_type1 (id,name,icon,picsname,descr) value (null,?,?,?,?)", new Object[]{name, "", uu + ext, descr}) > 0) {
                        req.getSession().setAttribute("info_addClass", "000");
                        resp.sendRedirect("/management/class_manage.jsp");
                    } else {
                        req.getSession().setAttribute("info_addClass", "001");
                        resp.sendRedirect(url);
                    }
                } else {
                    //out.print("只能上传图片！");
                    req.getSession().setAttribute("info_addClass", "002");
                    resp.sendRedirect(url);
                }
            } else {
                //out.print(newname + "已存在");
                req.getSession().setAttribute("info_addClass", "003");
                resp.sendRedirect(url);
            }
        } else {
            //out.print("输入不能为空，请仔细填写！");
            req.getSession().setAttribute("info_addClass", "004");
            resp.sendRedirect(url);
        }
    }
}
