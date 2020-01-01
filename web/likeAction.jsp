<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2020-01-01
  Time: 오후 1:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO" %>
<%!
    public static String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-FORWARDED-FRO");
        if( ip == null || ip.length() == 0) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if( ip == null || ip.length() == 0) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if( ip == null || ip.length() == 0) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
%>
<%

    request.setCharacterEncoding("UTF-8");

    UserDAO userDAO = new UserDAO();
    String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = userLogin.jsp");
        script.println("</script>");
        script.close();
        return;
    }

    String bbsID = null;
    if (request.getParameter("bbsID") != null) {
        bbsID = (String) request.getParameter("bbsID");
    }
    BbsDAO bbsDAO = new BbsDAO();
    LikeyDAO likeyDAO = new LikeyDAO();
    int result = likeyDAO.like(userID, bbsID, getClientIP(request));
    if (result == 1) {
        result = bbsDAO.like(bbsID);
        if (result == 1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('추천이 완료되었습니다.');");
            script.println("history.back()");
//            script.println("location.href = 'index.jsp'");
            script.println("</script>");
            script.close();
            return;
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 추천을 누른 글입니다..');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
%>