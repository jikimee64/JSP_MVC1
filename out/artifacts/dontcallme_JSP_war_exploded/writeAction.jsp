<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-12-26
  Time: 오후 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%--<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />--%>
<%--<jsp:setProperty name="bbs" property="bbsTitle" />--%>
<%--<jsp:setProperty name="bbs" property="bbsContent" />--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캡스톤디자인프로젝트</title>
</head>
<body>
<%

    String directory = application.getRealPath("/upload");
    int maxSize = 1024 * 1024 * 100;
    String encoding = "UTF-8";

    MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
            new DefaultFileRenamePolicy());

    String fileTitle = multipartRequest.getParameter("bbsTitle");
    String fileContent = multipartRequest.getParameter("bbsContent");
    String fileName = multipartRequest.getOriginalFileName("fileName");

    //==========게시물작성동작==========
    //세션관련 오류 처리
    String userID = null;
//    String bbsTitle = null;
//    String bbsContent = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
//    if(request.getParameter("bbsTitle") != null) {
//        bbsTitle= request.getParameter("bbsTitle");
//    }
//    if(request.getParameter("bbsContent") != null) {
//        bbsContent = request.getParameter("bbsContent");
//    }
    if(request.getParameter("fileTitle") != null) {
        fileTitle = request.getParameter("fileTitle");
    }
    if(request.getParameter("fileContent") != null) {
        fileContent = request.getParameter("fileContent");
    }

    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    } else {
        //게시판관련 오류 처리
//        if (bbsTitle == null || bbsContent == null ||
//        bbsTitle.equals("") || bbsContent.equals("")) {
        if (fileTitle == null || fileContent == null ||
                fileTitle.equals("") || fileContent.equals("")) {

            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
//            int result = bbsDAO.write(bbsTitle != null ? bbsTitle : null , userID, bbsContent != null ? bbsContent : null);
            int result = bbsDAO.write(fileTitle != null ? fileTitle : null , userID, fileContent != null ? fileContent : null,
                    fileName != null ? fileName : null);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'bbs.jsp'");
                script.println("</script>");
            }
        }
    }
%>
</body>
</html>