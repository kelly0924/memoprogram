<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%

    request.setCharacterEncoding("utf-8");
    String id=request.getParameter("teamMemberId");
    String name=request.getParameter("teamMemberName");
    ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="SELECT *FROM memo WHERE userId=?";
    PreparedStatement query=connect.prepareStatement(sql);
    query.setString(1,id);
    ResultSet result=query.executeQuery();
    
    while(result.next()){
       ArrayList<String> data=new ArrayList<String>();
       data.add("'" + Integer.toString(result.getInt(1)) + "'");
       data.add("'" + result.getString(4) + "'");//날짜
       data.add("'" + result.getString(3) + "'");//내용 
       dataList.add(data);
    }

%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" type="text/css" href="memoCSS/Management.css">
    <title>managementPage</title>
</head>
<body>
    <header id="header">
        <div id="headerLeftDiv">
            <div> <img src="img/id.png" id="userIcon"></div>
            <span id="headerLeftSpan"></span>
        </div>
        
        <div id="headerCenter">
            <div> <img src="img/left.png" class="headerCenterIcon" onclick="yearDateLeftIconEvent()"> </div>
            <div id="headerCenterDivDate"> </div>
            <div><img src="img/right.png" class="headerCenterIcon" onclick="yearDaterighteIconEvent()" ></div>
        
        </div>

        <div id="headerRightDiv">
            <input class="hedaderRightButton" id="addButton" type="button" value="뒤로" onclick="goBackEvent()">
        </div>

    </header>
    <main id="main">
        <div id="mainDiv"></div>
    </main>

    <script>
        var nowYear;//현재 년도 저장하는 변수
        var nowMonth;//현재 월을 저장하는 변수
        var boardList = <%=dataList%>;//jsp에 arrylist를 js 변수에 저장
        var tagDistinguish=0;

        window.onload = function() {
            document.getElementById("headerLeftSpan").innerHTML= "TeamMember";
            var newMainDiv=document.getElementById("main");//main을 가져온다.
            var memoIndex;
            var memoCount;//count 값을 저장 할 변수   
            // 데이터 베이스에 있는 것을 보여 주기 
            for(var index = 0; index<boardList.length; index++){
                boardIndex=1;
                var tmpDistinguishTagId=tagDistinguish.toString();//각 다른 id 이름을 지정해주기 위해 숫자를 문자로 바꿔서 구분 지우려고 한다.
                var newDiv=document.createElement("div");
                newDiv.setAttribute("class","mainDiv");
                newDiv.setAttribute("id","mainDivMemo"+tmpDistinguishTagId);
                newMainDiv.appendChild(newDiv);

                var newDivMemo=document.createElement("div");
                newDivMemo.setAttribute("class","mainDivDate");
                newDivMemo.setAttribute("id","mainDivMemoDate"+tmpDistinguishTagId);
                newDivMemo.innerHTML=boardList[index][boardIndex];
                newDiv.appendChild(newDivMemo);
                boardIndex++;

                var newSpan=document.createElement("span");
                newSpan.setAttribute("class","mainDivSpan");
                newSpan.setAttribute("id","mainDivMemoSpan" + tmpDistinguishTagId);
                newDiv.appendChild(newSpan);
                newSpan.innerHTML=boardList[index][boardIndex];
                
                var newImgDelete=document.createElement("img");
                newImgDelete.setAttribute("src","img/deletImg.png");
                newImgDelete.setAttribute("id",tmpDistinguishTagId);
                newDiv.appendChild(newImgDelete);
                newImgDelete.addEventListener("click", function(){deletEvent(this.id)});

                var newImgModify=document.createElement("img");
                newImgModify.setAttribute("src","img/modifiy.png");
                newImgModify.setAttribute("id",tmpDistinguishTagId);
                newDiv.appendChild(newImgModify);
                tagDistinguish++;//아이디가 겹치지 않게 하기
            }
            //현재 년도와 날짜를 출력 해주는 함수
            yearDate();
            visitTime();
            // managemenButtonDisplay(); //관리자 버튼을 나타낼지 말지를 결정하는 함수
        }
        //년 일 날짜가 나오기 
        function yearDate(){
            var today=new Date();
            nowYear=today.getFullYear();
            nowMonth=today.getMonth()+1;
            console.log(nowYear)
            document.getElementById("headerCenterDivDate").innerHTML= nowYear +"." + "0"+nowMonth;
        }
        //년 월 왼쪽 아이콘을 눌렀을 때 이벤트
        function yearDateLeftIconEvent(){
            
            if(nowMonth == 1){//현재 1월일 경우 한번 이전으로 하면 전 년 12월이 된다.
                nowYear=nowYear-1;
                nowMonth=12;
                printYearMonth(nowMonth);
            }else{
                nowMonth=nowMonth -1;
                printYearMonth(nowMonth);
            }
        }
        //년 월 오른쪽 아이콘을 눌렀을 떼 일어나는 이벤트 
        function yearDaterighteIconEvent(){
            if(nowMonth == 12){
                nowYear = nowYear + 1;
                nowMonth = 1;
                printYearMonth(nowMonth);
            }else {
                nowMonth = nowMonth + 1;
                printYearMonth(nowMonth);
            }
        }
        //년 월을 포맷에 맞게 출력 해는 함수
        function printYearMonth(nowMonth){//년 월을 출력만 해주는 합수 
            if(nowMonth == 10 || nowMonth == 11 || nowMonth == 12){
                document.getElementById("headerCenterDivDate").innerHTML= nowYear +"." + nowMonth;
            }else{
                document.getElementById("headerCenterDivDate").innerHTML= nowYear +"." + "0" + nowMonth;
            }
        }
        //웹 페이지 방문시 시간을 가져 오는 함수 
        function visitTime(){
            var today = new Date();
            var year = today.getFullYear();
            var month =today.getMonth() + 1;
            var day = today.getDate();
            var hours =  today.getHours();
            var minutes = today.getMinutes();
            var seconds = today.getSeconds();
            
            console.log(year,month,day,hours,minutes,seconds)
        }
        //뒤로가기 버튼 클릭시 이벤트 하기 
        function goBackEvent(){
            location.href="managmentPage.jsp";
        }

    </script>
</body>
</html>