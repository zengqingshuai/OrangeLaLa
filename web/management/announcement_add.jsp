<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="zh">
    <meta charset="UTF-8">
    <title>轮播添加</title>
    <link href="../management-css/page.css" rel="stylesheet" type="text/css">
    <link href="../management-css/header.css" rel="stylesheet" type="text/css">
    <link href="../management-css/footer.css" rel="stylesheet" type="text/css">
    <link href="../management-css/announcement_add.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../js/time_and_exit.js"></script>
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
        你现在的位置：<a href="../home/index.jsp">OrangeLaLa</a>>轮播管理系统
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
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png" class="dd1"><a href="announcement_manage.jsp">轮播管理</a>
                <span><a href="announcement_add.jsp">新增</a></span></li>
        </ul>
    </div>
    <div class="main_center_left">
        <p><img src="../management-css/images/ai.png"><strong>轮播添加</strong></p>
        <hr class="line">
        <div class="main_center_right">
            <form action="upload.action" method="post" enctype="multipart/form-data">
                <ul>
                    <li>链接分类名:<input type="text" name="address"></li>
                    <li>&nbsp;&nbsp;上传图片:<input type="file" name="upload"></li>
                    <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态:
                        <select name="sele">
                            <option selected>显示</option>
                            <option>不显示</option>
                        </select>
                    </li>
                    <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="上传"></li>
                </ul>
            </form>
        </div>
    </div>
    <script>
        var h = "<%=session.getAttribute("user_upload")%>";
        if (h != "null") {
            alert(h);
            <%session.removeAttribute("user_upload");%>
        }
    </script>
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