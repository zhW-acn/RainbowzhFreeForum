<%@ page import="com.acn.bean.User" %>
<%--
  User: acane
  Date: 2023/12/1
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
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

        .outer-container {
            width: 70%;
            height: 200px;
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
            background-color: #5256FF;
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
            background-color: #1EFFA9;
            flex-grow: 1;
            text-align: left;
            font-size: 15px; /* 调整内容字体大小 */
        }

        .comment-container {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .comment {
            display: flex;
            width: 100%;
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
            margin-right: 100px;
        }

        .user-info img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .user-info div {
            display: flex;
            flex-direction: column;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .comment-body {
            display: flex;
            flex-direction: column;
        }

        .comment-text {
            flex-grow: 1;
            text-align: center;
        }

        .comment .timestamp {
            font-size: 12px;
        }
    </style>
    <script>
        // 当前登录的用户id，没有为false
        currentUserId = <%=user==null?false:user.getId()%>;
        window.onload = function () {
            if (currentUserId === false) {
                alert("请登录")
                location.href = "/login";
            }
        }
    </script>
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
            ${user.username}
        </li>
        <%--头像--%>
        <li class="layui-nav-item" lay-unselect="">
            <img class="layui-nav-img" src="${user.avatar}">
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

<%--帖子--%>
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
        <%--评论--%>
        <ul class="comment-container">
            <%--一楼--%>
            <li>
                <div class="comment">
                    <div class="user-info">
                        <img src="avatar.jpg" alt="用户头像" class="user-avatar">
                        <div>用户名</div>
                        <div class="timestamp">2023-12-01 16:11</div>
                    </div>
                    <div class="comment-body">
                        <div class="comment-text">
                            这里是评论的文本内容。
                        </div>
                        <%--一楼的评论--%>
                        <ul class="comment-container">
                            <%--评论一--%>
                            <li>
                                <div class="comment">
                                    <div class="user-info">
                                        <img src="回复用户头像.jpg" alt="回复用户头像" class="user-avatar">
                                        <div>
                                            <p>回复用户名</p>
                                            <p class="timestamp">2023-12-01 16:15</p>
                                        </div>
                                    </div>
                                    <div class="comment-body">
                                        <div class="comment-text">
                                            这里是回复评论的文本内容。
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <%--评论二--%>
                            <li>
                                <div class="comment">
                                    <div class="user-info">
                                        <img src="回复用户头像.jpg" alt="回复用户头像" class="user-avatar">
                                        <div>
                                            <p>回复用户名</p>
                                            <p class="timestamp">2023-12-01 16:15</p>
                                        </div>
                                    </div>
                                    <div class="comment-body">
                                        <div class="comment-text">
                                            这里是回复评论的文本内容。
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </li>
            <%--二楼--%>
            <li>
                <div class="comment">
                    <div class="user-info">
                        <img src="新用户头像.jpg" alt="新用户头像" class="user-avatar">
                        <div>
                            <p>新用户名</p>
                            <p class="timestamp">2023-12-01 16:15</p>
                        </div>
                    </div>
                    <div class="comment-body">
                        <div class="comment-text">
                            这里是新评论的文本内容。
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script>

</script>
</body>
</html>