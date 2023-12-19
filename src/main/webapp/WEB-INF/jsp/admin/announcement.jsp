<%--
  User: acane
  Date: 2023/12/18
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
</head>
<body>

<div class="demoTable">
    搜索ID：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
    <div class="layui-inline">
        <button class="layui-btn" onclick="addAnnouncement()">新建公告</button>
    </div>
</div>

<table class="layui-hide" id="annTable" lay-filter="annTable"></table>

<!--单元格的删除-->
<script type="text/html" id="bar">
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">删除</a>
</script>

<script>
    var $ = layui.$;
    var form = layui.form;
    layui.use(['table', 'util'], function () {
        var table = layui.table;
        var util = layui.util;
        //方法级渲染
        table.render({
            elem: '#annTable'
            , url: '/getannouncement'
            , editTrigger: 'click'// 触发点击事件
            , cols: [[
                {field: "postId", title: 'ID'}
                ,{field: 'username', title: '发表人'}
                , {field: 'title', title: '标题', edit: 'text'}
                , {field: 'text', title: '正文', edit: 'text'}
                , {field: 'createtime', title: '创建时间', sort: true}
                , {field: '', title: '操作', align: 'center', toolbar: '#bar'}
            ]]
            , id: 'announcementTable'
        });

        var $ = layui.$, active = {
            reload: function () {
                var demoReload = $('#demoReload');

                //执行重载
                table.reload('announcementTable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                        key: {
                            id: demoReload.val()
                        }
                    }
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        // 单元格修改公告
        table.on('edit(annTable)', function (obj) {
            var value = obj.value //得到修改后的值
                ,data = obj.data // 当前行的所有数据
                , field = obj.field; //得到字段
            $.ajax({
                url:"admin/updAnnAjax"
                ,type: 'post'
                ,data :{
                    field:field,
                    value: value,
                    postId: data.postId
                },
                success: function (res) {
                      layer.msg(res)
                }
            })
        });

        table.on('tool(annTable)', function (obj) {
            var data = obj.data //获得当前行数据
                , layEvent = obj.event;
            if (layEvent === 'delete') {
                layer.confirm('真的删除ID为' + data.postId + '的公告吗？', function (index) {
                    layer.close(index);
                    //向服务端发送删除ajax
                    $.ajax({
                        url:"admin/deleteAnno"
                        ,type:'post'
                        ,data:{
                            id:data.postId
                        },
                        success: function (res){
                            layer.msg(res)
                            setTimeout(function () {
                                location.reload();
                            }, 2000);
                        }
                    })
                })
            }
        });
    });

    /*添加公告的ajax*/
    function addAnnouncement() {
        let index = layer.open({
            type: 1,
            title: '添加公告',
            shadeClose: true,
            area: ['70%', '70%'],
            content: $('#addAnn')
        });
        form.on('submit(submit)', function () {
            $.ajax({
                url: '/admin/addAnnAjax',
                type: 'post',
                data: {
                    title: $("#title").val(),
                    text: $("#text").val()
                },
                success: function (res) {
                    layer.msg(res)
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                }
            })
            return false;
        })
    }
</script>
<%--弹窗，用于添加公告--%>
<div class="layui-row" id="addAnn" style="display:none;">
    <form id="layui-form" lay-filter="layui-form" class="layui-form" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-inline">
                <input id="title" type="text" name="title" required lay-verify="required" placeholder="标题"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">正文</label>
            <div class="layui-input-inline">
            <textarea id="text" style="width: 500px;height: 50%;" name="text" required lay-verify="required"
                      placeholder="正文"
                      autocomplete="off" class="layui-input"></textarea>
            </div>
        </div>

        <div class="layui-form-item" align="center">
            <div class="layui-input-blockd">
                <button class="layui-btn" lay-submit lay-filter="submit">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
