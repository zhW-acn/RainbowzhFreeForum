<%--
  User: acane
  Date: 2023/12/1
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="com.acn.bean.User" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>用户主页</title>
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <style>
        video {
            height: 100%;
        }
    </style>
</head>
<body>
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
        <%--搜索，未实现--%>
        <li class="layui-nav-item">
            <label>
                <input type="text" placeholder="搜索帖子" value="" class="layui-input">
            </label>
        </li>
    </ul>
    <%--居右--%>
    <ul class="layui-nav layui-layout-right layui-bg-green" style="white-space: nowrap;!important;">
        <%--用户信息--%>
        <li class="layui-nav-item">
            ${user.username == null?"请登录":user.username}
        </li>
        <%--头像--%>
        <li class="layui-nav-item" lay-unselect="">
            <img class="layui-nav-img" src="${user == null?"/img/default-avatar.png":user.avatar}">
            <%--这里点击退出清除session域，并刷新页面--%>
            <dl class="layui-nav-child">
                <dd style="text-align: center;"><a href="/logout">退出</a></dd>
            </dl>
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
<div class="layui-container">
    <div class="layui-row">
        <!-- 左侧区域 -->
        <div class="layui-col-md4">
            <!-- 用户大头像 -->
            <div class="user-avatar" style="text-align: center">
                <img src="${user.avatar}" class="layui-circle" style="width: 300px; height: 300px;" alt="用户头像">
                <p style="font-size: 2em;font-weight: bold">${user.username}</p>
            </div>
            <!-- 用户留言记录 -->
            <div class="user-comments">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>留言记录</legend>
                    <!-- 留言内容 -->
                </fieldset>
            </div>
        </div>

        <!-- 右侧区域 -->
        <div class="layui-col-md8">
            <fieldset class="layui-elem-field layui-field-title">
                <legend>我的帖子</legend>
                <!-- 帖子列表 -->
            </fieldset>
        </div>
    </div>
</div>
<script>

    // 当前登录的用户id，没有为false
    currentUserId = <%=user==null?false:user.getId()%>;
    window.onload = function () {
        if (currentUserId === false) {
            alert("请登录")
            location.href = "/";
        }
    }

</script>
</body>
</html>