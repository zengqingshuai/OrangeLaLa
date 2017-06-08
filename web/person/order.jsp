<%@ page import="com.fz.db.MysqlUtil2" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fz.db.ConnMysql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
    <title>订单管理</title>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">
    <link href="../css/personal.css" rel="stylesheet" type="text/css">
    <link href="../css/orstyle.css" rel="stylesheet" type="text/css">
    <script src="../AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
    <script src="../AmazeUI-2.4.2/assets/js/amazeui.js"></script>
    <style>
        .tt {
            border-collapse: collapse;
            width: 998px;
            line-height: 20px;
        }

        .tt tr th, .tt tr td {
            border-bottom: 1px solid #c6c6c6;
            border-top: 1px solid #c6c6c6;
            padding: 8px;
            text-align: center;
        }
        .td01{
          width: 40%;
            border-left: 1px solid #c6c6c6;
        }
        .td02,.td03,.td04,.td05{
            width: 10%;
        }
        .td06{
            border-right: 1px solid #c6c6c6;
        }
        .page a {
            display: inline-block;
            padding: 3px;
            line-height: 20px;
            min-width: 20px;
            margin: 0px 5px;
            border: 1px solid #dbdbdb;
            text-decoration: none;
        }

        .page a:hover {
            background-color: #b9c6ff;
        }

        .page span {
            display: inline-block;
            background-color: #b9c6ff;
            padding: 3px;
            line-height: 20px;
            min-width: 20px;
            margin: 0 5px;
            border: 1px solid #dbdbdb;
        }
    </style>

    <script>
        $(function () {
            <%
                for (int i = 1; i < 6; i++) {
                    if (request.getParameter("p" + i) != null) {
                    %>
            var a =<%=i%>
            <%
                    }
                }
            %>
            for (var i = 1; i < 6; i++) {
                $('#show' + i).removeAttr("class");
                $('#tab' + i).removeAttr("class");
                if (i ==a) {
                    $('#show'+i).addClass("am-active");
                    $('#tab'+i).addClass("am-tab-panel am-fade am-active am-in");
                }
                else {
                    $('#tab' + i).addClass("am-tab-panel am-fade");
                }
            }
        });
        function exit() {
            if(confirm("确认退出？")){
                location.href="../exit.action"
            }
        }
    </script>

</head>

<body>
<!--头 -->
<header>
    <article>
        <div class="mt-logo">
            <!--顶部导航条 -->
            <div class="am-container header">
                <ul class="message-l">
                    <div class="topMessage">
                        <div class="menu-hd">
                            <span id="top_f"></span>
                            <script>
                                var a='<%=session.getAttribute("person_admin")%>';
                                if(a!="null"){
                                    $("#top_f").append('<a href="../person/index.jsp">欢迎<span style="color: red;font-weight: bolder"><%=session.getAttribute("person_admin")%></span>来到个人中心！</a>')
                                    $("#top_f").append(' <a href="javascript:void(0);" onclick="exit()">安全退出</a>')
                                }
                            </script>
                        </div>
                    </div>
                </ul>
                <ul class="message-r">
                    <div class="topMessage home">
                        <div class="menu-hd"><a href="../home/index.jsp" target="_top" class="h">商城首页</a></div>
                    </div>
                    <div class="topMessage my-shangcheng">
                        <div class="menu-hd MyShangcheng"><a href="index.jsp" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
                    </div>
                    <div class="topMessage mini-cart">
                        <div class="menu-hd"><a id="mc-menu-hd" href="../home/shopcart.jsp" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
                    </div>
                    <div class="topMessage favorite">
                        <div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div>
                    </div>
                </ul>
            </div>

            <!--悬浮搜索框-->

            <div class="nav white">
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
                        source: "../home/searchgoods.action",
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
        </div>
    </article>
</header>
<div class="nav-table">
    <div class="long-title"><span class="all-goods">我的中心</span></div>
    <div class="nav-cont">
        <ul>
            <li class="index"><a href="../home/index.jsp">首页</a></li>
            <li class="qc"><a href="#">闪购</a></li>
            <li class="qc"><a href="#">限时抢</a></li>
            <li class="qc"><a href="#">团购</a></li>
            <li class="qc last"><a href="#">大包装</a></li>
        </ul>
        <div class="nav-extra">
            <i class="am-icon-user-secret am-icon-md nav-user"></i><b></b>我的福利
            <i class="am-icon-angle-right" style="padding-left: 10px;"></i>
        </div>
    </div>
