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
        var t = '[{"name":"test1", "madeby":"Hong", "date":"19.02.12~19.05.12", "time": "12", "info":"12/50", "avg": "92"},'
        +'{"name":"test2", "madeby":"Hong", "date":"19.02.12~19.04.12", "time": "11", "info":"23/50", "avg": "88"}]';

        var test_list = JSON.parse(t);
        var row = Number(test_list.length);
        document.write("<button onclick=\'sortTable()\'>정렬</button>");
        document.write("<form onsubmit=\"checkDelete();\"><table name = \'tab\'><tr><td></td><td>name</td><td>madeby</td><td>date</td><td>time</td><td>info</td><td>avg</td></tr>");
        for (i = 0; i < row; i++) {
            document.write("<tr>");
            document.write("<td><input type=\"checkbox\" name=\"delete_list\" value=\"" + i + "\"></td>");
            document.write("<td>" + test_list[i].name + "</td>");
            document.write("<td>" + test_list[i].madeby + "</td>");
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
        function sortTable(){
            var table = document.getElementsByTagName('table');
            var rows = table[0].rows;
            for(var i=1;i<(rows.length-1);i++){
                for(var j=i;j<(rows.length-1);j++){
                    var fCell = rows[j].cells[4];
                    var sCell = rows[j+1].cells[4]; 
                    if(Number(fCell.innerHTML) > Number(sCell.innerHTML)){
                        rows[j].parentNode.insertBefore(rows[j+1], rows[j]);
                    }
                }
            }   
        }
        function searchProf(test_list, sub_string){
            var table = document.getElementsByTagName('table');
            var rows = talbe[0].rows;
            for(var i=table.rows.lenth-1;i>=1;i--){
                table.deleteRow(i);
            }
            for(var i=0;i<Number(test_list.length)){

            }
        }
    </script>

</body>

</html>