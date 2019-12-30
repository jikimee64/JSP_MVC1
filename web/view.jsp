<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-12-28
  Time: 오후 2:09
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-12-26
  Time: 오후 9:47
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-12-26
  Time: 오후 9:34
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: wlsgm
  Date: 2019-11-16
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.security.GeneralSecurityException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="util.DatabaseUtil" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
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

    String userID = null;
    int bbsID = 0;

    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
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

    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'login.jsp'; ");
        script.println("</script>");
        script.close();
        return;
    }

    boolean emailChecked = false;
    emailChecked = new UserDAO().getUserEmailChecked(userID);

    if(!emailChecked) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'emailSendConfirm.jsp'; ");
        script.println("</script>");
        script.close();
        return;
    }

%>

<nav class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">IoT SSS</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">스트리밍 서비스</a></li>
            <li class="active"><a href="bbs.jsp">게시판</a></li>
        </ul>
        <%
            if(userID == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <%
        } else {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="logoutAction.jsp">로그아웃</a></li>
                    <li><a href="update.jsp">회원수정</a></li>
                    <li><a onclick="return confirm('정말로 탈퇴하시겠습니까?')" href="removeAction.jsp">회원탈퇴</a></li>
                </ul>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>

<div class="container">
    <div class="row">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th colspan="3">게시판 글 보기</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="width: 20%;">글 제목</td>
                    <td colspan="2"><%= bbs.getBbsTitle() != null ? bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") : null %></td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td colspan="2"><%= bbs.getUserID() %></td>
                </tr>
                <tr>
                    <td>작성일자</td>
                    <td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13)+ ":" + bbs.getBbsDate().substring(14,16) %></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td colspan="2" style="min-height: 200px; text-align: left"><%= bbs.getBbsContent() != null ? bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") : null %></td>
                </tr>
                <tr>
                    <td>첨부파일</td>
                    <td colspan="2"><%= bbs.getFileName() != null ? bbs.getFileName() : "" %></td>
                </tr>

                </tbody>
            </table>
            <a href="bbs.jsp" class="btn btn-primary">목록</a>
        <%
            if(userID != null && userID.equals(bbs.getUserID())) {
        %>
            <a href="boardUpdate.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
            <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="boardDeleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
        <%
            }
        %>
        <a href="fileDownload.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">파일다운</a>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>