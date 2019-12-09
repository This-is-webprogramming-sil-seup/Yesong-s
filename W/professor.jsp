<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<meta charset="UTF-8" />
<html>

<head>
    <title>교수자 정보</title>

    <h2>시험목록</h2>

    <style>
        #info_table{
                border-collapse: collapse;
                border:1px solid black;
            }

            th, td{
                border:1px solid black;
            }
        </style>

</head>


<body onload="init()">
    <table id="info_table">
        <thead>
            <th></th>
            <th>시험명</th>
            <th>생성일</th>
            <th>응시기간</th>
            <th>응시시간</th>
            <th>응시인원/전체인원</th>
            <th>평균</th>
        </thead>
        <tbody id="testlist"></tbody>
    </table>
    <% String name=request.getParameter("name");%>
    <input type="button" id="create" value="시험생성" onclick="location.href='create.html?name=<%=name%>'" <input type="button"
        id="delete" value="삭제" onclick="delete_row()">
    <input type="button" id="copy" value="복사" onclick="copy_row()">


    <script>
        function init() {
            var s = '[{"name": "나의 기분","make":"2019-12-05","duration": 7,"time": 2,"auto": "false","applicantsInfo": [{"done":10,"total":30,"list":[{}]}],"average": 78,},{"name": "하기 싫다","make":"2019-12-07","duration": 3,"time": 1,"auto": "true","applicantsInfo": [{"done":30,"total":41,"list":[{}]}],"average": 100}]';
            var tests = eval("(" + s + ")");
            var length = Object.keys(tests).length;

            for (var i = 0; i < length; i++) {
                add_row(i, tests);
            }
        }

        function add_row(i, tests) {
            var table_body = document.getElementById('testlist');
            var row = table_body.insertRow(table_body.rows.length);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);

            cell1.innerHTML = "<input type='checkbox'/>";
            cell2.innerHTML = tests[i].name;
            cell3.innerHTML = tests[i].make;
            cell4.innerHTML = tests[i].duration;
            cell5.innerHTML = tests[i].time;
            cell6.innerHTML = tests[i].applicantsInfo[0].done + "/" + tests[i].applicantsInfo[0].total;
            cell7.innerHTML = tests[i].average;
            cell8.innerHTML = "<input type='button' value='상세정보' onclick=\"location.href='testdetail.html?" + tests[i].name + "'\"/>";
        }

        function delete_row() {
            // json 파일에서 해당 정보 삭제하는 함수
            // 아래의 임시 코드는 json 수정하면 지울 것

            var table = document.getElementById('info_table');
            for (var i = 1; i < table.rows.length; i++) {
                if (document.getElementsByTagName("tr")[i].cells[0].firstChild.checked) {
                    table.deleteRow(i);
                    document.getElementsByTagName("tr")[i].cells[0].firstChild.checked = false;
                }
            }
        }

        function copy_row() {
            // json 파일에 내용 복사하는 함수
            // 아래의 임시 코드는 json 수정하면 지울 것
            var table = document.getElementById('info_table');
            for (var i = 1; i < table.rows.length; i++) {
                if (document.getElementsByTagName("tr")[i].cells[0].firstChild.checked) {
                    document.getElementsByTagName("tr")[i].cells[0].firstChild.checked = false;
                }
            }
        }

        function sorting() {

        }

    </script>

</body>

</html>