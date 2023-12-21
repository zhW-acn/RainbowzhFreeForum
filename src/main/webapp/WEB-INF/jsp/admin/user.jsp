<%--
  User: acane
  Date: 2023/11/26
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>管理用户</title>
    <base href="<%=basePath%>">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="//unpkg.com/layui@2.7.6/dist/layui.js"></script>
    <style>
        .layui-table-cell {
            text-align: center;
            height: auto;
            white-space: normal;

        }
    </style>
</head>
<body>
<%--数据表格--%>
<table class="layui-hide" id="userTable" lay-filter="userTable"></table>

<%--角色--%>
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="role" value="{{d.banTime}}" lay-skin="switch" lay-text="管理员|用户" lay-filter="role"
           {{d.banTime== -1 ? 'checked' : '' }}>
</script>
<%--注销--%>
<script type="text/html" id="unableTpl">
    <input type="checkbox" name="unable" value="{{d.banTime}}" lay-skin="switch" lay-text="已注销|未注销"
           lay-filter="unable"
           {{d.banTime== -2 ?
    'checked' : '' }}>
</script>
<%--锁定--%>
<script type="text/html" id="lockTpl">
    <input type="checkbox" name="lock" value="{{d.banTime}}" title="锁定" lay-filter="lock" {{ d.banTime== -3 ?
    'checked' : '' }}>
</script>

<script>
    var $ = layui.$;
    var form = layui.form;
    var table = layui.table;


    // 这两个函数是数据表格模板
    var avatar = function (d) {
        return '<div style="height: 100%;width: 100%;"><img src="' + d.avatar + '"></div>';
    }
    var username = function (d) {
        return '<a href="" onclick="window.top.location.href=\'/user/' + d.id + '\'">' + d.username + '</a>';
    }


    layui.use(['table', 'util'], function () {
        var table = layui.table;
        var util = layui.util;
        //方法级渲染
        var table = table.render({
            elem: '#userTable'
            , url: '/admin/getusers'
            , editTrigger: 'click'// 触发点击事件
            , page: true
            , limit: 5
            , cols: [[
                {field: "id", title: 'ID'}
                , {field: 'username', title: '用户', templet: username}
                , {field: 'avatar', title: '头像', templet: avatar}
                , {field: 'birthday', title: '生日'}
                , {field: 'banTime', title: '角色', templet: '#switchTpl'}
                , {field: 'banTime', title: '锁定', templet: '#lockTpl'}
                , {field: 'banTime', title: '注销', templet: '#unableTpl'}
            ]]
            , id: 'userTable'
        });


        //角色操作
        form.on('switch(role)', function (obj) {
            var id = $($(obj.elem).parent().parent().parent().children()[0]).children().text()
            var roleName = this.value === '0' ? "管理员" : "用户";
            var role = this.value === '0' ? -1 : 0;
            layer.confirm('确定更改权限为：' + roleName + "？", {
                    btn: ['确定', '取消'],
                    closeBtn: 0
                }, function () {
                    changeRole(id, role)
                }
                , function () {// 取消选中后重新渲染表格
                    obj.elem.checked = !obj.elem.checked;
                    table.reload();
                });
        });

        //锁定操作
        form.on('checkbox(lock)', function (obj) {
            var id = $($(obj.elem).parent().parent().parent().children()[0]).children().text()
            var role = this.value === '-3' ? 0 : -3
            var confirmInfo = this.value !== '-3' ? '确定锁定用户ID为：':'确定解锁用户ID为：';
            layer.confirm(confirmInfo + id + "？", {
                    btn: ['确定', '取消'],
                    closeBtn: 0
                },
                function () {
                    changeRole(id, role)
                }
                , function () {// 取消选中后重新渲染表格
                    obj.elem.checked = !obj.elem.checked;
                    table.reload();
                });
        });

        //注销操作
        form.on('switch(unable)', function (obj) {
            var id = $($(obj.elem).parent().parent().parent().children()[0]).children().text()
            var role = this.value === '-2' ? 0 : -2
            var confirmInfo = this.value !== '-2' ? '确定注销用户ID为：':'确定重新注册用户ID为：';
            layer.confirm(confirmInfo + id + "？", {
                    btn: ['确定', '取消'],
                    closeBtn: 0
                },
                function () {
                    changeRole(id, role)
                }
                , function () {// 取消选中后重新渲染表格
                    obj.elem.checked = !obj.elem.checked;
                    table.reload();
                });
        });

        function changeRole(id, role) {
            // 发送请求，更改权限
            $.ajax({
                url: '/admin/role'
                , type: 'post'
                , data: {
                    id: id,
                    role: role
                }
                , success: function (res) {
                    if (res === "success") {
                        layer.msg(res)
                        table.reload();
                    } else {
                        layer.msg("服务器异常")
                    }
                }
            })
        }
    });
</script>
</body>
</html>
