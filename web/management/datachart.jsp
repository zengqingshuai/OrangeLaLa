<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>2017年6月商品浏览统计</title>
    <!-- 引入 echarts.js -->
    <script src="../js/echarts.min.js"></script>
    <script>
        function show(){
            location.href = 'data.html'
        }
    </script>
    <style>
        a{
            margin-left: 48%;
        }
    </style>
</head>
<body>
<div id="main" style="width: 900px;height:400px;border:1px solid gray;margin:80px auto;"></div>
<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('main'));
    var option = {
        title:{text:'2017年6月商品浏览统计',link:'#',x:'center'},
        label:{ normal:{ show: true, position:'top'} }, //inside
        tooltip: {},
        itemStyle: {
            normal: {
                //好，这里就是重头戏了，定义一个list，然后根据所以取得不同的值，这样就实现了，
                color: function(params) {
                    // build a color map as your need.
                    var colorList = [
                        '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                        '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                        '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                    ];
                    return colorList[params.dataIndex]
                },
                //以下为是否显示，显示位置和显示格式的设置了
                label: {
                    show: true,
                    position: 'top',
                    formatter: '{b}\n{c}'
                }
            }
        },
        legend: {
            data:['商品类别']
        },
        xAxis: {
            data:${requestScope.list[0]}
        },
        yAxis: {
            axisLabel: {
                formatter: '{value}次'
            }
        },
        series: [{
            name: '浏览次数',
            type: 'bar',
            data: ${requestScope.list[1]}
        }]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
<a href="index.jsp">回到首页</a>
</body>
</html>