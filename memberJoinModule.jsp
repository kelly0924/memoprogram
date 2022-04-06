<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String name=request.getParameter("userName");
    String id=request.getParameter("userId");
    String usPw=request.getParameter("userPw");
    String department=request.getParameter("Departments");
    String ranks=request.getParameter("ranks");
    String uwrite=request.getParameter("usDate");
    boolean inputCheck=false;
    int dpNum=0;
    if(department.equals("Accounting")){
        dpNum=1;
    }else if(department.equals("Development")){
        dpNum=2;
    }else if(department.equals("Education")){
        dpNum=3;
    }
    int raNum=0;
    if(ranks.equals("CEO")){
        raNum=1;
    }else if(ranks.equals("TeamLeader")){
        raNum=2;
    }else if(ranks.equals("Teammember")){
        raNum=3;
    }

    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduleDB", "schedule","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호

    if(name.equals("")||id.equals("")||usPw.equals("")||department.equals("")||ranks.equals("")){
        inputCheck=true;

    }else{
       String sql="INSERT INTO userImpormation (userId,userName,userPw,userDepartment,userRanks,userDate) VALUES(?,?,?,?,?,?)";
       PreparedStatement query =connect.prepareStatement(sql);
       query.setString(1,id);
       query.setString(2,name);
       query.setString(3,usPw);    
       query.setInt(4,dpNum);
       query.setInt(5,raNum);
       query.setString(6,uwrite);
       query.executeUpdate();
       response.sendRedirect("logPage.jsp");
    }
   
%>


<script>
    if(<%=inputCheck%> == true){
        alert("정보를 모두 입력 하세요");
        location.href="memberJoinPage.jsp";
    }
    console.log("<%=dpNum%>","<%=raNum%>")
</script>

