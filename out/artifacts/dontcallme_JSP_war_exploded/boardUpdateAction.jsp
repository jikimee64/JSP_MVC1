<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-12-28
  Time: 오후 3:04
  To change this template use File | Settings | File Templates.
--%>
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
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나를지켜줘</title>
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
    int bbsID = 0;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
//    if(request.getParameter("bbsTitle") != null) {
//        bbsTitle= request.getParameter("bbsTitle");
//    }
//    if(request.getParameter("bbsContent") != null) {
//        bbsContent = request.getParameter("bbsContent");
//    }
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    if(bbsID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.');");
        script.println("location.href = 'bbs.jsp'; ");
        script.println("</script>");
        script.close();
    }

    Bbs bbs = new BbsDAO().getBbs(bbsID);
    if(!userID.equals(bbs.getUserID())){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.');");
        script.println("location.href = 'bbs.jsp'; ");
        script.println("</script>");
        script.close();
    } else {
        //게시판관련 오류 처리
//        request.getParameter("bbsTitle") : 이거 넣어도 가능
        if (fileTitle == null || fileContent == null ||
                fileTitle.equals("") || fileContent.equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
//            int result = bbsDAO.update(bbsID, request.getParameter("fileTitle") != null ? request.getParameter("fileTitle") : null , request.getParameter("fileContent") != null ? request.getParameter("fileContent") : null,
//                    request.getParameter("fileName") != null ? request.getParameter("fileName") : null );

            int result = bbsDAO.update(bbsID, fileTitle != null ? fileTitle : null ,  fileContent != null ? fileContent : null,
                    fileName != null ? fileName : null);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 수정에 실패했습니다.')");
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