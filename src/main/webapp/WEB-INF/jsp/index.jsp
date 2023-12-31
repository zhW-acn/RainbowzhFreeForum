<%--
  User: acane
  Date: 2023/11/25
  主页
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
    <title>RFF</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <style>
        body {
            background-color: #FFC3A0;
        }

        video {
            height: 100%;
        }

        .announcement {
            position: relative;
        }

        .announcement > div > p {
            font-size: 30px;
            font-family: 幼圆, serif;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .outer-container {
            width: 70%;
            height: 150px; /* 设置外部容器高度为150px */
            background-color: #FFC0CB;
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
            background-color: #FFC0CB;
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
            background-color: #FFC0CB;
            font-weight: bold;
            font-size: 20px; /* 调整标题字体大小 */
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .content {
            background-color: #FFC0CB;
            flex-grow: 1;
            text-align: left;
            font-size: 15px; /* 调整内容字体大小 */
        }

        .thread-content {
            font-size: 15px;
            word-break: break-all
        }

        .info {
            background-color: #FFC0CB;
            flex: 1 1 20%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /*.hide {*/
        /*    -webkit-mask-image: linear-gradient(180deg, #000 60%, transparent);*/
        /*    mask-image: linear-gradient(180deg, #000 60%, transparent);*/
        /*    overflow: hidden;*/
        /*    padding: 0 10px;*/
        /*    max-lines: 2;*/
        /*    max-height: 400px*/
        /*}*/
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

<%--轮播公告，点击显示详情--%>
<div class="layui-carousel layui-layout-center" id="announcement" style="margin:0 auto">
    <div carousel-item="" class="announcement"></div>
</div>

<%--帖子信息流--%>
<div>
    <ul id="PostList"></ul>
</div>


<script>
    // 当前登录的用户id，没有为false
    currentUserId = <%=user==null?false:user.getId()%>;
    // 总页数
    var count = ${count};
    var layer = layui.layer;
    layui.use(['flow', 'carousel'], function () {
        var flow = layui.flow;
        var carousel = layui.carousel;


        flow.load({
            elem: '#PostList', //流加载容器
            done: function (page, next) { //下一页的回调
                $.ajax({
                    url: 'ajax',
                    type: 'GET',
                    data: {
                        page: page
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
                                '<div class="avatar-container user_' + list[i].userId + '">' +
                                '<img src="' + list[i].userAvatar + '" class="avatar layui-circle" alt="用户头像"> ' +
                                '<div class="username">' + list[i].username + '</div> ' +
                                '</div> ' +
                                '<div class="middle-container post_' + list[i].postId + '"> ' +
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
                        // 执行下一页渲染，第二参数为：满足“加载更多”的条件
                        next(lis.join(''), page < count);

                        // 绑定点击事件
                        for (var i = 0; i < list.length; i++) {
                            $('.user_' + list[i].userId).on('click', function () {
                                // 跳转到用户详情页
                                clickUser($(this).attr('class'));
                            });
                            $('.post_' + list[i].postId).on('click', function () {
                                // 跳转到帖子详情页
                                clickPost($(this).attr('class'));
                            });
                        }
                    }
                });
            }
        });
        // 加载轮播公告
        getAnnouncement()

    });


    function clickUser(userId) {
        if (currentUserId === false) {
            isLogin()
        } else {
            // 跳转到目标用户的首页
            location.href = "/user/" + userId.replace("avatar-container user_", "");
        }
    }

    function clickPost(postId) {
        if (currentUserId === false) {
            isLogin()
        } else {
            // 跳转到目标帖子详情
            location.href = "/post/" + postId.replace("middle-container post_", "");
        }
    }

    function isLogin() {
        if (confirm("游客请登录")) {
            location.href = "/login";
        }
    }

    // 加载轮播公告
    function getAnnouncement() {
        $.ajax({
            url: '/getannouncement',
            success: function (res) {
                var response = JSON.parse(res)
                // 公告数组
                var announcements = response.data
                // 遍历公告数组，添加到轮播中
                for (var i = 0; i < announcements.length; i++) {
                    let text = announcements[i].text
                    var announcementDiv = $("<div>").attr("style", "background-color: #fde3f0").click(function () {
                        layer.open({// 添加点击事件
                            type: 1
                            , title: false
                            , offset: 't'
                            , closeBtn: false
                            , area: '300px;'
                            , shade: 0.8
                            , id: 'LAY_layuipro' //设定一个id，防止重复弹出
                            , btn: ['确定']
                            , btnAlign: 'c'
                            , moveType: 1
                            , content:
                                '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">' + text + '</div>'
                        });
                    });
                    var announcementParagraph = $("<p>").text(announcements[i].title);

                    // 将 <p> 元素添加到 <div> 中
                    announcementDiv.append(announcementParagraph);

                    // 将整个 <div> 添加到轮播容器中
                    $(".announcement").append(announcementDiv);
                }
                // 渲染轮播公告
                layui.carousel.render({
                    elem: '#announcement'
                    , interval: 5000
                    , anim: 'fade'
                    , height: '200px'
                    , width: '70%'
                });
            }
        })
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
