
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
    String userRank="";//사용자의 직급을 저장 하는 변수 
    String userDepart="";

    ArrayList<String> departMemberList = new ArrayList<String>();
   // boolean logCheck = true;//로그인이 되었는지를 체그 하는 변수 
    if (ck != null) {//쿠키가 비여 있지 않을 경우
        for (Cookie cookies : ck) {
            if (cookies.getName().equals("cookid")){
                sessionId = cookies.getValue();//세션으로 id를 불러 온다. 
            }
        }
        if(sessionId != null){//생성된 세션이 존재 한다는 뜻 생성된 세션이 존재 하면 
            userName=(String)session.getAttribute("name");//사용자 이름을 가져 오겠다. 
            userDepart=(String)session.getAttribute("depart");//사용자   부서를 가져 오겠다.
        }
    }
    if(userName.equals("")){//???
        response.sendRedirect("logPage.jsp");
    }
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호

    String sql="SELECT *FROM userImpormation WHERE userDepartment=?";
    PreparedStatement query =connect.prepareStatement(sql);
    int tmp=Integer.parseInt(userDepart);
    query.setInt(1,tmp);//사용자의 직급이 무엇인지를 

    ResultSet result=query.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 
    while(result.next()){
        departMemberList.add("'" + result.getString(2) + "'");//직원에 이름을 리스트에 작성 할 것이다. 
    }

%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" type="text/css" href="img/memberManagment.css">
    <title>managementPage</title>
</head>
<body>
    <header id="header">
        <div id="headerLeftDiv">
            <div> <img src="img/id.png" id="userIcon"></div>
            <span id="headerLeftSpan"></span>
        </div>


        <div id="headerRightDiv">
            <input class="hedaderRightButton" id="addButton" type="button" value="추가" onclick="">
        </div>

    </header>
    
<body>
    <script>
        console.log(<%=userDepart%>)
    </script>

</body>
</html>