<%@ page import="java.io.PrintWriter" %>
<%@ page import="comm.Comm" %>
<%@ page import="comm.CommDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>캡스톤디자인프로젝트</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int bbsID = 0;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    int commID = 0;
    if (request.getParameter("commID") != null) {
        commID = Integer.parseInt(request.getParameter("commID"));
    }
    if (commID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    Comm comm = new CommDAO().getComm(commID, bbsID);
    if (!userID.equals(comm.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
        script.println("</script>");
    } else {
        CommDAO commDAO = new CommDAO();
        int result = commDAO.delete(commID, bbsID);
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 삭제에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
            script.println("</script>");
        }
    }
%>
</body>
</html>
