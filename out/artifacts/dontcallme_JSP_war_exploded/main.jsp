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
    String userIP1 = null;
    String userIP2 = null;
    String userIP3 = null;
    String userIP4 = null;

    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if(session.getAttribute("userIP1") != null) {
        userIP1 = (String) session.getAttribute("userIP1");
    }
    if(session.getAttribute("userIP2") != null) {
        userIP2 = (String) session.getAttribute("userIP2");
    }
    if(session.getAttribute("userIP3") != null) {
        userIP3 = (String) session.getAttribute("userIP3");
    }
    if(session.getAttribute("userIP4") != null) {
        userIP4 = (String) session.getAttribute("userIP4");
    }
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

    try (Connection conn = DatabaseUtil.getConnection()) {
        String sql1 = "select * from CCTV where userID = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql1);

        Statement stmt = null;
        pstmt.setString(1, userID);
        stmt = conn.createStatement();
        String sql2 = "select * from CCTV where userID = '" + userID + "'";
        ResultSet rs = stmt.executeQuery(sql2);

        if (rs.next()) {
            userIP1 = rs.getString("userIP1");
            userIP2 = rs.getString("userIP2");
            userIP3 = rs.getString("userIP3");
            userIP4 = rs.getString("userIP4");
        }
    } catch (SQLException e) {
        e.printStackTrace();
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
            <li class="active"><a href="main.jsp">스트리밍 서비스</a></li>
           <li><a href="bbs.jsp">게시판</a></li>
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
    <div class="jumbotron">
        <div class="container">
            <h1>IoT SSS</h1>
            <p>IoT 단말기 스트리밍 보안 솔루션</p>
        </div>
    </div>
</div>

<div class="container">
    <div class="jumbotron">
        <h1><%=userID %>의 ES100V Mini</h1>
        <br />
        <br />

        <div class="row" style="text-align:center;">
            <div class="col-md-6 col-lg-6">
                <div class="jumbotron" style="padding: 30px;">
                    <p style="font-weight: bold">Flask Test<br/>
                        <br/>
                        <iframe src="http://localhost:5000/" style="  display: block; margin-right: auto; margin-left: auto; overflow-x:hidden; overflow:auto; width:320px; height:300px;" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 vspace=0></iframe>
                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="jumbotron" style="padding: 30px;">
                    <p style="font-weight: bold"><%=userIP1 %><br/>
                        <br/>
                        <iframe src="http://<%=userIP1 %>:6611/web/admin.html"  style="  display: block; margin-right: auto; margin-left: auto; overflow-x:hidden; overflow:auto; width:320px; height:300px;" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 vspace=0></iframe>
                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="jumbotron" style="padding: 30px;">
                    <p style="font-weight: bold"><%=userIP2 %><br/>
                        <br/>
                        <iframe src="http://<%=userIP2 %>:6611/web/admin.html"  style="  display: block; margin-right: auto; margin-left: auto; overflow-x:hidden; overflow:auto; width:320px; height:300px;" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 vspace=0></iframe>
                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="jumbotron" style="padding: 30px;">
                    <p style="font-weight: bold"><%=userIP3 %><br/>
                        <br/>
                        <iframe src="http://<%=userIP3 %>:6611/web/admin.html"  style="  display: block; margin-right: auto; margin-left: auto; overflow-x:hidden; overflow:auto; width:320px; height:300px;" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 vspace=0></iframe>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>