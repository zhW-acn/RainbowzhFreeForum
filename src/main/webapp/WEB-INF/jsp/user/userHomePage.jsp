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
    User userOwner = (User) request.getAttribute("userOwner");
%>
<html>
<head>
    <title>${userOwner.username}的主页</title>
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <style>
        video {
            height: 100%;
        }

        .outer-container {
            width: 70%;
            height: 200px;
            background-color: #3498db;
            margin: 0 auto;
        }

        .container {
            display: flex;
            height: 100%; /* 使内部容器填充整个外部容器 */
            box-sizing: border-box;
        }

        .avatar {
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

        .user-info img {
            width: 50px; /* 头像的大小 */
            height: 50px;
            border-radius: 50%; /* 圆形头像 */
            margin-right: 10px;
        }

        .user-info div {
            display: flex;
            flex-direction: column;
        }

        .user-avatar {
            width: 50px; /* 头像的大小 */
            height: 50px;
            border-radius: 50%; /* 圆形头像 */
            margin-right: 10px;
        }

        .hide {
            -webkit-mask-image: linear-gradient(180deg, #000 60%, transparent);
            mask-image: linear-gradient(180deg, #000 60%, transparent);
            overflow: hidden;
            padding: 0 10px;
            max-lines: 2;
            max-height: 400px
        }

        .page-layout {
            display: flex;
            align-items: flex-start;
            padding: 20px;
        }

        .avatar {
            border: 2px solid black;
            border-radius: 50%;
            width: 100px;
            height: 100px;
            margin-right: 20px;
        }

        .content-area {
            flex-grow: 1;
        }

        .post-title {
            border: 2px solid black;
            padding: 5px;
            margin-bottom: 10px;
        }

        .comment {
            border: 2px solid black;
            padding: 5px;
            position: relative;
            height: 150px;
            overflow: auto;
        }

        .delete-button {
            position: absolute;
            bottom: 5px;
            left: 5px;
        }

        .comment-time {
            position: absolute;
            bottom: 5px;
            right: 5px;
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
            <a href="/">
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
            <a href="/user/${user.id}">
                ${user.username}
            </a>
        </li>
        <%--头像--%>
        <li class="layui-nav-item" lay-unselect="">
            <img class="layui-nav-img" src="${user == null?"/img/default-avatar.png":user.avatar}">
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
<div class="layui-container">
    <div class="layui-row" style="display: flex;">
        <!-- 左侧区域 -->
        <div class="layui-col-md4">
            <!-- 用户大头像 -->
            <div class="user-avatar" style="margin-bottom: 300px;">
                <img src="${userOwner.getAvatar()}" class="layui-circle" style="width: 300px; height: 300px;"
                     alt="用户头像">
                <p style="font-size: 2em; font-weight: bold; margin-top: 10px; margin-bottom:
                        0; white-space: nowrap;">${userOwner.getUsername()}</p>
            </div>
            <!-- 用户留言记录 -->
            <div class="user-comments" style="width: 100%;">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>留言记录</legend>
                    <ul id="myComments" style="border: 2px solid black"></ul>
                </fieldset>
            </div>
        </div>

        <!-- 右侧区域 -->
        <div class="layui-col-md8">
            <fieldset class="layui-elem-field layui-field-title">
                <legend><%=user.getId() == userOwner.getId() ? "我" : userOwner.getUsername()%>的帖子</legend>
                <!-- 帖子列表 -->
                <div>
                    <ul class="flow-default" id="myPost"></ul>
                </div>
            </fieldset>
        </div>
    </div>
</div>
<script>
    // 当前登录的用户id，没有为false
    var currentUserId = <%=user==null?false:user.getId()%>;
    window.onload = function () {
        if (currentUserId === false) {
            alert("请登录")
            location.href = "/login";
        }
        // 如果不是自己的主页
        if (currentUserId !== <%=userOwner.getId()%>) {
            $(".user-comments").remove()
        }
    }

    var layer = layui.layer;
    var flow = layui.flow;
    layui.use('flow', function () {
        /*帖子*/
        flow.load({
            elem: '#myPost', //流加载容器
            done: function (page, next) { //下一页的回调
                $.ajax({
                    url: '/user/${userId}/ajax',
                    type: 'GET',
                    data: {
                        userId: ${userId}
                    },
                    success: function (data) {
                        var list = JSON.parse(data);
                        var lis = [];
                        // 处理返回的帖子数据
                        for (var i = 0; i < list.length; i++) {
                            lis.push(
                                '<li style="text-align: center; margin-top: 5px">' +
                                /*帖子*/
                                '<div class="outer-container">' +
                                '<div class="container">' +
                                '<div class="avatar-container" id="user_' + list[i].userId + '">' +
                                '<img src="' + list[i].userAvatar + '" class="avatar layui-circle" alt="用户头像"> ' +
                                '<div class="username">' + list[i].username + '</div> ' +
                                '</div> ' +
                                '<div class="middle-container" id="post_' + list[i].postId + '"> ' +
                                '<div class="title">' + list[i].title + '</div>' +
                                ' <div class="content hide thread-content"> ' +
                                '<p>' + list[i].text + '</p> ' +
                                '</div> ' +
                                '</div> ' +
                                '<div class="info">' +
                                '<p>' + list[i].replyCount + ' 人回帖</p>' +
                                '<p>发帖时间: ' + list[i].createtime + '</p>' +
                                <%if(user.getId()==userOwner.getId()){%>
                                '<button class="deleteBtn" onclick="clickDelete(' + list[i].postId + ')">删除该帖' + '</button>' +
                                <%}%>
                                '</div>' +
                                '</div>' +
                                '</div>'
                                + '</li>'
                            );
                        }
                        next(lis.join(''), false);

                        // 绑定点击事件
                        for (var i = 0; i < list.length; i++) {
                            $('#post_' + list[i].postId).on('click', function () {
                                // 跳转到帖子详情页
                                clickPost($(this).attr('id'), this);
                            });
                        }
                    }
                });
            }
        });
        /*留言记录*/
        flow.load({
            elem: '#myComments',
            done: function (page, next) {
                $.ajax({
                    url: '/user/${userId}/commentsList/${userId}',
                    type: 'get',
                    success: function (data) {
                        var list = JSON.parse(data);
                        var lis = [];
                        for (var i = 0; i < list.length; i++) {
                            lis.push(
                                '<div class="page-layout">' +
                                '<img src="' + list[i].userAvatar +
                                '" class="avatar layui-circle" alt="用户头像" style="height: 50px; width: 50px"> ' +
                                '<div class="content-area">' +
                                '<div class="post-title comment_post_' + list[i].postId + '">' + list[i].title +
                                '</div>' +
                                '<div class="comment">' +
                                '<p>' + list[i].comment_text + '</p>' +
                                '<button class="layui-btn delete-button" onclick="deleteComment(' + list[i].postId + ',' + list[i].commentId + ')">点击删除</button>' +
                                '<div class="comment-time">' + list[i].createTime + '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>'
                            );

                        }
                        next(lis.join(''), false);

                        // 绑定点击事件
                        for (var i = 0; i < list.length; i++) {
                            $('.comment_post_' + list[i].postId).on('click', function () {
                                // 跳转到帖子详情页
                                clickCommentPost($(this).attr('class'), this);
                            });
                        }
                    }
                })
            }
        });
    });

    /*右侧点击跳转帖子*/
    function clickPost(postId) {
        location.href = "/post/" + postId.replace("post_", "");
    }

    /*左侧点击跳转帖子*/
    function clickCommentPost(postId) {
        location.href = "/post/" + postId.replace("post-title comment_post_", "");
    }

    /*右侧点击删除帖子*/
    function clickDelete(postId) {
        $.ajax({
            url: "/post/" + postId + "/delete/" + postId,
            type: 'post',
            success: function (res) {
                if (res === "success") {
                    layer.alert("删除成功", {offset: 't'}, function () {
                        location.reload();
                    })
                } else {
                    layer.msg("服务器异常", {offset: 't'})
                }
            }
        })
    }

    /*左侧点击删除评论*/
    function deleteComment(postId, commentId) {
        $.ajax({
            url: "/post/" + postId + "/deleteComment/" + commentId,
            type: 'post',
            success: function (res) {
                if (res === "success") {
                    layer.alert("删除成功", {offset: 't'}, function () {
                        location.reload();
                    })
                } else {
                    layer.msg("服务器异常", {offset: 't'})
                }
            }
        })
    }
</script>
</body>
</html>