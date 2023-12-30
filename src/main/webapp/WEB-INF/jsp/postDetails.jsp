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
    <title>${post.title}</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <style>
        video {
            height: 100%;
        }

        body {
            background-color: #FFC3A0;
            color: #333;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        .outer-container {
            width: 70%;
            margin: 0 auto;
        }

        .container {
            display: flex;
            box-sizing: border-box;
        }

        .avatar-container {
            flex: 1 1 20%;
            display: flex;
            background-color: #FFC0CB;
            flex-direction: column;
            align-items: center;
            overflow: hidden;
            padding: 20px;
        }

        .avatar {
            max-width: 100%;
            max-height: 80%;
            object-fit: cover;
        }

        .username {
            font-size: 16px;
            font-weight: bold;
            margin-top: 10px;
            color: #fff; /* 白色 */
        }

        .middle-container {
            flex: 1 1 60%;
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
            padding: 20px;
        }

        .title {
            background-color: #FFC0CB;
            font-weight: bold;
            font-size: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px;
            margin-bottom: 20px;
            color: #fff; /* 白色 */
        }

        .content {
            background-color: #FFC0CC;
            flex-grow: 1;
            text-align: left;
            font-size: 18px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .comment-form-container {
            margin-bottom: 20px;
        }

        #commentText {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        button {
            background-color: #3498db; /* 蓝色 */
            color: #fff; /* 白色 */
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .comment-container {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .comment {
            background-color: #D9A6A9;
            display: flex;
            flex-direction: row;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            padding: 10px;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            margin-right: 20px;
        }

        .user-info img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-bottom: 10px;
        }

        .user-info div {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .comment-body {
            display: flex;
            flex-direction: column;
        }

        .comment-text {
            flex-grow: 1;
            text-align: left;
            font-size: 16px;
        }

        .comment .timestamp {
            font-size: 12px;
            color: #888;
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
            <a href="/hot">热门</a>
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
            <a href="/user/${user.id}/post">去发帖</a>
        </li>
        <%}%>
        <%--用户信息--%>
        <li class="layui-nav-item">
            <a href="/user/${user.id}">
                ${user.username}
            </a>
        </li>
        <%--头像--%>
        <li class="layui-nav-item" lay-unselect="">
            <img class="layui-nav-img" src="${user.avatar}">
            <%--这里点击退出清除session域，并刷新页面--%>
            <dl class="layui-nav-child">
                <dd style="text-align: center;"><a href="/setting">设置</a></dd>
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

<div class="" style="margin:0 auto">
    <div class="outer-container">
        <%--帖子--%>
        <div class="container">
            <div class="avatar-container" id="user_${post.userId}">
                <img src="${post.userAvatar}" class="avatar layui-circle" alt="用户头像">
                <div class="username">${post.username}</div>
                <div>发帖时间: ${post.createtime}</div>
            </div>
            <div class="middle-container" id="post_${post.postId}">
                <div class="title">${post.title}</div>
                <div class="content hide thread-content">
                    <p>${post.text}</p>
                </div>
            </div>
        </div>
        <%--发表评论--%>
        <div class="comment-form-container">
            <form id="commentForm" action="/addComment" method="post">
                <textarea id="commentText" name="commentText" placeholder="在这里输入你的评论..."></textarea>
                <button type="submit">发表评论</button>
            </form>
        </div>
        <%--评论--%>
        <ul class="comment-container" id="CommentList">
        </ul>
    </div>
</div>

<script>
    var layer = layui.layer;
    // 评论总数
    var count = ${count}
    // 当前登录的用户id，没有为false
    var currentUserId = <%=user==null?false:user.getId()%>;
    window.onload = function () {
        if (currentUserId === false) {
            alert("请登录")
            location.href = "/login";
        }
    }
    layui.use('flow', function () {
        var flow = layui.flow;

        flow.load({
            elem: '#CommentList',
            done: function (page, next) {
                $.ajax({
                    url: '/post/${post.getPostId()}',
                    type: 'POST',
                    data: {
                        page: page
                    },
                    success: function (data) {
                        var list = JSON.parse(data);
                        var lis = [];
                        for (var i = 0; i < list.length; i++) {
                            lis.push(
                                '<li>' +
                                '<div class="comment" id="comment_' + list[i].id + '">' +
                                '<div class="user-info user_' + list[i].userId + '">' +
                                '<img src="' + list[i].userAvatar +
                                '" alt="用户头像" class="user-avatar">' +
                                '<div>' +
                                '<p>' + list[i].username + '</p>' +
                                '<p class="timestamp">' + list[i].createtime + '</p>' +
                                '</div>' +
                                '</div>' +
                                '<div class="comment-body">' +
                                '<div class="comment-text">' +
                                list[i].commentText +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</li>'
                            )
                        }
                        next(lis.join(''), page < count);
                        // 绑定点击事件
                        for (var i = 0; i < list.length; i++) {
                            $('.user_' + list[i].userId).on('click', function () {
                                // 跳转到用户详情页
                                clickUser($(this).attr('class'));
                            });
                        }
                    }
                });
            }
        });
    });

    $("#commentForm").submit(function (event) {
        event.preventDefault();
        var commentText = $("#commentText").val();
        if (commentText === "") {
            alert("输入评论不可为空")
            return false;
        }
        $.ajax({
            url: '/post/${post.getPostId()}/addComment',
            type: 'POST',
            data: {
                postId: ${post.getPostId()},
                commentText: commentText,
                userId: currentUserId
            },
            success: function (data) {
                if (data === "success") {
                    layer.msg("发表成功")
                    $("#commentText").val("")
                    // 按时间排序刷新评论区
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                }
            },
            error: function (error) {
                alert("服务器异常")
            }
        });
    });

    /*贴主*/
    $("#user_${post.userId}").on('click', function () {
        location.href = "/user/" + $("#user_${post.userId}").selector.replace("#user_", "");
    })

    /*楼主*/
    function clickUser(userId) {
        location.href = "/user/" + userId.replace("user-info user_", "");
    }

    if (currentUserId !== false) {
        $.ajax({
            url: '/getmessage',
            type: 'get',
            success: function (res) {
                $("#message").text(res)
            }

        })
    }
</script>
</body>
</html>