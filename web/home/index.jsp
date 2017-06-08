<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fz.db.ConnMysql" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fz.db.ConnMysql" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>首页</title>
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css"/>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css"/>
    <link href="../basic/css/demo.css" rel="stylesheet" type="text/css"/>
    <link href="../css/hmstyle.css" rel="stylesheet" type="text/css"/>
    <link href="../css/skin.css" rel="stylesheet" type="text/css"/>
    <script src="../AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
    <script src="../AmazeUI-2.4.2/assets/js/amazeui.min.js"></script>
    <script src="../js/jquery.js"></script>
    <script src="../js/jquery.flexslider.js"></script>
    <link href="../js/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet">
    <script src="../js/jquery-ui-1.12.1/jquery-ui.js"></script>
    <script>
        function exit() {
            if(confirm("确认退出？")){
                location.href="../exit.action"
            }
        }
    </script>
</head>
<body>

<div class="hmtop">
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
                <div class="menu-hd MyShangcheng"><a href="../person/index.jsp" target="_top"><i
                        class="am-icon-user am-icon-fw"></i>个人中心</a>
                </div>
            </div>
            <div class="topMessage mini-cart">
                <div class="menu-hd"><a id="mc-menu-hd" href="shopcart.jsp" target="_top"><i
                        class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum"
                                                                                              class="h">0</strong></a>
                </div>
            </div>
            <div class="topMessage favorite">
                <div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a>
                </div>
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
</div>
<div class="banner">
    <!--轮播 -->
    <div class="am-slider am-slider-default scoll" data-am-flexslider id="demo-slider-0">
        <ul class="am-slides">
            <%
               ConnMysql cm = new ConnMysql();
                List<Map<String, Object>> list0 = cm.query("select * from oll_activity where status = 1");
                int i = 1;
                for (Map m : list0) {
            %>
            <li class="banner<%=i++%>"><a href="search.jsp?sortkeyword=<%=m.get("path")%>"><img src="../images/<%=m.get("picsname")%>"/></a></li>
            <%
                }
            %>
        </ul>
    </div>
    <div class="clear"></div>
