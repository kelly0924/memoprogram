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
    String reUserId="";
    String reMemoContents=request.getParameter("userInptMemo");
    String reDate=request.getParameter("selectDate");
    String reTime=request.getParameter("selectTime");
    String totolTime=reDate + " " + reTime + ":" +"00";
    boolean addMemoUserImpormation=false;

    if(reMemoContents.equals("")||reDate.equals("")||reTime.equals("")){
        addMemoUserImpormation=true;
    }else{
         // boolean logCheck = true;//로그인이 되었는지를 체그 하는 변수 
        if (ck != null) {//쿠키가 비여 있지 않을 경우
            for (Cookie cookies : ck) {
                if (cookies.getName().equals("cookid")){
                    sessionId = cookies.getValue();//세션으로 id를 불러 온다. 
                }
            }
            if(sessionId != null){//생성된 세션이 존재 한다는 뜻 생성된 세션이 존재 하면 
                //userR(String)session.getAttribute("ranks");팀원인지 아닌지를 구분하고 싶어 하였는데 ??? 에로 가 난다? 왜??? 
                reUserId=(String)session.getAttribute("id");//사용자 이름을 가져 오겠다. 
            }
        }else if(sessionId== null){//???
            response.sendRedirect("logPage.jsp");
        }
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
        String sql="INSERT INTO  memo( userId,memoContents,memoWriteDate) VALUES (?,?,?)";
        PreparedStatement query=connect.prepareStatement(sql);
        query.setString(1,reUserId);
        query.setString(2,reMemoContents);
        query.setString(3,totolTime);
        query.executeUpdate();
        response.sendRedirect("scheduleManagement.jsp");
    }
   
%>

<script>
   if(<%=addMemoUserImpormation%> == true){
       alert("추가 날짜, 시간, 내용을 입력 하세요");
       location.href="scheduleManagement.jsp";
   }
</script>