<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-12-31
  Time: 오후 12:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="comm.CommDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>캡스톤디자인프로젝트</title>
</head>
<body>
<%
//    request.setCharacterEncoding("utf-8");

    //==========댓글작성동작==========
    String userID = null;
    //게시판관련 오류 처리
    int bbsID = 0;
    String commContent = null;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if(request.getParameter("commContent") != null) {
        commContent= request.getParameter("commContent");
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'view.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    //세션관련 오류 처리
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    } else {
        //댓글관련 오류 처리
        if (commContent == null || commContent.equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            CommDAO commDAO = new CommDAO();
            int result = commDAO.write(userID, commContent != null ? commContent : null, bbsID);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else {
                out.print(commContent);
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'view.jsp?bbsID="+bbsID+"'");
                script.println("</script>");
            }
        }
    }
%>
</body>
</html>
