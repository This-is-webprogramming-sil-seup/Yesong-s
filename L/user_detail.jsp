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
        border-spacing: 0px;
        width: 100%;
        border: 1px solid #444444;
        border-collapse: collapse;
        border-style: none;
        padding: 0px;
        width: 300px;
    }

    div{
        border-radius: 20px;
        padding:20px;
        text-align: left;
        background-color: white;
    }
    th,
    td {
        border-spacing: 0px;
        padding: 0px;
        border-style: none;
    }
    h2{
        color: #00b4ab;
    }
</style>



<body  bgcolor = #dadada>
    <div>
    <h2>상세 정보</h2>
    
    <script>
        var s="[";
        <%
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");
        String query = "SELECT * FROM user_data";
        query+=";";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        
        rs.next();
        while (rs.next()) {%>
            s+='{"id": "<%=rs.getString("user_id")%>",';
            s += '"name":"<%=rs.getString("user_name")%>",';
            s += '"sub_date": "null",';
            s += '"grade":"<%=rs.getString("user_grade")%>"},';
        <%}%>
            s=s.substr(0, s.length - 1);
        s += "]";
        
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
        
        var user_list = JSON.parse(s);
        var row = Number(user_list.length);
        for (i = 0; i < row; i++) {
            if (user_list[i].id == id) {
                break;
            }
        }
        document.write("<table>")
        document.write("<tr><th>아이디</th><th>" + user_list[i].id + "</th></tr>");
        document.write("<tr><th>이름</th><th>" + user_list[i].name + "</th></tr>");
        document.write("<tr><th>등급</th><th>" + user_list[i].grade + "</th></tr>");
        document.write("<tr><th>가입 일시</th><th>" + user_list[i].sub_date + "</th></tr>");
        if (user_list[i].grade == "professor") {
            if(user_list[i].prof_ok=='none'){
                document.write("<tr><th>승인 여부</th><th>미승인</th></tr>");
            }
            else{
                document.write("<tr><th>승인 여부</th><th>승인</th></tr>");
                document.write("<tr><th>승인 일시</th><th>" + user_list[i].prof_ok + "</th></tr>");
            }
            
        }
        document.write("<tr><th>최종 로그인 정보</th><th>" + user_list[i].last_login + "</th></tr></table>");
        document.write("<form></br><input type=\'button\' value=\'수정\' onclick=\'location.href=\"user_change.jsp?id=" + id + "\"\'</form>");
    </script>
   
    </div>
</body>

</html>