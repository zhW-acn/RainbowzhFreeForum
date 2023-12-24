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
    <script src="//unpkg.com/layui@2.7.6/dist/layui.js"></script>
</head>
<body>
<%--违禁词是否启用--%>
<script type="text/html" id="nwordTpl">
    <input type="checkbox" name="nword" value="{{d.flag}}" lay-skin="switch" lay-text="启用|禁用" lay-filter="nword" {{
           d.flag== 1 ?
    'checked' : '' }}>
</script>

<!--单元格的删除-->
<script type="text/html" id="bar">
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">删除</a>
</script>
<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">违禁词设置</li>
        <li>违禁帖</li>
    </ul>
    <div class="layui-tab-content">
        <%--违禁词设置--%>
        <div class="layui-tab-item layui-show">
            <div>
                <div class="layui-inline">
                    <button class="layui-btn" onclick="addIllegal()">新建违禁词</button>
                </div>
            </div>
            <table class="layui-hide" id="IllegalTable" lay-filter="IllegalTable"></table>
        </div>
        <%--违禁帖--%>
        <div class="layui-tab-item">
            <iframe src="/admin/IllegalPost" scrolling="no" style="height: 100%;width: 100%;"></iframe>
        </div>
    </div>
</div>

<script>
    var $ = layui.$;
    var form = layui.form;
    var table = layui.table;
    layui.use(['table', 'util'], function () {
        var table = layui.table;
        //方法级渲染
        var tableAll = table.render({
            elem: '#IllegalTable'
            , url: '/admin/getIllegal/'
            , editTrigger: 'click'// 触发点击事件
            , cols: [[
                {field: "id", title: 'ID', sort: true},
                {field: "nword", title: '违禁词', sort: true},
                {field: "flag", title: '状态', templet: '#nwordTpl', sort: true},
                {field: '', title: '操作', align: 'center', toolbar: '#bar'}
            ]]
            , id: 'IllegalTable'
        });

        //封禁
        form.on('switch(nword)', function (obj) {
            var nwordId = $($(obj.elem).parent().parent().parent().children()[0]).children().text()
            var flag = this.value === '0' ? 1 : 0
            var confirmInfo = this.value !== '1' ? '确定启用封禁词ID为：' : '确定禁用封禁词ID为：';
            layer.confirm(confirmInfo + nwordId + "？", {
                    btn: ['确定', '取消'],
                    closeBtn: 0
                },
                function () {
                    changeIllegalFlag(nwordId, flag)
                }
                , function () {// 取消选中后重新渲染表格
                    obj.elem.checked = !obj.elem.checked;
                    tableAll.reload();
                });
        });


        function changeIllegalFlag(id, flag) {
            $.ajax({
                url: '/admin/changeIllegal'
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



    table.on('tool(IllegalTable)', function (obj) {
        var data = obj.data //获得当前行数据
            , layEvent = obj.event;
        if (layEvent === 'delete') {
            layer.confirm('真的删除ID为' + data.id + '的违禁词吗？', function (index) {
                layer.close(index);
                //向服务端发送删除ajax
                $.ajax({
                    url:"admin/deleteIll"
                    ,type:'post'
                    ,data:{
                        id:data.id
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

    function addIllegal() {
        let index = layer.open({
            type: 1,
            title: '添加违禁词',
            shadeClose: true,
            area: ['30%', '30%'],
            content: $('#addIllegal')
        });
        let isSubmitting = false;
        form.on('submit(submitIll)', function () {
            if (isSubmitting) {
                // 如果正在提交中，不执行后续操作
                return false;
            }

            isSubmitting = true;  // 标记为正在提交
            $.ajax({
                url: '/admin/addIllegal',
                type: 'post',
                data: {
                    nword: $("#nword").val()
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

    function checkIllAvailable() {
        $.ajax({
            url: 'admin/checkIllAvailable',
            type: 'post',
            data: {
                nword: $("#nword").val()
            },
            success: function (res) {
                if(res !== "available"){
                    layer.msg("已存在该违禁词")
                    $("#nword").val("")
                }
            }
        })
    }
</script>

<%--弹窗--%>
<div class="layui-row" id="addIllegal" style="display:none;">
    <form id="layui-form" lay-filter="layui-form" class="layui-form" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">违禁词</label>
            <div class="layui-input-inline">
                <input id="nword" type="text" name="nword" required lay-verify="required" placeholder="违禁词"
                       autocomplete="off" class="layui-input" onblur="checkIllAvailable()">
            </div>
        </div>
        <div class="layui-form-item" align="center">
            <div class="layui-input-blockd">
                <button class="layui-btn" lay-submit lay-filter="submitIll">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
