
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

    String count="";
    String writeDate="";
    String memo="";
    String resultRrank="";//사용자의 직급을 데이터 베이스에 불러와서 저장 하는 변수
    ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();
   // boolean logCheck = true;//로그인이 되었는지를 체그 하는 변수 
    if (ck != null) {//쿠키가 비여 있지 않을 경우
        for (Cookie cookies : ck) {
            if (cookies.getName().equals("cookid")){
                sessionId = cookies.getValue();//세션으로 id를 불러 온다. 
            }
        }
        if(sessionId != null){//생성된 세션이 존재 한다는 뜻 생성된 세션이 존재 하면 
            //userR(String)session.getAttribute("ranks");팀원인지 아닌지를 구분하고 싶어 하였는데 ??? 에로 가 난다? 왜??? 
            userName=(String)session.getAttribute("name");//사용자 이름을 가져 오겠다. 
            userRank=(String)session.getAttribute("ranks");//사용자 이름을 가져 오겠다. 
        }
    }
    if(userName.equals("")){//???
        response.sendRedirect("logPage.jsp");
    }
   

    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="SELECT *FROM memo";
    PreparedStatement query=connect.prepareStatement(sql);
    ResultSet result=query.executeQuery();
    
    while(result.next()){
       ArrayList<String> data=new ArrayList<String>();
       data.add("'" + Integer.toString(result.getInt(1)) + "'");
       data.add("'" + result.getString(4) + "'");//날짜
       data.add("'" + result.getString(3) + "'");//내용 
       dataList.add(data);
    }

    //부서를 테이블 조회 하기 
    String sql2="SELECT *FROM ranks WHERE ranksNum=?";
    PreparedStatement query2 =connect.prepareStatement(sql2);
    int tmp=Integer.parseInt(userRank);
    query2.setInt(1,tmp);//사용자의 직급이 무엇인지를 

    ResultSet result2=query2.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 
    while(result2.next()){
        resultRrank=result2.getString(2);
    }

%>




