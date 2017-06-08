<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="stylesheet" href="../AmazeUI-2.4.2/assets/css/amazeui.css"/>
    <link href="../css/dlstyle.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery-1.7.2.min.js"></script>
    <script>
        $(function () {
            $("#login_submit").click(function () {
                var u = $("#user").val();
                var pass = $("#password").val();
                $.ajax({
                    type: "post",
                    url: '../login.action',
                    data: {user: u, password: pass},
                    dataType: "text",
                    success: function (f) {
                        if (f == "yes") {
                            location.href = "/home/index.jsp";
                        } else {
                            alert(f)
                        }
                    }
                })

            })
        })
    </script>
</head>
<body>
<div class="login-boxtitle">
    <a href="index.jsp"><img alt="logo" src="../images/logobig.png"/></a>
</div>
<div class="login-banner">
    <div class="login-main">
        <div class="login-banner-bg"><span></span><img src="../images/big.jpg"/></div>
        <div class="login-box">
            <h3 class="title">登录账号</h3>
            <div class="clear"></div>
            <div class="login-form">
                <form>
                    <div class="user-name">
                        <label for="user"><i class="am-icon-user"></i></label>
                        <input type="text" id="user" placeholder="用户名">
                    </div>
                    <div class="user-pass">
                        <label for="password"><i class="am-icon-lock"></i></label>
                        <input type="password" id="password" placeholder="请输入密码">
                    </div>
                </form>
            </div>
            <div class="login-links">
                <label for="remember-me"><input id="remember-me" type="checkbox">记住密码</label>
                <a href="modifypsd.jsp" class="am-fr">忘记密码</a>
                <a href="register.jsp" class="zcnext am-fr am-btn-default">注册</a>
                <br/>
            </div>
            <div class="am-cf">
                <input type="submit" id="login_submit" value="登 录" class="am-btn am-btn-primary am-btn-sm">
            </div>
            <div class="partner">
                <%--<h3>合作账号</h3>--%>
                <%--<div class="am-btn-group">--%>
                <%--<li><a href="#"><i class="am-icon-qq am-icon-sm"></i><span>QQ登录</span></a></li>--%>
                <%--<li><a href="#"><i class="am-icon-weibo am-icon-sm"></i><span>微博登录</span> </a></li>--%>
                <%--<li><a href="#"><i class="am-icon-weixin am-icon-sm"></i><span>微信登录</span> </a></li>--%>
                <%--</div>--%>
            </div>

        </div>
    </div>
</div>

<div class="footer ">
    <div class="footer-hd ">
        <p style="text-align: center">
            <a>夏桔科技</a>
            <b>|</b>
            <a href="index.jsp">商城首页</a>
            <b>|</b>
            <a href="http://www.alipay.com">支付宝</a>
            <b>|</b>
        </p>
    </div>
    <div class="footer-bd ">
        <p style="text-align: center">
            <a href="">关于夏桔</a>
            <a href="">联系我们</a>
            <em>CORYRING&nbsp;&copy;&nbsp;2016-2017&nbsp; 郑州市OrangeLaLa商城有限公司&nbsp;ALL&nbsp;RIGHT&nbsp;RESERVED
                <br>
                ICP:京ICP备00000001号
            </em>
        </p>
    </div>
</div>
</body>

</html>