<%--
  User: acane
  Date: 2023/11/26
  管理页
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
</head>
<style>
    video {
        height: 100%;
    }
</style>
<body>
<div class="layui-layout layui-layout-admin">
    <%--头部导航栏--%>
    <div class="layui-header">
        <%--跳转到首页--%>
        <a href="">
            <video autoplay loop muted playsinline>
                <source src="img/logo.webm" type="video/webm">
                抱歉，您的浏览器不支持内嵌视频。
            </video>
        </a>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-hide-xs"><a href="">我的主页</a></li>
            <li class="layui-nav-item layui-hide-xs"><a href="">公告管理</a></li>
            <li class="layui-nav-item layui-hide-xs"><a href="">nav 3</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">nav groups</a>
                <dl class="layui-nav-child">
                    <dd><a href="">menu 11</a></dd>
                    <dd><a href="">menu 22</a></dd>
                    <dd><a href="">menu 33</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <%--头像--%>
                <a href="javascript:;">
                    <img src="${user.avatar}" class="layui-nav-img">
                    ${user.username}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="/user/${user.id}">我的主页</a></dd>
                    <dd><a href="">Settings</a></dd>
                    <dd><a href="logout">登出</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左导航栏-->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">用户</a>
                    <dl class="layui-nav-child">
                        <dd onclick="updateIframe('all.jsp')"><a href="javascript:;">全部用户</a></dd>
                        <dd><a href="javascript:;">封禁用户</a></dd>
                        <dd><a href="javascript:;">menu 3</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">帖子</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">全部帖</a></dd>
                        <dd><a href="javascript:;">封禁贴</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="javascript:;">click menu item</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe id="content-frame" style="width:100%; height:100%;"></iframe>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        底部固定区域
    </div>
</div>
<script>

    // 当导航项被点击时调用此函数
    function updateIframe(url) {
        // 获取iframe元素
        var iframe = document.getElementById('content-frame');
        // 更新iframe的src属性
        iframe.src = url;
    }

    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.$;
    });


</script>
</body>
</html>
