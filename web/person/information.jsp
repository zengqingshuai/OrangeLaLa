<%@ page import="com.fz.db.ConnMysql" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改个人信息</title>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">
    <link href="../css/personal.css" rel="stylesheet" type="text/css">
    <link href="../css/infstyle.css" rel="stylesheet" type="text/css">
    <script src="../AmazeUI-2.4.2/assets/js/jquery.min.js" type="text/javascript"></script>
    <script src="../AmazeUI-2.4.2/assets/js/amazeui.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
    <link href="../js/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet">
    <script src="../js/jquery-ui-1.12.1/jquery-ui.js"></script>
    <script>
        function exit() {
            if(confirm("确认退出？")){
                location.href="../exit.action"
            }
        }
        $(function () {
            $("#modify").click(function () {
                $("#modify-info").css("visibility","visible")
            });
            $("#cancel").click(function () {
                $("#modify-info").css("visibility","hidden")
            });
            var a="${mdg}";
            if(a!=""){
                alert(a)
            }
            var b="${msg}${mcg}${mag}${mbg}";
            if(b!=""){
                $("#modify-info").css("visibility","visible");
            }
        })
    </script>
    <style>
        #table{
            margin-left: 100px;
        }
        #table tr td{
            padding: 10px;
        }
        #table th{
            text-align: right;
        }
    </style>
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
            <div class="user-info">
                <!--标题 -->
                <div class="am-cf am-padding">
                    <div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">个人资料</strong> / <small>Personal&nbsp;information</small></div>
                </div>
                <hr>
                <!--头像 -->
                    <table id="table">
                        <%
                            String person_id = session.getAttribute("person_id").toString();
                            ConnMysql cm=new ConnMysql();
                            List<Map<String, Object>> list= cm.query("select * from oll_user_info where uid="+person_id);
                            if (list.size()>0){
                            for (Map<String, Object> map:list) {
                                String gender="";
                                if((Boolean) map.get("gender")){
                                    gender="男";
                                }else{
                                    gender="女";
                                }
                        %>
                        <tr>
                            <th>昵称:</th><td><%=map.get("name")%></td>
                        </tr>
                        <tr>
                            <th>性别:</th><td><%=gender%></td>
                        </tr>
                        <tr>
                            <th>生日:</th><td><%=map.get("birth")%></td>
                        </tr>
                        <tr>
                            <th>地址:</th><td><%=map.get("address")%></td>
                        </tr>
                        <tr>
                            <th>电话:</th><td><%=map.get("phone")%></td>
                        </tr>
                        <tr>
                            <th>电子邮件:</th><td><%=map.get("email")%></td>
                        </tr>
                        <tr><td><input type="button" value="  修改  " id="modify"></td></tr>
                        <%
                            }
                        }else{
                                %>
                        <tr><td><input type="button" value="  添加  " id="modify"></td></tr>
                        <%

                            }
                        %>
                    </table>
                <!--个人信息 -->
                <div class="info-main" id="modify-info" style="visibility: hidden">
                    <form class="am-form am-form-horizontal" action="information.do" method="post">
                        <div class="am-form-group">
                            <label class="am-form-label">昵称</label>
                            <div class="am-form-content">
                                <input type="text" placeholder="Nickname" name="username">
                                <font color="red" size="2"> ${msg}</font>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-form-label">性别</label>
                            <div class="am-form-content sex">
                                    <input type="radio" name="gender" value="1" checked="checked" />男
                                    <input type="radio" name="gender" value="0" />女
                            </div>
                        </div>
                        <div class="an-form-group">
                            <label for="user-phone" class="am-form-label">地址</label>
                            <div class="am-form-content">
                                <input name="adress" placeholder="Adress" type="tel">
                                <font color="red" size="2"> ${mcg}</font>

                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-form-label">生日</label>
                            <div class="am-form-content birth">
                                <div class="birth-select">
                                    <input class="Wdate" type="text" name="birth" placeholder="Birthday"  onclick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d'})">
                                </div>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label for="user-phone" class="am-form-label">电话</label>
                            <div class="am-form-content">
                                <input id="user-phone" name="phone" placeholder="Telephonenumber" type="tel">
                                <font color="red" size="2"> ${mag}</font>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label for="user-email" class="am-form-label">电子邮件</label>
                            <div class="am-form-content">
                                <input id="user-email" placeholder="Email" type="email" name="email">
                                <font color="red" size="2"> ${mbg}</font>
                            </div>
                        </div>

                        <div class="info-btn">
                            <input type="submit" value="保存" class="am-btn-danger">
                            <input type="button" id="cancel" value="取消" class="am-btn-danger">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--底部-->
        <div class="footer ">
            <div class="footer-hd ">
                <p style="text-align: center">
                    <a href="#">夏桔科技</a>
                    <b>|</b>
                    <a href="#">商城首页</a>
                    <b>|</b>
                    <a href="#">支付宝</a>
                    <b>|</b>
                    <a href="#">物流</a>
                </p>
            </div>
            <div class="footer-bd ">
                <p style="text-align: center">
                    <a href="#">关于夏桔</a>
                    <a href="#">联系我们</a>
                    <em>CORYRING&copy;2014-2015&nbsp; 北京市orangelala商城有限公司&nbsp;ALL&nbsp;RIGHT&nbsp;RESERVED
                        <br>
                        ICP:京ICP备02121211号
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
