<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<meta charset="UTF-8" />
<html>
<head>
<style>
    body { background-color: #DADADA; text-align: center; }
    .login_btn {
      width: 450px;
      height: 45px;
      border: none;
      border-radius: 5px;
      background-color: #00b4ab;
      color: white;
      font-size: 15px;
      font-weight: bold;
    }
    #loginID {
      width: 450px;
      height: 30px;
      color: gray;
    }
    #loginPW {
      width: 450px;
      height: 30px;
      color: gray;
      margin-top: 10px;
    }
    #remain {
      color: #00b4ab;
      margin-top: 15px;
      margin-bottom: 15px;
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
      ArrayList<String> pws=new ArrayList<String>();
      ArrayList<String> grades=new ArrayList<String>();
  
      while(rs.next()){
        ids.add(rs.getString("user_id"));
        pws.add(rs.getString("user_pw"));
        grades.add(rs.getString("user_grade"));
      }
    %>
  <h1 style="font-weight:bold; color: #00b4ab;"> 로그인 페이지 </h1>
  <p><span id="UserInfo"></span></p>
  <script>
    function setCookie(name, value, expiredays) { //쿠키 저장함수
      var todayDate = new Date();
      todayDate.setDate(todayDate.getDate() + expiredays);
      document.cookie = name + "=" + escape(value) + "; path=/; expires="
        + todayDate.toGMTString() + ";"
    }
    function getCookie(Name) { // 쿠키 불러오는 함수
      var search = Name + "=";
      if (document.cookie.length > 0) { // if there are any cookies
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // if cookie exists
          offset += search.length; // set index of beginning of value
          end = document.cookie.indexOf(";", offset); // set index of end of cookie value
          if (end == -1)
            end = document.cookie.length;
          return unescape(document.cookie.substring(offset, end));
        }
      }
    }

    function login() {
      var ids = [ <% for (int i = 0; i < ids.size(); i++) { %> "<%= ids.get(i) %>" <%= i < ids.size() - 1 ? "," : "" %> <% } %>];
      var pws = [ <% for (int j = 0; j < pws.size(); j++) { %> "<%= pws.get(j) %>" <%= j < pws.size() - 1 ? "," : "" %> <% } %>];
      var grades = [ <% for (int k = 0; k < pws.size(); k++) { %> "<%= grades.get(k) %>" <%= k < grades.size() - 1 ? "," : "" %> <% } %>];

      var objLoginID = document.getElementById("loginID");
      var objLoginPW = document.getElementById("loginPW");

      if (objLoginID.value == "") {
        alert("아이디를 입력하세요");
        objLoginID.focus();
        return;
      }
      else if (objLoginPW.value == "") {
        alert("비밀번호를 입력하세요");
        objLoginPW.focus();
        return;
      }

      if (document.getElementById("remain").checked == true) { //아이디 저장을 체크했을 때
        setCookie("id", objLoginID, 7); //쿠키이름을 id로 아이디 입력 필드값을 7일동안 저장
      }
      else { //아이디 저장을 체크하지 않았을 때
        setCookie("id", objLoginID, 0); //날짜를 0으로 저장하여 쿠키 삭제
      }

      var tmp = ids.indexOf(objLoginID.value);
      if (tmp == -1) {
        window.alert("존재하지 않는 ID입니다.");
        objLoginID.value = "";
        objLoginPW.value = "";
      } else if (pws[tmp] != objLoginPW.value) {
        window.alert("ID나 비밀번호가 틀렸습니다.");
        objLoginID.value = "";
        objLoginPW.value = "";
      } else {
        if (grades[tmp] == "professor") {
          location.href = '../W/professor.jsp?name=' + objLoginID.value;
        }
        else {
          location.href = 'user_main.html';
        }
      }
    }
  </script>

  <form method="POST" action="">
      <table style="margin: 0 auto;">
      <tr style="background-color:white;"><td style="width:500px; border-radius:5px;">
      <br>
      <label><input type="text" id="loginID" placeholder="아이디" /></label><br>
      <label><input type="password" id="loginPW" placeholder="비밀번호" /></label><br>
      <input type="checkbox" id="remain"/><a style="font-size:12px; font-weight:bold; color: gray;">아이디 저장</a>
      <br><input class="login_btn" type ="submit" value="로그인" onclick="login();return false" /> <br>
      <br><br>
      </td></tr>
      </table>
  </form>
  <table style="margin: 0 auto; margin-top:10px;">
  <tr style="background-color:white;"><td style="width:483px; border-radius:5px; padding:10px; font-size:13px;">
  로그인 할 계정이 없다면 <a id="here" href="register.jsp"> 여기</a>를 눌러주세요.
  </td></tr>
  </table>
</body>
</html>
