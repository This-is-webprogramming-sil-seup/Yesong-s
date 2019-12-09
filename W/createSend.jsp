<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");

String test_name = request.getParameter("test_name");
String date1 = request.getParameter("date1");
String date2 = request.getParameter("date2");
String time = request.getParameter("time");
String auto = request.getParameter("auto");
if (auto == null) auto = request.getParameter("manual");

Statement stmt = conn.createStatement();

String query = "insert into test_data values(";
query += "'" + Integer.toString(1) + "',";  // Test_id
query += "'" + test_name + "',";
query += "'" + Integer.toString(1) + "',";  // Professor ID
query += "'" + time + "',";
query += "'" + date1 + "',";
query += "'" + date2 + "',";
query += "'" + Integer.toString(1) + "',";  // Birthday
query += "'" + auto + "')";

stmt.executeUpdate(query);
stmt.close();
conn.close();
%>
<html>
<meta http-equiv="refresh" content="3;URL='professor.html'">

</html>