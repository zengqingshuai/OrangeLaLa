package com.fz.util;

import com.fz.db.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2017/5/19.
 */
@WebServlet("/person/information.do")
public class UserModifyInfo extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String adress = request.getParameter("adress");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String birth = request.getParameter("birth");
        String account= request.getSession().getAttribute("person_admin").toString();
       //String rpsw = request.getParameter("rpsw");//得到表单输入的内容
        if(username==null||username.trim().isEmpty()){
            request.setAttribute("msg", "昵称不能为空");
            request.getRequestDispatcher("/person/information.jsp").forward(request, response);
            return;
        }
        if(adress==null||adress.trim().isEmpty()){
            request.setAttribute("mcg", "地址不能为空");
            request.getRequestDispatcher("/person/information.jsp").forward(request, response);
            return;
        }
        if(phone==null||phone.trim().isEmpty()){
            request.setAttribute("mag", "电话不能为空");
            request.getRequestDispatcher("/person/information.jsp").forward(request, response);
            return;
        }
        if(email==null||email.trim().isEmpty()){
            request.setAttribute("mbg", "邮件能为空");
            request.getRequestDispatcher("/person/information.jsp").forward(request, response);
            return;
        }
        UserDao u = new UserDao();
        if (u.addUser(username, gender,adress,phone,email,birth,account)){
            request.setAttribute("mdg", "恭喜："+username+"，修改成功");
        }else{
            request.setAttribute("mdg", "修改失败！请重试！");
        }
        //调用addUser（）方法
        request.getRequestDispatcher("/person/information.jsp").forward(request, response);

    }
}
