<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fz.db.ConnMysql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>商品页面</title>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css"/>
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css"/>
    <link href="../basic/css/demo.css" rel="stylesheet" type="text/css"/>
    <link type="text/css" href="../css/optstyle.css" rel="stylesheet"/>
    <link type="text/css" href="../css/style.css" rel="stylesheet"/>
    <script type="text/javascript" src="../basic/js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../basic/js/quick_links.js"></script>
    <script type="text/javascript" src="../AmazeUI-2.4.2/assets/js/amazeui.js"></script>
    <script type="text/javascript" src="../js/jquery.imagezoom.min.js"></script>
    <script type="text/javascript" src="../js/jquery.flexslider.js"></script>
    <script type="text/javascript" src="../js/list.js"></script>
    <script>
        function exit() {
            if (confirm("确认退出？")) {
                location.href = "../exit.action"
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
<div class="listMain">

    <!--分类-->
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
    <ol class="am-breadcrumb am-breadcrumb-slash">
        <li><a href="index.jsp">首页</a></li>
        <li><a href="search.jsp">分类</a></li>
        <li class="am-active">内容</li>
    </ol>
    <script type="text/javascript">
        $(function () {
        });
        $(window).load(function () {
            $('.flexslider').flexslider({
                animation: "slide",
                start: function (slider) {
                    $('body').removeClass('loading');
                }
            });
        });
    </script>
    <div class="scoll">
        <section class="slider">
            <div class="flexslider">
                <ul class="slides">
                    <li>
                        <img src="../images/01.jpg" title="pic"/>
                    </li>
                </ul>
            </div>
        </section>
    </div>

    <!--放大镜-->

    <div class="item-inform">
        <div class="clearfixLeft" id="clearcontent">
            <%
                ConnMysql mu = new ConnMysql();
                String name = request.getParameter("goodskeyword");
                if (name != "null") {
                    mu.update("update oll_goods set clicknum=clicknum+1 where goodsname='" + name + "'");
                    List<Map<String, Object>> list = mu.query("select * from oll_goods where goodsname='" + name + "'");
                    for (Map<String, Object> m : list) {
            %>

            <div class="box">
                <script type="text/javascript">
                    $(document).ready(function () {
                        $(".jqzoom").imagezoom();
                        $("#thumblist li a").click(function () {
                            $(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
                            $(".jqzoom").attr('src', $(this).find("img").attr("mid"));
                            $(".jqzoom").attr('rel', $(this).find("img").attr("big"));
                        });
                    });
                </script>

                <div class="tb-booth tb-pic tb-s310">
                    <a href="../images/<%=m.get("picname")%>"><img src="../images/<%=m.get("picname")%>" alt="细节展示放大镜特效" rel="../images/<%=m.get("picname")%>" class="jqzoom"/></a>
                </div>
                <ul class="tb-thumb" id="thumblist">
                    <li class="tb-selected">
                        <div class="tb-pic tb-s40">
                            <a href=""><img src="../images/<%=m.get("picname")%>" mid="../images/<%=m.get("picname")%>" big="../images/<%=m.get("picname")%>"></a>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="clear"></div>
        </div>

        <div class="clearfixRight">


            <!--规格属性-->
            <!--名称-->
            <div class="tb-detail-hd">
                <h1 id="goodsname"><%=m.get("goodsname")%></h1>
            </div>
            <div class="tb-detail-list">
                <!--价格-->
                <div class="tb-detail-price">
                    <li class="price iteminfo_price">
                        <dt>促销价</dt>
                        <dd><em>¥</em><b class="sys_item_price"></b><%=m.get("price")%>
                        </dd>
                    </li>
                    <li class="price iteminfo_mktprice">
                        <dt>规格:</dt>
                        <dd><em></em><b class="sys_item_mktprice"></b><%=m.get("equiv")%>克</dd>
                    </li>
                    <div class="clear"></div>
                </div>
                <!--地址-->
                <dl class="iteminfo_parameter freight">
                    <dt>配送至</dt>
                    <div class="iteminfo_freprice">
                        <div class="am-form-content address">
                            <select id="selProvince" onchange="changecity()" style="width: 110px;">
                                <option>--选择省份--</option>
                            </select>
                            <select id="selCity" style="width: 110px;">
                                <option>--选择城市--</option>
                            </select>
                        </div>
                        <div class="pay-logis">
                            快递<b class="sys_item_freprice">0</b>元
                        </div>
                    </div>
                </dl>
                <script>
                    var cityList = new Array();
                    cityList['北京市'] = ['怀柔区', '昌平区', '顺义区', '平谷区', '顺义区', '海淀区', '东城区', '朝阳区', '西城区', '门头沟区', '石景山区', '丰台区', '房山区', '大兴区', '延庆县', '密云县'];
                    cityList['上海市'] = ['杨浦区', '黄浦区', '虹口区', '闸北区', '静安区', '普陀区', '长宁区', '徐汇区', '浦东新区', '闵行区', '宝山区', '嘉定区', '青浦区', '松江区', '奉贤区', '金山区'];
                    cityList['天津市'] = ['宝坻区', '武清区', '滨海新区', '津南区', '北辰区', '红桥区', '河北区', '河东区', '河西区', '和平区', '西青区', '红桥区', '蓟县', '静海县', '宁河县', '静海县'];
                    cityList['重庆市'] = ['万州区', '黔江区', '涪陵区', '渝中区', '大渡口区', '江北区', '沙坪坝区', '九龙坡区', '南岸区', '北碚区', '渝北区', '巴南区', '长寿区', '江津区', '合川区', '永川区', '南川区', '綦江区', '大足区', '璧山区', '铜梁区', '潼南区',
                        '荣昌区', '开州区', '梁平区', '武隆区', '城口县', '丰都县', '垫江县', '忠县', '云阳县', '奉节县', '巫山县', '巫溪县', '石柱土家族自治县', '秀山土家族苗族自治县', '酉阳土家族苗族自治县', '彭水苗族土家族自治县'];
                    cityList['浙江省'] = ['杭州市', '湖州市', '舟山市', '嘉兴市', '绍兴市', '宁波市', '台州市', '金华市', '丽水市', '温州市', '衢州市'];
                    cityList['江苏省'] = ['南京市', '扬州市', '镇江市', '宿迁市', '连云港市', '徐州市', '淮安市', '盐城市', '泰州市', '常州市', '无锡市', '苏州市', '南通市'];
                    cityList['福建省'] = ['福州市', '宁德市', '莆田市', '南平市', '三明市', '泉州市', '龙岩市', '厦门市', '漳州市'];
                    cityList['山东省'] = ['济南市', '烟台市', '日照市', '威海市', '莱芜市', '枣庄市', '菏泽市', '德州市', '滨州市', '东营市', '潍坊市', '青岛市', '聊城市', '临沂市', '南岛市', '淄博市', '泰安市'];
                    cityList['安徽省'] = ['合肥市', '芜湖市', '马鞍山市', '淮北市', '铜陵市', '黄山市', '池州市', '亳州市', '宿州市', '蚌埠市', '淮南市', '阜阳市', '滁州市', '六安市', '安庆市', '宣城市'];
                    cityList['江西省'] = ['南昌市', '九江市', '鹰潭市', '新余市', '景德镇市', '抚州市', '上饶市', '宜春市', '萍乡市', '赣州市', '吉安市'];
                    cityList['广东省'] = ['广州市', '深圳市', '佛山市', '珠海市', '汕头市', '韶关市', '江门市', '东莞市', '湛江市', '茂名市', '肇庆市', '惠州市', '河源市', '阳江市', '清远市', '中山市', '揭阳市', '云浮市', '梅州市', '潮州市', '汕尾市'];
                    cityList['湖北省'] = ['武汉市', '黄石市', '十堰市', '宜昌市', '荆门市', '鄂州市', '孝感市', '黄冈市', '随州市', '恩施州', '襄阳市', '咸宁市', '荆州市'];
                    cityList['湖南省'] = ['长沙市', '株洲市', '湘潭市', '邵阳市', '岳阳市', '常德市', '益阳市', '娄底市', '衡阳市', '永州市', '怀化市', '张家界市', '郴州市', '湘西土家族苗族自治州 '];
                    cityList['河南省'] = ['郑州市', '开封市', '洛阳市', '漯河市', '商丘市', '三门峡市', '平顶山市', '周口市', '安阳市', '濮阳市', '新乡市', '焦作市', '许昌市', '驻马店市', '信阳市', '南阳市', '鹤壁市'];
                    cityList['广西壮族自治区'] = ['桂林市', '北海市', '防城港市', '钦州市', '贵港市', '百色市', '贺州市', '河池市', '来宾市', '崇左市', '柳州市', '梧州市', '玉林市', '南宁市'];
                    cityList['海南省'] = ['海口市', '三亚市', '海南岛'];
                    cityList['河北省'] = ['石家庄市', '承德市', '秦皇岛市', '唐山市', '张家口市', '廊坊市', '保定市', '沧州市', '衡水市', '邢台市', '邯郸市'];
                    cityList['山西省'] = ['太原市', '忻州市', '吕梁市', '运城市', '大同市', '朔州市', '阳泉市', '晋中市', '临汾市', '长治市', '晋城市'];
                    cityList['内蒙古自治区'] = ['呼和浩特市', '呼伦贝尔市', '通辽市', '乌海市', '赤峰市', '乌兰察布市', '额鄂尔多斯市', '包头市', '巴彦淖尔市', '锡林郭勒盟', '阿拉善盟', '兴安盟'];
                    cityList['辽宁省'] = ['沈阳市', '盘锦市', '铁岭市', '抚顺市', '辽阳市', '本溪市', '阜新市', '朝阳市', '锦州市', '鞍山市', '营口市', '丹东市', '大连市', '葫芦岛'];
                    cityList['吉林省'] = ['吉林市', '四平市', '通化市', '白山市', '辽源市', '松原市', '白城市', '长春市', '延边朝鲜族自治州'];
                    cityList['黑龙江省'] = ['哈尔滨市', '佳木斯市', '鹤岗市', '鸡西市', '双鸭山市', '黑河市', '七台河市', '绥化市', '伊春市', '牡丹江市', '大庆市', '齐齐哈尔市', '大兴安岭地区'];
                    cityList['四川省'] = ['成都市', '自贡市', '攀枝花市', '泸州市', '德阳市', '绵阳市', '广元市', '遂宁市', '内江市', '眉山市', '广安市', '达州市', '雅安市', '资阳市', '乐山市', '宜宾市', '南充市', '巴中市', '阿坝藏族羌族自治州', '甘孜藏族自治州', '凉山彝族自治州'];
                    cityList['云南省'] = ['昆明市', '曲靖市', '玉溪市', '普洱市', '保山市', '丽江市', '临沧市', '昭通市', '西双版纳州', '大理州', '楚雄州', '红河州', '文山州', '德宏州', '怒江州', '迪庆州'];
                    cityList['贵州省'] = ['安顺市', '毕节市', '遵义市', '铜仁市', '六盘水市', '贵阳市', '黔南布依族苗族自治州', '黔东南苗族侗族自治州', '黔西南苗族布依族自治州'];
                    cityList['西藏自治区'] = ['拉萨市', '阿里地区', '那曲地区', '昌都地区', '林芝地区', '山南地区', '日喀则地区'];
                    cityList['陕西省'] = ['西安市', '渭南市', '延安市', '商洛市', '榆林市', '铜川市', '咸阳市', '宝鸡市', '汉中市', '安康市'];
                    cityList['青海省'] = ['玉树市', '果洛市', '海东市', '海西市', '海南市', '海北市', '西宁市', '黄南市'];
                    cityList['甘肃省'] = ['嘉峪关市', '金昌市', '白银市', '武威市', '酒泉市', '平凉市', '庆阳市', '陇南市', '天水市', '定西市', '兰州市', '张掖市', '甘南藏族自治州', '临夏回族自治州'];
                    cityList['宁夏回族自治区'] = ['银川市', '石嘴山市', '吴忠市', '固原市', '中卫市'];
                    cityList['新疆维吾尔自治区'] = ['克拉玛依市', '吐鲁番地区', '哈密地区', '昌吉回族自治州', '和田地区', '阿克苏地区', '喀什地区', '克孜勒苏柯尔克孜自治州', '巴音郭楞蒙古自治州', '博尔塔拉蒙古自治州', '伊犁哈萨克自治州', '塔城地区', '阿勒泰地区', '乌鲁木齐市'];
                    function allcity() {
                        var provinces = document.getElementById("selProvince");
                        for (var i in cityList) {
                            provinces.add(new Option(i, i), null);
                        }
                    }
                    allcity()
                    function changecity() {
                        var province = document.getElementById("selProvince").value;
                        var city = document.getElementById("selCity");
                        city.options.length = 1;
                        for (var i in cityList) {
                            if (i == province) {
                                for (var j in cityList[i]) {
                                    city.add(new Option(cityList[i][j], cityList[i][j]), null);
                                }
                            }
                        }
                    }
                </script>
                <div class="clear"></div>

                <!--销量-->
                <ul class="tm-ind-panel">
                    <li class="tm-ind-item tm-ind-sellCount canClick">
                        <div class="tm-indcon"><span class="tm-label">月销量</span><span class="tm-count">----</span></div>
                    </li>
                    <li class="tm-ind-item tm-ind-sumCount canClick">
                        <div class="tm-indcon"><span class="tm-label">累计销量</span><span class="tm-count"><%=m.get("sales")%></span></div>
                    </li>
                    <li class="tm-ind-item tm-ind-reviewCount canClick tm-line3">
                        <div class="tm-indcon"><span class="tm-label">浏览次数:</span><span class="tm-count"><%=m.get("clicknum")%></span></div>
                    </li>
                </ul>
                <div class="clear"></div>

                <!--各种规格-->
                <dl class="iteminfo_parameter sys_item_specpara">
                    <dt class="theme-login">
                    <div class="cart-title">可选规格<span class="am-icon-angle-right"></span></div>
                    </dt>
                    <dd>
                    </dd>
                    <!--操作页面-->
                    <div class="theme-popover">
                        <div class="theme-span"></div>
                        <div class="theme-poptit">
                            <a href="javascript:;" title="关闭" class="close">×</a>
                        </div>
                        <div class="theme-popbod dform">
                            <div class="theme-signin-left">
                                <div class="theme-options">
                                    <div class="cart-title number">数量</div>
                                    <dd>
                                        <input id="min" type="button" value="-">
                                        <input id="text_box" type="text" value="1" onkeypress="return event.keyCode>=48&&event.keyCode<=57" style="width:30px;" maxlength="3">
                                        <input id="add" type="button" value="+">
                                        <span id="Stock" class="tb-hidden">库存<span id="addMAX" class="stock"><%=m.get("store")%></span>件</span>
                                    </dd>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                </dl>
                <div class="clear"></div>
                <!--活动	-->
                <div class="shopPromotion gold">
                    <div class="hot">
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <script>
                $(function () {
                    var user = "<%=session.getAttribute("person_admin")%>";
                    var goods = $('#goodsname').html();
                    $("#text_box").blur(function () {
                        if($("#text_box").val()==""){
                            $("#text_box").val(1);
                        }
                    });
                    $('#add').click(function () {
                        var a = $('#text_box');
                        var b = $('#addMAX');
                        if (a.val() >= parseInt(b.html())) {
                            a.val(b.html());
                        }
                    });
                    $('#LikBuy').click(function () {
                        var a = $('#text_box').val();
                        if (user != "null") {
                            location.href = "pay.jsp?num=" + a + "&goodsname=<%=m.get("goodsname")%>";
                        } else {
                            alert("请登录！再购买！")
                        }
                    });
                    $('#LikBasket').click(function () {
                        if (user != "null") {
                            if (confirm("确认添加？")) {
                                var a = $('#text_box').val();
                                $.ajax({
                                    type: 'post',
                                    url: 'buy.action',
                                    data: {action: 'add', num: a, goodsname: goods},
                                    cache: false,
                                    success: function (d) {
                                        if (confirm(d)) {
                                            location.href = "shopcart.jsp"
                                        }
                                    }
                                })
                            }
                        } else {
                            alert("请登录！再添加！")
                        }
                    })
                })
            </script>
            <div class="pay">
                <div class="pay-opt">
                    <a href="index.jsp"><span class="am-icon-home am-icon-fw">首页</span></a>
                    <a><span class="am-icon-heart am-icon-fw">收藏</span></a>

                </div>
                <li>
                    <div class="clearfix tb-btn tb-btn-buy theme-login">
                        <a id="LikBuy" title="点此按钮到下一步确认购买信息" href="javascript:;">立即购买</a>
                    </div>
                </li>
                <li>
                    <div class="clearfix tb-btn tb-btn-basket theme-login">
                        <a id="LikBasket" title="加入购物车" href="javascript:;"><i></i>加入购物车</a>
                    </div>
                </li>
            </div>

        </div>

        <div class="clear"></div>

    </div>


    <div class="clear"></div>


    <!-- introduce-->

    <div class="introduce">
        <div class="browse">
            <div class="mc">
                <ul>
                    <div class="mt">
                        <h2>看了又看</h2>
                    </div>
                    <li class="first">
                        <div class="p-img">
                            <a href="#"> <img class="" src="../images/browse1.jpg"> </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="introduceMain">
            <div class="am-tabs" data-am-tabs>
                <ul class="am-avg-sm-3 am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active">
                        <a href="#">

                            <span class="index-needs-dt-txt">宝贝详情</span></a>
                    </li>
                </ul>

                <div class="am-tabs-bd">

                    <div class="am-tab-panel am-fade am-in am-active">
                        <div class="J_Brand">

                            <div class="attr-list-hd tm-clear">
                                <h4>产品参数：</h4></div>
                            <div class="clear"></div>
                            <ul id="J_AttrUL">
                                <li title="">商品名称:&nbsp;<%=m.get("goodsname")%>
                                </li>
                                <li title="">品牌:&nbsp;<%=m.get("brand")%>
                                </li>
                                <%
                                    String statsu = null;
                                    int i = (int) m.get("status");
                                    if (i == 1) {
                                        statsu = "新品";
                                    } else if (i == 2) {
                                        statsu = "在售";
                                    } else {
                                        statsu = "下架";
                                    }
                                %>
                                <li title="">商品状态:&nbsp;<%=statsu%>
                                </li>
                                <li title="">产品规格:&nbsp;<%=m.get("equiv")%>
                                </li>
                                <li title="">保质期:&nbsp;180天</li>
                                <li title="">产品标准号:&nbsp;GB/T 22165</li>
                                <li title="">生产许可证编号：&nbsp;QS4201 1801 0226</li>
                                <li title="">储存方法：&nbsp;请放置于常温、阴凉、通风、干燥处保存</li>
                                <li title="">食用方法：&nbsp;开袋去壳即食</li>
                            </ul>
                            <div class="clear"></div>
                        </div>
                        <div class="details">
                            <div class="attr-list-hd after-market-hd">
                                <h4>商品细节</h4>
                            </div>
                            <div class="twlistNews">
                                <img src="../images/<%=m.get("picname")%>">
                            </div>
                        </div>
                        <div class="clear"></div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>

                <div class="clear"></div>

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
                        <div class="mp_qrcode" style="display:none;"><img src="../images/weixin_code_145.png"/><i class="icon_arrow_white"></i></div>
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
</div>
</body>

</html>