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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
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
        }
    </style>
</head>
<body>
<%--导航栏--%>
<div class="layui-header header">
    <%--居左--%>
    <ul class="layui-nav layui-bg-blue" lay-bar="disabled">
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
            <a href="/search">去搜索</a>
        </li>
    </ul>
    <%--居右--%>
    <ul class="layui-nav layui-layout-right layui-bg-green" style="white-space: nowrap;!important;">
        <%if (user != null) {%>
        <li class="layui-nav-item">
            <a href="/user/${user.id}/post">去发帖</a>
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
        <div id="topic" style="width: 100%;height: 90%;">
        </div>
    </div>

    <%--左侧帖子--%>
    <script>
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
                backgroundColor: '#ffffff',
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
                        color: '#ffd91d'
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
            myChartTopic.setOption(topicOption)
        }

        myChartTopic.on('click', function (params) {
            window.location.href = '/search/' + params.data.name
        });
    </script>
</body>
</html>
