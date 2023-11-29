<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  User: acane
  Date: 2023/11/25
  登录和注册页
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
    <style>
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden
        }

        body {
            background: #1E9FFF;
        }

        body:after {
            content: '';
            background-repeat: no-repeat;
            background-size: cover;
            -webkit-filter: blur(3px);
            -moz-filter: blur(3px);
            -o-filter: blur(3px);
            -ms-filter: blur(3px);
            filter: blur(3px);
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: -1;
        }

        .layui-container {
            width: 100%;
            height: 100%;
            overflow: hidden
        }

        .admin-login-background {
            width: 360px;
            height: 300px;
            position: absolute;
            left: 50%;
            top: 40%;
            margin-left: -180px;
            margin-top: -100px;
        }

        .logo-title {
            text-align: center;
            letter-spacing: 2px;
            padding: 14px 0;
        }

        .logo-title h1 {
            color: #1E9FFF;
            font-size: 25px;
            font-weight: bold;
        }

        .login-form {
            background-color: #fff;
            border: 1px solid #fff;
            border-radius: 3px;
            padding: 14px 20px;
            box-shadow: 0 0 8px #eeeeee;
        }

        .login-form .layui-form-item {
            position: relative;
        }

        .login-form .layui-form-item label {
            position: absolute;
            left: 1px;
            top: 1px;
            width: 38px;
            line-height: 36px;
            text-align: center;
            color: #d2d2d2;
        }

        .login-form .layui-form-item input {
            padding-left: 36px;
        }
    </style>
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <%--表单--%>

            <form class="layui-form" action="" enctype="multipart/form-data">
                <%--表头--%>
                <div class="layui-form-item logo-title">
                    <h1>RFF${name}</h1>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username"></label>
                    <input type="text" name="username" lay-verify placeholder="用户名" autocomplete="off"
                           class="layui-input">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password"></label>
                    <input type="password" name="password" lay-verify placeholder="密码" autocomplete="off"
                           class="layui-input">
                </div>

                <%if (request.getAttribute("action") == "register") {%>
                <%--这里存放上传头像和birthday的div--%>
                <div class="layui-form-item">
                    <input type="file" class="layui-btn" id="avatar" name="avatarFile">
                        <i class="layui-icon">&#xe67c;</i>上传头像
                </div>
                <div class="layui-form-item">
                    生日<input type="date" name="birthday">
                </div>
                <%}%>

                <%--滑块模拟验证--%>
                <div class="layui-form-item">
                    <div id="slider"></div>
                </div>

                <div class="layui-form-item" style="margin-top: 10px;">
                    <div style="float: left;">
                        <%--这里切换登录和注册--%>
                        <button type="button" class="layui-btn layui-btn-primary"
                                onclick="location.href='${leftLocation}'">${leftButton}</button>
                    </div>
                    <div style="float: right;">
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-fluid" lay-submit
                                lay-filter="login">${rightButton}
                        </button>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer;

        /*滑块使用*/
        layui.config({}).use(['sliderVerify', 'jquery', 'form'], function () {
            var sliderVerify = layui.sliderVerify,
                form = layui.form;
            var slider = sliderVerify.render({
                elem: '#slider',
                onOk: function () {//当验证通过回调
                    layer.msg("人机验证通过");
                }
            })
            //监听提交
            form.on('submit(login)', function (data) {
                data = data.field;
                if (data.username === '') {
                    layer.msg('用户名不能为空');
                    return false;
                }
                if (data.password === '') {
                    layer.msg('密码不能为空');
                    return false;
                }
                if ("${action}" === "register") {
                    if (data.birthday === '') {
                        layer.msg('生日不能为空');
                        return false;
                    }
                }
                if (slider.isOk()) {//用于表单验证是否已经滑动成功
                    var formData = new FormData();
                    formData.append('username', data.username);
                    formData.append('password', data.password);

                    // 如果表单是注册，就加上下面的formData
                    if ("${action}" === "register") {
                        formData.append('birthday', data.birthday);
                        // 获取文件上传的input
                        var fileInput = document.getElementById("avatar");
                        // 添加文件到 FormData
                        formData.append('avatarFile', fileInput.files[0]);
                    }

                    $.ajax({
                        url: "${action}",
                        // 使用formData提交
                        data: formData,
                        type: "post",
                        processData: false,
                        contentType: false, // 告诉jQuery不要去设置Content-Type请求头
                        dataType: 'text',
                        async: false,
                        success: function (response) {
                            response = JSON.parse(response)
                            console.log(response)
                            if (response.data === "success") {
                                //携带session信息跳转到首页
                                layer.msg('${name}成功，一秒后跳转首页');
                                if ("${action}" === "register") {
                                    // 跳转
                                    $.ajax({
                                        url: "login",
                                        data: data,
                                        type: "post",
                                        success: function (response) {
                                            // 等待三秒再跳转
                                            setTimeout(
                                                function () {
                                                    window.location.href = "<%=basePath%>";
                                                }, 1000);
                                        }
                                    })
                                }
                                setTimeout(
                                    function () {
                                        window.location.href = "<%=basePath%>";
                                    }, 1000);
                            }
                            if (response.data === "false") {
                                // 清空表内容，提示登陆&注册失败
                                $('input').val('');
                                slider.reset();
                                alert("${action}失败，请检查用户名和密码。");
                            }
                            if (response.data === "exist") {
                                $('input').val('');
                                slider.reset();
                                alert("${name}失败，存在重名。");
                            }
                        },
                        error: function () {
                            alert("服务器异常");
                        }
                    });
                    return false;
                } else {
                    layer.msg("请先通过滑块验证");
                }
                return false;
            });
        })
    })
</script>
</body>
</html>