</div>
<b class="line"></b>
<div class="center">
    <div class="col-main">
        <div class="main-wrap">

            <div class="user-order">


                <!--标题 -->
                <div class="am-cf am-padding">
                    <div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">订单管理</strong> /
                        <small>Order</small>
                    </div>
                </div>
                <hr/>

                <div class="am-tabs am-tabs-d2 am-margin" data-am-tabs>

                    <ul class="am-avg-sm-5 am-tabs-nav am-nav am-nav-tabs">
                        <li id="show1" class="am-active"><a href="#tab1">所有订单</a></li>
                        <li id="show2"><a href="#tab2">待付款</a></li>
                        <li id="show3"><a href="#tab3">待发货</a></li>
                        <li id="show4"><a href="#tab4">待收货</a></li>
                        <%--<li id="show5"><a href="#tab5">待评价</a></li>--%>
                    </ul>

                    <div class="am-tabs-bd">
                        <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                            <div class="order-top">
                                <div class="th th-item">
                                    <td class="td-inner">商品</td>
                                </div>
                                <div class="th th-price">
                                    <td class="td-inner">单价</td>
                                </div>
                                <div class="th th-number">
                                    <td class="td-inner">数量</td>
                                </div>
                                <div class="th th-operation">
                                    <td class="td-inner">商品规格</td>
                                </div>
                                <div class="th th-amount">
                                    <td class="td-inner">合计</td>
                                </div>
                                <div class="th th-status">
                                    <td class="td-inner">交易状态</td>
                                </div>
                                <%--<div class="th th-change">--%>
                                <%--<td class="td-inner">交易操作</td>--%>
                                <%--</div>--%>
                            </div>

                            <div class="order-main">
                                <div class="order-list">
                                    <table class="tt">
                                        <%
                                            ConnMysql c=new ConnMysql();
                                            String uid=c.queryByField("oll_user","id","where account ='"+session.getAttribute("person_admin").toString()+"'").toString();
                                            MysqlUtil2 mu = new MysqlUtil2();
                                            mu.setPagesize(4);
                                            int currpage1 = request.getParameter("p1") == null ? 1 : Integer.parseInt(request.getParameter("p1"));
                                            mu.setCurrpage(currpage1);
                                            List<Map<String, Object>> list = mu.page("oll_order a,oll_order_info b,oll_goods c", "a.status,b.num,c.goodsname,c.price,c.equiv,a.total", "where a.id=b.orderid and a.status!=6 and b.goodsid=c.id and a.uid="+uid, "");
                                            String stat = "";
                                            if (list!=null){
                                            for (Map<String, Object> m : list) {
                                                if (m.get("status").toString().equals("1")) {
                                                    stat = "未付款";
                                                } else if (m.get("status").toString().equals("2")) {
                                                    stat = "商家未发货";
                                                } else if (m.get("status").toString().equals("3")) {
                                                    stat = "已发货";
                                                } else if (m.get("status").toString().equals("4")) {
                                                    stat = "确认收货";
                                                } else if (m.get("status").toString().equals("5")) {
                                                    stat = "取消订单";
                                                }
                                        %>
                                        <!--交易成功-->
                                        <tr>
                                            <td class="td01"><%=m.get("goodsname")%>
                                            </td>
                                            <td class="td02"><%=m.get("price")%>
                                            </td>
                                            <td class="td03"><%=m.get("num")%>
                                            </td>
                                            <td class="td04"><%=m.get("equiv")%>
                                            </td>
                                            <td class="td05"><%=m.get("total")%>
                                            </td>
                                            <td class="td06"><%=stat%>
                                            </td>
                                        </tr>
                                        <%} }%>
                                        <tr>
                                            <td colspan="100">
                                                <%=mu.pageIn(1)%>
                                            </td>
                                        </tr>

                                    </table>
                                    <!--不同状态订单-->

                                </div>

                            </div>

                        </div>
                        <div class="am-tab-panel am-fade" id="tab2">

                            <div class="order-top">
                                <div class="th th-item">
                                    <td class="td-inner">商品</td>
                                </div>
                                <div class="th th-price">
                                    <td class="td-inner">单价</td>
                                </div>
                                <div class="th th-number">
                                    <td class="td-inner">数量</td>
                                </div>
                                <div class="th th-operation">
                                    <td class="td-inner">商品规格</td>
                                </div>
                                <div class="th th-amount">
                                    <td class="td-inner">合计</td>
                                </div>
                                <div class="th th-status">
                                    <td class="td-inner">交易状态</td>
                                </div>
                                <%--<div class="th th-change">--%>
                                    <%--<td class="td-inner">交易操作</td>--%>
                                <%--</div>--%>
                            </div>

                            <div class="order-main">
                                <div class="order-list">
                                    <table class="tt">
                                        <%
                                            MysqlUtil2 mu1 = new MysqlUtil2();
                                            mu1.setPagesize(1);
                                            int currpage2 = request.getParameter("p2") == null ? 1 : Integer.parseInt(request.getParameter("p2"));
                                            mu1.setCurrpage(currpage2);
                                            List<Map<String, Object>> list1 = mu1.page("oll_order a,oll_order_info b,oll_goods c", " a.status,b.num,c.goodsname,c.price,c.equiv,a.total", "where a.id=b.orderid and b.goodsid=c.id and a.status=1 and a.uid="+uid, "");
                                            String stat1 = "";
                                            if (list1!=null){
                                            for (Map<String, Object> m1 : list1) {
                                                if (m1.get("status").toString().equals("1")) {
                                                    stat1 = "未付款";
                                                }

                                        %>
                                        <!--交易成功-->
                                        <tr>
                                            <td class="td01"><%=m1.get("goodsname")%>
                                            </td>
                                            <td class="td02"><%=m1.get("price")%>
                                            </td>
                                            <td class="td03"><%=m1.get("num")%>
                                            </td>
                                            <td class="td04"><%=m1.get("equiv")%>
                                            </td>
                                            <td class="td05"><%=m1.get("total")%>
                                            </td>
                                            <td class="td06"><%=stat1%>
                                            </td>
                                        </tr>
                                        <%}
                                        }%>
                                        <tr>
                                            <td colspan="100">
                                                <%=mu1.pageIn(2)%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="am-tab-panel am-fade" id="tab3">
                            <div class="order-top">
                                <div class="th th-item">
                                    <td class="td-inner">商品</td>
                                </div>
                                <div class="th th-price">
                                    <td class="td-inner">单价</td>
                                </div>
                                <div class="th th-number">
                                    <td class="td-inner">数量</td>
                                </div>
                                <div class="th th-operation">
                                    <td class="td-inner">商品规格</td>
                                </div>
                                <div class="th th-amount">
                                    <td class="td-inner">合计</td>
                                </div>
                                <div class="th th-status">
                                    <td class="td-inner">交易状态</td>
                                </div>
                                <%--<div class="th th-change">--%>
                                    <%--<td class="td-inner">交易操作</td>--%>
                                <%--</div>--%>
                            </div>

                            <div class="order-main">
                                <div class="order-list">
                                    <table class="tt">
                                    <%
                                    MysqlUtil2 mu2 = new MysqlUtil2();
                                    mu2.setPagesize(1);
                                    int currpage3 = request.getParameter("p3") == null ? 1 : Integer.parseInt(request.getParameter("p3"));
                                    mu2.setCurrpage(currpage3);
                                    List<Map<String, Object>> list2 = mu2.page("oll_order a,oll_order_info b,oll_goods c", " a.status,b.num,c.goodsname,c.price,c.equiv,a.total", "where a.id=b.orderid and b.goodsid=c.id and a.status=2 and a.uid="+uid, "");
                                    String stat2 = "";
                                    if (list2!=null){


                                    for (Map<String, Object> m2 : list2) {
                                    if (m2.get("status").toString().equals("2")) {
                                    stat2 = "待发货";
                                    }
                                    %>
                                    <!--交易成功-->
                                    <tr>
                                        <td class="td01"><%=m2.get("goodsname")%>
                                        </td>
                                        <td class="td02"><%=m2.get("price")%>
                                        </td>
                                        <td class="td03"><%=m2.get("num")%>
                                        </td>
                                        <td class="td04"><%=m2.get("equiv")%>
                                        </td>
                                        <td class="td05"><%=m2.get("total")%>
                                        </td>
                                        <td class="td06"><%=stat2%>
                                        </td>
                                    </tr>
                                    <%}
                                        }%>
                                    <tr>
                                    <td colspan="100">
                                    <%=mu2.pageIn(3)%>
                                    </td>
                                    </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="am-tab-panel am-fade" id="tab4">
                            <div class="order-top">
                                <div class="th th-item">
                                    <td class="td-inner">商品</td>
                                </div>
                                <div class="th th-price">
                                    <td class="td-inner">单价</td>
                                </div>
                                <div class="th th-number">
                                    <td class="td-inner">数量</td>
                                </div>
                                <div class="th th-operation">
                                    <td class="td-inner">商品规格</td>
                                </div>
                                <div class="th th-amount">
                                    <td class="td-inner">合计</td>
                                </div>
                                <div class="th th-status">
                                    <td class="td-inner">交易状态</td>
                                </div>
                                <%--<div class="th th-change">--%>
                                    <%--<td class="td-inner">交易操作</td>--%>
                                <%--</div>--%>
                            </div>

                            <div class="order-main">
                                <div class="order-list">
                                    <table class="tt">
                                        <%
                                            MysqlUtil2 mu3 = new MysqlUtil2();
                                            mu3.setPagesize(1);
                                            int currpage4 = request.getParameter("p4") == null ? 1 : Integer.parseInt(request.getParameter("p4"));
                                            mu3.setCurrpage(currpage4);
                                            List<Map<String, Object>> list3 = mu3.page("oll_order a,oll_order_info b,oll_goods c", " a.status,b.num,c.goodsname,c.price,c.equiv,a.total", "where a.id=b.orderid and b.goodsid=c.id and a.status=3 and a.uid="+uid, "");
                                            String stat3 = "";
                                            if (list3!=null){
                                            for (Map<String, Object> m2 : list3) {
                                                if (m2.get("status").toString().equals("3")) {
                                                    stat3 = "待收货";
                                                }
                                        %>
                                        <!--交易成功-->
                                        <tr>
                                            <td class="td01"><%=m2.get("goodsname")%>
                                            </td>
                                            <td class="td02"><%=m2.get("price")%>
                                            </td>
                                            <td class="td03"><%=m2.get("num")%>
                                            </td>
                                            <td class="td04"><%=m2.get("equiv")%>
                                            </td>
                                            <td class="td05"><%=m2.get("total")%>
                                            </td>
                                            <td class="td06"><%=stat3%>
                                            </td>
                                        </tr>
                                        <%}}%>
                                        <tr>
                                            <td colspan="100">
                                                <%=mu3.pageIn(4)%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="am-tab-panel am-fade" id="tab5">
                            <div class="order-top">
                                <div class="th th-item">
                                    <td class="td-inner">商品</td>
                                </div>
                                <div class="th th-price">
                                    <td class="td-inner">单价</td>
                                </div>
                                <div class="th th-number">
                                    <td class="td-inner">数量</td>
                                </div>
                                <div class="th th-operation">
                                    <td class="td-inner">商品操作</td>
                                </div>
                                <div class="th th-amount">
                                    <td class="td-inner">合计</td>
                                </div>
                                <div class="th th-status">
                                    <td class="td-inner">交易状态</td>
                                </div>
                                <div class="th th-change">
                                    <td class="td-inner">交易操作</td>
                                </div>
                            </div>

                            <div class="order-main">
                                <div class="order-list">
                                    <!--不同状态的订单	-->
                                    <div class="order-status4">

                                        <div class="order-content">


                                        </div>
                                    </div>


                                    <div class="order-status4">

                                        <div class="order-content">


                                        </div>
                                    </div>


                                </div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!--底部-->
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
    <aside class="menu">
        <ul>
            <li class="person active">
                <a></a>
            </li>
            <li class="person">
                <a>个人资料</a>
                <ul>
                    <li> <a href="information.jsp">个人信息</a></li>
                    <li> <a href="safety.jsp">安全设置</a></li>
                    <li> <a href="address.jsp">收货地址</a></li>
                </ul>
            </li>
            <li class="person">
                <a>我的交易</a>
                <ul>
                    <li><a href="order.jsp">订单管理</a></li>
                    <li> <a href="change.html">退款售后</a></li>
                </ul>
            </li>
            <li class="person">
                <a>我的资产</a>
                <ul>
                    <li> <a href="coupon.html">优惠券 </a></li>
                    <li> <a href="bonus.jsp">红包</a></li>
                    <li> <a href="bill.jsp">账单明细</a></li>
                </ul>
            </li>

            <li class="person">
                <a>我的小窝</a>
                <ul>
                    <li> <a href="collection.html">收藏</a></li>
                    <li> <a href="foot.html">足迹</a></li>
                    <li> <a href="comment.html">评价</a></li>
                    <li> <a href="news.html">消息</a></li>
                </ul>
            </li>
        </ul>
    </aside>
</div>

</body>

</html>