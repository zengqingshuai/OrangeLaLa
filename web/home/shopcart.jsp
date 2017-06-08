<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fz.db.ConnMysql" %>
<%@ page import="com.fz.db.MyDbUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>购物车页面</title>
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css"/>
    <link href="../basic/css/demo.css" rel="stylesheet" type="text/css"/>
    <link href="../css/cartstyle.css" rel="stylesheet" type="text/css"/>
    <link href="../css/optstyle.css" rel="stylesheet" type="text/css"/>
    <link href="../css/optaddr.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/address.js"></script>
    <script>
        function exit() {
            if (confirm("确认退出？")) {
                location.href = "../exit.action"
            }
        }

        function deleteGoods(a) {
            var gid = $(a).attr("id");
            if (confirm("确认删除？")) {
                $.ajax({
                    type: 'post',
                    url: 'buy.action',
                    data: {action: 'delgoods', goodsid: gid},
                    cache: false,
                    success: function () {
                        alert("删除成功！");
                        window.location.reload();
                    }
                })
            }
        }
        $(function () {
            $('#J_Go').click(function () {
                var addrid = $('#addrid').val();
                if (addrid != "") {
                    $.ajax({
                        type: 'post',
                        url: 'buy.action',
                        data: {action: 'toOrder', addr: addrid},
                        cache: false,
                        success: function () {
                            alert("订单提交成功！请在30分钟内完成支付！")
                        }
                    })
                } else {
                    alert("请先选择收货人信息！")
                }
            })
        });
        $(function () {
            $('#opt-addr').click(function () {
                $('.mytheme-popover-mask').css("display", "block");
                $('.mytheme-popover').css("display", "block");
            });
            $('#save-addr').click(function () {
                var a = $('input[type=radio]:checked').val();
                if (typeof (a) != "undefined") {
                    $('.mytheme-popover-mask').css("display", "none");
                    $('.mytheme-popover').css("display", "none");
                    $('#opt-addr').css("display", "none");
                    $('#opt-addr-info').html("收货人信息：" + $('#addrinfo').html());
                    $('#addrid').val(a);
                    $('#opt-addr-info').css("display", "block");
                }
            });
            $('#close').click(function () {
                $('.mytheme-popover-mask').css("display", "none");
                $('.mytheme-popover').css("display", "none");
            })
        })
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
                    var a = '<%=session.getAttribute("person_admin")%>';
                    if (a != "null") {
                        $("#top_f").append('<a href="../person/index.jsp" style="font-size: 17px">欢迎 <%=session.getAttribute("person_admin")%> ！</a>')
                        $("#top_f").append(' <a href="javascript:void(0);" onclick="exit()">安全退出</a>')
                    } else {
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
        /*$("#tags").autocomplete({
         source: "searchgoods.action",
         minLength: 1,
         select: function (event, ui) {
         }
         });*/
        $("#ai-topsearch").click(function () {
            var keyword = $("#tags").val();
            if (keyword.length > 0) {
                location.href = "search.jsp?searchkeyword=" + keyword;
            }
        });
    });

</script>
<div class="clear"></div>

<!--购物车 -->

