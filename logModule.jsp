<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String id=request.getParameter("idValue");
    String pw=request.getParameter("pwValue");
    String resultId="";
    String resultPw="";
    String resultName="";
    String sessionId="";
    String ranks="";
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    String sql="SELECT * FROM user WHERE userId=? and userPw=?";
    PreparedStatement query =connect.prepareStatement(sql);
    query.setString(1,id);
    query.setString(2,pw);
    ResultSet result=query.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 
    while(result.next()){
        resultId=result.getString(1);
        resultName=result.getString(2);//사용자 이름
        resultPw=result.getString(3);
        ranks=result.getString(5);//팀장인지 팀원인지 대표인지를 구분하기 위해 
    }
    if(id.equals(resultId) && pw.equals(resultPw)){//로그인이 성공 한 경우
       // 세션 생성 한다. 로그인에 대한 세션 생성 --> 서버에 에서 유일한 세션 아이디 부여 하고 서버에
         //사용자에 id와 pw 가 저장된다.
		session.setAttribute("pw", pw);
        session.setAttribute("id", id);
        session.setAttribute("name",resultName);//사용자에 이름도 세션에 포함 시킨다.
        session.setAttribute("ranks",ranks);//팀원인지 팀장인지 를 구분하기 위해서 세션도 같이 새성 해주기
        //생성한 세션에서 사용자 id, pw 가져오기
        sessionId = session.getId();//생성된 세션 id를 가져온다. 
        //세션 값을 쿠키에 넣어서 주기 쿠키 생성
        Cookie c = new Cookie("cookid", sessionId);
		response.addCookie(c);
        response.sendRedirect("scheduleManagement.jsp");
    }
    else{
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
     console.log("id"+<%=id%>)
    </script>

</body>
</html>