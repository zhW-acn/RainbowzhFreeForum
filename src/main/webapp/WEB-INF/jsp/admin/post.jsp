<%--
  User: acane
  Date: 2023/12/20
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>管理帖子</title>
    <base href="<%=basePath%>">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <script src="//unpkg.com/layui@2.7.6/dist/layui.js"></script>
</head>
<body>
<%--搜索栏--%>
<form class="layui-form" style="width: 500px">
    <div class="layui-input-wrap">
        <div class="layui-form-item">
            <div class="layui-input-inline" style="width: 70%;">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-star-fill"></i>
                </div>
                <input id="search" type="text" name="title" value="" placeholder="帖子" class="layui-input"
                       lay-affix="clear"
                       autocomplete="off">
            </div>
            <div class="layui-input-inline" style="width: 15%;">
                <button id="btn" class="layui-btn" lay-submit lay-filter="search-post">搜索</button>
            </div>
        </div>
    </div>
</form>
<table class="layui-hide" id="postTable" lay-filter="postTable"></table>
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

    // 数据表格模板
    var username = function (d) {
        return '<a href="" onclick="window.top.location.href=\'/user/' + d.userId + '\'">' + d.username + '</a>';
    }
    var post = function (d) {
        return '<a href="" onclick="window.top.location.href=\'/post/' + d.postId + '\'">' + d.text + '</a>';
    }
    var replyCount = function (d) {
        var param = String("'"+d.title+","+d.postId+"'")
        return '<a href="javascript:;" onclick="openComment('+ param +')">' + d.replyCount + '</a>';
    }

    layui.use(['table', 'util'], function () {
        var table = layui.table;
        var util = layui.util;
        //方法级渲染
        var tableAll = table.render({
            elem: '#postTable'
            , url: '/admin/getposts'
            , editTrigger: 'click'// 触发点击事件
            , page: true
            , cols: [[
                {field: "postId", title: 'ID', sort: true},
                {field: "username", title: '发帖用户', templet: username},
                {field: "title", title: '标题', templet: post},
                {field: "text", title: '正文'},
                {field: "createtime", title: '发帖时间', sort: true},
                {field: "replyCount", title: '回帖数', sort: true, templet: replyCount},
                {field: "flag", title: '封禁', templet: '#banTpl', sort: true},
            ]]
            , id: 'postTable'
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



    // 搜索用户
    $("#btn").on('click', function () {
        // 执行搜索重载
        $.ajax({
            url: "/admin/getposts"
            , type: "get"
            , data: {
                page: 1,
                limit: 10,
                search: $("#search").val()
            },
            success: function (res) {
                table.render({
                    elem: '#postTable'
                    , data: JSON.parse(res).data
                    , editTrigger: 'click'// 触发点击事件
                    , page: true
                    , cols: [[
                        {field: "postId", title: 'ID', sort: true},
                        {field: "username", title: '发帖用户', templet: username},
                        {field: "title", title: '标题'},
                        {field: "text", title: '正文'},
                        {field: "createtime", title: '发帖时间', sort: true},
                        {field: "replyCount", title: '回帖数', sort: true},
                        {field: "flag", title: '封禁', templet: '#banTpl', sort: true},
                    ]]
                    , id: 'postTable'
                    , height: 650
                });
            }
        })
        return false; // 阻止form跳转
    });

    function openComment(param) {
        var parts = param.split(',');// 分割参数
        var title = parts[0];
        var id = parseInt(parts[1]);
        var index = layer.open({
            type: 2,
            content: '/admin/comment/'+id,
            area: ['320px', '195px'],
            title: title,
            maxmin: true
        });
        layer.full(index);
    }


</script>

</body>
</html>
