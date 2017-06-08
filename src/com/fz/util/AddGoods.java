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
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

/**
 * Created by Administrator on 2017/5/19.
 */
@WebServlet("/management/goodsadd.do") @MultipartConfig
public class AddGoods extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        MyDbUtil m = new MyDbUtil();
        String name = req.getParameter("name");//获取商品名称
        String goods_type = req.getParameter("goods_type");//获取商品类型
        String id = m.queryByField("oll_type2", "id", "where name = '" + goods_type + "'").toString();
        int i = Integer.parseInt(id);
        String price = req.getParameter("price");//获取商品单价
        String descr = req.getParameter("descr");//获取商品介绍
        String num = req.getParameter("num");//获取商品数量
        String brand = req.getParameter("brand");//获取商品品牌
        String equiv = req.getParameter("equiv");//获取商品规格
        //创建文件存储目录
        String path = req.getServletContext().getRealPath("images");
        File f = new File(path);
        if (!f.exists()) {
            f.mkdirs();
        }
        //获取商品图片
        Part uf = req.getPart("picname");
        String fn = uf.getSubmittedFileName();
        if (!"".equals(fn) && out != null && name != null && descr != null &&brand != null && goods_type != null && price != null && num != null && equiv != null) {
            if (!m.exists("oll_goods", "where goodsname = '" + name + "'")) {
                String ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
                if (".jpg".equals(ext) || ".png".equals(ext) || ".jpeg".equals(ext)) {
                    String uu = UUID.randomUUID().toString();
                    String uploadname=getServletContext().getRealPath("images/") + uu+ ext;
                    uf.write(uploadname);
                    EditPic e = new EditPic();
                    e.addContent(uploadname, "@Orange商城版权", new Color(0, 0, 0, 250), 30, 8);
                    if(m.insert("insert into oll_goods (id,goodsname,t2id,price,store,descr,brand,picname,equiv) value(null,?,?,?,?,?,?,?,?)", new Object[]{name, i, price, num, descr,brand, uu+ext,equiv})>0){
                        req.getSession().setAttribute("info_addGoods", "000");
                        resp.sendRedirect("/management/goods_detail_add.jsp");
                    }else{
                        req.getSession().setAttribute("info_addGoods", "001");
                        resp.sendRedirect("/management/goods_detail_add.jsp");
                    }
                } else {
                    //out.print("只能上传图片！");
                    req.getSession().setAttribute("info_addGoods", "002");
                    resp.sendRedirect("/management/goods_detail_add.jsp");
                }
            } else {
                // out.print(name + "已存在");
                req.getSession().setAttribute("info_addGoods", "003");
                resp.sendRedirect("/management/goods_detail_add.jsp");
            }
        } else {
            //out.print("输入不能为空，请仔细填写！");
            req.getSession().setAttribute("info_addGoods", "004");
            resp.sendRedirect("/management/goods_detail_add.jsp");
        }
    }
}