</div>
<div class="shopNav">
    <div class="slideall">
        <div class="long-title"><span class="all-goods">全部分类</span></div>
        <div class="nav-cont">
            <ul>
                <li class="index"><a href="index.jsp">首页</a></li>
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


        <!--侧边导航 -->
        <div id="nav" class="navfull">
            <div class="area clearfix">
                <div class="category-content" id="guide_2">
                    <div class="category">
                        <ul class="category-list" id="js_climit_li">
                            <%
                                List<Map<String, Object>> list1 = cm.query("select * from oll_type1");
                                int j = 0;
                                for (Map m1 : list1) {
                                    j++;
                                    if (j == 1) {
                            %>
                            <li class="appliance js_toggle relative first">
                                    <%
                                    }else if (j==list1.size()){
                                %>
                            <li class="appliance js_toggle relative last">
                                    <%
                                    }else{
                                %>
                            <li class="appliance js_toggle relative">
                                <%
                                    }
                                %>
                                <div class="category-info">
                                    <h3 class="category-name b-category-name">
                                        <i><img src="../images/cake.png">
                                        </i>
                                        <a class="ml-22" href="search.jsp?sortkeyword=<%=m1.get("name")%>">
                                            <%=m1.get("name")%>
                                        </a>
                                    </h3>
                                    <em>&gt;</em>
                                </div>

                                <div class="menu-item menu-in top" style="display: none;">
                                    <div class="area-in">
                                        <div class="area-bg">
                                            <div class="menu-srot">
                                                <div class="sort-side">
                                                    <%
                                                        List<Map<String, Object>> list2 = cm.query("select * from oll_type2 where oll_type2.t1id=" + m1.get("id"));
                                                        for (Map m2 : list2) {
                                                    %>
                                                    <dl class="dl-sort">
                                                        <dt>
                                                            <span><a href="search.jsp?sortkeyword1=<%=m2.get("name")%>"><%=m2.get("name")%></a></span>
                                                        </dt>
                                                        <%
                                                            List<Map<String, Object>> list3 = cm.query("select * from oll_goods where oll_goods.t2id=" + m2.get("id"));
                                                            for (Map m3 : list3) {
                                                        %>
                                                        <dd>
                                                            <a href="introduction.jsp?goodskeyword=<%=m3.get("goodsname")%>">
                                                                <span><%=m3.get("goodsname")%></span>
                                                            </a>
                                                        </dd>
                                                        <%
                                                            }
                                                        %>
                                                    </dl>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <b class="arrow"></b>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!--轮播效果-->
        <script type="text/javascript">
           $(function () {
               $('.am-slider').flexslider();
            });
            $(document).ready(function () {
                $("li").hover(function () {
                    $(".category-content .category-list li.first .menu-in").css("display", "none");
                    $(".category-content .category-list li.first").removeClass("hover");
                    $(this).addClass("hover");
                    $(this).children("div.menu-in").css("display", "block")
                }, function () {
                    $(this).removeClass("hover");
                    $(this).children("div.menu-in").css("display", "none")
                });
            })
        </script>


        <!--小导航 -->
        <div class="am-g am-g-fixed smallnav">
            <div class="am-u-sm-3">
                <a href="shopcart.jsp"><img src="../images/navsmall.jpg"/>
                    <div class="title">商品分类</div>
                </a>
            </div>
            <div class="am-u-sm-3">
                <a href="#"><img src="../images/huismall.jpg"/>
                    <div class="title">大聚惠</div>
                </a>
            </div>
            <div class="am-u-sm-3">
                <a href="#"><img src="../images/mansmall.jpg"/>
                    <div class="title">个人中心</div>
                </a>
            </div>
            <div class="am-u-sm-3">
                <a href="#"><img src="../images/moneysmall.jpg"/>
                    <div class="title">投资理财</div>
                </a>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <script type="text/javascript">
        if ($(window).width() < 640) {
            function autoScroll(obj) {
                $(obj).find("ul").animate({
                    marginTop: "-39px"
                }, 500, function () {
                    $(this).css({
                        marginTop: "0px"
                    }).find("li:first").appendTo(this);
                })
            }

            $(function () {
                setInterval('autoScroll(".demo")', 3000);
            })
        }
    </script>
</div>
<div class="shopMainbg">
    <div class="shopMain" id="shopmain">

        <!--今日推荐 -->

        <div class="am-g am-g-fixed recommendation">
            <div class="clock am-u-sm-3">
                <img src="../images/2016.png "/>
                <p>今日<br>推荐</p>
            </div>
            <div class="am-u-sm-4 am-u-lg-3 ">
                <div class="info ">
                    <h3>真的有鱼</h3>
                    <h4>开年福利篇</h4>
                </div>
                <div class="recommendationMain one">
                    <a href="introduction.jsp?"><img src="../images/tj.png "/></a>
                </div>
            </div>
            <div class="am-u-sm-4 am-u-lg-3 ">
                <div class="info ">
                    <h3>囤货过冬</h3>
                    <h4>让爱早回家</h4>
                </div>
                <div class="recommendationMain two">
                    <img src="../images/tj1.png "/>
                </div>
            </div>
            <div class="am-u-sm-4 am-u-lg-3 ">
                <div class="info ">
                    <h3>浪漫情人节</h3>
                    <h4>甜甜蜜蜜</h4>
                </div>
                <div class="recommendationMain three">
                    <img src="../images/tj2.png "/>
                </div>
            </div>

        </div>
        <div class="clear "></div>
        <!--热门活动 -->

        <div class="am-container activity ">
            <div class="shopTitle ">
                <h4>活动</h4>
                <h3>每期活动 优惠享不停 </h3>
                <span class="more ">
                              <a href="#">全部活动<i class="am-icon-angle-right" style="padding-left:10px ;"></i></a>
                        </span>
            </div>
            <div class="am-g am-g-fixed ">
                <div class="am-u-sm-3 ">
                    <div class="icon-sale one "></div>
                    <h4>秒杀</h4>
                    <div class="activityMain ">
                        <img src="../images/activity1.jpg "/>
                    </div>
                    <div class="info ">
                        <h3>春节送礼优选</h3>
                    </div>
                </div>

                <div class="am-u-sm-3 ">
                    <div class="icon-sale two "></div>
                    <h4>特惠</h4>
                    <div class="activityMain ">
                        <img src="../images/activity2.jpg "/>
                    </div>
                    <div class="info ">
                        <h3>春节送礼优选</h3>
                    </div>
                </div>

                <div class="am-u-sm-3 ">
                    <div class="icon-sale three "></div>
                    <h4>团购</h4>
                    <div class="activityMain ">
                        <img src="../images/activity3.jpg "/>
                    </div>
                    <div class="info ">
                        <h3>春节送礼优选</h3>
                    </div>
                </div>

                <div class="am-u-sm-3 last ">
                    <div class="icon-sale "></div>
                    <h4>超值</h4>
                    <div class="activityMain ">
                        <img src="../images/activity.jpg "/>
                    </div>
                    <div class="info ">
                        <h3>春节送礼优选</h3>
                    </div>
                </div>

            </div>
        </div>
        <div class="clear ">
    </div>
    <%
        int floor = 0;
        for (Map m1 : list1) {
    %>
    <!--分类-->
    <div id="f<%=++floor%>">
        <div class="am-container ">
            <div class="shopTitle ">
                <h4><%=m1.get("name")%></h4>
            </div>
        </div>
        <div class="am-g am-g-fixed floodThree ">
            <div class="am-u-sm-4 text-four list">
                <div class="word">
                    <%
                        List<Map<String, Object>> list4 = cm.query("select distinct oll_type2.name from oll_type2,oll_type1 where oll_type2.t1id=" + m1.get("id"));
                        for (Map m2 : list4) {
                    %>
                    <a class="outer" href="search.jsp?sortkeyword1=<%=m2.get("name")%>"><span class="inner"><b class="text"><%=m2.get("name")%></b></span></a>
                    <%
                        }
                    %>
                </div>
                <a href="search.jsp?sortkeyword=<%=m1.get("name")%>">
                    <img style="width: 220px; height: 220px;" src="../images/<%=m1.get("picsname")%> "/>
                    <div class="outer-con ">
                        <div class="title">
                            <%=m1.get("descr")%>
                        </div>
                    </div>
                </a>
                <div class="triangle-topright"></div>
            </div>
            <%
                List<Map<String, Object>> lg = cm.query("select distinct oll_goods.* from oll_goods,oll_type2,oll_type1 where oll_goods.t2id=oll_type2.id and oll_type2.t1id=" + m1.get("id"));
            if(lg.size()>=6){
            %>
            <div class="am-u-sm-4 text-four">
                <a href="introduction.jsp?goodskeyword=<%=lg.get(0).get("goodsname")%>">
                    <img style="width:180px;height:180px" src="../images/<%=lg.get(0).get("picname")%>"/>
                    <div class="outer-con ">
                        <div class="title ">
                            <%=lg.get(0).get("descr")%>
                        </div>
                        <div class="sub-title ">
                            <%=lg.get(0).get("price")%>
                        </div>
                        <i class="am-icon-shopping-basket am-icon-md seprate"></i>
                    </div>
                </a>
            </div>
            <div class="am-u-sm-4 text-four sug">
                <a href="introduction.jsp?goodskeyword=<%=lg.get(1).get("goodsname")%>">
                    <img style="width:180px;height:180px" src="../images/<%=lg.get(1).get("picname")%>"/>
                    <div class="outer-con ">
                        <div class="title ">
                            <%=lg.get(1).get("descr")%>
                        </div>
                        <div class="sub-title ">
                            <%=lg.get(1).get("price")%>
                        </div>
                        <i class="am-icon-shopping-basket am-icon-md  seprate"></i>
                    </div>
                </a>
            </div>
            <div class="am-u-sm-6 am-u-md-3 text-five big ">
                <a href="introduction.jsp?goodskeyword=<%=lg.get(2).get("goodsname")%>">
                    <img style="width:180px;height:180px" src="../images/<%=lg.get(2).get("picname")%>"/>
                    <div class="outer-con ">
                        <div class="title ">
                            <%=lg.get(2).get("descr")%>
                        </div>
                        <div class="sub-title ">
                            <%=lg.get(2).get("price")%>
                        </div>
                        <i class="am-icon-shopping-basket am-icon-md  seprate"></i>
                    </div>
                </a>
            </div>
            <div class="am-u-sm-6 am-u-md-3 text-five ">
                <a href="introduction.jsp?goodskeyword=<%=lg.get(3).get("goodsname")%>">
                    <img style="width:180px;height:180px" src="../images/<%=lg.get(3).get("picname")%>"/>
                    <div class="outer-con ">
                        <div class="title ">
                            <%=lg.get(3).get("descr")%>
                        </div>
                        <div class="sub-title ">
                            <%=lg.get(3).get("price")%>
                        </div>
                        <i class="am-icon-shopping-basket am-icon-md  seprate"></i>
                    </div>
                </a>
            </div>
            <div class="am-u-sm-6 am-u-md-3 text-five sug">
                <a href="introduction.jsp?goodskeyword=<%=lg.get(4).get("goodsname")%>">
                    <img style="width:180px;height:180px" src="../images/<%=lg.get(4).get("picname")%>"/>
                    <div class="outer-con ">
                        <div class="title ">
                            <%=lg.get(4).get("descr")%>
                        </div>
                        <div class="sub-title ">
                            <%=lg.get(4).get("price")%>
                        </div>
                        <i class="am-icon-shopping-basket am-icon-md  seprate"></i>
                    </div>
                </a>
            </div>
            <div class="am-u-sm-6 am-u-md-3 text-five big">
                <a href="introduction.jsp?goodskeyword=<%=lg.get(5).get("goodsname")%>">
                    <img style="width:180px;height:180px" src="../images/<%=lg.get(5).get("picname")%>"/>
                    <div class="outer-con ">
                        <div class="title ">
                            <%=lg.get(5).get("descr")%>
                        </div>
                        <div class="sub-title ">
                            <%=lg.get(5).get("price")%>
                        </div>
                        <i class="am-icon-shopping-basket am-icon-md  seprate"></i>
                    </div>
                </a>
            </div>
            <%
                }
            %>
        </div>

        <div class="clear "></div>
    </div>
    <%
        }
    %>

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
</div>
<!--引导 -->
<div class="navCir">
    <li class="active"><a href="index.jsp"><i class="am-icon-home "></i>首页</a></li>
    <li><a href="search.jsp"><i class="am-icon-list"></i>分类</a></li>
    <li><a href="shopcart.jsp"><i class="am-icon-shopping-basket"></i>购物车</a></li>
    <li><a href="../person/index.jsp"><i class="am-icon-user"></i>我的</a></li>
</div>
<!--菜单 -->
<div class=tip>
    <div id="sidebar">
        <div id="wrap">
            <div id="prof" class="item ">
                <a href="#">
                    <span class="setting "></span>
                </a>
                <div class="ibar_login_box status_login ">
                    <div class="avatar_box ">
                        <p class="avatar_imgbox "><img src="../images/no-img_mid_.jpg "/></p>
                        <ul class="user_info ">
                            <li>用户名sl1903</li>
                            <li>级&nbsp;别普通会员</li>
                        </ul>
                    </div>
                    <div class="login_btnbox ">
                        <a href="#" class="login_order ">我的订单</a>
                        <a href="#" class="login_favorite ">我的收藏</a>
                    </div>
                    <i class="icon_arrow_white "></i>
                </div>

            </div>
            <div id="shopCart " class="item ">
                <a href="#">
                    <span class="message "></span>
                </a>
                <p>
                    购物车
                </p>
                <p class="cart_num ">0</p>
            </div>
            <div id="asset " class="item ">
                <a href="#">
                    <span class="view "></span>
                </a>
                <div class="mp_tooltip ">
                    我的资产
                    <i class="icon_arrow_right_black "></i>
                </div>
            </div>

            <div id="foot " class="item ">
                <a href="#">
                    <span class="zuji "></span>
                </a>
                <div class="mp_tooltip ">
                    我的足迹
                    <i class="icon_arrow_right_black "></i>
                </div>
            </div>

            <div id="brand " class="item ">
                <a href="#">
                    <span class="wdsc "><img src="../images/wdsc.png "/></span>
                </a>
                <div class="mp_tooltip ">
                    我的收藏
                    <i class="icon_arrow_right_black "></i>
                </div>
            </div>

            <div id="broadcast " class="item ">
                <a href="#">
                    <span class="chongzhi "><img src="../images/chongzhi.png "/></span>
                </a>
                <div class="mp_tooltip ">
                    我要充值
                    <i class="icon_arrow_right_black "></i>
                </div>
            </div>

            <div class="quick_toggle ">
                <li class="qtitem ">
                    <a href="#"><span class="kfzx "></span></a>
                    <div class="mp_tooltip ">客服中心<i class="icon_arrow_right_black "></i></div>
                </li>
                <!--二维码 -->
                <li class="qtitem ">
                    <a href="#none "><span class="mpbtn_qrcode "></span></a>
                    <div class="mp_qrcode " style="display:none; "><img src="../images/weixin_code_145.png "/><i
                            class="icon_arrow_white "></i></div>
                </li>
                <li class="qtitem ">
                    <a href="#top " class="return_top "><span class="top "></span></a>
                </li>
            </div>

            <!--回到顶部 -->
            <div id="quick_links_pop " class="quick_links_pop hide "></div>

        </div>

    </div>
    <div id="prof-content " class="nav-content ">
        <div class="nav-con-close ">
            <i class="am-icon-angle-right am-icon-fw "></i>
        </div>
        <div>
            我
        </div>
    </div>
    <div id="shopCart-content " class="nav-content ">
        <div class="nav-con-close ">
            <i class="am-icon-angle-right am-icon-fw "></i>
        </div>
        <div>
            购物车
        </div>
    </div>
    <div id="asset-content " class="nav-content ">
        <div class="nav-con-close ">
            <i class="am-icon-angle-right am-icon-fw "></i>
        </div>
        <div>
            资产
        </div>

        <div class="ia-head-list ">
            <a href="#" target="_blank " class="pl ">
                <div class="num ">0</div>
                <div class="text ">优惠券</div>
            </a>
            <a href="#" target="_blank " class="pl ">
                <div class="num ">0</div>
                <div class="text ">红包</div>
            </a>
            <a href="#" target="_blank " class="pl money ">
                <div class="num ">￥0</div>
                <div class="text ">余额</div>
            </a>
        </div>

    </div>
    <div id="foot-content " class="nav-content ">
        <div class="nav-con-close ">
            <i class="am-icon-angle-right am-icon-fw "></i>
        </div>
        <div>
            足迹
        </div>
    </div>
    <div id="brand-content " class="nav-content ">
        <div class="nav-con-close ">
            <i class="am-icon-angle-right am-icon-fw "></i>
        </div>
        <div>
            收藏
        </div>
    </div>
    <div id="broadcast-content " class="nav-content ">
        <div class="nav-con-close ">
            <i class="am-icon-angle-right am-icon-fw "></i>
        </div>
        <div>
            充值
        </div>
    </div>
</div>
<script>
    window.jQuery || document.write('<script src="basic/js/jquery.min.js "><\/script>');
</script>
<script type="text/javascript " src="../basic/js/quick_links.js "></script>

</body>

</html>