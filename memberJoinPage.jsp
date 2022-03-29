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
            <input class="fromDivText" type="text" name="userId" id="fromDivId" >
            <input id="formDivIdCheckButton" type="button" value="중복체크" onclick="idCheckEvent()"> 
        </div>

        <span>비밀번호<span>
        <div class="formDiv">
            <input class="fromDivText" type="password" name="userPw">
        </div>

        <span>비밀번호확인<span>
        <div class="formDiv">
            <input class="fromDivText" type="password" name="userPwCheck" >
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
    </script>
</body>
</html>