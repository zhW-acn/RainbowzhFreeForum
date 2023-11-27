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
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" action="${action}" method="post">
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
                <div class="layui-form-item">
                    <label class="layui-form-label"></label>
                    <div class="layui-input-block">
                        <div id="slider"></div>
                    </div>
                </div>
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div style="float: left;">
                        <%--这里跳转--%>
                        <button type="button" class="layui-btn layui-btn-primary"
                                onclick="location.href='${leftLocation}'">${leftButton}</button>
                    </div>
                    <div style="float: right;">
                        <button class="layui-btn layui-btn-normal layui-btn-fluid" lay-submit
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

        // 登录过期的时候，跳出iframe框架
        if (top.location != self.location) top.location = self.location;


        // 进行登录操作
        form.on('submit(login)', function (data) {
            data = data.field;
            if (data.username == '') {
                layer.msg('用户名不能为空');
                return false;
            }
            if (data.password == '') {
                layer.msg('密码不能为空');
                return false;
            }
        });
    });


    /*滑块使用*/
    layui.config({
    }).use(['sliderVerify', 'jquery', 'form'], function() {
        var sliderVerify = layui.sliderVerify,
            form = layui.form;
        var slider = sliderVerify.render({
            elem: '#slider',
            onOk: function(){//当验证通过回调
                layer.msg("滑块验证通过");
            }
        })
        //监听提交
        form.on('submit(formDemo)', function(data) {
            if(slider.isOk()){//用于表单验证是否已经滑动成功
                layer.msg(JSON.stringify(data.field));
            }else{
                layer.msg("请先通过滑块验证");
            }
            return false;
        });

    })
</script>
</body>
</html>
