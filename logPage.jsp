<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="logPage.css">
    <title>loginPage</title>
</head>
<body>
    <form action="logModule.jsp" method="post">
        <h1>로그인</h1>
       <div class="fromDiv"> 
            <img class="fromDivImg" src="img/id.png">
            <input class="fromDivText" id="userId" type="text" name="idValue"> 
        </div>
       <div class="fromDiv"> 
            <img class="fromDivImg" src="img/pw.png">
            <input class="fromDivText" id="userPw" type="password" name="pwValue">
        </div>
       <div class="fromDiv"> <input class="fromDivButton" type="submit" value="로그인"></div>
       <div class="fromDiv"> <input class="fromDivButton" type="button" value="회원가입" onclick="memberJoinEvent()"></div>
       
    </form>
    <script>
        function memberJoinEvent() {
            location.href="memberJoinPage.jsp";
        }
    </script>
</body>
</html>