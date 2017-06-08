<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
		<title>个人中心</title>
		<link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
		<link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">
		<link href="../css/personal.css" rel="stylesheet" type="text/css">
		<link href="../css/systyle.css" rel="stylesheet" type="text/css">
		<script src="../js/jquery-3.2.1.min.js"></script>
		<link href="../js/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet">
		<script src="../js/jquery-ui-1.12.1/jquery-ui.js"></script>
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
									<a href="../person/index.jsp" style="font-size: 16px;">欢迎<span style="color: red;font-weight: bolder"><%=session.getAttribute("person_admin")%></span>来到个人中心！</a>
									&nbsp;<a href="javascript:void(0);" onclick="exit()">安全退出</a>
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
					<div class="wrap-left">
						<div class="wrap-list">
							<div class="m-user">
								<!--个人信息 -->
								<div class="m-bg"></div>
								<div class="m-userinfo">
									<div class="m-baseinfo">
										<a href="information.jsp">
											<img src="../images/getAvatar.do.jpg">
										</a>
									</div>
									<div class="m-right">
										<div class="m-new">
											<a href="news.html"><i class="am-icon-bell-o"></i>消息</a>
										</div>
										<div class="m-address">
											<a href="address.jsp" class="i-trigger">我的收货地址</a>
										</div>
									</div>
								</div>

								<!--个人资产-->
								<div class="m-userproperty">
									<div class="s-bar">
										<i class="s-icon"></i>个人资产
									</div>
									<p class="m-bonus">
										<a href="bonus.jsp">
											<i><img src="../images/bonus.png"/></i>
											<span class="m-title">红包</span>
										</a>
									</p>
									<p class="m-coupon">
										<a href="coupon.html">
											<i><img src="../images/coupon.png"/></i>
											<span class="m-title">优惠券</span>
										</a>
									</p>
									<p class="m-bill">
										<a href="bill.jsp">
											<i><img src="../images/wallet.png"/></i>
											<span class="m-title">钱包</span>
										</a>
									</p>
									<p class="m-big">
										<a href="#">
											<i><img src="../images/day-to.png"/></i>
											<span class="m-title">签到有礼</span>
										</a>
									</p>
									<p class="m-big">
										<a href="#">
											<i><img src="../images/72h.png"/></i>
											<span class="m-title">72小时发货</span>
										</a>
									</p>
								</div>
							</div>
							<div class="box-container-bottom"></div>

							<!--订单 -->
							<div class="m-order">
								<div class="s-bar">
									<i class="s-icon"></i>我的订单
									<a class="i-load-more-item-shadow" href="order.jsp">全部订单</a>
								</div>
								<ul>
									<li><a href="order.jsp"><i><img src="../images/pay.png"/></i><span>待付款</span></a></li>
									<li><a href="order.jsp"><i><img src="../images/send.png"/></i><span>待发货</span></a></li>
									<li><a href="order.jsp"><i><img src="../images/receive.png"/></i><span>待收货</span></a></li>
									<li><a href="order.jsp"><i><img src="../images/comment.png"/></i><span>待评价</span></a></li>
									<li><a href="change.html"><i><img src="../images/refund.png"/></i><span>退换货</span></a></li>
								</ul>
							</div>
							<!--九宫格-->
							<div class="user-patternIcon">
								<div class="s-bar">
									<i class="s-icon"></i>我的常用
								</div>
								<ul>
									<a href="../home/shopcart.jsp"><li class="am-u-sm-4"><i class="am-icon-shopping-basket am-icon-md"></i><img src="../images/iconbig.png"/><p>购物车</p></li></a>
									<a href="collection.html"><li class="am-u-sm-4"><i class="am-icon-heart am-icon-md"></i><img src="../images/iconsmall1.png"/><p>我的收藏</p></li></a>
									<a href="../home/index.jsp"><li class="am-u-sm-4"><i class="am-icon-gift am-icon-md"></i><img src="../images/iconsmall0.png"/><p>为你推荐</p></li></a>
									<a href="comment.html"><li class="am-u-sm-4"><i class="am-icon-pencil am-icon-md"></i><img src="../images/iconsmall3.png"/><p>好评宝贝</p></li></a>
									<a href="foot.html"><li class="am-u-sm-4"><i class="am-icon-clock-o am-icon-md"></i><img src="../images/iconsmall2.png"/><p>我的足迹</p></li></a>                                                                        
								</ul>
							</div>
							<!--物流 -->
							<div class="m-logistics">

								<div class="s-bar">
									<i class="s-icon"></i>我的物流
								</div>
								<div class="s-content">
									<ul class="lg-list">

										<li class="lg-item">
										</li>
									</ul>
								</div>
							</div>
							<!--收藏夹 -->
							<div class="you-like">
								<div class="s-bar">我的收藏
									<a class="am-badge am-badge-danger am-round">降价</a>
									<a class="am-badge am-badge-danger am-round">下架</a>
									<a class="i-load-more-item-shadow" href="#"><i class="am-icon-refresh am-icon-fw"></i>换一组</a>
								</div>
								<div class="s-content">
									<div class="s-item-wrap">

									</div>

									<div class="s-item-wrap">
									</div>
									<div class="s-item-wrap">
									</div>

									<div class="s-item-wrap">

									</div>

									<div class="s-item-wrap">

									</div>

									<div class="s-item-wrap">

									</div>

								</div>


							</div>

						</div>
					</div>
					<div class="wrap-right">

						<!-- 日历-->
						<div class="day-list">
							<div class="s-bar">
								<a class="i-history-trigger s-icon" href="#"></a>我的日历
								<a class="i-setting-trigger s-icon" href="#"></a>
							</div>
							<div class="s-care s-care-noweather">
								<div class="s-date">
									<em><%=new SimpleDateFormat("dd").format(new Date())%></em>

									<span><%=new SimpleDateFormat("yyyy年MM月").format(new Date())%></span>
								</div>
							</div>
						</div>
						<!--新品 -->
						<div class="new-goods">
							<div class="s-bar">
								<i class="s-icon"></i>今日新品
								<a class="i-load-more-item-shadow">15款新品</a>
							</div>
							<div class="new-goods-info">
								<a class="shop-info" href="#" target="_blank">
									<div class="face-img-panel">
										<img src="../images/imgsearch1.jpg" alt="">
									</div>
									<span class="new-goods-num ">4</span>
									<span class="shop-title">剥壳松子</span>
								</a>
								<a class="follow " target="_blank">关注</a>
							</div>
						</div>

						<!--热卖推荐 -->
						<div class="new-goods">
							<div class="s-bar">
								<i class="s-icon"></i>热卖推荐
							</div>
							<div class="new-goods-info">
								<a class="shop-info" href="#" target="_blank">
									<div >
										<img src="../images/imgsearch1.jpg" alt="">
									</div>
                                    <span class="one-hot-goods">￥9.20</span>
								</a>
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
		<!--引导 -->

	</body>

</html>