
<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>
<%@ include file="userSession.jsp"%>
<%
    request.setCharacterEncoding("utf-8");
    Cookie[] ck = request.getCookies();
    String sessionId="";
    String userName="";
   // boolean logCheck = true;//로그인이 되었는지를 체그 하는 변수 
    if (ck != null) {//쿠키가 비여 있지 않을 경우
        for (Cookie cookies : ck) {
            if (cookies.getName().equals("cookid")){
                sessionId = cookies.getValue();//세션으로 id를 불러 온다. 
            }
        }
        if(sessionId != null){//생성된 세션이 존재 한다는 뜻 생성된 세션이 존재 하면 
            userName=(String)session.getAttribute("name");//사용자 이름을 가져 오겠다. 
        }
    }


%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>scheduleManagementPage</title>
</head>
<body>
    <h1>일정 관리 페이지<h1>
    <header>
        <div id="headerLeftDiv">
            <div> <img src=""></div>
            <span id="headerLeftSpan"></span>
        </div>

        <div id="headerCenter">
            <div> <img src=""> </div>
            <div> </div>
            <div><img src=""></div>
        
        </div>

        <div>
            <input type="button" value="추가">
            <input type="button" value="로그아웃">
        </div>

    </header>

    <main>
        <div>
            <div></div>
            <span>memo 내용</span>
        <div>
        
    </main>
  
  <script>
    document.getElementById("headerLeftSpan").innerHTML="<%=userName%>";
  </script>
</body>
</html>