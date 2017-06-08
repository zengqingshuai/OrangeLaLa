package com.fz.util;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Wei Yinghang on 2017/5/11.
 */
public class Encoding implements Filter{
    private String encoding="utf-8";
    @Override
    public void init(FilterConfig fc) throws ServletException {
        String en=fc.getInitParameter("encoding");
        if (encoding!=null){
            this.encoding=en;
        }
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc) throws IOException, ServletException {
        HttpServletRequest request= (HttpServletRequest) req;
        HttpServletResponse response= (HttpServletResponse) res;
        request.setCharacterEncoding(encoding);
        response.setCharacterEncoding(encoding);
        response.setContentType("text/html;charset=UTF-8");
        fc.doFilter(request,response);
    }

    @Override
    public void destroy() {

    }
}
