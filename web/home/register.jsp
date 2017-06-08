<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head lang="en">
    <meta charset="UTF-8">
    <title>注册</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="stylesheet" href="../AmazeUI-2.4.2/assets/css/amazeui.min.css"/>
    <link href="../css/dlstyle.css" rel="stylesheet" type="text/css">
    <script src="../AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
    <script src="../AmazeUI-2.4.2/assets/js/amazeui.min.js"></script>
    <script>
        $(function () {
            $("#submit").click(function () {
                var user = $('input[name=user]').val();
                var pass1 = $("#password_she").val();
                var pass2 = $("#passwordRepeat").val();
                var checkcode = $("#code").val();
                if (user != "" && pass1 != "") {
                    $.ajax({
                        type: "post",
                        url: '../register.action',
                        data: {user: user, pass1: pass1, pass2: pass2, checkcode: checkcode, action: "submit"},
                        dataType: 'json',
                        success: function (d) {
                            if (d == "注册成功") {
                                alert(d)
                                location.href = "login.jsp";
                            } else {
                                alert(d)
                            }
                        }
                    })
                } else {
                    alert("账号密码不能为空")
                }
            });
            $('input[name=user]').keyup(function () {
                var user = $(this).val();
                if (user.length >= 6) {
                    $.ajax({
                        type: "post",
                        url: '../register.action',
                        data: {action: "ok", user: user},
                        dataType: 'json',
                        success: function (d) {
                            if (d == "不存在") {
                                $("#tips").css('color', 'green');
                                $("#tips").html("√");
                            } else {
                                $("#tips").css('color', 'red');
                                $("#tips").html("×");
                            }
                        }
                    })
                } else {
                    $("#tips").html("")
                }
            })
        })
    </script>
</head>

<body>

<div class="login-boxtitle">
    <a href="index.jsp"><img alt="" src="../images/logobig.png"/></a>
</div>

<div class="res-banner">
    <div class="res-main">
        <div class="login-banner-bg"><span></span><img src="../images/big.jpg"/></div>
        <div class="login-box">
            <div class="am-tabs" id="doc-my-tabs">
                <ul class="am-tabs-nav am-nav am-nav-tabs am-nav-justify">
                    <li><a href="">帐号注册</a></li>
                </ul>
                <div class="am-tabs-bd">
                    <div class="am-tab-panel">
                        <form method="post">
                            <div class="user-phone">
                                <label for="email"><i class="am-icon-mobile-phone am-icon-md"></i></label>
                                <input type="text" name="user" id="email" placeholder="请输入帐号" maxlength="16">
                                <span id="tips"></span>
                            </div>
                            <div class="user-pass">
                                <label for="password_she"><i class="am-icon-lock"></i></label>
                                <input type="password" name="" id="password_she" placeholder="设置密码">
                            </div>
                            <div class="user-pass">
                                <label for="passwordRepeat"><i class="am-icon-lock"></i></label>
                                <input type="password" name="" id="passwordRepeat" placeholder="确认密码">
                            </div>
                            <div class="verification">
                                <label for="code"><i class="am-icon-code-fork"></i></label>
                                <input type="text" name="" id="code" placeholder="请输入验证码" maxlength="4">
                                <img id="checkaction" src="check.action" alt="看不清？点击换一张！" title="看不清？点击换一张！" onclick="this.src='check.action?'+new Date()">
                            </div>
                        </form>
                        <div class="login-links">
                            <label for="reader-me">
                                <input id="reader-me" type="checkbox"> 点击表示您同意商城《服务协议》
                            </label>
                        </div>
                        <div class="am-cf">
                            <input type="submit" id="submit" value="注册" class="am-btn am-btn-primary am-btn-sm am-fl">
                        </div>
                        <hr>
                    </div>
                    <script>
                        $(function () {
                            $('#doc-my-tabs').tabs();
                        })
                    </script>
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
</div>
</body>

</html>