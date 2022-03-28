<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String name=request.getParameter("userName");
    String id=request.getParameter("userId");
    String pw=request.getParameter("userPw");
    String pwCheck=request.getParameter("userPwCheck");
    String department=request.getParameter("Departments");
    String ranks=request.getParameter("ranks");
    boolean inputCheck=false;
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호

    if(name.equals("")||id.equals("")||pw.equals("")||department.equals("")||ranks.equals("")){
        inputCheck=true;

    }else{
        String sql="INSERT INTO user(userId,userName,userPw,userDepartment,userRank) VALUES(?,?,?,?,?)";
        PreparedStatement query =connect.prepareStatement(sql);
        query.setString(1,id);
        query.setString(2,name);
        query.setString(3.pw);
        query.setString(4,department);
        query.setString(5,ranks);

        query.executeUpdate();
        response.sendRedirect("logPage.jsp");
    }
   
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
</head>
<body>
    <script>
      if(<%=inputCheck%> == true){
          alert("정보를 모두 입력 하세요");
          location.href="memberJoinPage.jsp";
        }
    </script>

</body>
</html>