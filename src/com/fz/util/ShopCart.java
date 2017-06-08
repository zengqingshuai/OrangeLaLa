package com.fz.util;

import com.fz.db.ConnMysql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by webrx on 2017/6/2.
 */
@WebServlet("/home/shopcart.action")
public class ShopCart extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String action = req.getParameter("action");
        int num = Integer.parseInt(req.getParameter("num"));
        String id = req.getParameter("id");
        String gid = req.getParameter("gid");
        double price = Double.parseDouble(req.getParameter("price"));
        ConnMysql m = new ConnMysql();
        //查询购物车中商品数量
        int n=(int)m.queryByField("oll_order_info","num"," where orderid = " + id + " and goodsid=" + gid);
        PrintWriter out = resp.getWriter();
        String sql;
        if ("min".equals(action)) {
            if (num <= 1) {
                sql = "update oll_order_info set num = " + num + " where orderid = " + id + " and goodsid=" + gid;
                m.update(sql);
                sql = "update oll_order set total = total - " + price*n+" + "+price*num + " where id = " + id;
                m.update(sql);
                out.print(1);
            } else {
                sql = "update oll_order_info set num = " + (num - 1) + " where orderid = " + id + " and goodsid=" + gid;
                m.update(sql);
                sql = "update oll_order set total = total - " + price*n+" + "+price*num + " where id = " + id;
                m.update(sql);
                out.print(num - 1);
            }
        } else {
            int allnum = Integer.parseInt(req.getParameter("allnum"));
            if (num >= allnum) {
                sql = "update oll_order_info set num = " + allnum + " where orderid = " + id + " and goodsid=" + gid;
                m.update(sql);
                sql = "update oll_order set total = total - " + price*n+" + "+price*num + " where id = " + id;
                m.update(sql);
                out.print(allnum);
            } else {
                sql = "update oll_order_info set num = " + (num + 1) + " where orderid = " + id + " and goodsid=" + gid;
                m.update(sql);
                sql = "update oll_order set total = total - " + price*n+" + "+price*num + " where id = " + id;
                m.update(sql);
                out.print(num + 1);
            }
        }

    }
}
