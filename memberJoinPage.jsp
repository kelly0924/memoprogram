<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
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
            <input id="fromDivPw" class="fromDivText" type="password" name="userPw" onchange="PwEvent()">
        </div>

        <span>비밀번호확인<span>
        <div class="formDiv">
            <input id="fromDivePWCheck" class="fromDivText" type="password" name="userPwCheck" onchange="PwEvent()" >
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
        function PwEvent(){
            var pw=document.getElementById("fromDivPw");
            var pwCheck=document.getElementById("fromDivePWCheck");
            var SC = ["!","@","#","$","%"];
            var checkSC = 0;
            if(pw.length < 8 || pw.length>15){//비밀 번호는 8자 이상 15 이하 
                window.alert('비밀번호는 8글자 이상, 15글자 이하만 이용 가능합니다.');
                document.getElementById('fromDivPw').value='';
            }
            if(SC==0){
               window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
                document.getElementById('fromDivPw').value='';
            }
            if(pw.value == pwCheck.value){
                document.getElementById("fromDivSpan").innerHTML="일치 합니다.";
                document.getElementById("fromDivSpan").style.color="blue";
            }else{
                document.getElementById("fromDivSpan").innerHTML="일치 하지 않습니다.";
                document.getElementById("fromDivSpan").style.color="red";
                document.getElementById("fromDivePWCheck".innerHTML="";
            }
        
        }
        

    </script>
</body>
</html>