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
    <title>发帖页面</title>
    <base href="<%=basePath%>">
    <script src="https://www.layuicdn.com/auto/layui.js" v="2.8.0"></script>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui-v2.8.0/css/layui.css"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        #postForm {
            max-width: 600px;
            margin: 20px auto;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
        }

        textarea {
            resize: vertical;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>

</head>
<body>

<div id="postForm">
    <h2>发表新帖</h2>
    <form id="form">
        <label for="title">标题:</label>
        <input type="text" id="title" name="title" required>

        <label for="content">内容:</label>
        <textarea id="content" name="content" rows="6" required></textarea>

        <button type="button" onclick="submitPost()">发布帖子</button>
    </form>
</div>

<script>
    function submitPost() {
        $.ajax({
            url: 'user/${user.id}/addPost',
            type: 'post',
            data:{
                title: $("#title").val(),
                content: $("#content").val(),
            },
            success: function (res) {
                var response = JSON.parse(res)
                if(response.data === "success"){
                    alert("发表成功，即将跳转到帖子详情")
                    location.href = '/post/'+response.code;
                }else{
                    alert("服务器异常")
                }
            }
        })
    }
</script>


</body>
</html>