<div class="concent">
    <%
        ConnMysql m = new ConnMysql();
        Object uid = session.getAttribute("person_id");
        double total = 0;
        int count = 0;
        if (uid != null) {
            List<Map<String, Object>> list = m.query("SELECT oll_goods.id as gid,oll_order.id,total,oll_goods.store,number,picname,descr,price,num,price*num money FROM oll_goods,oll_order,oll_order_info WHERE oll_goods.id=oll_order_info.goodsid AND oll_order.uid=" + uid.toString() + " AND oll_order.id=oll_order_info.orderid AND oll_order.status=6");
            if (list.size() > 0) {
    %>
    <div id="cartTable">
        <div class="cart-table-th">
            <div class="wp">
                <div class="th th-chk">
                    <div id="J_SelectAll1" class="select-all J_SelectAll">

                    </div>
                </div>
                <div class="th th-item">
                    <div class="td-inner">商品信息</div>
                </div>
                <div class="th th-price">
                    <div class="td-inner">单价</div>
                </div>
                <div class="th th-amount">
                    <div class="td-inner">数量</div>
                </div>
                <div class="th th-sum">
                    <div class="td-inner">金额</div>
                </div>
                <div class="th th-op">
                    <div class="td-inner">操作</div>
                </div>
            </div>
        </div>
        <div class="clear"></div>

        <tr class="item-list">
            <div class="bundle  bundle-last ">

                <div class="clear"></div>
                <div class="bundle-main">
                    <%
                        for (int i = 0; i < list.size(); i++) {
                            double money = Double.parseDouble(list.get(i).get("money").toString());
                            count = count + 1;
                    %>
                    <ul class="item-content clearfix">
                        <li class="td td-chk">
                            <div class="cart-checkbox ">
                                <input class="check" name="items[]" type="checkbox">
                                <label for="<%=list.get(i).get("id")%>"></label>
                            </div>
                        </li>
                        <li class="td td-item">
                            <div class="item-pic">
                                <a href="javascript:void(0);" target="_blank" data-title="<%=list.get(i).get("descr")%>" class="J_MakePoint" data-point="tbcart.8.12">
                                    <img src="../images/<%=list.get(i).get("picname")%>" style="width: 80px;height: 80px;" class="itempic J_ItemImg"></a>
                            </div>
                            <div class="item-info">
                                <div class="item-basic-info">
                                    <a href="javascript:void(0);" target="_blank" title="<%=list.get(i).get("descr")%>" class="item-title J_MakePoint" data-point="tbcart.8.11"><%=list.get(i).get("descr")%>
                                    </a>
                                </div>
                            </div>
                        </li>
                        <li class="td td-info" style="visibility:hidden">
                            <div class="item-props item-props-can">
                                <span class="sku-line"></span>
                                <span class="sku-line"></span>
                                <span tabindex="0" class="btn-edit-sku theme-login"></span>
                                <i class="theme-login am-icon-sort-desc"></i>
                            </div>
                        </li>
                        <li class="td td-price">
                            <div class="item-price price-promo-promo">
                                <div class="price-content">
                                    <div class="price-line">
                                        <em class="J_Price price-now" tabindex="0"><%=String.format("%.2f", list.get(i).get("price"))%></em>￥
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="td td-amount">
                            <div class="amount-wrapper ">
                                <div class="item-amount ">
                                    <div class="sl">
                                        <input id="min<%=i%>" type="button" value=" - "/>
                                        <input id="num<%=i%>" type="text" value="<%=list.get(i).get("num")%>" maxlength="3" onkeypress="return event.keyCode>=48&&event.keyCode<=57" style="width:30px;"/>
                                        <input id="add<%=i%>" type="button" value=" + "/>
                                        <script>
                                            var allnum =<%=list.get(i).get("store")%>;
                                            $("#min<%=i%>").click(function () {
                                                var id = <%=list.get(i).get("id")%>;
                                                var num = $("#num<%=i%>").val();
                                                $.ajax({
                                                    type: 'post',
                                                    url: 'shopcart.action',
                                                    data: {action: 'min', num: num, id: id,gid:"<%=list.get(i).get("gid")%>",price:"<%=list.get(i).get("price")%>"},
                                                    cache: false,
                                                    success: function (d) {
                                                        $("#num<%=i%>").val(d);
                                                    }
                                                })
                                            })
                                            $("#add<%=i%>").click(function () {
                                                var id = <%=list.get(i).get("id")%>;
                                                var num = $("#num<%=i%>").val();
                                                $.ajax({
                                                    type: 'post',
                                                    url: 'shopcart.action',
                                                    data: {action: 'add', num: num, allnum: allnum, id: id,gid:"<%=list.get(i).get("gid")%>",price:"<%=list.get(i).get("price")%>"},
                                                    cache: false,
                                                    success: function (d) {
                                                        $("#num<%=i%>").val(d);
                                                        window.location.reload();
                                                    }
                                                })
                                            })
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="td td-sum">
                            <div class="td-inner">
                                <em tabindex="0" class="J_ItemSum number"><%=String.format("%.2f", money)%>
                                </em>￥
                            </div>
                        </li>
                        <li class="td td-op">
                            <div class="td-inner"><a href="javascript:void(0);" id="<%=list.get(i).get("gid")%>" onclick="deleteGoods(this)">删除</a>
                            </div>
                        </li>
                    </ul>
                    <%
                        }
                    %>

                </div>
            </div>
        </tr>
        <div class="clear"></div>

    </div>
    <div class="clear"></div>

    <div class="float-bar-wrapper">
        <div id="J_SelectAll2" class="select-all J_SelectAll">
            <div class="cart-checkbox">
                <input class="check-all check" id="J_SelectAllCbx2" name="select-all" value="true" type="checkbox">
                <label for="J_SelectAllCbx2"></label>
            </div>
            <span>全选</span>
        </div>
        <div class="operations">
            <a href="javascript:void(0);" hidefocus="true" class="deleteAll"></a>
            <a href="javascript:void(0);" hidefocus="true" class="J_BatchFav">移入收藏夹</a>
        </div>
        <div class=" theme-login am-btn am-btn-danger" id="opt-addr">选择收货人信息</div>
        <div id="opt-addr-info"></div>
        <input type="hidden" value="" size="1" id="addrid">
        <div class="float-bar-right">
            <div class="amount-sum">
                <span class="txt">已选商品</span>
                <em id="J_SelectedItemsCount"><%=count%>
                </em><span class="txt">件</span>
                <div class="arrow-box">
                    <span class="selected-items-arrow"></span>
                    <span class="arrow"></span>
                </div>
            </div>
            <div class="price-sum">
                <span class="txt">合计:</span>
                <strong class="price">¥<em id="J_Total"><%=list.get(0).get("total")%>
                </em></strong>
            </div>
            <div class="btn-area">
                <a href="javascript:void(0);" id="J_Go" class="submit-btn submit-btn-disabled" aria-label="请注意如果没有选择宝贝，将无法结算">
                    <span>提交订单</span></a>
            </div>
        </div>
        <%
                } else {
                    out.print("<br><br><br><div>您的购物车中暂时没有商品！</div>");
                }
            }
        %>
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

