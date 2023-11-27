<%--
  User: acane
  Date: 2023/11/25
  主页
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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <style>
        body {
            background-color: rebeccapurple;
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
            background-color: #5256FF;
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
            margin-top: 5px; /* 在用户名和头像之间添加一些间距 */
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

        .info {
            background-color: #B29CFF;
            flex: 1 1 20%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
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
                    <source src="img/logo.webm" type="video/webm">
                    抱歉，您的浏览器不支持内嵌视频。
                </video>
            </a>
        </li>
        <%--搜索--%>
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
            <a href="">消息<span class="layui-bg-red">114514</span></a>
        </li>
        <%--头像--%>
        <li class="layui-nav-item" lay-unselect="">
            <%--头像--%>
            <a href="javascript:;"><img class="layui-nav-img" src="img/default-avatar.png"></a>
            <dl class="layui-nav-child">
                <dd style="text-align: center;"><a href="">退出</a></dd>
            </dl>
        </li>
    </ul>
</div>

<%--轮播公告，点击显示详情--%>
<div class="layui-carousel layui-layout-center" id="announcement" style="margin:0 auto">
    <div carousel-item="" class="announcement">
        <%--循环--%>
        <div style="background-color: hotpink"><p>美国卡内基梅隆大学开设《原神》研究课程：考试要在 2 分钟内击败 BOSS</p>
        </div>
        <div style="background-color: hotpink"><p>美国核反应堆实验室遭到黑客攻击，被要求制造“猫娘”</p></div>
    </div>
</div>

<%--帖子信息流--%>
<div>
    <ul class="flow-default" id="PostList"></ul>
</div>


<script>
    layui.use('flow', function () {
        var flow = layui.flow;
        var carousel = layui.carousel;

        /*帖子信息流*/
        // flow.load({
        //     elem: '#PostList' //流加载容器
        //     , done: function (page, next) { //下一页的回调
        //         // 模拟
        //         setTimeout(function () {
        //                 // 循环加载帖子
        //                 for (var i = 0; i < 3; i++) {
        //                     var lis = [];
        //                     lis.push(
        //                         '<li style="text-align: center ;margin-top: 5px">' +
        //                         /*帖子*/
        //                         '<div class="outer-container">' +
        //                         '<div class="container">' +
        //                         '<div class="avatar-container">' +
        //                         '<img src="img/default-avatar.png" class="avatar" alt="用户头像"> ' +
        //                         '<div class="username">username</div> ' +
        //                         '</div> ' +
        //                         '<div class="middle-container"> ' +
        //                         '<div class="title">标题 : ' + ((page - 1) * 5 + i + 1) + '</div>' +
        //                         ' <div class="content"> ' +
        //                         '<p>这是正文内容</p> ' +
        //                         '</div> ' +
        //                         '</div> ' +
        //                         '<div class="info">' +
        //                         '<p>[回帖数] 人回帖 [收藏数] 人收藏</p>' +
        //                         '<p>发帖时间</p>' +
        //                         '</div>' +
        //                         '</div>' +
        //                         '</div>'
        //                         + '</li>'
        //                     )
        //                 }
        //
        //                 //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
        //                 //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
        //                 next(lis.join(''), page < 4); //假设总页数为 4
        //             }
        //             , 500);
        //     }
        // });
        flow.load({
            elem: '#PostList', //流加载容器
            done: function (page, next) { //下一页的回调
                $.ajax({
                    url: 'ajax',
                    type: 'GET',
                    data: {
                        page: page,
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
                                '<div class="avatar-container">' +
                                '<img src="' + list[i].avatar + '" class="avatar" alt="用户头像"> ' +
                                '<div class="username">' + list[i].username + '</div> ' +
                                '</div> ' +
                                '<div class="middle-container"> ' +
                                '<div class="title">标题 : ' + list[i].title + '</div>' +
                                ' <div class="content"> ' +
                                '<p>' + list[i].content + '</p> ' +
                                '</div> ' +
                                '</div> ' +
                                '<div class="info">' +
                                '<p>[回帖数] ' + list[i].replyCount + ' 人回帖 [收藏数] ' + data[i].collectCount + ' 人收藏</p>' +
                                '<p>发帖时间: ' + list[i].postTime + '</p>' +
                                '</div>' +
                                '</div>' +
                                '</div>'
                                + '</li>'
                            );
                        }
                        // 执行下一页渲染，第二参数为：满足“加载更多”的条件
                        next(lis.join(''), page < 4);
                    }
                });
            }
        });
        /*轮播公告*/
        carousel.render({
            elem: '#announcement'
            , interval: 5000
            , anim: 'fade'
            , height: '200px'
            , width: '70%'
        });
    });


</script>
</body>
</html>
