<%--
  User: acane
  Date: 2023/12/24
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
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <script src="//unpkg.com/layui@2.7.6/dist/layui.js"></script>
</head>
<body>
<table class="layui-hide" id="IllegalPostTable" lay-filter="IllegalPostTable"></table>

<%--封禁--%>
<script type="text/html" id="banTpl">
    <input type="checkbox" name="ban" value="{{d.flag}}" lay-skin="switch" lay-text="封禁|可见" lay-filter="ban" {{
           d.flag != 1 ?
    'checked' : '' }}>
</script>

<script>
    var $ = layui.$;
    var form = layui.form;
    var table = layui.table;

    var post = function (d) {
        return '<a href="" onclick="window.top.location.href=\'/post/' + d.postId + '\'">' + d.text + '</a>';
    }

    layui.use(['table', 'util'], function () {
        var table = layui.table;
        var util = layui.util;
        //方法级渲染
        var tableAll = table.render({
            elem: '#IllegalPostTable'
            , url: '/admin/getIllegalPostTable'
            , editTrigger: 'click'
            , cols: [[
                {field: "postId", title: 'ID', sort: true},
                {field: "username", title: '发帖用户'},
                {field: "title", title: '标题', templet: post},
                {field: "flag", title: '封禁', templet: '#banTpl'}
            ]]
            , id: 'IllegalPostTable'
            , height: 650
        });

        //封禁
        form.on('switch(ban)', function (obj) {
            var id = $($(obj.elem).parent().parent().parent().children()[0]).children().text()
            var flag = this.value === '0' ? 1 : 0
            var confirmInfo = this.value !== '1' ? '确定解封帖子ID为：' : '确定锁定帖子ID为：';
            layer.confirm(confirmInfo + id + "？", {
                    btn: ['确定', '取消'],
                    closeBtn: 0
                },
                function () {
                    changePostFlag(id, flag)
                }
                , function () {// 取消选中后重新渲染表格
                    obj.elem.checked = !obj.elem.checked;
                    tableAll.reload();
                });

        });

        // 发送请求，更改权限
        function changePostFlag(id, flag) {
            $.ajax({
                url: '/admin/changepost'
                , type: 'post'
                , data: {
                    id: id,
                    flag: flag
                }
                , success: function (res) {
                    if (res === "success") {
                        layer.msg(res)
                        tableAll.reload();
                    } else {
                        layer.msg("服务器异常")
                    }
                }
            })
        }
    })
</script>
</body>
</html>
