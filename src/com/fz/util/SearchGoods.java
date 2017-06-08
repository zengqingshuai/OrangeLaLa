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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Wei Yinghang on 2017/5/16.
 */

@WebServlet("/home/searchgoods.action")
public class SearchGoods extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("term");
        PrintWriter out = resp.getWriter();
        ConnMysql cm = new ConnMysql();
        List<Map<String, Object>> list = cm.query("select goodsname from oll_goods where goodsname like '%" + name + "%' order by id");
        List<String> key = new ArrayList<String>();
        if(list!=null){
            for (Map<String, Object> m : list) {
                key.add(m.get("goodsname").toString());
            }
        }else{
            key.add("没有建议");
        }
        out.print(JSONObject.toJSON(key));
        out.flush();
        out.close();
    }
}