<!--操作页面-->
<div class="mytheme-popover-mask"></div>
<div class="mytheme-popover">
    <table>
        <tr>
            <td>选择</td>
            <td>收货人信息</td>
        </tr>
        <%
            MyDbUtil mu = new MyDbUtil();
            String person_admin = session.getAttribute("person_admin").toString();
            List<Map<String, Object>> list = mu.query("oll_addr,oll_user", "*", "where oll_addr.uid=oll_user.id and oll_user.account='" + person_admin + "'", "", " limit 5");//oll_addr.account='" + person_admin+"'
            if (list != null) {
                for (Map<String, Object> map : list) {
        %>
        <tr>
            <td><input type="radio" value="<%=map.get("id")%>" name="opt-a"></td>
            <td id="addrinfo">收货人:<%=map.get("linkman")%>&nbsp;&nbsp;电话:<%=map.get("phone")%>&nbsp;&nbsp;地址:<%=map.get("address")%>&nbsp;&nbsp;邮编:<%=map.get("code")%>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
    <div class="am-btn am-btn-danger" id="save-addr">确定</div>&nbsp;&nbsp;&nbsp;
    <div class="am-btn am-btn-danger" id="close">取消</div>
</div>

<!--引导 -->
<div class="navCir">
    <li><a href="index.jsp"><i class="am-icon-home "></i>首页</a></li>
    <li><a href="search.jsp"><i class="am-icon-list"></i>分类</a></li>
    <li class="active"><a href="shopcart.jsp"><i class="am-icon-shopping-basket"></i>购物车</a></li>
    <li><a href="../person/index.jsp"><i class="am-icon-user"></i>我的</a></li>
</div>
</body>

</html>