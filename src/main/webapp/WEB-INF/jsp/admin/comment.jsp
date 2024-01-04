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
<table class="layui-hide" id="commentTable" lay-filter="commentTable"></table>
<%--封禁--%>
<script type="text/html" id="banTpl">
    <input type="checkbox" name="ban" value="{{d.flag}}" lay-skin="switch" lay-text="封禁|可见" lay-filter="ban" {{
           d.flag== 0 ?
    'checked' : '' }}>
</script>
<script>
    var $ = layui.$;
    var form = layui.form;
    var table = layui.table;
    var username = function (d) {
        return '<a href="" onclick="window.top.location.href=\'/user/' + d.id + '\'">' + d.username + '</a>';
    }
    layui.use(['table', 'util'], function () {
        var table = layui.table;
        var util = layui.util;
        //方法级渲染
        var tableAll = table.render({
            elem: '#commentTable'
            , url: '/admin/getcomment/${id}'
            , editTrigger: 'click'// 触发点击事件
            , cols: [[
                {field: "id", title: 'ID', sort: true},
                {field: "username", title: '回帖用户', templet: username},
                {field: "commentText", title: '评论'},
                {field: "createtime", title: '发帖时间', sort: true},
                {field: "flag", title: '封禁', templet: '#banTpl', sort: true},
            ]]
            , id: 'commentTable'
        });

        //封禁
        form.on('switch(ban)', function (obj) {
            var commentId = $($(obj.elem).parent().parent().parent().children()[0]).children().text()
            var flag = this.value === '0' ? 1 : 0
            var confirmInfo = this.value !== '1' ? '确定解封评论ID为：' : '确定锁定评论ID为：';
            layer.confirm(confirmInfo + commentId + "？", {
                    btn: ['确定', '取消'],
                    closeBtn: 0
                },
                function () {
                    changeCommentFlag(commentId, flag)
                }
                , function () {// 取消选中后重新渲染表格
                    obj.elem.checked = !obj.elem.checked;
                    tableAll.reload();
                });
        });
    })

    function changeCommentFlag(commentId, flag) {
        $.ajax({
            url: '/admin/changecomment'
            , type: 'post'
            , data: {
                postId: ${id},
                commentId: commentId,
                flag: flag
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
</script>
</body>
</html>
