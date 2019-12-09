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
        text-align: center;
    }

    tr,
    td {
        border: 1px solid #444444;
    }
    tr{
        background: #fff;
    }
    tr:hover{
        background: #ddd;
    }
    #back{
        border-radius: 20px;
        padding:25px;
        background-color: white;
    }
    th {
        background-color: #AAAAAA;
        border: 1px solid #444444;
    }
    p{
        text-align: right;
    }
    .left-box {
    float: left;
    /* width: 50%; */
    }
    .right-box {
    float: right;
    /* width: 50%; */
    }
    #btn{
        border: 1px solid #00b4ab; 
        background-color: rgba(0,0,0,0); 
        color:#00b4ab; 
        padding: 5px;

    }
    #btn1{
        border: 1px solid #00b4ab; 
        background-color: rgba(0,0,0,0); 
        color: #00b4ab; 
        padding: 5px;
        border-top-left-radius: 5px; 
        border-bottom-left-radius: 5px;
    }
    #btn2{
        border: 1px solid #00b4ab; 
        background-color: rgba(0,0,0,0); 
        color: #00b4ab; 
        padding: 5px;
        border-top-right-radius: 5px; 
        border-bottom-right-radius: 5px;
    }
    #btn:hover{
        color:white; 
        background-color: #00b4ab;
    }
    #btn1:hover{
        color:white; 
        background-color: #00b4ab;
    }
    #btn2:hover{
        color:white; 
        background-color: #00b4ab;
    }
    #btn3{
        border: 1px solid #00b4ab; 
        background-color: rgba(0,0,0,0); 
        color: #00b4ab; 
        padding: 5px;
        border-top-left-radius: 5px; 
        border-bottom-left-radius: 5px;
        border-top-right-radius: 5px; 
        border-bottom-right-radius: 5px;
    }
    #btn3:hover{
        color:white; 
        background-color: #00b4ab;
    }
</style>


