<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>付款成功页面</title>
    <link rel="stylesheet" type="text/css" href="../AmazeUI-2.4.2/assets/css/amazeui.css"/>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
    <link href="../basic/css/demo.css" rel="stylesheet" type="text/css"/>
    <link href="../css/sustyle.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="../basic/js/jquery-1.7.min.js"></script>
    <script>
        function exit() {
            if(confirm("确认退出？")){
                location.href="../exit.action"
            }
        }
    </script>
</head>
<body>
<!--顶部导航条 -->
<div class="am-container header">
    <ul class="message-l">
        <div class="topMessage">
            <div class="menu-hd">
                <span id="top_f"></span>
                <script>
                    var a='<%=session.getAttribute("person_admin")%>';
                    if(a!="null"){
                        $("#top_f").append('<a href="../person/index.jsp" style="font-size: 17px">欢迎 <%=session.getAttribute("person_admin")%> ！</a>')
                        $("#top_f").append(' <a href="javascript:void(0);" onclick="exit()">安全退出</a>')
                    }else {
                        $("#top_f").append('<a href="login.jsp">亲,点击登陆</a>');
                        $("#top_f").append('  <a href="register.jsp" target="_top">免费注册</a>')
                    }
                </script>
            </div>
        </div>
    </ul>
    <ul class="message-r">
        <div class="topMessage home">
            <div class="menu-hd"><a href="index.jsp" target="_top" class="h">商城首页</a></div>
        </div>
        <div class="topMessage my-shangcheng">
            <div class="menu-hd MyShangcheng"><a href="../person/index.jsp" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
        </div>
        <div class="topMessage mini-cart">
            <div class="menu-hd"><a id="mc-menu-hd" href="shopcart.jsp" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
        </div>
        <div class="topMessage favorite">
            <div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div>
        </div>
    </ul>
</div>

<!--悬浮搜索框-->

<div class="nav white">
    <div class="logo"><img src="../images/logo.png"/></div>
    <div class="logoBig">
        <li><img src="../images/logobig.png"/></li>
    </div>
    <div class="search-bar pr ui-widget">
        <input id="tags" type="text" placeholder="输入关键字" style="border: solid rgba(255,0,0,0.75);">
        <input id="ai-topsearch" class="submit am-btn" value="搜索" type="submit">
    </div>
</div>
<script>
    $(function () {
        $("#tags").autocomplete({
            source: "searchgoods.action",
            minLength: 1,
            select: function (event, ui) {
            }
        });
        $("#ai-topsearch").click(function () {
            var keyword = $("#tags").val();
            if (keyword.length > 0) {
                location.href = "search.jsp?searchkeyword=" + keyword;
            }
        });
    });

</script>
<div class="clear"></div>


<div class="take-delivery">
    <div class="status">
        <h2>您已成功付款</h2>
        <div class="successInfo">
            <ul>
                <li>付款金额<em>¥9.90</em></li>
                <div class="user-info">
                    <p>收货人：艾迪</p>
                    <p>联系电话：15871145629</p>
                    <p>收货地址：湖北省 武汉市 武昌区 东湖路75号众环大厦</p>
                </div>
                请认真核对您的收货信息，如有错误请联系客服

            </ul>
            <div class="option">
                <span class="info">您可以</span>
                <a href="../person/order.jsp" class="J_MakePoint">查看<span>已买到的宝贝</span></a>
                <a href="../person/orderinfo.html" class="J_MakePoint">查看<span>交易详情</span></a>
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
