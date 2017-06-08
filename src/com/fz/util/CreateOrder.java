package com.fz.util;

import com.alibaba.fastjson.JSONObject;
import com.fz.db.ConnMysql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by weiyinghang on 2017/5/27.
 */
@WebServlet("/home/buy.action")
public class CreateOrder extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        String action = req.getParameter("action");
        String gname = req.getParameter("goodsname");
        String num = req.getParameter("num");
        //直接购买接值
        String total = req.getParameter("total");
        String aid = req.getParameter("addr");
        //添加购物车接值
        int n = 0;
        if (num != null) {
            n = Integer.parseInt(num);
        }
        Random r = new Random();
        ConnMysql cm = new ConnMysql();
        //购物车删除商品接值
        String goodsid = req.getParameter("goodsid");
        //用户ID
        String uid = req.getSession().getAttribute("person_id").toString();
        //商品ID
        Object gid = cm.queryByField("oll_goods", "id", "where goodsname ='" + gname + "'");
        Object gprice = cm.queryByField("oll_goods", "price", "where goodsname ='" + gname + "'");
        Double gp = 0d;
        if (gprice != null) {
            gp = Double.parseDouble(gprice.toString());
        }
        if (action.equals("buy")) {
            //直接购买
            String number = r.nextInt(89999999) + 10000000 + uid + new SimpleDateFormat("MMddHHmmss").format(new Date());
            //获取addrid
            cm.insertInto("insert into oll_order values (null,?,?,?,?,?,?)", new Object[]{number, uid, aid, total, 1, new Date()});
            String orderid = cm.queryByField("oll_order", "id", "where number=" + number).toString();
            cm.insertInto("insert into oll_order_info values (null,?,?,?)", new Object[]{orderid, gid, num});
        } else if (action.equals("add")) {
            //购物车
            //判断购物车是否存在
            if (cm.queryIfExists("oll_order", "where status=6 and uid=" + uid)) {
                String orderid = cm.queryByField("oll_order", "id", "where status=6 and uid=" + uid).toString();
                //判断购物车是否存在该商品
                if (cm.queryIfExists("oll_order_info", "where orderid=" + orderid + " and goodsid=" + gid)) {
                    cm.update("update oll_order_info set num=num+" + num + " where orderid=" + orderid + " and goodsid=" + gid);
                } else {
                    cm.insertInto("insert into oll_order_info values (null,?,?,?)", new Object[]{orderid, gid, num});
                }
                cm.update("update oll_order set total=total+" + n * gp + " where id=" + orderid);
            } else {
                String number = r.nextInt(89999999) + 10000000 + new SimpleDateFormat("MMddHHmmss").format(new Date());
                cm.insertInto("insert into oll_order values (null,?,?,?,?,?,?)", new Object[]{number, uid, null, n * gp, 6, new Date()});
                String orderid = cm.queryByField("oll_order", "id", "where number=" + number).toString();
                cm.insertInto("insert into oll_order_info values (null,?,?,?)", new Object[]{orderid, gid, num});
            }
            out.print(JSONObject.toJSONString("添加成功！是否进入购物车?"));
        } else if (action.equals("delgoods")) {
            //购物车删除一种商品
            Object oid = cm.queryByField("oll_order", "id", " where uid=" + uid + " and status=6");
            Object oiid = cm.queryByField("oll_order_info", "id", " where orderid=" + oid + " and goodsid=" + goodsid);
            int nn = (int) cm.queryByField("oll_order_info", "num", " where id=" + oiid);
            cm.delete("oll_order_info", "where goodsid=" + goodsid + " and id=" + oiid);
            cm.update("update oll_order set total=total-" + nn * gp + " where uid=" + uid + " and status=6");
        } else {
            //购物车转订单
            String number = r.nextInt(89999999) + 10000000 + new SimpleDateFormat("MMddHHmmss").format(new Date());
            cm.update("update oll_order set status=" + 1 + ",addrid=" + aid + ",addtime='" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + "',number='" + number + "' where uid=" + uid + " and status=6");
        }
    }
}
