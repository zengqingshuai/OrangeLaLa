<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <title>后台管理系统登录</title>
    <link href="management-css/header.css" rel="stylesheet" type="text/css">
    <link href="management-css/footer.css" rel="stylesheet" type="text/css">
    <link href="management-css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="js/time_and_exit.js"></script>
    <script>
        $(function () {
            $('input[type=submit]').click(function () {
                var a = $("#past1").val();
                var b = $("#past2").val();
                if (a == "") {
                    $('#past1_1').html("账号不能为空");
                } else {
                    if (b == "") {
                        $('#past2_2').html("密码不能为空");
                    } else {
                        $.ajax({
                            type: "post",
                            data: {name: a, pass: b},
                            dataType: 'json',
                            url: "login.do",
                            success: function (d) {
                                if (d == "/management/index.jsp") {
                                    location.href = d;
                                } else {
                                    alert(d);
                                }
                            }
                        });
                    }
                }

            });
        })
    </script>
</head>
<body onload="showTime()">
<header>
    <div class="top_left"><img src="management-css/images/orangelala.png" height="90" width="200"/></div>
    <div class="top_bottom">
        <ul>.
            <li><a href="management/index.jsp"><input class="button" type="button" value="首页"></a></li>
            <li><a href="management/user_manage.jsp"><input class="button" type="button" value="用户"></a></li>
            <li><a href="management/class_manage.jsp"><input class="button1" type="button" value="商品分类"></a></li>
            <li><a href="management/order_manage.jsp"><input class="button" type="button" value="订单"></a></li>
            <li><a href="management/goods_detail_manage.jsp"><input class="button1" type="button" value="商品详细"></a></li>
            <li><a href="management/announcement_add.jsp"><input class="button" type="button" value="公告"></a></li>
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
        您现在的位置:<a href="home/index.jsp">OrangeLaLa</a>>系统登录
    </div>
    <div class="main_center_left">
        <p><img src="management-css/images/ai.png"><strong>管理首页</strong></p>
        <hr class="line">
        <div class="main_center">
            欢迎登陆OrangeLaLa系统
        </div>
        <div class="main_center_1">
            <ul>
                <li>
                    &nbsp;&nbsp;账户名:<input type="text" id="past1">
                    <span id="past1_1"></span>
                </li>
                <li class="main_center_li2">
                    登录密码:<input type="password" id="past2" name="pass">
                    <span id="past2_2"></span>
                </li>
            </ul>
        </div>
        <div id="login_submit" class="main_center3">
            <input type="submit" value="" class="login_submit">
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