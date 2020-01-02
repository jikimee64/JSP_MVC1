<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.security.GeneralSecurityException" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserDTO" scope="page"/>
<jsp:setProperty name="user" property="userID"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캡스톤디자인프로젝트</title>
</head>
<body>

<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    UserDAO userDAO = new UserDAO();

    int result = 0;
    try {
        result = userDAO.remove(userID);
    } catch (GeneralSecurityException e) {
        e.printStackTrace();
    }

    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원탈퇴에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    session.invalidate();
%>
</body>
</html>