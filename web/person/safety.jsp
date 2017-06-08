<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">

		<title>安全设置</title>
		<link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
		<link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">
		<link href="../css/personal.css" rel="stylesheet" type="text/css">
		<link href="../css/infstyle.css" rel="stylesheet" type="text/css">
		<script src="../js/jquery-3.2.1.min.js"></script>
		<script src="../js/jquery-ui-1.12.1/jquery-ui.js"></script>
		<link href="../js/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet">
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
									<span id="top_f"></span>
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

					<!--标题 -->
					<div class="user-safety">
						<div class="am-cf am-padding">
							<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">账户安全</strong> / <small>Set&nbsp;up&nbsp;Safety</small></div>
						</div>
						<hr/>

						<div class="check">
							<ul>
								<li>
									<i class="i-safety-lock"></i>
									<div class="m-left">
										<div class="fore1">登录密码</div>
										<div class="fore2"><small>为保证您购物安全，建议您定期更改密码以保护账户安全。</small></div>
									</div>
									<div class="fore3">
										<a href="password.jsp">
											<div class="am-btn am-btn-secondary"><a href="password.jsp" style="color: white">修改</a></div>
										</a>
									</div>
								</li>

								<li>
									<i class="i-safety-idcard"></i>
									<div class="m-left">
										<div class="fore1">实名认证</div>
										<div class="fore2"><small>用于提升账号的安全性和信任级别，认证后不能修改认证信息。</small></div>
									</div>
									<div class="fore3">
										<a href="idcard.html">
											<div class="am-btn am-btn-secondary">认证</div>
										</a>
									</div>
								</li>
								<li>
									<i class="i-safety-security"></i>
									<div class="m-left">
										<div class="fore1">安全问题</div>
										<div class="fore2"><small>保护账户安全，验证您身份的工具之一。</small></div>
									</div>
									<div class="fore3">
										<a href="question.html">
											<div class="am-btn am-btn-secondary">认证</div>
										</a>
									</div>
								</li>
							</ul>
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