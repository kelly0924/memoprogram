
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
    String userId="";
    ArrayList<ArrayList<String>> departMemberList = new ArrayList<ArrayList<String>> ();
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
    //if(userName.equals("")){//???
    //    response.sendRedirect("logPage.jsp");
    //}
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호

    String sql="SELECT *FROM userImpormation WHERE userDepartment=?";
    PreparedStatement query =connect.prepareStatement(sql);
    int tmp=Integer.parseInt(userDepart);
    query.setInt(1,tmp);//사용자의 직급이 무엇인지를 

    ResultSet result=query.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 
    while(result.next()){
        ArrayList<String> tmpMemberList = new ArrayList<String>();
        if(userName.equals(result.getString(2))){
            continue;
        }else if(result.getString(5).equals("2")||result.getString(5).equals("1")){
            continue;
        }
        else{
            tmpMemberList.add("'" + result.getString(1) + "'");//사용자의 아이디를 알아야 한다.
            tmpMemberList.add("'" + result.getString(3) + "'");//비밀 번호 
            tmpMemberList.add("'" + result.getString(2) + "'");//직원에 이름을 리스트에 작성 할 것이다. 
            departMemberList.add(tmpMemberList);
        }
    }

%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="memoCSS/memberManagment.css">
    <title>managementPage</title>
</head>
<body>
    <header id="header">
        <div id="headerLeftDiv">
            <div class="hedaderLeftUser"> <img src="img/userIcon.png" id="userIcon"></div>
            <div class="hedaderLeftUser" id="headerLeftDivName"></div>
        </div>


        <div id="headerRightDiv">
            <input class="hedaderRightButton" id="managementButton" type="button" value="일정" onclick="managmentScheduleEvent()">
        </div>

    </header>
    <main id="main">
        <div id="mainContainerDiv"></div>
    </main>
    
<body>
    <script>
       var jsMemberList=<%=departMemberList%>
       var managmentName="<%=userName%>";
       var resultDiv=document.getElementById("mainContainerDiv")
       var memberNameCount=0;

       document.getElementById("headerLeftDivName").innerHTML=managmentName;

       for(var index=0; index<jsMemberList.length;index++){
           var newDiv=document.createElement("div");
           newDiv.setAttribute("id", memberNameCount);
           newDiv.setAttribute("class","memberNameDiv")
           resultDiv.appendChild(newDiv); 
           newDiv.innerHTML=jsMemberList[index][2];
           newDiv.addEventListener("click", function(){selectMemberNameEvent(this.id)});//배열에 마지막 값만 넣어 진다. 그래서 
           memberNameCount++;
        }

        console.log("<%=userName%>")

        function selectMemberNameEvent(index){
            var reusltMain=document.getElementById("main");

            var newForm=document.createElement("form");
            newForm.setAttribute("action","memberSchedulePage.jsp");
            newForm.setAttribute("method","post");
            reusltMain.appendChild(newForm);

            var newInputId=document.createElement("input");
            newInputId.setAttribute("type","hidden");
            newInputId.setAttribute("name","teamMemberId");
            newInputId.setAttribute("value",jsMemberList[index][0]);//userId를 값으로 넘겨 줄것이다. 
            newForm.appendChild(newInputId);
            
            var newInputPw=document.createElement("input");
            newInputPw.setAttribute("type","hidden");
            newInputPw.setAttribute("name","teamMemberPw");
            newInputPw.setAttribute("value",jsMemberList[index][1]);//userId를 값으로 넘겨 줄것이다. 
            newForm.appendChild(newInputPw);

            newForm.submit();       
        }

        //관리자 일정으로 가기 이벤트 
        function managmentScheduleEvent(){
            location.href="scheduleManagement.jsp";
        }
    </script>

</body>
</html>