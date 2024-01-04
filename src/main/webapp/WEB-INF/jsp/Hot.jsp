<%@ page import="com.acn.bean.User" %>
<%--
  User: acane
  Date: 2023/12/20
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>热门</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <style>
        video {
            height: 100%;
        }

        .parent-div {
            display: flex;
            justify-content: space-between;
            width: 100%;
            height: 100%;
            margin: 0 auto;
            border: 1px solid #ccc;
        }


        .left-div, .right-div {
            width: 100%;
            border: 1px solid #ddd;
        }

        body {
            overflow: hidden;
            background-color: #FFC3A0;
        }
    </style>
</head>
<body>
<%--导航栏--%>
<div class="layui-header header">
    <%--居左--%>
    <ul class="layui-nav" style="background-color: #cabbe9">
        <%--logo--%>
        <li class="layui-nav-item">
            <%--跳转到首页--%>
            <a href="">
                <video autoplay loop muted playsinline>
                    <source src="/img/logo.webm" type="video/webm">
                    抱歉，您的浏览器不支持内嵌视频。
                </video>
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="/search">搜索</a>
        </li>
    </ul>
    <%--居右--%>
    <ul class="layui-nav layui-layout-right" style="background-color: #ffa8a8;white-space: nowrap;!important;">
        <%if (user != null) {%>
        <li class="layui-nav-item">
            <a href="/user/${user.id}/message">
                消息<span class="layui-badge" id="message"></span>
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="/user/${user.id}/post">发帖</a>
        </li>
        <%}%>
        <%--用户信息--%>
        <li class="layui-nav-item">
            <%if (user == null) {%>
            <a href="/login">请登录</a>
            <%} else {%>
            <a href="/user/${user.id}">
                ${user.username}
            </a>
            <%}%>
        </li>
        <%--头像--%>
        <li class="layui-nav-item" lay-unselect="">
            <img class="layui-nav-img" src="${user == null?"/img/default-avatar.png":user.avatar}">
            <%--这里点击退出清除session域，并刷新页面--%>
            <%if (user == null) {%>
            <%} else {%>
            <dl class="layui-nav-child">
                <dd style="text-align: center;"><a href="/setting">设置</a></dd>
                <dd style="text-align: center;"><a href="/logout">退出</a></dd>
            </dl>
            <%}%>
        </li>
        <%--管理员面板跳转按钮--%>
        <%if (user != null && Integer.parseInt(user.getBanTime()) == -1) {%>
        <li class="layui-nav-item">
            <a href="/admin">
                管理员面板</a>
            <%}%>
        </li>
    </ul>
</div>


<div class="parent-div">
    <div class="left-div">
        <div id="post" style="width: 100%;height: 90%;">
        </div>

    </div>
    <div class="right-div">
        <p style="font-size: 50px;font-family: 幼圆" id="promptTip">正在分词，请等待</p>
        <div id="progressBar" class="layui-progress layui-progress-big" lay-showpercent="true" lay-filter="progressBar">
            <div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
        </div>
        <div id="topic" style="width: 100%;height: 90%;">
        </div>
    </div>
</div>
<%--左侧帖子--%>
<script>
    currentUserId = <%=user==null?false:user.getId()%>;
    var myChartPost = echarts.init($("#post")[0])

    window.onload = function () {
        // 帖子
        $.ajax({
            url: '/hotPost',
            type: 'post',
            success: function (data) {
                drawPost(JSON.parse(data));
            }
        })

        // 话题
        $.ajax({
            url: 'hotTopic',
            type: 'post',
            success: function (data) {
                drawTopic(JSON.parse(data))
            }
        })
    }

    // 跳转
    myChartPost.on('click', function (params) {
        window.location.href = '/post/' + encodeURIComponent(params.data.postid);
    });

    function drawPost(data) {
        var postOption = {
            // 图表标题
            title: {
                show: true,//显示策略
                text: '热门帖',//主标题文本
                x: 'center',        // 水平安放位置，
                y: 'top',             // 垂直安放位置
                backgroundColor: 'rgba(0,0,0,0)',
                borderWidth: 0,         // 标题边框线宽，单位px
                padding: 5,             // 标题内边距，单位px
                itemGap: 10,            // 主副标题纵向间隔，单位px
                textStyle: {
                    fontSize: 30,
                    color: '#1dffc9'        // 主标题文字颜色
                }
            },
            backgroundColor: '#FFC3A0',
            tooltip: {
                trigger: 'item',
                formatter: function (params) {
                    return "《" + params.data.name + "》回复数:" + params.data.symbolSize / 10;
                }
            },
            animationEasingUpdate: 'bounceIn',
            series: [{
                type: 'graph',
                layout: 'force',
                force: {
                    repulsion: 250,
                    edgeLength: 100
                },
                roam: true,
                label: {
                    normal: {
                        show: true,
                    }
                },
                data: data
            }]
        }
        myChartPost.setOption(postOption)
    }

</script>
<%--右侧话题--%>
<script>
    var myChartTopic = echarts.init($("#topic")[0])

    function drawTopic(data) {
        var topicOption = {
            title: {
                show: true,//显示策略
                text: "热门话题",
                x: 'center',
                y: 'top',
                backgroundColor: 'rgba(0,0,0,0)',
                borderWidth: 0,
                padding: 5,
                itemGap: 10,
                textStyle: {
                    fontSize: 30,
                    color: '#1dbbff'
                }
            },
            series: [
                {
                    name: "全部话题",
                    type: "treemap",
                    visibleMin: 300,
                    data: data,
                    leafDepth: 2,
                    levels: [
                        {
                            itemStyle: {
                                normal: {
                                    borderColor: "#555",
                                    borderWidth: 4,
                                    gapWidth: 4,
                                },
                            },
                        },
                        {
                            colorSaturation: [0.3, 0.6],
                            itemStyle: {
                                normal: {
                                    borderColorSaturation: 0.7,
                                    gapWidth: 1,
                                    borderWidth: 2,
                                },
                            },
                        },
                        {
                            colorSaturation: [0.3, 0.5],
                            itemStyle: {
                                normal: {
                                    borderColorSaturation: 0.6,
                                    gapWidth: 1,
                                },
                            },
                        },
                        {
                            colorSaturation: [0.3, 0.5],
                        },
                    ],
                },
            ],
        };
        $("#promptTip").hide()
        $("#progressBar").hide()
        myChartTopic.setOption(topicOption)
    }

    myChartTopic.on('click', function (params) {
        window.location.href = '/search/' + params.data.name
    });
</script>

<script>
    if (currentUserId !== false) {
        $.ajax({
            url: '/getmessage',
            type: 'get',
            success: function (res) {
                $("#message").text(res)
            }

        })
    }
    layui.use('element', function () {
        var $ = layui.jquery
            , element = layui.element;
        element.progress('progressBar', '0%');
        //触发事件
        function updateProgress() {
            var n = 0, timer = setInterval(function () {
                n = n + Math.random() * 10 | 0;
                if (n > 100) {
                    n = 100;
                    clearInterval(timer);
                }
                element.progress('progressBar', n + '%');
            }, 300 + Math.random() * 1000);
        }
        updateProgress();
    });

</script>
</body>
</html>
