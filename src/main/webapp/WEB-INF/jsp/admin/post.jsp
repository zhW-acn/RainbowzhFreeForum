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
</head>
<body>
这里是管理贴子的页面
</body>
</html>
