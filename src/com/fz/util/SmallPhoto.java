package com.fz.util;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

@WebServlet("/goods_small")//缩略图
public class SmallPhoto extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("image/jpeg;charset=utf-8");
        String name=req.getSession().getAttribute("small_photo_fang").toString();
        int w =60;
        int h =60;
        BufferedImage i = new BufferedImage(w,h,1);
        Graphics2D g = i.createGraphics();
        String path=req.getServletContext().getRealPath("/");
        BufferedImage i0 = ImageIO.read(new File(path+"images/"+name));//原图
        g.drawImage(i0,0,0,w,h,0,0,i0.getWidth(),i0.getHeight(),null);
        g.dispose();
        ImageIO.write(i,"png",resp.getOutputStream());
    }
}
