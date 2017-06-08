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
import java.net.URLEncoder;
import java.util.UUID;

/**
 * Created by Administrator on 2017/5/19.
 */
@WebServlet("/management/goodsModify.do") @MultipartConfig
public class UpdateGoods extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        //PrintWriter out = resp.getWriter();
        MyDbUtil m = new MyDbUtil();
        String oldname = req.getParameter("oldname");//获取修改旧商品名称
        String newname = req.getParameter("newname");//获取修改新商品名称
        String descr = req.getParameter("descr");//获取修改商品介绍
        String goods_type = req.getParameter("goods_type");//获取修改商品类型
        String price = req.getParameter("price");//获取修改商品单价
        String num = req.getParameter("num");//获取修改商品数量
        String brand = req.getParameter("brand");//获取商品品牌
        String equiv = req.getParameter("equiv");//获取修改商品规格
        Part uf = req.getPart("picname");//获取修改商品图片
        String val = URLEncoder.encode(oldname, "utf-8");
        String url = "/management/goods_detail_modify.jsp?modifygoods=" + val;//跳转地址
        String fn = uf.getSubmittedFileName();
        String gid = m.queryByField("oll_goods", "id", "where goodsname='" + oldname + "'").toString();
        String oldpicname = m.queryByField("oll_goods", "picname", "where goodsname='" + oldname + "'").toString();
        if (!"".equals(fn) && brand != null && newname != null && descr != null && goods_type != null && price != null && num != null && equiv != null) {
            if (!m.exists("oll_goods", "where goodsname = '" + newname + "'and id!=" + gid)) {
                String ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
                if (".jpg".equals(ext) || ".png".equals(ext) || ".jpeg".equals(ext)) {
                    String id = m.queryByField("oll_type2", "id", "where name = '" + goods_type + "'").toString();
                    int i = Integer.parseInt(id);
                    String uu = UUID.randomUUID().toString();
                    String path_ = getServletContext().getRealPath("images/");
                    String uploadname = path_ + uu + ext;
                    uf.write(uploadname);
                    EditPic e = new EditPic();
                    e.addContent(uploadname, "@Orange商城版权", new Color(0, 0, 0, 250), 30, 8);
                    String str = "update oll_goods set goodsname='" + newname + "',t2id= " + i + ",price=" + price + ",store=" + num + ",descr='" + descr + "',equiv='" + equiv + "',brand='" + brand + "',picname='" + uu + ext +"' where goodsname = '" + oldname + "' ";
                    if (m.update(str) > 0) {
                        //删除旧图
                        File f1 = new File(path_ + oldpicname);
                        f1.delete();
                        req.getSession().setAttribute("info_modifyGoods", "000");
                        resp.sendRedirect("/management/goods_detail_modify.jsp");
                    } else {
                        req.getSession().setAttribute("info_modifyGoods", "001");
                        resp.sendRedirect(url);
                    }
                } else {
                    //out.print("只能上传图片！");
                    req.getSession().setAttribute("info_modifyGoods", "002");
                    resp.sendRedirect(url);
                }
            } else {
                //out.print(newname + "已存在");
                req.getSession().setAttribute("info_modifyGoods", "003");
                resp.sendRedirect(url);
            }
        } else {
            //out.print("输入不能为空，请仔细填写！");
            req.getSession().setAttribute("info_modifyGoods", "004");
            resp.sendRedirect(url);
        }
    }
}