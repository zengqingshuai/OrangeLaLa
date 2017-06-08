<%@ page import="com.fz.db.ConnMysql" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改订单</title>
    <link href="../management-css/order_modify.css" rel="stylesheet" type="text/css">
    <link href="../management-css/header.css" rel="stylesheet" type="text/css">
    <link href="../management-css/footer.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../js/time_and_exit.js"></script>
    <script>
        $(function () {
            var orderid =<%=request.getParameter("id")%>;
            function show() {
                $.ajax({
                    type: 'POST',
                    url: '../orderSearch.action',
                    data: {action: "select_order", order_id: orderid},
                    success: function (d) {
                        $('#name').val(d[0].linkman);
                        $('#addr').val(d[0].address);
                        $('#phone').val(d[0].phone);
                        switch (d[0].status){
                            case 2:$('select').val("待发货"); break;
                            case 3:$('select').val("待收货"); break;
                            case 4:$('select').val("已签收"); break;
                            case 5:$('select').val("取消订单"); break;
                            default:$('select').val("待付款"); break;
                        }
                    },
                    dataType: 'json',
                    cache: false
                })
            }
            show();
            $('#order-modify-submit').click(function () {
                var name = $('#name').val();
                var addr = $('#addr').val();
                var phone = $('#phone').val();
                var statu = $('select').val();
                if (name.length > 0&&phone.length > 0&&addr.length) {
                    $.ajax({
                        type: 'POST',
                        url: '../orderSearch.action',
                        data: {action: "update", order_id: orderid, linkman: name, phone: phone, addr: addr, sta: statu},
                        success: function (d) {
                            alert(d);
                            location.href="order_manage.jsp";
                        },
                        dataType: 'json',
                        cache: false
                    })
                }else{
                    alert("提交内容有空，请检查！")
                }
            });
        })
    </script>
</head>
<body onload="showTime()">
<header>
    <div class="top_left"><img src="../management-css/images/orangelala.png" height="90" width="200"/></div>
    <div class="top_bottom">
        <ul>
            <li><a href="index.jsp"><input class="button" type="button" value="首页"></a></li>
            <li><a href="user_manage.jsp"><input class="button" type="button" value="用户"></a></li>
            <li><a href="class_manage.jsp"><input class="button1" type="button" value="商品分类"></a></li>
            <li><a href="order_manage.jsp"><input class="button" type="button" value="订单"></a></li>
            <li><a href="goods_detail_manage.jsp"><input class="button1" type="button" value="商品详细"></a></li>
            <li><a href="announcement_add.jsp"><input class="button" type="button" value="轮播"></a></li>
            <li><a><input id="exit" class="button" type="button" value="退出"></a></li>
        </ul>
    </div>
    <div class="top_bottom2">
        <div class="top_bottom2_right">
            管理员您好，今天是<span id="times"></span>，欢迎来到OrangeLaLa后台管理系统！
        </div>
    </div>
</header>
<main>
    <!---左上--->
    <div class="main_top_left">
        你现在的位置：<a href="../home/index.jsp">OrangeLaLa</a>>订单管理系统
    </div>
    <!--中左表格-->
    <div class="main_left">
        <ul>
            <li class="main_li-1"><strong>&nbsp;用户管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="user_manage.jsp">用户管理</a></li>
            <li class="main_li-1"><strong>&nbsp;商品分类管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="class_manage.jsp">一级分类管理</a>
                <span><a href="class_add.jsp">新增</a></span></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="category_manage.jsp">二级分类管理</a>
                <span><a href="category_add.jsp">新增</a></span></li>
            <li class="main_li-1"><strong>&nbsp;订单管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="order_manage.jsp">订单管理</a></li>
            <li class="main_li-1"><strong>&nbsp;商品详细管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png"><a href="goods_detail_manage.jsp">商品详细管理</a>
                <span><a href="goods_detail_add.jsp">新增</a></span></li>
            <li class="main_li-1"><strong>&nbsp;轮播管理</strong></li>
            <li class="main_li-2">&nbsp;<img src="../management-css/images/index_3.png" class="dd1"><a href="announcement_manage.jsp">轮播管理</a>
                <span><a href="announcement_add.jsp">新增</a></span></li>
        </ul>
    </div>
    <div class="main_center_left">
        <p><img src="../management-css/images/ai.png"><strong>修改订单</strong></p>
        <hr class="line">
        <div class="main_center_center">
            <br>
            <%
                ConnMysql cm=new ConnMysql();
                List<Map<String, Object>> l= cm.query("select a.id,b.linkman,b.address,a.status,phone from oll_order a,oll_addr b where a.addrid=b.id and a.status!=6 and a.id="+request.getParameter("id"));
            %>
            &nbsp;&nbsp;订单编号:<%=request.getParameter("id")%><br>
            订购人姓名:<input type="text" id="name" value="<%=l.get(0).get("linkman")%>" size="50"><br>
            订购人地址:<input type="text" id="addr" value="<%=l.get(0).get("address")%>" size="50"><br>
            &nbsp;&nbsp;&nbsp;&nbsp;手机号:<input type="text" value="<%=l.get(0).get("phone")%>" id="phone" size="50" maxlength="11"><br>
            &nbsp;&nbsp;订单状态:<select>
            <option>待付款</option>
            <option>待发货</option>
            <option>待收货</option>
            <option>已完成</option>
            <option>取消订单</option>
        </select><br>
            <div class="main_center_submit"><input id="order-modify-submit" type="image" src="../management-css/images/submit.gif"></div>
        </div>
    </div>
</main>
<footer>
    <div>
        <p class="footer_top">
            友情链接:
            <a href="https://www.baidu.com/" target="_blank">百度</a>|
            <a href="https://www.google.com.hk/" target="_blank">Google</a>|
            <a href="" target="_blank">雅虎</a>|
            <a href="http://uland.taobao.com" target="_blank">淘宝</a>|
            <a href="http://www.ppdai.com/" target="_blank">拍拍</a>|
            <a href="https://www.paypal-biz.com/" target="_blank">易趣</a>|
            <a href="http://www.dangdang.com/" target="_blank">当当</a>|
            <a href="https://www.jd.com/" target="_blank">京东商城</a>|
            <a href="http://www.xunlei.com/" target="_blank">迅雷</a>|
            <a href="http://www.sina.com.cn/" target="_blank">新浪</a>|<a href="http://www.163.com/">网易</a>|
            <a href="http://www.sohu.com/" target="_blank">搜狐</a>|
            <a href="http://www.mop.com/" target="_blank">猫扑</a>|
            <a href="http://kx.99.com/" target="_blank">开心网</a>|
            <a href="http://www.xinhuanet.com" target="_blank">新华网</a>|
            <a href="http://www.ifeng.com/" target="_blank">凤凰网</a>
        </p>
    </div>
    <div class="footer_line"></div>
    <div class="footer_center">
        <p>CORYRIGHT&nbsp;&copy;&nbsp;2016-2017&nbsp; 郑州市OrangeLaLa商城有限公司
            &nbsp;ALL&nbsp;RIGHT&nbsp;RESERVED</p>
        <p>&nbsp;丰泽研发部&nbsp;</p>
        <p>Email:service@168.com</p>
        <p>ICP:京ICP备00000001号</p>
    </div>
</footer>
</body>
</html>