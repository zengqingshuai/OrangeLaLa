package com.fz.util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Wei Yinghang on 2017/5/24.
 */
@WebFilter(urlPatterns = {"/person/*","/home/shopcart.jsp","/home/pay.jsp","/home/success.jsp"})
public class PersonFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request= (HttpServletRequest) req;
        HttpServletResponse response= (HttpServletResponse) resp;
        HttpSession session= request.getSession();
        if (session.getAttribute("person_admin")==null){
            response.sendRedirect("/home/login.jsp");
        }
        chain.doFilter(req,resp);
    }

    @Override
    public void destroy() {

    }
}
