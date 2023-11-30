<%--
  User: acane
  Date: 2023/12/1
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户主页</title>
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
</head>
<body>

<div class="layui-container">
    <div class="layui-row">
        <!-- 左侧区域 -->
        <div class="layui-col-md4">
            <!-- 用户大头像 -->
            <div class="user-avatar">
                <img src="img/default-avatar.png" class="layui-circle" style="width: 100px; height: 100px;" alt="用户头像">
                <p>用户名</p>
            </div>
            <!-- 用户留言记录 -->
            <div class="user-comments">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>留言记录</legend>
                    <!-- 留言内容 -->
                </fieldset>
            </div>
        </div>

        <!-- 右侧区域 -->
        <div class="layui-col-md8">
            <fieldset class="layui-elem-field layui-field-title">
                <legend>创建的帖子</legend>
                <!-- 帖子列表 -->
            </fieldset>
        </div>
    </div>
</div>

</body>
</html>