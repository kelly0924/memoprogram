<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String sessionId="";
    ArrayList<String> ranksList =new ArrayList<String>();
    ArrayList<String> departmentList=new ArrayList<String>();
        //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    String sql="SELECT * FROM user WHERE userId=? and userPw=?";
    PreparedStatement query =connect.prepareStatement(sql);
    ResultSet result=query.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 
    while(result.next()){
        
    }
    //세션 처리
    //session.setAttribute("pw", pw);
    //session.setAttribute("id", id);
    //session.setAttribute("name",resultName);//사용자에 이름도 세션에 포함 시킨다.
    //session.setAttribute("ranks",userRanks);//팀원인지 팀장인지 를 구분하기 위해서 세션도 같이 새성 해주기
    ////생성한 세션에서 사용자 id, pw 가져오기
    //sessionId = session.getId();//생성된 세션 id를 가져온다. 
    ////세션 값을 쿠키에 넣어서 주기 쿠키 생성
    //Cookie c = new Cookie("cookid", sessionId);
    //response.addCookie(c);
    //response.sendRedirect("scheduleManagement.jsp");

%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" type="text/css" href="memoCSS/memberJoinPage.css">
    <title>memberJoinPage</title>
</head>
<body>
    <form action="memberJoinModule.jsp" method="post">
        <span>이름<span>
        <div class="formDiv">
            <input class="fromDivText"  type="text" name="userName" >
        </div>

       <span>부서<span>
        <div class="formDiv">
            <select name="Departments" class="fromDivSelect">
                <option value="">선택</option>
                <option value="Accounting">Accounting</option>
                <option value="Development">Development</option>
                <option value="Education">Education</option>
            </select>
        </div>
        
        <span>직급<span>
        <div class="formDiv">
            <select name="ranks" class="fromDivSelect">
                <option value="">선택</option>
                <option value="CEO">CEO</option>
                <option value="TeamLeader">TeamLeader</option>
                <option value="Teammember">Teammember</option>
            </select>
        </div>

        <span>아이디<span>
        <div class="formDiv">
            <%-- id 입력 폼 예외 처리 숫자만 가능 /^[0-9]+$/ == > 0~9까지 숫자만 입력 가능하다는 정규 표현식 : 정규 표현식이란 정한 규칙을 가진 문자열의 집합을 표현하는 데 사용하는 형식 언어이다. --%>
            <input class="fromDivText" type="text" name="userId" id="fromDivId" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" / >
            <input id="formDivIdCheckButton" type="button" value="중복체크" onclick="idCheckEvent()"> 
        </div>

        <span>비밀번호<span>
        <div class="formDiv">
            <input id="fromDivPw" class="fromDivText" type="password" name="userPw" onchange="pwEvent()">
        </div>

        <span>비밀번호확인<span>
        <div class="formDiv">
            <input id="fromDivePWCheck" class="fromDivText" type="password" name="userPwCheck" onkeyup="checkPwEvent()">
            <span id="fromDivSpan"></span>
        </div>

        <div class="formDiv"> 
            <input id="fromDivSubmit" type="submit" value="회원가입">
        </div>
    </form>

    <script>

        function  idCheckEvent() {
            var userId=document.getElementById("fromDivId").value;//중복체크 버튼 클릭시 넘어 오는 사용자 id 값
            url = "checkId.jsp?userid="+userId;
            window.name="parentWindow"
            window.open(url,"newWindow","height=200,width=400");//맥에서는 싸파리에서만 가능함 이유는 그냥 지원 하지 않느다고 함
        }
        //비밀 번호 확인 하기 
        //  var pwObj=document.getElementById("fromDivPw");
        //  pwObj.addEventListener("onchange",pwEvent);
         
        function pwEvent(){
            var pw=document.getElementById("fromDivPw").value;
            var SC = ["!","@","#","$","%"];
            var checkSC = 0;
            if(pw.length < 6 || pw.length>15){//비밀 번호는 8자 이상 15 이하 
                window.alert('비밀번호는 8글자 이상, 15글자 이하만 이용 가능합니다.');
                document.getElementById('fromDivPw').value='';
            }
            for(var i=0;i<SC.length;i++){
                if(pw.indexOf(SC[i]) != -1){
                    checkSC = 1;
                }
            }
            if(checkSC == 0){
                window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.');
                document.getElementById('pw').value='';
            }
            console.log("함수 호출")
        }
        
       function checkPwEvent(){
            var pw=document.getElementById("fromDivPw");
            var pwCheck=document.getElementById("fromDivePWCheck");
            if(pw.value !=pwCheck.value){
                document.getElementById("fromDivSpan").innerHTML="비밀번호가 일치하지 않습니다.";
                document.getElementById("fromDivSpan").style.color="red";
            }else if(pw.value==pwCheck.value){
                document.getElementById("fromDivSpan").innerHTML=" 비밀번호가 일치 합니다.";
                document.getElementById("fromDivSpan").style.color="blue";
            }
        }


    </script>
</body>
</html>