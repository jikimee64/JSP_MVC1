<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-11-11
  Time: 오후 2:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.security.GeneralSecurityException" %>
<%
    request.setCharacterEncoding("UTF-8");
    String code = request.getParameter("code");
    UserDAO userDAO = new UserDAO();
    String userID = null;

    if(session.getAttribute("userID") != null) {
        userID = (String)session.getAttribute("userID");
    }

    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'login.jsp");
        script.println("</script>");
        script.close();
        return;
    }

    String userEmail = null;
        userEmail = userDAO.getUserEmail(userID);

    boolean rightCode = new SHA256().getSHA256(userEmail).equals(code);

    if(rightCode) {
            userDAO.setUserEmailChecked(userID);

        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('인증에 성공했습니다.');");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 코드입니다.');");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

%>