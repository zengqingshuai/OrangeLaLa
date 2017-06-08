<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/23
  Time: 8:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
        <title>我的红包</title>
        <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
        <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">
        <link href="../css/personal.css" rel="stylesheet" type="text/css">
        <link href="../css/bostyle.css" rel="stylesheet" type="text/css">
        <script src="../AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
        <script src="../AmazeUI-2.4.2/assets/js/amazeui.js"></script>
    <script>function exit() {
        if(confirm("确认退出？")){
            location.href="../exit.action"
        }
    }</script>
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
                            <a href="../person/index.jsp" style="font-size: 16px;">欢迎<span style="color: red;font-weight: bolder"><%=session.getAttribute("person_admin")%></span>来到个人中心!</a>
                            &nbsp;<a href="javascript:void(0);" onclick="exit()">安全退出</a>
                        </div>
                    </div>
                </ul>
                <ul class="message-r">
                    <div class="topMessage home">
                        <div class="menu-hd"><a href="#" target="_top" class="h">商城首页</a></div>
                    </div>
                    <div class="topMessage my-shangcheng">
                        <div class="menu-hd MyShangcheng"><a href="#" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
                    </div>
                    <div class="topMessage mini-cart">
                        <div class="menu-hd"><a id="mc-menu-hd" href="#" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
                    </div>
                    <div class="topMessage favorite">
                        <div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div>
                    </div>
                </ul>
            </div>

            <!--悬浮搜索框-->

            <div class="nav white">
                <div class="logoBig">
                    <li><img src="../images/logobig.png" /></li>
                </div>

                <div class="search-bar pr">
                    <a name="index_none_header_sysc" href="#"></a>
                    <form>
                        <input id="searchInput" name="index_none_header_sysc" type="text" placeholder="搜索" autocomplete="off">
                        <input id="ai-topsearch" class="submit am-btn" value="搜索" index="1" type="submit">
                    </form>
                </div>
            </div>

            <div class="clear"></div>
        </div>
        </div>
    </article>
</header>
<div class="nav-table">
    <div class="long-title"><span class="all-goods">全部分类</span></div>
    <div class="nav-cont">
        <ul>
            <li class="index"><a href="#">首页</a></li>
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

            <div class="user-bonus">
                <!--标题 -->
                <div class="am-cf am-padding">
                    <div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">红包</strong> / <small>Bonus</small></div>
                </div>
                <hr/>

                <div class="am-tabs-d2 am-tabs  am-margin" data-am-tabs>

                    <ul class="am-avg-sm-2 am-tabs-nav am-nav am-nav-tabs">
                        <li class="am-active"><a href="#tab1">可用红包</a></li>
                        <li><a href="#tab2">已用/过期红包</a></li>

                    </ul>

                    <div class="am-tabs-bd">
                        <div class="am-tab-panel am-fade am-in am-active" id="tab1">

                            <div class="cart-table-th">
                                <div class="order-top">
                                    <div class="th th-from">
                                        来源
                                    </div>
                                    <div class="th th-remainderprice">
                                        剩余金额
                                    </div>
                                    <div class="th th-term">
                                        有效期
                                    </div>
                                    <div class="th th-usestatus">
                                        使用状态
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="order-main">


                                </div>
                            </div>
                        </div>
                        <div class="am-tab-panel am-fade" id="tab2">

                            <div class="cart-table-th">
                                <div class="order-top">
                                    <div class="th th-from">
                                        来源
                                    </div>
                                    <div class="th th-remainderprice">
                                        剩余金额
                                    </div>
                                    <div class="th th-term">
                                        有效期
                                    </div>
                                    <div class="th th-usestatus">
                                        使用状态
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="order-main">
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
                <%--<a href="index.jsp">个人中心</a>--%>
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
