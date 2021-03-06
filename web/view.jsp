<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="comm.Comm" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
    <title>캡스톤디자인프로젝트</title>

</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    String userID = null;
    int bbsID = 0;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.');");
        script.println("location.href = 'bbs.jsp'; ");
        script.println("</script>");
        script.close();
    }

    Bbs bbs = new BbsDAO().getBbs(bbsID);

    if (userID == null) {
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

    if (!emailChecked) {
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
            if (userID == null) {
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
                <td colspan="2"><%= bbs.getBbsTitle() != null ? bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") : null %>
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td colspan="2"><%= bbs.getUserID() %>
                </td>
            </tr>
            <tr>
                <td>작성일자</td>
                <td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + ":" + bbs.getBbsDate().substring(14, 16) %>
                </td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="2"
                    style="min-height: 200px; text-align: left"><%= bbs.getBbsContent() != null ? bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") : null %>
                </td>
            </tr>
            <tr>
                <td>첨부파일</td>
                <td colspan="2"><%= bbs.getFileName() != null ? bbs.getFileName() : "" %>
                </td>
            </tr>


            </tbody>
        </table>


        <table class="table table-striped">
            <thead>
            <tr>
                <th>작성자</th>
                <th>댓글 내용</th>
                <th>기타</th>
            </tr>
            </thead>
            <tbody>
            <%
                CommDAO commDAO = new CommDAO();
                ArrayList<Comm> list = commDAO.getList(bbsID);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%= list.get(i).getUserID() %>
                </td>
                <td><%= list.get(i).getCommContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
                </td>
                <%
                    if (userID != null && userID.equals(userID)) {
                %>

                <td><a onclick="return confirm('정말로 삭제하시겠습니까?')"
                       href="commentDeleteAction.jsp?bbsID=<%= bbsID %>&commID=<%=list.get(i).getCommID() %>&<%=list.get(i).getUserID()%>"
                       class="btn btn-primary">삭제</a>
                <td>
                        <%
                }
                else{
                    %>
                <td><a href="#" class="btn btn-primary">공사중</a></td>
                <%
                        }
                    }
                %>
            </tr>
            </tbody>
        </table>


        <form method="post" action="commentAction.jsp?bbsID=<%= bbs.getBbsID() %>">
            <table class="table table-striped">
                <thead>
                <tr>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td colspan="3"><%= userID %>
                    </td>
                    <td><input type="text" class="form-control" placeholder="댓글 내용" name="commContent" maxlength="200">
                    </td>
                    <td>
                        <input type="submit" class="btn btn-primary pull-right" value="댓글작성">
                    </td>

                </tr>
                </tbody>
            </table>

        </form>


        <a href="bbs.jsp" class="btn btn-primary">목록</a>
        <%
            if (userID != null && userID.equals(bbs.getUserID())) {
        %>
        <a href="boardUpdate.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
        <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="boardDeleteAction.jsp?bbsID=<%= bbsID %>"
           class="btn btn-primary">삭제</a>
        <%
            }
        %>
        <%
            if (bbs.getFileName() != null) {
        %>
        <a href="fileDownload.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">파일다운</a>
        <%
            }
        %>
        <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?bbsID=<%= bbs.getBbsID() %>"
           class="btn btn-primary">추천</a>
        <a href="#reportModal" class="btn btn-danger ml-1 mt-2" data-toggle="modal">신고</a>
    </div>
</div>


<!-- 신고 -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledy="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal">신고하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="./reportAction.jsp?bbsID=<%= bbs.getBbsID() %>" method="post">
                    <div class="form-group">
                        <label>신고 제목</label> <input type="text" name="reportTitle" class="form-control" maxlength="30"
                                                    style="color:black" ;>
                    </div>
                    <div class="form-group">
                        <label>신고 내용</label>
                        <textarea name="reportContent" class="form-control" maxlength="2048"
                                  style="height: 180px; color:black"></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-danger">신고하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>