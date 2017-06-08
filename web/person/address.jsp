<%@ page import="com.fz.db.MyDbUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>收货地址管理</title>
    <link href="../AmazeUI-2.4.2/assets/css/admin.css" rel="stylesheet" type="text/css">
    <link href="../AmazeUI-2.4.2/assets/css/amazeui.css" rel="stylesheet" type="text/css">
    <link href="../css/personal.css" rel="stylesheet" type="text/css">
    <link href="../css/addstyle.css" rel="stylesheet" type="text/css">
    <script src="../AmazeUI-2.4.2/assets/js/jquery.min.js" type="text/javascript"></script>
    <script src="../AmazeUI-2.4.2/assets/js/amazeui.js"></script>
    <link href="../js/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet">
    <script src="../js/jquery-ui-1.12.1/jquery-ui.js"></script>
    <script>
        var a = "<%=request.getParameter("addrinfo")%>";
        if (a != "null") {
            alert(a)
        }
        $(function () {
            $("#show1").click(function () {
                $("#doc-modal-1").css("visibility","visible")
            })
        })
        function exit() {
            if(confirm("确认退出？")){
                location.href="../exit.action"
            }
        }
    </script>
    <style>
        #show1 {
            width: 100px;
            height: 30px;
            font-size: 17px;
            line-height: 30px;
            text-align: center;
            margin: auto;
            color: white;
            background-color: red;
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
                        <div class="menu-hd MyShangcheng"><a href="index.jsp" target="_top">
                            <i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
                    </div>
                    <div class="topMessage mini-cart">
                        <div class="menu-hd"><a id="mc-menu-hd" href="#" target="_top">
                            <i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车
                        </span><strong id="J_MiniCartNum" class="h">0</strong></a>
                        </div>
                    </div>
                    <div class="topMessage favorite">
                        <div class="menu-hd"><a href="#" target="_top">
                            <i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div>
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
            <div class="user-address">
                <!--标题 -->
                <div class="am-cf am-padding">
                    <div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">地址管理</strong> /
                        <small>Address&nbsp;list</small>
                    </div>
                </div>
                <hr/>
                <ul class="am-avg-sm-1 am-avg-md-3 am-thumbnails">
                    <%
                        request.setCharacterEncoding("utf-8");
                        MyDbUtil m = new MyDbUtil();
                        String person_admin = session.getAttribute("person_admin").toString();
                        List<Map<String, Object>> list = m.query("oll_addr,oll_user", "*", "where oll_addr.uid=oll_user.id and oll_user.account='" + person_admin + "'", "", " limit 5");//oll_addr.account='" + person_admin+"'
                        if (list!= null) {
                            for (Map<String, Object> map : list) {
                    %>
                    <li class="user-addresslist">
                        <span class="new-option-r"><i class="am-icon-check-circle"></i>默认地址</span>
                        <p class="new-tit new-p-re">
                            <span class="new-txt">联系人：<%=map.get("linkman")%></span>
                            <br>
                            <span class="new-txt-rd2">联系电话：<%=map.get("phone")%></span>
                        </p>
                        <div class="new-mu_l2a new-p-re">
                            <p class="new-mu_l2cw">
                                <span class="title">地址：</span>
                                <span class="province"><%=map.get("address")%></span>
                                <br>
                                <span class="title">邮编：</span>
                                <span class="province"><%=map.get("code")%></span>
                            </p>
                        </div>
                        <div class="new-addr-btn">
                            <a href="">
                                <i class="am-icon-edit" name="edit"></i>编辑</a>
                            <span class="new-addr-bar">|</span>
                            <a href="javascript:;" onclick="comfirmDel()">
                                <i class="am-icon-trash" name="delete"></i>删除
                            </a>
                        </div>
                    </li>
                    <script>
                        function comfirmDel() {
                            if (confirm("确定删除？")){
                                location.href="address.do?id=<%=map.get("id")%>"
                            }
                        }
                    </script>
                    <%
                            }
                        }
                    %>
                </ul>

                <div id="show1" style="cursor: pointer">添加新地址</div>
                <!--例子-->
                <div class="am-modal am-modal-no-btn" id="doc-modal-1" style="visibility:hidden">
                    <div class="add-dress">
                        <!--标题 -->
                        <div class="am-cf am-padding">
                            <div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">新增地址</strong> /
                                <small>Add&nbsp;address</small>
                            </div>
                        </div>
                        <hr/>
                        <div class="am-u-md-12 am-u-lg-8" style="margin-top: 20px;">
                            <form class="am-form am-form-horizontal" action="address.do" method="post">
                                <div class="am-form-group">
                                    <label class="am-form-label">收货人</label>
                                    <div class="am-form-content">
                                        <input type="text" id="name" placeholder="收货人" name="name">
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <label class="am-form-label">手机号码</label>
                                    <div class="am-form-content">
                                        <input id="phone" placeholder="手机号必填" type="text" name="phone">
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <label class="am-form-label">所在地</label>
                                    <div class="am-form-content address">
                                        <select name="addr1" id="selProvince" onchange="changecity()">
                                            <option>--选择省份</option>
                                        </select>
                                        <select name="addr2" id="selCity">
                                            <option>--选择城市--</option>
                                        </select>
                                    </div>
                                </div>
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
                                <div class="am-form-group">
                                    <label class="am-form-label">邮编</label>
                                    <div class="am-form-content">
                                        <input type="text" id="intro" placeholder="输入邮编" name="intro" minlength="6" maxlength="6">
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <div class="am-u-sm-9 am-u-sm-push-3">
                                        <input type="submit" value="保存" class="am-btn-danger"
                                               id="address_submit_button">
                                        <input type="reset" value="取消" id="cancel" class="am-btn-danger">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    $(".new-option-r").click(function () {
                        $(this).parent('.user-addresslist').addClass("defaultAddr").siblings().removeClass("defaultAddr");
                    });
                    var $ww = $(window).width();
                    if ($ww > 640) {
                        $("#doc-modal-1").removeClass("am-modal am-modal-no-btn")
                    }
                })
                $(function () {
                    $('#cancel').click(function () {
                        $("#doc-modal-1").css("visibility","hidden")
                    })
                })
            </script>

            <div class="clear"></div>

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
                    <li><a href="information.jsp">个人信息</a></li>
                    <li><a href="safety.jsp">安全设置</a></li>
                    <li><a href="address.jsp">收货地址</a></li>
                </ul>
            </li>
            <li class="person">
                <a>我的交易</a>
                <ul>
                    <li><a href="order.jsp">订单管理</a></li>
                    <li><a href="change.html">退款售后</a></li>
                </ul>
            </li>
            <li class="person">
                <a>我的资产</a>
                <ul>
                    <li><a href="coupon.html">优惠券 </a></li>
                    <li><a href="bonus.jsp">红包</a></li>
                    <li><a href="bill.jsp">账单明细</a></li>
                </ul>
            </li>

            <li class="person">
                <a>我的小窝</a>
                <ul>
                    <li><a href="collection.html">收藏</a></li>
                    <li><a href="foot.html">足迹</a></li>
                    <li><a href="comment.html">评价</a></li>
                    <li><a href="news.html">消息</a></li>
                </ul>
            </li>
        </ul>
    </aside>
</div>


</body>
</html>
