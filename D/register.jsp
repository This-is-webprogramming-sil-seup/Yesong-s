<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<meta charset="utf-8">

<head>
<style>
  body { background-color: #DADADA; text-align: center; }
    .register_btn {
      margin-top: 10px;
      width: 450px;
      height: 45px;
      border: none;
      border-radius: 5px;
      background-color: #00b4ab;
      color: white;
      font-size: 15px;
      font-weight: bold;
    }
    #registerName {
      width: 450px;
      height: 30px;
      color: gray;
      margin-top: 10px;
    }
    #registerID {
      width: 374px;
      height: 30px;
      color: gray;
      margin-top: 10px;
    }
    #dup_id {
      width: 70px;
      height: 30px;
      border: none;
      border-radius: 5px;
      background-color: #00b4ab;
      color: white;
      font-size: 10px;
      font-weight: bold;
    }
    #registerPW {
      width: 450px;
      height: 30px;
      color: gray;
      margin-top: 10px;
    }
    #registerRePW {
      width: 450px;
      height: 30px;
      color: gray;
      margin-top: 10px;
    }
    #chk_info1 {
      margin-top: 15px;
    }
    #reset_write {
      width: 80px;
      height: 30px;
      margin-top: 10px;
      margin-right: 5px;
      margin-bottom: 10px;
      border: none;
      border-radius: 5px;
      background-color: #6e6e6e;
      color: white;
      font-weight: bold;
    } 
    #back {
      width: 75px;
      height: 30px;
      margin-top: 10px;
      margin-left: 5px;
      margin-bottom: 10px;
      border: none;
      border-radius: 5px;
      background-color: #6e6e6e;
      color: white;
      font-weight: bold;
    }
    #here:hover {
      color: red;
    }
</style>
</head>

<body>
  <%
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");
    Statement stmt=conn.createStatement();
    ResultSet rs=stmt.executeQuery("SELECT * from user_data");

    ArrayList<String> ids=new ArrayList<String>();

    while(rs.next()){
      ids.add(rs.getString("user_id"));
    }
  %>
  <h1 style="font-weight:bold; color: #00b4ab;"> 회원가입 페이지 </h1>
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

    }
    function id_check() {
      var ids = [ <% for (int i = 0; i < ids.size(); i++) { %> "<%= ids.get(i) %>" <%= i < ids.size() - 1 ? "," : "" %> <% } %>];
      var id = document.getElementById("registerID");

      // ID duplication check
      if (ids.indexOf(id.value) != -1) {
        alert("중복된 아이디입니다.");
        id.value = "";
      }
    }
  </script>
  <form action="registerCheck.jsp" method="post">
  <table style="text-align: center; margin: 0 auto;">
      <tr style="background-color:white;"><td style="width:500px; border-radius:5px;">
      <label> <input type="text" id="registerName" name="name" placeholder="이름"/></label><br>
      <label> <input type="text" id="registerID" name="id" placeholder="아이디" />
      <input type="button" id="dup_id" name="check_dup" value="중복체크" onclick="id_check()"/> </label><br>
      <label> <input type="password" id="registerPW" name="pw" placeholder="비밀번호" /></label><br>
      <label> <input type="password" id="registerRePW" placeholder="비밀번호 확인" /></label><br>
      <label style="font-size:14px; color: #505050;"> <b>등급<b> :&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      <input type="radio" id="chk_info1" name="grade1" value="professor"/> 교수자
      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      <input type="radio" id="chk_info2" name="grade2" value="student"/> 학습자 </a> </label><br>
      <input type ="submit" class="register_btn" name="register" value="회원가입" onclick="info_check()" />
      &nbsp<input type ="reset" id="reset_write" value="다시 작성"/>
      &nbsp<input type="button" name="cancel" value="취소" onclick="location.href='login.jsp'" />
  </form>
  <table style="margin: 0 auto; margin-top:10px;">
    <tr style="background-color:white;"><td style="width:483px; border-radius:5px; padding:10px; font-size:13px;">
    로그인 할 계정이 있다면 <a id="here" href="login.html"> 여기</a>를 눌러주세요.
    </td></tr>
  </table>
</body>

</html>
