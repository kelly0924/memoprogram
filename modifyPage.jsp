<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>
<%@ include file="userSession.jsp"%>

<%
    request.setCharacterEncoding("utf-8");
   
    String modifiyDate=request.getParameter("modiDate");
    String modifiyMemo=request.getParameter("modiMemo");
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="UPDATE memo SET memoContents=? WHERE memoWriteDate=?";
    PreparedStatement query=connect.prepareStatement(sql);
    query.setString(1,modifiyMemo);
    query.setString(2,modifiyDate);
    query.executeUpdate();

    response.sendRedirect("scheduleManagement.jsp");
    

%>
<script>
    console.log("<%=modifiyDate%>","<%=modifiyMemo%>")
</script>