<body bgcolor = #dadada>
    <div id = 'back'>
    <script>
    var s = "[";
        <%
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");
        String query = "SELECT * FROM test_data";
        query+=";";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        
        while (rs.next()) {%>
            var tmp="<%=rs.getString("birthday")%>";
            tmp=tmp.substring(0,10);
            
            s+='{"name": "<%=rs.getString("test_name")%>",';
            s += '"madeby":"<%=rs.getString("Professor_id")%>",';
            s += '"date": "<%=rs.getString("test_start_period")%>~<%=rs.getString("test_end_period")%>"';
            s += ',"made_date":"'+tmp+'",';
            s += '"time": "<%=rs.getString("test_start_time")%>",';
            s+='"info":"12/50", "avg": "92",';
            s+='"student":[{"name" : "kk", "didit": "yes"}]'+'},';
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
        var search = request.getParameter('search');

        document.write("<div class='left-box'>");
        document.write("<button id = 'btn1' onclick=\'sortTableDate(1)\'>응시기간 오름차순</button>");
        document.write("<button id = 'btn' onclick=\'sortTableDate(2)\'>응시기간 내림차순</button>");
        document.write("<button id = 'btn' onclick=\'sortTableMadeDate(1)\'>생성일시 오름차순</button>");
        document.write("<button id = 'btn2' onclick=\'sortTableMadeDate(2)\'>생성일시 내림차순</button></div>");
        document.write("<div class='right-box'>");
        document.write("<input type=\'text\' id=\'search\' value = "+search+">");
        document.write(" <button id = 'btn3' onclick=\'searchTable()\'>검색</button></div>")
        
        document.write("</br></br><form onsubmit=\"checkDelete();\"><table name = \'tab\'><tr><th>name</th><th>madeby</th><th>made date</th><th>date</th><th>time</th><th>info</th><th>avg</th><th></th></tr>");
        var test_list = JSON.parse(s);
        var row = Number(test_list.length);
        if(search == ""){
            for (i = 0; i < row; i++) {
                var id = test_list[i].name;
                var test_student = test_list[i].student;
                var sum = 0;
                var num = 0;
                for(j=0;j<Number(test_student.length);j++){
                    if(test_student[j].didit=="yes"){
                        sum = sum + Number(test_student[j].score);
                        num = num + 1;
                    }
                }
                var avg = 0;
                if(num!=0) avg = sum / num;
                document.write("<tr>");
            
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].name + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].madeby + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].made_date + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].date + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].time + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + num + "/" + Number(test_student.length) + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + avg + "</td>");
                document.write("<td><input type=\"checkbox\" name=\"delete_list\" value=\"" + i + "\"></td>");
                document.write("</tr>");
            }
        }
        else{
            for (i = 0; i < row; i++) {
                var id = test_list[i].name;
                var isInList = 0;
                if(test_list[i].madeby == search) isInList = 1;
                var test_student = test_list[i].student;
                var sum = 0;
                var num = 0;
                for(j=0;j<Number(test_student.length);j++){
                    if(test_student[j].didit=="yes"){
                        if(test_student[j].name == search) isInList = 1;
                        sum = sum + Number(test_student[j].score);
                        num = num + 1;
                    }
                }
                if(isInList == 0){
                    continue;
                }
                var avg = 0;
                if(num!=0) avg = sum / num;
                document.write("<tr>");
            
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].name + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].madeby + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].made_date + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].date + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + test_list[i].time + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + num + "/" + Number(test_student.length) + "</td>");
                document.write("<td onclick=\"clickTr(\'"+id+"\')\">" + avg + "</td>");
                document.write("<td><input type=\"checkbox\" name=\"delete_list\" value=\"" + i + "\"></td>");
                document.write("</tr>");
            }
        }
        document.write("</table>");
        document.write("<input type=\"submit\" value=\"삭제\"/>");
        document.write("</form>");
        function checkDelete() {
            var chk_obj = document.getElementsByName("delete_list");
            var chk_leng = chk_obj.length;
            var checked = 0;

            for (i = 0; i < chk_leng; i++) {
                if (chk_obj[i].checked == true) {
                    checked += 1;
                    alert(test_list[Number(chk_obj[i].value)].name);
                }
            }
        }
        function sortTable() {
            var table = document.getElementsByTagName('table');
            var rows = table[0].rows;
            for (var i = 1; i < (rows.length - 1); i++) {
                for (var j = i; j < (rows.length - 1); j++) {
                    var fCell = rows[j].cells[4];
                    var sCell = rows[j + 1].cells[4];
                    if (Number(fCell.innerHTML) > Number(sCell.innerHTML)) {
                        rows[j].parentNode.insertBefore(rows[j + 1], rows[j]);
                    }
                }
            }
        }
        function sortTableDate(type) {
            var table = document.getElementsByTagName('table');
            var rows = table[0].rows;
            for (var i = 1; i < (rows.length - 1); i++) {
                for (var j = i; j < (rows.length - 1); j++) {
                    var fCell = rows[j].cells[4];
                    var sCell = rows[j + 1].cells[4];
                    if (type == 1) {
                        if (fCell.innerHTML > sCell.innerHTML) {
                            rows[j].parentNode.insertBefore(rows[j + 1], rows[j]);
                        }
                    } else {
                        if(fCell.innerHTML < sCell.innerHTML){
                            rows[j].parentNode.insertBefore(rows[j+1], rows[j]);
                        }
                    }

                }
            }
        }
        function sortTableMadeDate(type){
            var table = document.getElementsByTagName('table');
            var rows = table[0].rows;
            for (var i = 1; i < (rows.length - 1); i++) {
                for (var j = i; j < (rows.length - 1); j++) {
                    var fCell = rows[j].cells[3];
                    var sCell = rows[j + 1].cells[3];
                    if (type == 1) {
                        if (fCell.innerHTML > sCell.innerHTML) {
                            rows[j].parentNode.insertBefore(rows[j + 1], rows[j]);
                        }
                    } else {
                        if(fCell.innerHTML < sCell.innerHTML){
                            rows[j].parentNode.insertBefore(rows[j+1], rows[j]);
                        }
                    }

                }
            }
        }
        function searchTable(){
            var searchName = document.getElementById('search').value;
            if(searchName == ""){
                alert("검색어를 입력해주세요");
                return;
            }
            location.href="test_list.html?search="+searchName;
        }
        function clickTr(id){
            location.href="test_detail.html?id="+id;
        }
    </script>
    </div>
</body>

</html>