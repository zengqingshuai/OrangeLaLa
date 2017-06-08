<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fz.db.ConnMysql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>搜索页面</title>
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css"/>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css"/>
    <link href="../basic/css/demo.css" rel="stylesheet" type="text/css"/>
    <link href="../css/seastyle.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="../basic/js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../js/script.js"></script>
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
            <div class="menu-hd MyShangcheng"><a href="../person/index.jsp" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a>
            </div>
        </div>
        <div class="topMessage mini-cart">
            <div class="menu-hd"><a id="mc-menu-hd" href="shopcart.jsp" target="_top"><i
                    class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum"
                                                                                          class="h">0</strong></a></div>
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
<b class="line"></b>
<div class="search">
    <div class="search-list">
        <div class="nav-table">
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
        </div>
        <div class="am-g am-g-fixed">
            <div class="am-u-sm-12 am-u-md-12">
                <div class="theme-popover">
                    <ul class="select">
                        <p class="title font-normal">
                            <%
                                String sortkeyword = request.getParameter("sortkeyword");
                                String sortkeyword1 = request.getParameter("sortkeyword1");
                                String sortkeyword2 = request.getParameter("searchkeyword");
                                int ii = 0;
                                String p = request.getParameter("p");
                                if (p == null) p = "1";
                                int p1 = Integer.parseInt(p);
                                List<Map<String, Object>> li = null;
                                List<Map<String, Object>> li1 = null;
                                List<Map<String, Object>> li2 = null;
                                List<Map<String, Object>> li3 = null;
                                ConnMysql m = new ConnMysql();
                                if (sortkeyword != null) {
                                    ii = 1;
                                    li = m.query("select name from oll_type1 where name = '" + sortkeyword + "'");
                                    li1 = m.query("select oll_type2.name from oll_type1,oll_type2 where oll_type1.name='" + sortkeyword + "' and oll_type2.t1id=oll_type1.id");
                                    li2 = m.query("oll_goods,oll_type1,oll_type2", "where oll_type1.name='" + sortkeyword + "' and oll_goods.t2id=oll_type2.id and oll_type2.t1id=oll_type1.id and oll_goods.status!=3", p1);
                                    li3 = m.query("select DISTINCT brand from oll_goods,oll_type1,oll_type2 where oll_type1.name='" + sortkeyword + "' and oll_goods.t2id=oll_type2.id and oll_type2.t1id=oll_type1.id and oll_goods.status!=3");
                                } else if (sortkeyword1 != null) {
                                    sortkeyword = sortkeyword1;
                                    ii = 2;
                                    li = m.query("select oll_type1.name from oll_type1,oll_type2 where oll_type2.name='" + sortkeyword + "' and oll_type2.t1id=oll_type1.id");
                                    li1 = m.query("select oll_type2.name from oll_type2 where name = '" + sortkeyword + "'");
                                    li2 = m.query("oll_goods,oll_type2", "where oll_type2.name='" + sortkeyword + "' and oll_goods.t2id=oll_type2.id and oll_goods.status!=3", p1);
                                    li3 = m.query("select DISTINCT brand from oll_goods,oll_type2 where oll_type2.name='" + sortkeyword + "' and oll_goods.t2id=oll_type2.id and oll_goods.status!=3");
                                } else {
                                    ii = 3;
                                    if (sortkeyword2 == null) {
                                        sortkeyword = "";
                                        li = m.query("select DISTINCT oll_type1.name from oll_goods,oll_type1,oll_type2 where goodsname like '%" + sortkeyword + "%' and oll_goods.t2id=oll_type2.id and oll_type2.t1id=oll_type1.id");
                                        li1 = m.query("select DISTINCT oll_type2.name from oll_goods,oll_type2 where goodsname like '%" + sortkeyword + "%' and oll_goods.t2id=oll_type2.id");
                                        li2 = m.query("oll_goods", "where goodsname like '%" + sortkeyword + "%' and oll_goods.status!=3", p1);
                                        li3 = m.query("select DISTINCT brand from oll_goods where goodsname like '%" + sortkeyword + "%' and oll_goods.status!=3");
                                    } else {
                                        sortkeyword = sortkeyword2;
                                        li = m.query("select DISTINCT oll_type1.name from oll_goods,oll_type1,oll_type2 where goodsname like '%" + sortkeyword + "%' and oll_goods.t2id=oll_type2.id and oll_type2.t1id=oll_type1.id");
                                        li1 = m.query("select DISTINCT oll_type2.name from oll_goods,oll_type2 where goodsname like '%" + sortkeyword + "%' and oll_goods.t2id=oll_type2.id");
                                        li2 = m.query("oll_goods", "where goodsname like '%" + sortkeyword + "%' and oll_goods.status!=3", p1);
                                        li3 = m.query("select DISTINCT brand from oll_goods where goodsname like '%" + sortkeyword + "%' and oll_goods.status!=3");
                                    }

                                }

                            %>
                            <span class="fl"><%=sortkeyword%></span>
                            <span class="total fl">搜索到<strong class="num"><%=m.getAllnum()%></strong>件相关商品</span>
                        </p>
                        <div class="clear"></div>
                        <li class="select-result">
                            <dl>
                                <dt>已选</dt>
                                <dd class="select-no"></dd>
                                <p class="eliminateCriteria">清除</p>
                            </dl>
                        </li>
                        <div class="clear"></div>
                        <li class="select-list">
                            <dl id="select1">
                                <dt class="am-badge am-round">类别一：</dt>
                                <div class="dd-conent">
                                    <dd class="select-all selected"><a href="#">全部</a></dd>
                                    <%
                                        for (Map<String, Object> mm : li) {
                                    %>
                                    <dd><a href="#"><%=mm.get("name")%>
                                    </a></dd>
                                    <%
                                        }
                                    %>
                                </div>
                            </dl>
                        </li>
                        <li class="select-list">
                            <dl id="select2">
                                <dt class="am-badge am-round">类别二：</dt>
                                <div class="dd-conent">
                                    <dd class="select-all selected"><a href="#">全部</a></dd>
                                    <%
                                        for (Map<String, Object> mm : li1) {
                                    %>
                                    <dd><a href="#"><%=mm.get("name")%>
                                    </a></dd>
                                    <%
                                        }
                                    %>
                                </div>
                            </dl>
                        </li>
                        <li class="select-list">
                            <dl id="select3">
                                <dt class="am-badge am-round">品牌</dt>
                                <div class="dd-conent">
                                    <dd class="select-all selected"><a href="#">全部</a></dd>
                                    <%
                                        for (Map<String, Object> mm : li3) {
                                    %>
                                    <dd><a href="#"><%=mm.get("brand")%>
                                    </a></dd>
                                    <%
                                        }
                                    %>
                                </div>
                            </dl>
                        </li>

                    </ul>
                    <div class="clear"></div>
                </div>
                <div class="search-content">
                    <div class="sort">
                        <li class="first"><a title="综合">综合排序</a></li>
                        <li><a title="销量">销量排序</a></li>
                        <li><a title="价格">价格优先</a></li>
                        <li class="big"><a title="评价" href="#">评价为主</a></li>
                    </div>
                    <div class="clear"></div>

                    <ul class="am-avg-sm-2 am-avg-md-3 am-avg-lg-4 boxes">

                        <%
                            for (Map<String, Object> mm : li2) {
                        %>
                        <li>
                            <div class="i-pic limit" style="text-align: center">
                                <a href="introduction.jsp?goodskeyword=<%=mm.get("goodsname")%>">
                                    <img style="width: 280px;height: 280px;" src="../images/<%=mm.get("picname")%>"/>
                                    <a href="introduction.jsp?goodskeyword=<%=mm.get("goodsname")%>"
                                       class="title fl" ><%=mm.get("goodsname")%>
                                    </a>
                                    <p class="price fl">
                                        <b>¥</b>
                                        <strong><%=mm.get("price")%>
                                        </strong>
                                    </p>
                                    <p class="number fl">
                                        销量<span><%=mm.get("sales")%></span>
                                    </p>
                                </a>
                            </div>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
                <div class="clear"></div>
                <!--分页 -->
                <ul class="am-pagination am-pagination-right">
                    <%
                        String n = null;
                        if (ii == 1) {
                            n = "sortkeyword";
                        } else if (ii == 2) {
                            n = "sortkeyword1";
                        } else {
                            n = "searchkeyword";
                        }
                    %>
                    <li><a href='?<%=n%>=<%=sortkeyword%>&p=1'>首页</a></li>
                    <%
                        int start = 1;
                        int end = 10;
                        if (m.getP() != 1) {
                    %>
                    <li><a href='?<%=n%>=<%=sortkeyword%>&p=<%=m.getP() - 1%>'>上一页</a></li>
                    <%
                        }
                        if (m.getP() > 6) {
                            start = m.getP() - 5;
                            end = m.getP() + 4;
                            if (m.getP() > m.getAllpage() - 5) {
                                start = m.getAllpage() - 9;
                                end = m.getAllpage();
                            }
                        }
                        if (start < 1) {
                            start = 1;
                        }
                        for (int i = start; i <= end; i++) {
                            if (i > m.getAllpage()) {
                                break;
                            }
                            if (m.getP() == i) {
                    %>
                    <li class='am-active'><span><%=m.getP()%></span></li>
                    <%
                            continue;
                            }
                    %>
                    <li><a href='?<%=n%>=<%=sortkeyword%>&p=<%=i%>'><%=i%>
                    </a></li>
                    <%
                        }
                        if (m.getP() != m.getAllpage()) {
                    %>
                    <li><a href='?<%=n%>=<%=sortkeyword%>&p=<%=m.getP() + 1%>'>下一页</a></li>
                    <%
                        }
                    %>
                    <li><a href='?<%=n%>=<%=sortkeyword%>&p=<%=m.getAllpage()%>'>尾页</a></li>
                    <div>第<%=m.getP()%>页/共<%=m.getAllpage()%>页 共<%=m.getAllnum()%>条记录 <%=m.getYenum()%>条/页
                    </div>
                </ul>
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

</div>

<!--引导 -->
<div class="navCir">
    <li><a href="index.jsp"><i class="am-icon-home "></i>首页</a></li>
    <li><a href="search.jsp"><i class="am-icon-list"></i>分类</a></li>
    <li><a href="shopcart.jsp"><i class="am-icon-shopping-basket"></i>购物车</a></li>
    <li><a href="../person/index.jsp"><i class="am-icon-user"></i>我的</a></li>
</div>

<!--菜单 -->
<div class=tip>
    <div id="sidebar">
        <div id="wrap">
            <div id="prof" class="item">
                <a href="#">
                    <span class="setting"></span>
                </a>
                <div class="ibar_login_box status_login">
                    <div class="avatar_box">
                        <p class="avatar_imgbox"><img src="../images/no-img_mid_.jpg"/></p>
                        <ul class="user_info">
                            <li>用户名：sl1903</li>
                            <li>级&nbsp;别：普通会员</li>
                        </ul>
                    </div>
                    <div class="login_btnbox">
                        <a href="#" class="login_order">我的订单</a>
                        <a href="#" class="login_favorite">我的收藏</a>
                    </div>
                    <i class="icon_arrow_white"></i>
                </div>

            </div>
            <div id="shopCart" class="item">
                <a href="#">
                    <span class="message"></span>
                </a>
                <p>
                    购物车
                </p>
                <p class="cart_num">0</p>
            </div>
            <div id="asset" class="item">
                <a href="#">
                    <span class="view"></span>
                </a>
                <div class="mp_tooltip">
                    我的资产
                    <i class="icon_arrow_right_black"></i>
                </div>
            </div>

            <div id="foot" class="item">
                <a href="#">
                    <span class="zuji"></span>
                </a>
                <div class="mp_tooltip">
                    我的足迹
                    <i class="icon_arrow_right_black"></i>
                </div>
            </div>

            <div id="brand" class="item">
                <a href="#">
                    <span class="wdsc"><img src="../images/wdsc.png"/></span>
                </a>
                <div class="mp_tooltip">
                    我的收藏
                    <i class="icon_arrow_right_black"></i>
                </div>
            </div>

            <div id="broadcast" class="item">
                <a href="#">
                    <span class="chongzhi"><img src="../images/chongzhi.png"/></span>
                </a>
                <div class="mp_tooltip">
                    我要充值
                    <i class="icon_arrow_right_black"></i>
                </div>
            </div>

            <div class="quick_toggle">
                <li class="qtitem">
                    <a href="#"><span class="kfzx"></span></a>
                    <div class="mp_tooltip">客服中心<i class="icon_arrow_right_black"></i></div>
                </li>
                <!--二维码 -->
                <li class="qtitem">
                    <a href="#none"><span class="mpbtn_qrcode"></span></a>
                    <div class="mp_qrcode" style="display:none;"><img src="../images/weixin_code_145.png"/><i
                            class="icon_arrow_white"></i></div>
                </li>
                <li class="qtitem">
                    <a href="#top" class="return_top"><span class="top"></span></a>
                </li>
            </div>

            <!--回到顶部 -->
            <div id="quick_links_pop" class="quick_links_pop hide"></div>

        </div>

    </div>
    <div id="prof-content" class="nav-content">
        <div class="nav-con-close">
            <i class="am-icon-angle-right am-icon-fw"></i>
        </div>
        <div>
            我
        </div>
    </div>
    <div id="shopCart-content" class="nav-content">
        <div class="nav-con-close">
            <i class="am-icon-angle-right am-icon-fw"></i>
        </div>
        <div>
            购物车
        </div>
    </div>
    <div id="asset-content" class="nav-content">
        <div class="nav-con-close">
            <i class="am-icon-angle-right am-icon-fw"></i>
        </div>
        <div>
            资产
        </div>

        <div class="ia-head-list">
            <a href="#" target="_blank" class="pl">
                <div class="num">0</div>
                <div class="text">优惠券</div>
            </a>
            <a href="#" target="_blank" class="pl">
                <div class="num">0</div>
                <div class="text">红包</div>
            </a>
            <a href="#" target="_blank" class="pl money">
                <div class="num">￥0</div>
                <div class="text">余额</div>
            </a>
        </div>

    </div>
    <div id="foot-content" class="nav-content">
        <div class="nav-con-close">
            <i class="am-icon-angle-right am-icon-fw"></i>
        </div>
        <div>
            足迹
        </div>
    </div>
    <div id="brand-content" class="nav-content">
        <div class="nav-con-close">
            <i class="am-icon-angle-right am-icon-fw"></i>
        </div>
        <div>
            收藏
        </div>
    </div>
    <div id="broadcast-content" class="nav-content">
        <div class="nav-con-close">
            <i class="am-icon-angle-right am-icon-fw"></i>
        </div>
        <div>
            充值
        </div>
    </div>
</div>
<script>
    window.jQuery || document.write('<script src="basic/js/jquery-1.9.min.js"><\/script>');
</script>
<script type="text/javascript" src="../basic/js/quick_links.js"></script>

<div class="theme-popover-mask"></div>

</body>

</html>