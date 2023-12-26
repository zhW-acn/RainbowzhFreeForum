<%@ page import="com.acn.bean.User" %>
<%--
  User: acane
  Date: 2023/12/26
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>${user.username}的消息</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        #search {
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }

        video {
            height: 100%;
        }

        .outer-container {
            width: 70%;
            height: 150px; /* 设置外部容器高度为150px */
            background-color: #3498db;
            margin: 0 auto;
        }

        .container {
            display: flex;
            height: 100%; /* 使内部容器填充整个外部容器 */
            box-sizing: border-box;
        }

        .avatar, .info {
            box-sizing: border-box;
            text-align: center;
            vertical-align: top;
        }

        .avatar-container {
            flex: 1 1 20%;
            height: 100%; /* 适应外部容器的高度 */
            display: flex;
            background-color: #5ec3e8;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* 防止内容溢出div */
        }

        .avatar {
            max-width: 100%; /* 限制图片最大宽度 */
            max-height: 80%; /* 调整图片最大高度，为用户名留出空间 */
            object-fit: cover; /* 保持图片的宽高比 */
        }

        .username {
            font-size: 12px; /* 调整用户名字体大小 */
            font-weight: bold;
            margin-top: 5px; /* 在用户名和头像之间添加间距 */
            color: #fff;
        }


        .middle-container {
            flex: 1 1 60%;
            display: flex;
            flex-direction: column;
            height: 100%; /* 适应外部容器的高度 */
            box-sizing: border-box;
        }

        .title, .content {
            box-sizing: border-box;
        }

        .title {
            background-color: #0DDCFF;
            font-weight: bold;
            font-size: 20px; /* 调整标题字体大小 */
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .content {
            background-color: #83ddfc;
            flex-grow: 1;
            text-align: left;
            font-size: 15px; /* 调整内容字体大小 */
        }

        .thread-content {
            font-size: 15px;
            word-break: break-all
        }

        .info {
            background-color: #01b7ef;
            flex: 1 1 20%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .hide {
            -webkit-mask-image: linear-gradient(180deg, #000 60%, transparent);
            mask-image: linear-gradient(180deg, #000 60%, transparent);
            overflow: hidden;
            padding: 0 10px;
            max-lines: 2;
            max-height: 400px
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
            <a href="/hot">热门</a>
        </li>
        <li class="layui-nav-item">
            <a href="/search">搜索</a>
        </li>
    </ul>
    <%--居右--%>
    <ul class="layui-nav layui-layout-right layui-bg-green" style="white-space: nowrap;!important;">
        <%if (user != null) {%>
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

<div>
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 50px;font-family: 幼圆;">未读评论</legend>
        <ul class="flow" id="UnreadCommentList"></ul>
    </fieldset>

    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 50px;font-family: 幼圆;">已读评论</legend>
        <ul class="flow" id="ReadedCommentList"></ul>
    </fieldset>
</div>
<script>
    var flow = layui.flow;

    var unreadList;

    var readedList;


    window.onload = function () {
        layui.use('flow', function () {
            $.ajax({
                url: '/user/${user.id}/message',
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    unreadList = data.unread;
                    readedList = data.readed;

                    flow.load({
                        elem: '#UnreadCommentList',
                        done: function (page, next) {
                            addList(page, next, unreadList)
                        }
                    })
                    flow.load({
                        elem: '#ReadedCommentList',
                        done: function (page, next) {
                            addList(page, next, readedList)
                        }
                    })

                }
            })
        })
    }


    function addList(page, next, list) {
        var lis = [];
        if(list.length === 0){
            next(lis.join(''), false);
            return false;
        }
        for (var i = 0; i < list.length; i++) {
            lis.push(
                '<li style="text-align: center; margin-top: 5px">' +
                '<div class="outer-container">' +
                '<div class="container">' +
                '<div class="avatar-container user_' + list[i].userId + '">' +
                '<img src="' + list[i].userAvatar + '" class="avatar layui-circle" alt="用户头像"> ' +
                '<div class="username">' + list[i].username + '</div> ' +
                '</div> ' +
                '<div class="middle-container post_' + list[i].postId + '"> ' +
                '<div class="title">' + list[i].postTitle + '</div>' +
                ' <div class="content hide thread-content"> ' +
                '<p>' + list[i].commentText + '</p> ' +
                '</div> ' +
                '</div> ' +
                '<div class="info">' +
                '<p class="create-time">评论时间: ' + list[i].createtime + '</p>' +
                '</div>' +
                '</div>' +
                '</div>'
                + '</li>'
            );
            next(lis.join(''), false);
        }
        bindFunction(list);
    }


    // 绑定点击事件函数
    function bindFunction(list) {
        for (var i = 0; i < list.length; i++) {
            // 这个是用户的绑定事件
            $('.users_' + list[i].id).on('click', function () {
                location.href = "/user/" + $(this).attr('class').replace("users_", "");
            })

            // 这个是帖子的绑定事件
            $('.user_' + list[i].userId).on('click', function () {
                // 跳转到用户详情页
                location.href = "/user/" + $(this).attr('class').replace("avatar-container user_", "");
            });
            $('.post_' + list[i].postId).on('click', function () {
                // 跳转到帖子详情页
                location.href = "/post/" + $(this).attr('class').replace("middle-container post_", "");
            });
        }
    }
</script>

</body>
</html>
