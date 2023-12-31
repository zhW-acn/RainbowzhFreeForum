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
    <title>设置</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <style>
        video {
            height: 100%;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #FFC3A0;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #A7D8DE;
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

        input.delete {
            text-align: center;
            background-color: #fc0000;
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
        <ul class="layui-nav" style="background-color: #cabbe9">
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
            <a href="/user/${user.id}/post">发帖</a>
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
<form id="form" action="" enctype="multipart/form-data">
    <label>头像</label>
    <img src="${user.avatar}" alt="User Avatar" id="userAvatar">
    <input type="file" id="avatar" value="更新头像" style="display: none">

    <label for="username">用户名</label>
    <input type="text" id="username" name="username" value="${user.username}" autocomplete="false">

    <label for="oldPassword">密码<span class="passwordMatchIcon" style="display: none;">✅</span><span
            class="passwordMismatchIcon" style="display: none; color: red;">❌</span></label>
    <input type="password" lay-verify="required" id="oldPassword" name="oldPassword" placeholder="你的旧密码">

    <label for="newPassword">新密码 【为空则不修改密码】<span class="passwordMatchIcon"
                                                            style="display: none;">✅</span><span
            class="passwordMismatchIcon" style="display: none; color: red;">❌</span></label>
    <input type="password" id="newPassword" name="newPassword" placeholder="你的新密码" oninput="checkPasswordEqual()">

    <label for="birthday">生日</label>
    <input type="date" id="birthday" name="birthday" value="${user.birthday}">

    <input class="submit" onclick="update()" value="确定修改" readonly/>

    <input class="delete" onclick="deleteUser()" value="注销用户" readonly/>
</form>


<script>
    currentUserId = <%=user==null?false:user.getId()%>;
    // 封装表单数据
    function getFormData() {
        var formData = new FormData();
        if ($('#avatar')[0].files[0] !== undefined) {// 用户更新了头像
            formData.append('avatar', $('#avatar')[0].files[0]);
        }
        formData.append('username', $('#username').val());
        formData.append('oldPassword', $('#oldPassword').val());
        formData.append('newPassword', $('#newPassword').val());
        formData.append('birthday', $('#birthday').val());
        return formData;
    }

    // 图片点击事件
    $('#userAvatar').on('click', function () {
        // 触发文件选择框点击事件
        $('#avatar').click();
    });

    // 文件选择框改变事件
    $('#avatar').on('change', function (event) {
        // 获取选中的文件
        const selectedFile = event.target.files[0];

        // 如果有文件
        if (selectedFile) {
            // 替换图片
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#userAvatar').attr('src', e.target.result);
            };
            reader.readAsDataURL(selectedFile);
        }
    });


    // 密码检测
    function checkPasswordEqual() {
        var newPassword = $('#newPassword').val();
        var oldPassword = $('#oldPassword').val();

        if (newPassword === '') {// 不需要修改密码
            return true;
        }

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


    // 表单提交
    function update() {
        var formData = getFormData();
        if (checkPasswordEqual()) {
            $.ajax({
                url: '/setting',
                type: 'post',
                data: formData,
                processData: false,
                contentType: false,
                success: function (res) {
                    if (res === 'falsePassword') {
                        alert('密码有误，请重新输入');
                        $('#oldPassword').val('')
                        return false;
                    }
                    if (res === 'success') {
                        alert('成功修改，将跳转到你的主页')
                        location.href = 'user/${user.id}'
                    } else {
                        alert("服务器异常")
                    }
                }
            })
            return true;
        } else {
            alert("密码重复捏")
            $('#newPassword').val('')
            return false;
        }
    }

    function deleteUser() {
        $.ajax({
            url: '/setting/${user.id}',
            type: 'post',
            success: function (res) {
                if (res === 'success') {
                    alert('注销成功，即将跳转首页');
                    location.href = '/';
                } else {
                    alert('服务器异常');
                }
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
