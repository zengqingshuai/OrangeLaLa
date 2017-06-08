package com.fz.util;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
@WebServlet("/home/check.action")
public class CreateCode extends HttpServlet {
    private static final int LEN = 4;
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("image/jpeg;charset=utf-8");
        int w = 100;
        int h = 40;
        BufferedImage img = new BufferedImage(w, h,BufferedImage.TYPE_INT_RGB);
        Graphics2D g2 = img.createGraphics();
        g2.setColor(new Color(240, 240, 240));
        g2.fillRect(0, 0, w, h);
        Random r = new Random();
        //四位验证码
        String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuffer code = new StringBuffer();
        g2.setColor(new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256)));
        for (int n = 0; n < LEN; n++) {
            int i = r.nextInt(str.length());
            String s = str.substring(i, i + 1);
            //给每个字符设置颜色
            //g2.setColor(new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256)));
            //设置字体
            g2.setFont(new Font("宋体", Font.BOLD, r.nextInt(7) + 28));
            //设置位置
            int x=n * 22 + 6;
            int y=r.nextInt(10) + 25;
            //旋转文本
            //设置旋转角度
            double degree=Math.PI / 6*r.nextFloat()*Math.pow((-1),r.nextInt(2));
            g2.rotate( degree,x,y);
            g2.drawString(s,x,y);
            g2.rotate( -degree,x,y);
            code.append(s);
        }
        //写入到session中
        req.getSession().setAttribute("checkcode", code.toString());
        //线段
        for (int n = 0; n < 12; n++) {
            g2.setStroke(new BasicStroke(r.nextInt(2)));
            g2.setColor(new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256), r.nextInt(56) + 200));
            g2.drawLine(r.nextInt(w), r.nextInt(h), r.nextInt(w), r.nextInt(h));
        }
        //圆、椭圆
        for (int n = 0; n < 6; n++) {
            g2.setStroke(new BasicStroke(r.nextInt(2)));
            g2.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255), r.nextInt(20) + 45));
            g2.fillOval(r.nextInt(w), r.nextInt(h), r.nextInt(30) + 20, r.nextInt(30) + 20);
        }
        ImageIO.write(img, "jpeg", resp.getOutputStream());
        g2.dispose();
    }
}
