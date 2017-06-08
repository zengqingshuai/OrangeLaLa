$(function () {
    $(function () {
        $(".user-addresslist").click(function () {
            $(this).addClass("defaultAddr").siblings().removeClass("defaultAddr");
        });
        $(".logistics").each(function () {
            var i = $(this);
            var p = i.find("ul>li");
            p.click(function () {
                if (!!$(this).hasClass("selected")) {
                    $(this).removeClass("selected");
                } else {
                    $(this).addClass("selected").siblings("li").removeClass("selected");
                }
            })
        })
    });
});
// 弹出地址选择
$(document).ready(function ($) {
    var $ww = $(window).width();
    $('.theme-login').click(function () {
//禁止遮罩层下面的内容滚动
        $(document.body).css("overflow", "hidden");
        $(this).addClass("selected");
        $(this).parent().addClass("selected");
        $('.theme-popover-mask').show();
        $('.theme-popover-mask').height($(window).height());
        $('.theme-popover').slideDown(200);
    });
    $('.theme-poptit .close,.btn-op .close').click(function () {
        $(document.body).css("overflow", "visible");
        $('.theme-login').removeClass("selected");
        $('.item-props-can').removeClass("selected");
        $('.theme-popover-mask').hide();
        $('.theme-popover').slideUp(200);
    })
});
 
 
 
 
 
 
 
 
 
 
 
 

