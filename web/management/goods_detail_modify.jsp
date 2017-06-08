<%@ page import="com.fz.db.MyDbUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fz.db.ConnMysql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改商品详细信息</title>
    <link href="../management-css/goods_detail_modify.css" rel="stylesheet" type="text/css">
    <link href="../management-css/header.css" rel="stylesheet" type="text/css">
    <link href="../management-css/footer.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../js/time_and_exit.js"></script>
    <script>
        var a ='<%=session.getAttribute("info_modifyGoods")%>';
        <%session.removeAttribute("info_modifyGoods");%>
        if (a == "000") {
            alert("修改成功!");
            location.href="goods_detail_manage.jsp";
        } else if (a == "001") {
            alert("数据输入有误，请检查!")
        } else if (a == "002") {
            alert("只能上传图片！")
        } else if (a == "003") {
            alert("商品已存在")
        } else if (a == "004") {
            alert("信息填写不完整，请检查!")
        }
    </script>
</head>
<body onload="showTime()">
<header>
    <div class="top_left"><img src="../management-css/images/orangelala.png" height="90" width="200"/></div>
    <div class="top_bottom">
        <ul>
            <li><a href="index.jsp"><input class="button" type="button" value="首页"></a></li>
            <li><a href="user_manage.jsp"><input class="button" type="button" value="用户"></a></li>
            <li><a href="class_manage.jsp"><input class="button1" type="button" value="商品分类"></a></li>
            <li><a href="order_manage.jsp"><input class="button" type="button" value="订单"></a></li>
            <li><a href="goods_detail_manage.jsp"><input class="button1" type="button" value="商品详细"></a></li>
            <li><a href="announcement_manage.jsp"><input class="button" type="button" value="轮播"></a></li>
            <li><a><input id="exit" class="button" type="button" value="退出"></a></li>
        </ul>
    </div>
    <div class="top_bottom2">
        <div class="top_bottom2_right">
            管理员您好，今天是<span id="times"></span>，欢迎来到OrangeLaLa后台管理系统！
        </div>
    </div>
</header>
<main>
    <!---左上--->
    <div class="main_top_left">
        你现在的位置：<a href="../home/index.jsp">OrangeLaLa</a>>商品详细信息管理系统
    </div>
    <!--中左表格-->
    <div class="main_left">
        <ul>
            <li class="main_li-1"><strong>&nbsp;用户管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="user_manage.jsp">用户管理</a></li>
            <li class="main_li-1"><strong>&nbsp;商品分类管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="class_manage.jsp">一级分类管理</a>
                <span><a href="class_add.jsp">新增</a></span></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="category_manage.jsp">二级分类管理</a>
                <span><a href="category_add.jsp">新增</a></span></li>
            <li class="main_li-1"><strong>&nbsp;订单管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="order_manage.jsp">订单管理</a></li>
            <li class="main_li-1"><strong>&nbsp;商品详细管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="goods_detail_manage.jsp">商品详细管理</a>
                <span><a href="goods_detail_add.jsp">新增</a></span></li>
            <li class="main_li-1"><strong>&nbsp;轮播管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png" class="dd1"><a href="announcement_add.jsp">轮播管理</a>
                <span><a href="announcement_add.jsp">新增</a></span></li>
        </ul>
    </div>
    <div class="main_center_left">
        <p><img src="../management-css/images/ai.png"><strong>修改商品详细信息</strong></p>
        <hr class="line">
        <form action="goodsModify.do" method="post" enctype="multipart/form-data">
            <table class="main-right-footer">
                <tr>
                    <td class="main-right-footer-1">商品旧名称:</td>
                    <td>
                        <%
                            String modify = request.getParameter("modifygoods");
                            ConnMysql cm=new ConnMysql();
                            List<Map<String,Object>> l=cm.query("select * from oll_goods where goodsname='"+modify+"'");
                        %>
                        <span><%=modify%></span>
                        <input hidden type="text" name="oldname" value="<%=modify%>">
                    </td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">商品新名称:</td>
                    <td><input type="text" size="50" maxlength="50" name="newname"></td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">商品介绍:</td>
                    <td><input type="text" size="50" value="<%=l.get(0).get("descr")%>" maxlength="50" name="descr"></td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">所属二级分类:</td>
                    <td>
                        <select name="goods_type">
                            <%
                                MyDbUtil mu = new MyDbUtil();
                                List<Map<String, Object>> list = mu.query("oll_type2", "name", "where 1=1", "", "");
                                for (Map<String, Object> m : list) {
                            %>
                            <option><%=m.get("name")%>
                            </option>
                            <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">品牌:</td>
                    <td><input type="text" name="brand" value="<%=l.get(0).get("brand")%>" size="50"></td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">价格:</td>
                    <td><input type="text" size="50" maxlength="16" value="<%=l.get(0).get("price")%>" name="price"></td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">库存:</td>
                    <td><input type="text" size="50" value="<%=l.get(0).get("store")%>" name="num"></td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">规格:</td>
                    <td><input type="text" name="equiv" value="<%=l.get(0).get("equiv")%>" size="50"></td>
                </tr>
                <tr>
                    <td class="main-right-footer-1">图片:</td>
                    <td><input type="file" name="picname"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input id="submit-form" style="cursor: pointer"  type="submit" value="修改"></td>
                </tr>
            </table>
        </form>
    </div>
</main>
<footer>
    <div>
        <p class="footer_top">
            友情链接:
            <a href="https://www.baidu.com/" target="_blank">百度</a>|
            <a href="https://www.google.com.hk/" target="_blank">Google</a>|
            <a href="" target="_blank">雅虎</a>|
            <a href="http://uland.taobao.com" target="_blank">淘宝</a>|
            <a href="http://www.ppdai.com/" target="_blank">拍拍</a>|
            <a href="https://www.paypal-biz.com/" target="_blank">易趣</a>|
            <a href="http://www.dangdang.com/" target="_blank">当当</a>|
            <a href="https://www.jd.com/" target="_blank">京东商城</a>|
            <a href="http://www.xunlei.com/" target="_blank">迅雷</a>|
            <a href="http://www.sina.com.cn/" target="_blank">新浪</a>|<a href="http://www.163.com/">网易</a>|
            <a href="http://www.sohu.com/" target="_blank">搜狐</a>|
            <a href="http://www.mop.com/" target="_blank">猫扑</a>|
            <a href="http://kx.99.com/" target="_blank">开心网</a>|
            <a href="http://www.xinhuanet.com" target="_blank">新华网</a>|
            <a href="http://www.ifeng.com/" target="_blank">凤凰网</a>
        </p>
    </div>
    <div class="footer_line"></div>
    <div class="footer_center">
        <p>CORYRIGHT&nbsp;&copy;&nbsp;2016-2017&nbsp; 郑州市OrangeLaLa商城有限公司
            &nbsp;ALL&nbsp;RIGHT&nbsp;RESERVED</p>
        <p>&nbsp;丰泽研发部&nbsp;</p>
        <p>Email:service@168.com</p>
        <p>ICP:京ICP备00000001号</p>
    </div>
</footer>
</body>
</html>