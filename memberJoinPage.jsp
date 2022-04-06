<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    ArrayList<String> ranksList =new ArrayList<String>();
    ArrayList<String> departmentList=new ArrayList<String>();
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="SELECT *FROM department";
    PreparedStatement query=connect.prepareStatement(sql);
    ResultSet result=query.executeQuery();
    
    while(result.next()){
        departmentList.add("'" + result.getString(2) + "'");

    }
    
    String sql2="SELECT *FROM ranks";
    PreparedStatement query2 =connect.prepareStatement(sql2);
    ResultSet result2=query2.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 

    while(result2.next()){
        ranksList.add( "'" + result2.getString(2) + "'");
       
    }
    

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
    <form action="memberJoinModule.jsp" method="post" id="fromTag">
        <span>이름<span>
        <div class="formDiv">
            <input class="fromDivText"  type="text" name="userName" >
        </div>

       <span>부서<span>
        <div class="formDiv">
            <select name="Departments" class="fromDivSelect">
                <option> </option>
                <option id="Accounting"></option>
                <option id="Development"></option>
                <option id="Education"></option>
            </select>
        </div>
        
        <span>직급<span>
        <div class="formDiv">
            <select name="ranks" class="fromDivSelect">
                <option> </option>
                <option id="CEO"></option>
                <option id="TeamLeader"></option>
                <option id="Teammember"></option>
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
            <input id="fromDivSubmit" type="button" value="회원가입" onclick="memberJoinButtonEvent()">
        </div>
    </form>

    <script>
        var jsDepartList=<%=departmentList%>
        var jsRanksList=<%=ranksList%>
        var idCheckEventCall=false;//중복 코드가 눌렸는지 아닌지를 확인 하기 위한 변수 
        //부서를 데이테 베이스에서 불러 와서 넣어 html에 넣어 주는 것
        document.getElementById("Accounting").innerHTML=jsDepartList[0];
        document.getElementById("Development").innerHTML=jsDepartList[1];
        document.getElementById("Education").innerHTML=jsDepartList[2];
        //직급을 데이터 베이스에서 불러와서 넣어 주는 과정
        document.getElementById("CEO").innerHTML=jsDepartList[0];
        document.getElementById("TeamLeader").innerHTML=jsDepartList[1];
        document.getElementById("Teammember").innerHTML=jsDepartList[2];
       
       //id 중복 체크 이벤트 
        function  idCheckEvent() {
            idCheckEventCall=true;
            var userId=document.getElementById("fromDivId").value;//중복체크 버튼 클릭시 넘어 오는 사용자 id 값
            url = "checkId.jsp?userid="+userId;
            window.name="parentWindow"
            window.open(url,"newWindow","height=200,width=400");//맥에서는 싸파리에서만 가능함 이유는 그냥 지원 하지 않느다고 함
            //아이디 입력 란을 비활성화 해서 중복체크 한후 다시 입력이 불가 하게 할것이다.
            document.getElementById("fromDivId").style.disabled="disabled";
        }
         
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

        //회원 가입 버튼을 눌렀을때 일어 나는 이벤트 
        function memberJoinButtonEvent(){
            //만약 아이디 중복 체크가 쿨릭 됬다면 submit 해서 가입 페이지로 넘어 가기 
            if(idCheckEventCall == true){
                document.getElementById("fromTag").submit();
            }else{
                alert("중복체크를 하지 않았습니다.")
            }
        }
         console.log("<%=ranksList%>")

    </script>
</body>
</html>