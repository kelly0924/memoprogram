<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String id=request.getParameter("userid");
    String resultId="";
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    String sql="SELECT * FROM user WHERE userId=?";
    PreparedStatement query =connect.prepareStatement(sql);
    query.setString(1,id);
    ResultSet result=query.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 
    while(result.next()){
        resultId=result.getString(1);
    }
    if(id.equals(resultId)){// 같은 사용자 아이디가 존재 하면  다시 존재 하는 아이디 입니다. 
    }
    else{//같은 아이디가 없으면 사용가능한 아이디 입니다. 
        
    }
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>s</title>
</head>
<body>
    <script>
        console.log("<%=id%>")
    </script>
    
</body>
</html>