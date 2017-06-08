/**
 * Created by weiyinghang on 2017/5/20.
 */

//使用ajax 实现时钟
var aj = new XMLHttpRequest();
function showTime() {
    aj.open("GET", "/servertime.do", true);
    aj.send(null);
}
aj.onreadystatechange = function () {
    if (aj.status == 200 && aj.readyState == 4) {
        $('#times').html(aj.responseText);
    }
};
setInterval(showTime, 1000);
//安全退出
$(function () {
    $('#exit').click(function () {
        if(confirm('确认退出？')){
            location.href="exit.do"
        }
    })
});
$(function () {
    $('#confirmdel').click(function () {
        if (!confirm('确定删除？')) {
            this.href = "javascript:(0);"
        }
    })
});