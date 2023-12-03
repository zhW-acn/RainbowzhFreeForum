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
    <title>用户主页</title>
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
    </style>
</head>
<body>
<div class="layui-header header">
    <%--居左--%>
    <ul class="layui-nav layui-bg-blue" lay-bar="disabled">
        <%--logo--%>
        <li class="layui-nav-item">
            <%--跳转到首页--%>
            <a href="<%=basePath%>">
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
    <div class="layui-row" style="display: flex;">
        <!-- 左侧区域 -->
        <div class="layui-col-md4">
            <!-- 用户大头像 -->
            <div class="user-avatar" style="margin-bottom: 300px;">
                <img src="${userOwner.avatar}" class="layui-circle" style="width: 300px; height: 300px;" alt="用户头像">
                <p style="font-size: 2em; font-weight: bold; margin-top: 10px; margin-bottom:
                        0; white-space: nowrap;">${userOwner.username}</p>
            </div>
            <!-- 用户留言记录 -->
            <div class="user-comments" style="width: 100%;">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>留言记录</legend>
                    <ul id="myComments" style="border: 2px solid black">
                        <li style="border: 2px solid black">记录1</li>
                        <li style="border: 2px solid black">记录2</li>
                    </ul>
                    <!-- 留言内容 -->
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
    currentUserId = <%=user==null?false:user.getId()%>;
    window.onload = function () {
        if (currentUserId === false) {
            alert("请登录")
            location.href = "/login";
        }
    }
    // 如果不是自己的主页
    if (currentUserId !== <%=userOwner.getId()%>) {
        $(".user-comments").remove()
    }

    layui.use('flow', function () {
        var flow = layui.flow;
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
            done: function (page, next){
                $.ajax({
                    url: '',
                    type: '',
                    data: {

                    },
                    success: function () {
                        var list = JSON.parse(data);
                        var lis = [];

                        next(lis.join(''), false);
                    }
                })
            }
        });
    });

    function clickPost(postId) {
        location.href = "/post/" + postId.replace("post_", "");
    }
</script>
</body>
</html>