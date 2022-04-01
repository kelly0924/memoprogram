<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    Cookie user = new Cookie("id", "");
    user.setMaxAge(0);//를 사용하면 쿠기 삭제가 된다. 
    response.addCookie(user);//쿠키에 초기화된 user정보를 보내 줘야 한다. 
    
    session.invalidate(); //세션에 있는 모든 내용을 삭제 할 것이다. 
    //response.sendRedirect("index.jsp");
%>

<script>
    alert("로그 아웃");
    location.href="logPage.jsp";
</script>