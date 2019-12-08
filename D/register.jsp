<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<meta charset="utf-8">

<head>
</head>

<body>
  <%
    var idArray=new Array();
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webprogramming?serverTimezone=UTC", "root", "3br3br");
    Statement stmt=conn.createStatement();
    ResultSet rs=stmt.executeQuery("SELECT * from user_data");
    while(rs.next()){
    idArray.push(rs.getString("user_id"));
    }
  %>
  <script>
    function info_check() {
      var id = document.getElementById("registerID").value;
      var pw = document.getElementById("registerPW").value;
      var re_pw = document.getElementById("registerRePW").value;
      var name = document.getElementById("registerName").value;

      var pattern1 = /[0-9]/;
      var pattern2 = /[a-zA-Z]/;

      if (id.length == 0) {
        alert("아이디를 입력해주세요"); //have to add ID duplication operation 
        return false;
      }
      else if (pw.length == 0) {
        alert("비밀번호를 입력해주세요");
        return false;
      }
      else if (pw != re_pw) {
        alert("비밀번호가 일치하지 않습니다");
        return false;
      }
      else if (name.length == 0) {
        alert("이름을 입력해주세요");
        return false;
      }
      else if (document.getElementById("chk_info1").checked != true && document.getElementById("chk_info2").checked != true) {
        alert("등급을 선택해주세요");
        return false;
      }

      if (!pattern1.test(pw) || !pattern2.test(pw) || pw.length < 8) {
        alert("문자와 숫자 포함 8글자 이상의 비밀번호를 입력해주세요");
        return false;
      }

      // ID duplication check
    }
  </script>
  <form action="registerCheck.jsp" method="post">
    <label>ID : <input type="text" id="registerID" name="id" />
      <input type="button" name="check_dup" value="중복체크" /> </label><br>
    <label>PW : <input type="password" id="registerPW" name="pw" /></label><br>
    <label>Re-PW : <input type="password" id="registerRePW" /></label><br>
    <label>이름 : <input type="text" id="registerName" name="name" /></label><br>
    <label>등급 : <input type="radio" id="chk_info1" value="professor" name="grade" /> 교수자
      <input type="radio" id="chk_info2" value="student" /> 학습자 </label><br><br>
    <input type="submit" name="register" value="가입" onclick="info_check()" />
    &nbsp<input type="reset" value="다시작성" />
    &nbsp<input type="button" name="cancel" value="취소" onclick="location.href='login.html'" />
  </form>
</body>

</html>