<%
    /*if (session.getAttribute("admin") == null) {
        response.sendRedirect("/index.jsp");
    } else {
        if (!session.getAttribute("admin").toString().equals("root")) {
            response.sendRedirect("/index.jsp");
        }
    }*/
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>重置后台管理系统密码</title>
    <link href="management-css/header.css" rel="stylesheet" type="text/css">
    <link href="management-css/footer.css" rel="stylesheet" type="text/css">
    <link href="management-css/reset_pwd.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/time_and_exit.js"></script>
    <script>
        $(function () {
            $("#pwd_submit").click(function () {
                var name = $("input[type=text]").val();
                var pass = $("#4").val();
                var pass1 = $("#5").val();
                $.ajax({
                    type: "post",
                    url: "pwd.do",
                    data: {n: name, p: pass, p1: pass1},
                    dataType: 'json',
                    success: function (d) {
                        alert(d);
                        location.href="/management/index.jsp";
                    }
                })
            })
        })
    </script>
</head>
<body onload="showTime()">
<header>
    <div class="top_left"><img src="management-css/images/orangelala.png" height="90" width="200"/></div>
    <div class="top_bottom">
        <ul>
            <li><a href="management/index.jsp"><input class="button" type="button" value="首页"></a></li>
            <li><a href="management/user_manage.jsp"><input class="button" type="button" value="用户"></a></li>
            <li><a href="management/class_manage.jsp"><input class="button1" type="button" value="商品分类"></a></li>
            <li><a href="management/order_manage.jsp"><input class="button" type="button" value="订单"></a></li>
            <li><a href="management/goods_detail_manage.jsp"><input class="button1" type="button" value="商品详细"></a></li>
            <li><a href="management/announcement_manage.jsp"><input class="button" type="button" value="轮播"></a></li>
        </ul>
    </div>
    <div class="top_bottom2">
        <div class="top_bottom2_right">
            管理员您好，今天是<span id="times"></span>，欢迎来到OrangeLaLa后台管理系统！
        </div>
    </div>
</header>
<main>
    <div class="main_top_left">
        您现在的位置:<a>OrangeLaLa</a>>密码重置
    </div>
    <div class="main_center_left">
        <p><img src="management-css/images/ai.png"><strong>管理首页</strong></p>
        <hr class="line">
        <div class="main_center">
            密码重置
        </div>
        <div class="main_center_1">
            <ul>
                <li>用户名:<input type="text" id="1"><span id="1_1"></span></li>
                <li>新密码:<input type="password" id="4"><span id="4_4"></span></li>
                <li id="center_7">确认密码:<input type="password" id="5" onblur="change5()"><span id="5_5"></span></li>
                <li class="main_center_bottom"><input type="image" src="management-css/images/submit.gif" id="pwd_submit"></li>
            </ul>
        </div>
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