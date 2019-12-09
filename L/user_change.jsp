<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<meta charset="UTF-8">
<!DOCTYPE html>
<html>
<style>
    table {
        width: 100%;
        border: 1px solid #444444;
        border-collapse: collapse;
    }

    th,
    td {
        border: 1px solid #444444;
    }
</style>

<body>
    <h2>회원 정보 수정</h2>
    <script>
        var Request = function () {
            this.getParameter = function (name) {
                var rtnval = '';
                var nowAddress = unescape(location.href);
                var parameters = (nowAddress.slice(nowAddress.indexOf('?') + 1,
                    nowAddress.length)).split('&');
                for (var i = 0; i < parameters.length; i++) {
                    var varName = parameters[i].split('=')[0];
                    if (varName.toUpperCase() == name.toUpperCase()) {
                        rtnval = parameters[i].split('=')[1];
                        break;
                    }
                }
                return rtnval;
            }
        }
        
        var request = new Request();

        var id = request.getParameter('id');

        var s = '[{"id": "hh", "name":"Hong","sub_date":"19.02.11", "grade": "professor", "prof_ok":"19.02.11", "last_login":"19.8.16", "pw":"qwer1234"},'
            + '{"id": "kk", "name":"Kim","sub_date":"19.02.12", "grade": "student", "prof_ok":"none", "last_login":"19.5.12", "pw":"qwer1234"},'
            + '{"id": "pp", "name":"Park","sub_date":"19.01.11", "grade": "admin", "prof_ok":"none", "last_login":"19.11.25", "pw":"qwer1234"},'
            + '{"id": "nop", "name":"Nooop","sub_date":"19.08.11", "grade": "professor", "prof_ok":"none", "last_login":"19.11.25", "pw":"qwer1234"}]';

        var user_list = JSON.parse(s);
        var row = Number(user_list.length);
        for (i = 0; i < row; i++) {
            if(user_list[i].id == id){
                break;
            }
        }
        document.write("<form name = \'f\'>")
        document.write("<table><tr><td>아이디</td><td>" + user_list[i].id+"</td></tr>");
        document.write("<tr><td>이름</td><td><input type=\'text\' name=\'nm\' value=\'"+user_list[i].name+"\'></td></tr>");
        document.write("<tr><td>등급</td><td>");
        if(user_list[i].grade == 'professor'){
            document.write(user_list[i].grade);
            if(user_list[i].prof_ok == 'none'){
                document.write("(미승인) ");
                document.write("<input type = \"button\" onclick='\profRequest()\' value = \'승인\'>");
            }
        } else{
            document.write(user_list[i].grade);
        }
        document.write("</td></tr>");
        document.write("<tr><td>비밀번호</td><td><input type=\'password\' name=\'pw\' value=\'"+user_list[i].pw + "\'></td></tr>");
        document.write("<tr><td>비밀번호 확인</td><td><input type=\'password\' name=\'pw2\'></td></tr>");    
        document.write("</table>");
        
        document.write("</form>");  
        document.write("<button onclick=\'checkForm()\'>수정</button>");
        function checkForm(){
            form = document.f;
            if(form.nm.value==""){
                alert("이름을 입력하세요");
                form.nm.focus();
                return;
            }
            if(form.pw.value==""){
                alert("암호를 입력하세요");
                form.pw.focus();
                return;
            }
            if(form.pw.value!=form.pw2.value){
                alert("암호가 일치하지 않습니다");
                form.pw.focus();
                return;
            }
            location.href="user_detail.html?id="+id;
        }
        function profRequest(){
            alert("승인되었습니다.");
        }
    </script>

</body>

</html>