<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC" , "root", "3br3br");

String id=request.getParameter("id");
String pw=request.getParameter("pw");
String name=request.getParameter("name");
String grade=request.getParameter("grade");

out.println(id);
out.println(pw);

Statement stmt=conn.createStatement();

String query="insert into user_data values(";
query+="'"+id+"',";
query+="'"+pw+"',";
query+="'"+grade+"',";
query+="'"+name+"')";

stmt.executeUpdate(query);
stmt.close();
conn.close();
%>
<html>
가입 완료되었습니다.<br> 3초 후 자동으로 로그인 화면으로 이동합니다.
<meta http-equiv="refresh" content="3;URL='login.jsp'">

</html>