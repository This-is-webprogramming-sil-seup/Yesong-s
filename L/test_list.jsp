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

        var test_list = JSON.parse(s);
        var row = Number(test_list.length);
        document.write("<button onclick=\'sortTableDate(1)\'>응시기간 오름차순</button>");
        document.write("<button onclick=\'sortTableDate(2)\'>응시기간 내림차순</button>");
        document.write("<button onclick=\'sortTableDate(1)\'>생성일시 오름차순</button>");
        document.write("<button onclick=\'sortTableDate(2)\'>생성일시 내림차순</button>");
        document.write("<form onsubmit=\"checkDelete();\"><table name = \'tab\'><tr><td></td><td>name</td><td>madeby</td><td>made date</td><td>date</td><td>time</td><td>info</td><td>avg</td></tr>");
        for (i = 0; i < row; i++) {
            var test_student = test_list[i].student;
            for(j=0;j<Number(test_student.length);j++){
                
            }
            document.write("<tr>");
            document.write("<td><input type=\"checkbox\" name=\"delete_list\" value=\"" + i + "\"></td>");
            document.write("<td>" + test_list[i].name + "</td>");
            document.write("<td>" + test_list[i].madeby + "</td>");
            document.write("<td>" + test_list[i].made_date + "</td>");
            document.write("<td>" + test_list[i].date + "</td>");
            document.write("<td>" + test_list[i].time + "</td>");
            document.write("<td>" + test_list[i].info + "</td>");
            document.write("<td>" + test_list[i].avg + "</td>");
            document.write("</tr>");
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
        // function searchProf(test_list){
        //     var table = document.getElementsByTagName('table');
        //     var rows = talbe[0].rows;
        //     for(var i=table.rows.lenth-1;i>=1;i--){
        //         table.deleteRow(i);
        //     }
        //     for(var i=0;i<Number(test_list.length)){

        //     }
        // }
    </script>
</body>

</html>