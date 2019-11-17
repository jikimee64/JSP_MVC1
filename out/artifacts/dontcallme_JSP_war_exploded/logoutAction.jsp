<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-11-14
  Time: 오후 7:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캡스톤디자인프로젝트</title>

    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-148884809-2"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'UA-148884809-2');
    </script>

</head>
<body>
<%
    session.invalidate();
%>
<script>
    location.href = 'main.jsp';
</script>
</body>
</html>