<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" type="text/css" href="memoCSS/Management.css">
    <title>scheduleManagementPage</title>
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
            <input class="hedaderRightButton" id="addButton" type="button" value="추가" onclick="addMemoEvent()">
            <input class="hedaderRightButton" id="managmentButton" type="button" value="관리자" onclick="managmentEvent()">
            <input class="hedaderRightButton" id="logOUtButton" type="button" value="로그아웃" onclick="logOutEvent()">
        </div>

    </header>
    
    <main id="main">
      <%-- 메모를 추가 하기 추가 버튼 눌렀을때 생기는 돔  --%>
         <div id="mainContainer"> 
            <div id="bodyDiv" class="mainAddPageModifyPageDiv">
                <form id="bodyDivFormAdd" class="mainDivFrom" action="memoAddPage.jsp" method="post">
                    <div>
                        <input type="date" name="selectDate">
                        <input type="time" name="selectTime">
                    </div>
                    <div>
                    <input type="text" id="inputText" name="userInptMemo">
                    </div>
                    <div> 
                        <input type="button" value="저장" id="saveButton" onclick="saveButtonEvent()">
                    </div>
                </form>
            </div>
            <%-- 메모를 수정 하기 위한 창이 뜨게 하는 것이다. --%>
            <div id="mainModifyDiv"class="mainAddPageModifyPageDiv">
                <form id="bodyDivForm" class="mainDivFrom" action="modifyPage.jsp" method="post">
                    <div>
                        <input type="text" id="modifyDate" name="modiDate">
                    </div>
                    <div>
                    <input type="text" id="modifyMemo" name="modiMemo">
                    </div>
                    <div> 
                        <input type="submit" value="수정" id="saveButton" onclick="modifyButtonEvent()">
                    </div>
                </form>
            <div>
        </div>

        <div id="mainList"></div>

    </main>
  
    <script>
        var nowYear;//현재 년도 저장하는 변수
        var nowMonth;//현재 월을 저장하는 변수
        var boardList = <%=dataList%>;//jsp에 arrylist를 js 변수에 저장
        var tagDistinguish=0;

        window.onload = function() {
            document.getElementById("headerLeftSpan").innerHTML= "<%=resultRrank%>" + "     " + "<%=userName%>" ;
            var newMain=document.getElementById("main");//main을 가져온다.
            //var newList=document.getElementById("mainList");?? 여기에 자식으로 추가 하면 왜 안되지??
            var memoIndex;
            var memoCount;//count 값을 저장 할 변수   
            // 데이터 베이스에 있는 것을 보여 주기 
            for(var index = 0; index<boardList.length; index++){
                boardIndex=1;
                var tmpDistinguishTagId=tagDistinguish.toString();//각 다른 id 이름을 지정해주기 위해 숫자를 문자로 바꿔서 구분 지우려고 한다.
                var newDiv=document.createElement("div");
                newDiv.setAttribute("class","mainDiv");
                newDiv.setAttribute("id","mainDivMemo"+tmpDistinguishTagId);
                newMain.appendChild(newDiv);

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
                newImgModify.addEventListener("click", function(){modifyEvent(this.id)});//배열에 마지막 값만 넣어 진다. 그래서 
                //내가 누른 tr에 count 가 아닌 데이터 베이스에 마지막 인덱스만 넘어 온다 -- > 어떻게 해결 ??
                tagDistinguish++;//아이디가 겹치지 않게 하기
            }
            //현재 년도와 날짜를 출력 해주는 함수
            yearDate();
            visitTime();
            // managemenButtonDisplay(); //관리자 버튼을 나타낼지 말지를 결정하는 함수
        }

         managemenButtonDisplay(); //관리자 버튼을 나타낼지 말지를 결정하는 함수

        //수정 함수  수정을 그자리에서 일어 나게 하기
        function modifyEvent(index){
            console.log(index)
            var tmpDiv=document.getElementById("mainModifyDiv");
                if(window.getComputedStyle(tmpDiv).display=='none'){
                tmpDiv.style.display = 'block';
                var mc=document.getElementById("mainContainer");
                mc.style.boxShadow=" rgba(85, 84, 84, 0.5) 0 0 0 9999px"
                }else{
                    tmpDiv.style.display = 'none';
                }
            var tmpDate=document.getElementById("mainDivMemoDate" + index);
            var tmpSpan=document.getElementById("mainDivMemoSpan" + index);
            console.log(tmpSpan.innerHTML ,tmpDate.innerHTML)
            document.getElementById("modifyDate").value=tmpDate.innerHTML;
            document.getElementById("modifyMemo").value=tmpSpan.innerHTML;
            //css 하기

        }
        //수정 버튼을 눌렀을 경우 
         function modifyButtonEvent(){
           addFrom=document.getElementById("bodyDivFormModify");
           var mc=document.getElementById("mainContainer");
            mc.style.boxShadow="none";
            addFrom.submit();
        }

        //삭제 이벤트 
        function deletEvent(index){
            console.log(index)
            var tmpDate=document.getElementById("mainDivMemoDate" + index);
            var reusltMain=document.getElementById("main");
            var newForm=document.createElement("form");
            newForm.setAttribute("action","deletMemoModule.jsp");
            newForm.setAttribute("method","post");
            reusltMain.appendChild(newForm);
            var newInput=document.createElement("input");
            newInput.setAttribute("type","hidden");
            newInput.setAttribute("name","delet");
            newInput.setAttribute("value",tmpDate.innerHTML);
            newForm.appendChild(newInput);
            newForm.submit();            
        }
        //년 일 날짜가 나오기 
        function yearDate(){
            var today=new Date();
            nowYear=today.getFullYear();
            nowMonth=today.getMonth()+1;
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

        //추가 버튼 눌렀을 때 호출 되는 이벤트 
        function addMemoEvent(){
            var tmpDiv=document.getElementById("bodyDiv");
            if(window.getComputedStyle(tmpDiv).display=='none'){//window.getComputedStyle() 함수는 외부 css를 가져 올 것이다. 
               tmpDiv.style.display = 'block';
               var mc=document.getElementById("mainContainer");
            //    window.getComputedStyle(mc).box-shadow=" rgba(85, 84, 84, 0.5) 0 0 0 9999px"
               mc.style.boxShadow=" rgba(85, 84, 84, 0.5) 0 0 0 9999px"
            }else{
                tmpDiv.style.display = 'none';
	        }
            console.log("호출")
        }
        //새로 추가 하는 메모의 저장 버튼을 눌럿을 경우 
        function saveButtonEvent(){
           addFrom=document.getElementById("bodyDivFormAdd");
           var mc=document.getElementById("mainContainer");
            mc.style.boxShadow="none";
            addFrom.submit();
        }

        //관리자 버튼을 만들지 없앨지 결정 하는함수 
        function managemenButtonDisplay(){
            var managemenButtonDiv=document.getElementById("managmentButton");
            if("<%=resultRrank%>" == "TeamLeader" ||"<%=resultRrank%>" == "CEO" ){
                managemenButtonDiv.style.display="block";
            }else if("<%=resultRrank%>" == "TeamMember"){
                managemenButtonDiv.style.display="none";
            }
        }

        // 괄리자 버튼을 눌렀으 때 일어 나는 이벤트 
        function managmentEvent(){
            location.href="managmentPage.jsp";
        }


        //로그 아웃 하기 위해 로그 아웃으로 이동하는 함수 
        function logOutEvent(){
            location.href="logOutModule.jsp";
        }
        console.log("<%=sessionId%>")//로그 아웃으로 세션 아이디 지우고 햇는데 세션 아이디가 나온다??
        console.log("<%=userRank%>")//로그 아웃으로 세션 아이디 지우고 햇는데 세션 아이디가 나온다??
        console.log("<%=resultRrank%>")//로그 아웃으로 세션 아이디 지우고 햇는데 세션 아이디가 나온다??     
    </script>
</body>
</html>