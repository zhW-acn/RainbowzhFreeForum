<%--
  User: acane
  Date: 2023/11/29
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>错误页面</title>
    <base href="<%=basePath%>">
</head>
<body>
error
</body>
</html>
