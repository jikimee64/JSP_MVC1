<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
<nav class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="mainAction.jsp">IoT SSS</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="mainAction.jsp">스트리밍 서비스</a></li>
            <li><a href="info.jsp">대시보드</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li class="active"><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<!-- 이거 추가함 191016_2/3 -->
<div class="container">
    <div class="jumbotron">
        <div class="container">
            <h1>IoT SSS</h1>
            <p>IoT 단말기 스트리밍 보안 솔루션</p>
        </div>
    </div>
</div>

<div class="container">
    <div class="jumbotron" style="padding-top: 20px;">
        <form method="post" action="joinAction.jsp">
            <h3 style="text-align: center;">회원가입 화면</h3>
            <br/>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
            </div>
            <div class="form-group">
                <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="1번 카메라 IP" name="userIP1" maxlength="50">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="2번 카메라 IP" name="userIP2" maxlength="50">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="3번 카메라 IP" name="userIP3" maxlength="50">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="4번 카메라 IP" name="userIP4" maxlength="50">
            </div>
            <input type="submit" class="btn btn-primary form-control" value="회원가입">
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>