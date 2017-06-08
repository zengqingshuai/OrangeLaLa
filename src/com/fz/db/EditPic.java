package com.fz.db;

import sun.font.FontDesignMetrics;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;
import java.net.URL;

public class EditPic {
    private static final int X = 10;
    private static final int Y = 10;
    private static final String FORMAT_NAME = "jpeg";

    /**
     * 添加水印
     *
     * @param picPath 图片位置
     * @param content 水印内容
     * @param color   文字颜色
     * @param size    字号
     * @param pos     水印位置
     */
    public void addContent(String picPath, String content, Color color, int size, int pos) {
        try {
            File pic = new File(picPath);
            BufferedImage img = ImageIO.read(pic);
            int w = img.getWidth();
            int h = img.getHeight();
            Graphics2D g = img.createGraphics();
            g.setColor(color);
            Font ft = new Font("宋体", Font.BOLD, size);
            g.setFont(ft);
            FontDesignMetrics fm = FontDesignMetrics.getMetrics(ft);
            int cw = fm.stringWidth(content);
            int ch = fm.getHeight();
            int x = X;
            int y = ch;
            switch (pos) {
                case 1:
                    break;
                case 2:
                    x = (w - cw) / 2;
                    break;
                case 3:
                    x = w - cw - X;
                    break;
                case 4:
                    y = (h + 2 * ch) / 2;
                    break;
                case 5:
                    x = (w - cw) / 2;
                    y = (h + 2 * ch) / 2;
                    break;
                case 6:
                    x = w - cw - X;
                    y = (h + 2 * ch) / 2;
                    break;
                case 7:
                    y = h - ch / 2;
                    break;
                case 8:
                    x = (w - cw) / 2;
                    y = h - ch / 2;
                    break;
                case 9:
                    x = w - cw - X;
                    y = h - ch / 2;
                    break;
                default:
                    Random rm = new Random();
                    x = rm.nextInt(w - 2 * cw - 2 * X) + cw;
                    y = rm.nextInt(h - ch - ch / 2) + ch;
                    break;
            }
            g.drawString(content, x, y);
            ImageIO.write(img, FORMAT_NAME, pic);
            g.dispose();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加素材图片
     *
     * @param picPath    图片位置
     * @param photoPath  素材图片位置
     * @param pos        素材添加位置
     * @param newPicPath 新图片位置
     */
    public void addPhoto(String picPath, String photoPath, int pos, String newPicPath) {
        try {
            BufferedImage img = ImageIO.read(new File(picPath));
            int w = img.getWidth();
            int h = img.getHeight();
            Graphics2D g = img.createGraphics();
            BufferedImage new_img = ImageIO.read(new File(photoPath));
            int pw = new_img.getWidth();
            int ph = new_img.getHeight();
            int x = X;
            int y = Y;
            switch (pos) {
                case 1:
                    break;
                case 2:
                    x = (w - pw) / 2;
                    break;
                case 3:
                    x = w - pw - X;
                    break;
                case 4:
                    y = (h - ph) / 2;
                    break;
                case 5:
                    x = (w - pw) / 2;
                    y = (h - ph) / 2;
                    break;
                case 6:
                    x = w - pw - X;
                    y = (h - ph) / 2;
                    break;
                case 7:
                    y = h - ph - Y;
                    break;
                case 8:
                    x = (w - pw) / 2;
                    y = h - ph - Y;
                    break;
                case 9:
                    x = w - pw - X;
                    y = h - ph - Y;
                    break;
                default:
                    Random r = new Random();
                    x = r.nextInt(w - X - pw) + X;
                    y = r.nextInt(h - Y - ph) + Y;
            }
            g.drawImage(new_img, x, y, null);
            ImageIO.write(img, FORMAT_NAME, new File(newPicPath));
            g.dispose();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加素材图片(覆盖原图)
     *
     * @param picPath   图片位置
     * @param photoPath 素材图片位置
     * @param pos       素材添加位置
     */
    public void addPhoto(String picPath, String photoPath, int pos) {
        addPhoto(picPath, photoPath, pos, picPath);
    }

    /**
     * 缩略图(比例)生成
     *
     * @param picPath    图片位置
     * @param new_width  新图片宽度
     * @param newPicPath 新图片位置
     */
    public void changeSmall(String picPath, int new_width, String newPicPath) {
        try {
            //获取源图
            BufferedImage img = ImageIO.read(new File(picPath));
            int w = img.getWidth();
            int h = img.getHeight();
            //建立新图像
            int new_height = (int) (h * ((double) new_width / w));
            BufferedImage new_img = new BufferedImage(new_width, new_height, 1);
            Graphics2D g = new_img.createGraphics();
            g.drawImage(img, 0, 0, new_width, new_height, 0, 0, w, h, null);
            ImageIO.write(new_img, FORMAT_NAME, new File(newPicPath));
            g.dispose();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    /**
     * 正方形裁剪
     *
     * @param picPath
     * @param x          裁剪起点X
     * @param y          裁剪起点Y
     * @param new_width  裁剪图片宽
     * @param newPicPath 裁剪图片位置
     */
    public void cut(String picPath, int x, int y, int new_width, String newPicPath) {
        try {
            //获取源图
            BufferedImage img = ImageIO.read(new File(picPath));
            int w = img.getWidth();
            int h = img.getHeight();
            //建立新图像
            int new_height = new_width;
            BufferedImage new_img = new BufferedImage(new_width, new_height, 1);
            Graphics2D g = new_img.createGraphics();
            g.drawImage(img, 0, 0, new_width, new_height, x, y, x + new_width, y + new_height, null);
            ImageIO.write(new_img, FORMAT_NAME, new File(newPicPath));
            g.dispose();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}