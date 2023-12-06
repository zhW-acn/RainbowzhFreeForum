<%@ page import="com.acn.bean.User" %>
<%--
  User: acane
  Date: 2023/12/6
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <style>
        video {
            height: 100%;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        img {
            display: block;
            margin: 0 auto;
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input.submit {
            text-align: center;
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        input.submit:hover {
            background-color: #45a049;
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
            <a href="/">
                <video autoplay loop muted playsinline>
                    <source src="/img/logo.webm" type="video/webm">
                    抱歉，您的浏览器不支持内嵌视频。
                </video>
            </a>
        </li>
        <%--搜索，未实现--%>
        <li class="layui-nav-item">
            <a href="/search">去搜索</a>
        </li>
    </ul>
    <%--居右--%>
    <ul class="layui-nav layui-layout-right layui-bg-green" style="white-space: nowrap;!important;">
        <%--去发帖，未实现--%>
        <li class="layui-nav-item">
            <a href="/fatie">去发帖</a>
        </li>
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
<body>
<h2>修改你的信息</h2>


<form id="form" action="" method="post">
    <label for="avatar">Avatar</label>
    <img src="${user.avatar}" alt="User Avatar" id="avatar">

    <label for="username">Username</label>
    <input type="text" id="username" name="username" value="${user.username}" readonly>

    <label for="oldPassword">Old Password<span class="passwordMatchIcon" style="display: none;">✅</span><span
            class="passwordMismatchIcon" style="display: none; color: red;">❌</span></label>
    <input type="password" id="oldPassword" name="oldPassword" placeholder="你的旧密码">

    <label for="newPassword">New Password<span class="passwordMatchIcon" style="display: none;">✅</span><span
            class="passwordMismatchIcon" style="display: none; color: red;">❌</span></label>
    <input type="password" id="newPassword" name="newPassword" placeholder="你的新密码" oninput="checkPasswordEqual()">

    <label for="birthday">Birthday</label>
    <input type="date" id="birthday" name="birthday" value="${user.birthday}">

    <input class="submit" onclick="update()" value="Update Settings"/>
</form>


<script>
    function checkPasswordEqual() {// 密码检测
        var newPassword = $('#newPassword').val();
        var oldPassword = $('#oldPassword').val();

        if (newPassword === oldPassword) {
            // 显示红色的×
            $('.passwordMatchIcon').hide();
            $('.passwordMismatchIcon').show();
            return false;
        } else {
            // 显示绿色的√
            $('.passwordMismatchIcon').hide();
            $('.passwordMatchIcon').show();
            return true;
        }
    }



    function update() {
        if (checkPasswordEqual()) {
            $.ajax({
                url: '/setting',
                type: 'post',
                data: {
                    data: $('#form').serialize()
                },
                success: function (res) {
                    if (res === 'falsePassword') {
                        alert('密码有误，请重新输入');
                        $('#oldPassword').val('')
                        return false;
                    }
                    if (res === 'success') {
                        alert('成功修改，将跳转到你的主页')
                        location.href = 'user/${user.id}'
                    }
                }
            })
            return true;
        }else {
            alert("密码重复捏")
            $('#newPassword').val('')
            return false;
        }
    }

</script>
</body>
</html>
