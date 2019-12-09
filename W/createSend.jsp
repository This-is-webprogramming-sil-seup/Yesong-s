<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");

String professor_name=request.getParameter("name");
String test_name = request.getParameter("test_name");
String date1 = request.getParameter("date1");
String date2 = request.getParameter("date2");
String time = request.getParameter("time");
String auto = request.getParameter("auto");
if (auto == null) auto = request.getParameter("manual");

String for_test=request.getParameter("list");
out.println(for_test);

java.util.Date from = new java.util.Date();
java.text.SimpleDateFormat transFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String to = transFormat.format(from);

Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery("SELECT * FROM test_data");
rs.last();
int a=rs.getRow();

String query = "insert into test_data values(";
query += "'" + Integer.toString(a) + "',";
query += "'" + test_name + "',";
query += "'" + professor_name + "',";
query += "'" + time + "',";
query += "'" + date1 + "',";
query += "'" + date2 + "',";
query += "'" + to + "',";  // Birthday
query += "'" + auto + "')";

stmt.executeUpdate(query);
stmt.close();
conn.close();
%>
<html>
<meta http-equiv="refresh" content="5;URL='professor.jsp'">

</html>