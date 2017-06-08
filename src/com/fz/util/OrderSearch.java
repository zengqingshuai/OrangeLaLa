package com.fz.util;

import com.alibaba.fastjson.JSONObject;
import com.fz.db.ConnMysql;
import com.fz.db.MyDbUtil;
import com.fz.db.MysqlUtil2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weiyinghang on 2017/5/22.
 */
@WebServlet("/management/orderSearch.action")
public class OrderSearch extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        String action = req.getParameter("action");

        String search_id = req.getParameter("search_id");
        String order_id = req.getParameter("order_id");
        String p = req.getParameter("p");
        String linkman = req.getParameter("linkman");
        String phone = req.getParameter("phone");
        String addr = req.getParameter("addr");
        String sta = req.getParameter("sta");
        int stat = 1;
        if (sta != null) {
            if (sta.equals("待付款")) {
                stat = 1;
            } else if (sta.equals("待发货")) {
                stat = 2;
            } else if (sta.equals("待收货")) {
                stat = 3;
            } else if (sta.equals("已签收")) {
                stat = 4;
            } else {
                stat = 5;
            }
        }

        MysqlUtil2 mu = new MysqlUtil2();
        mu.setPagesize(8);
        if (p != null) {
            mu.setCurrpage(Integer.parseInt(p));
        }
        List<Map<String, Object>> list = new ArrayList<>();
        if (action.equals("show")) {
            list = mu.page("oll_order a,oll_addr b", "a.id,b.linkman,b.address,a.status", "where a.addrid=b.id and a.status!=6", "");
            Map<String, Object> m = new HashMap<String, Object>();
            m.put("getPagesize", mu.getPagesize());
            m.put("getRecordcount", mu.getRecordcount());
            m.put("getCurrpage", mu.getCurrpage());
            m.put("getPagecount", mu.getPagecount());
            m.put("pageInfo", mu.pageInfo());
            list.add(m);
            out.print(JSONObject.toJSONString(list));
        } else if (action.equals("showSearch")) {
            ConnMysql cm = new ConnMysql();
            if (cm.queryCount("oll_order", "where id=" + search_id) > 0) {
                System.out.println(search_id);
                list = mu.page("oll_order a,oll_addr b", "a.id,b.linkman,b.address,a.status", "where a.addrid=b.id and a.id=" + search_id, "");
                Map<String, Object> m = new HashMap<String, Object>();
                m.put("getPagesize", mu.getPagesize());
                m.put("getRecordcount", mu.getRecordcount());
                m.put("getCurrpage", mu.getCurrpage());
                m.put("getPagecount", mu.getPagecount());
                m.put("pageInfo", mu.pageInfo());
                list.add(m);
                out.print(JSONObject.toJSONString(list));
            } else {
                out.print(JSONObject.toJSONString("订单不存在！"));
            }
        } else if (action.equals("delete")) {
            String id = req.getParameter("id");
            if (mu.delete("oll_order", "where oll_order.id=" + id ) > 0) {
                out.print(JSONObject.toJSONString("删除成功！"));
            } else {
                out.print(JSONObject.toJSONString("删除失败！"));
            }
        } else if (action.equals("update")) {
            if (mu.update("update oll_order a,oll_addr b set linkman='" + linkman + "',phone='" + phone + "',address='" + addr + "',status='" + stat + "' where a.addrid=b.id and a.id=" + order_id) > 0) {
                out.print(JSONObject.toJSONString("更改成功！"));
            } else {
                out.print(JSONObject.toJSONString("更改失败！提交内容有误，请检查！"));
            }
        } else if (action.equals("select_order")) {
            MyDbUtil md = new MyDbUtil();
            list = md.query(" oll_order a,oll_addr b ", " b.linkman,b.address,a.status,phone ", "where a.addrid=b.id and a.id=" + order_id, "", "");
            out.print(JSONObject.toJSONString(list));
        }
    }
}
