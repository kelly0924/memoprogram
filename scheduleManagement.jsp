
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
   
    String count="";
    String writeDate="";
    String memo="";
    ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();
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

    <main id="main">
        <%-- <div>
            <div></div>
            <span>memo 내용</span>
        <div> --%>
        
    </main>
  
  <script>
    document.getElementById("headerLeftSpan").innerHTML="<%=userName%>";

     var boardList = <%=dataList%>;//jsp에 arrylist를 js 변수에 저장
            //userId를 출력 하는 부분
            function moveBoardConentsEvent(memocnt){
                var resultDiv=document.getElementById("main");
                var newForm=document.createElement("form");
                newForm.setAttribute("action","memoContents.jsp");
                newForm.setAttribute("method","post");
                resultDiv.appendChild(newForm);
                var newInput=document.createElement("input");
                newInput.setAttribute("type","hidden");
                newInput.setAttribute("name","boardcount");
                newInput.setAttribute("value",memocnt);
                newForm.appendChild(newInput);
                newForm.submit();
            }
            window.onload = function() {
                var newMain=document. getElementById("main");//main을 가져온다.
                var memoIndex;
                var memoCount;//count 값을 저장 할 변수  
                // 데이터 베이스에 있는 것을 보여 주기 
                for(var index = 0; index<boardList.length; index++){
                    boardIndex=1;
                    var newDiv=document.createElement("div");
                    newDiv.setAttribute("class","mainDiv");
                    newDiv.setAttribute("id","mainDivMemo");
                    newMain.appendChild(newDiv);

                    var newDivMemo=document.createElement("div");
                    newDivMemo.setAttribute("class","mainDivDate");
                    newDivMemo.setAttribute("id","mainDivMemoDate");
                     newDivMemo.innerHTML=boardList[index][boardIndex];
                    newDiv.appendChild(newDivMemo);
                    boardIndex++;

                    var newSpan=document.createElement("span");
                    newSpan.setAttribute("class","mainDivSpan");
                    newSpan.setAttribute("id","mainDivMemoSpan");
                    newDiv.appendChild(newSpan);
                    newSpan.innerHTML=boardList[index][boardIndex];
                    memoCount=boardList[index][0]
                    newSpan.addEventListener("click", function(){moveBoardConentsEvent(memoCount)});//배열에 마지막 값만 넣어 진다. 그래서 
                    //내가 누른 tr에 count 가 아닌 데이터 베이스에 마지막 인덱스만 넘어 온다 -- > 어떻게 해결 ??
                }
    
            }
            //사용자가 새로운 글을 쓰기 위해 페이지 이동하는 함수 
            function newWriteEvent(){
                location.href="addMemoPagejsp";
            }
            //로그 아웃 하기 위해 로그 아웃으로 이동하는 함수 
            function logOutEvent(){
                location.href="logOutModule.jsp";
            }
            function logInEvent(){
                location.href="logPage.jsp";
            }
  </script>
</body>
</html>