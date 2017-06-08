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
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * Created by Wei Yinghang on 2017/5/19.
 */
@WebServlet("/management/upload.action")
@MultipartConfig
public class AddAnnounce extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        String address = req.getParameter("address");
        String select = req.getParameter("sele");
        int s;
        if(select.equals("显示")){
            s=1;
        }else{
            s=0;
        }
        Part uf = req.getPart("upload");
        String fn = uf.getSubmittedFileName();
        if (!address.equals("") && !fn.equals("")) {
            String path = req.getServletContext().getRealPath("images/");
            File f = new File(path);
            if (!f.exists()) {
                f.mkdirs();
            }
            String ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
            if (".jpg".equals(ext) || ".png".equals(ext) || ".gif".equals(ext)) {
                String nn = UUID.randomUUID().toString();
                long v = uf.getSize();
                long vv = 1024 * 1024;
                if (v < vv) {
                    String uploadname = path + nn + ext;
                    uf.write(uploadname);
                    MyDbUtil mu = new MyDbUtil();
                    mu.insert("insert into oll_activity value(null,?,?,?)", new Object[]{nn + ext, s, address});
                    req.getSession().setAttribute("user_upload", "上传成功");
                    resp.sendRedirect("/management/announcement_add.jsp");
                } else {
                    req.getSession().setAttribute("user_upload", "文件过大,请重新上传");
                    resp.sendRedirect("/management/announcement_add.jsp");
                }
            } else {
                req.getSession().setAttribute("user_upload", "请检查文件格式");
                resp.sendRedirect("/management/announcement_add.jsp");
            }
        } else {
            req.getSession().setAttribute("user_upload", "请认真检查,输入不能为空");
            resp.sendRedirect("/management/announcement_add.jsp");
        }
    }
}
