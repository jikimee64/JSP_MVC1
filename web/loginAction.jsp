<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-11-13
  Time: 오후 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.security.GeneralSecurityException" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userIP1" />
<jsp:setProperty name="user" property="userIP2" />
<jsp:setProperty name="user" property="userIP3" />
<jsp:setProperty name="user" property="userIP4" />


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캡스톤디자인프로젝트</title>

</head>
<body>
<%
    String userID = null;

    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if(userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }

    UserDAO userDAO = new UserDAO();
    int result = 0;
    try {
        result = userDAO.login(user.getUserID(), user.getUserPassword());
    } catch (GeneralSecurityException e) {
        e.printStackTrace();
    }
    if (result == 1) {
        session.setAttribute("userID",user.getUserID());
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    else if (result == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디 혹은 IP주소가 존재하지 않습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>