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
        h2 {
            color: #00b4ab;
            text-align: center;
        }

        body {
            background-color: #DADADA;
        }

        #info_table {
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
            border: 1px solid gray;
            text-align: center;
        }

        th,
        td {
            border: 1px solid gray;
        }

        tr{
            height:40px;
        }

        #tag{
            background-color:#DADADA;
        }

        #check{
            width:40px;
        }

        #nametag{
            width:300px;
        }

        #datetag{
            width:100px;
        }

        #durationtag{
            width:250px;
        }

        #timetag{
            width:80px;
        }

        #numtag{
            width:180px;
        }

        #avgtag{
            width:50px;
        }

        #detailtag{
            width:100px;
        }

        #contain {
            border-radius:5px;
            display:table;
            width:1170px;
            margin-left:auto;
            margin-right:auto;
            background-color: white;
            
        }

        #find,#sortingbtn, #DBchange {
            width:500px;
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            text-align: center;
            border-radius:5px;
        }

        .btn{
            background-color:#00b4ab;
            border:0px;
            color:white;
        }

        #create{
            width:200px;
            height:40px;
            font-size:15px;
        }

        #delete, #copy{
            width:100px;
            height:40px;
            font-size:15px;
        }

        #sortbyDate{
            width:125px;
            height:40px;
            font-size:15px;
        }

        #sortbyDuration{
            width:150px;
            height:40px;
            font-size:15px;
        }

        #sortbyAvg{
            width:125px;
            height:40px;
            font-size:15px;
        }

        #detailbtn{
            background:none;
            border:none;
            color:#00b4ab;
        }
    </style>

</head>


<body onload="init()">
    <div id="contain">
        <table id="info_table">
            <br>
            <table id="info_table">
                <tr id="tag">
                    <th id="check"></th>
                    <th id="nametag">시험명</th>
                    <th id="datetag">생성일</th>
                    <th id="durationtag">응시기간</th>
                    <th id="timetag">응시시간</th>
                    <th id="numtag">응시인원/전체인원</th>
                    <th id="avgtag">평균</th>
                    <th id="detailtag">상세정보보기</th>
                </tr>
                <tbody id="testlist"></tbody>
            </table>
            <br>

            <div id="find">
                검색 : <input type="text" id="search">
                <input type="button" id="searchbtn" class="btn" value="검색" onclick="search()"><br>
            </div>

            <br>
    </div>
    <% String name=request.getParameter("name");%>
    <div id="DBchange">
        <br>
        <input type="button" id="create" class="btn" value="시험생성" onclick="location.href='create.jsp?name=<%=name%>'">
        <input type="button" id="delete" class="btn" value="삭제" onclick="delete_row()">
        <input type="button" id="copy" class="btn" value="복사" onclick="copy_row()">
        <br><br>
    </div>

    <br>
    <div id="sortingbtn">
        <br>
        <input type="button" id="sortbyDate" class="btn" value="생성일로 정렬" onclick="sortDate()">
        <input type="button" id="sortbyDuration" class="btn" value="응시기간으로 정렬" onclick="sortDuration()">
        <input type="button" id="sortbyAvg" class="btn" value="평균으로 정렬" onclick="sortAvg()">
        <br><br>
    </div>

    <script>
        var s = "[";
        <%
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");
        String query = "SELECT * FROM test_data where professor_id=";
        query += "'" + name + "';";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {%>
            s+='{"name": "<%=rs.getString("test_name")%>",';
            s += '"make":"<%=rs.getString("Birthday")%>",';
            s += '"duration": "<%=rs.getString("test_start_period")%>~<%=rs.getString("test_end_period")%>"';
            s += ',"time": "<%=rs.getString("test_start_time")%>",';
            s += '"auto": "false",';
            s += '"applicantsInfo": [{"done":10,"total":30,"list":[{}]}],';
            s += '"average": 78,},';
        <%}%>
            s=s.substr(0, s.length - 1);
        s += "]";

        var tests = eval("(" + s + ")");
        var length = Object.keys(tests).length;
        function init() {
            var search = get_search();
            var sorttype = get_type();

            console.log(search);
            console.log(sorttype);
            if(search == null && sorttype == null){
                for (var i = 0; i < length; i++) {
                    add_row(i, tests);
                }
            }
            else if(search != null && sorttype == null){
                for (var i = 0; i < length; i++) {
                    if (tests[i].name == search) {
                        add_row(i, tests);
                    }
                }
            }
            else if(search == null && sorttype != null){
                if(sorttype == "average"){
                    sortbyAvg();
                }
                else if(sorttype == "madedate"){
                    sortbyDate();
                }
                else if(sorttype == "testduration"){
                    sortbyDuration();
                }
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
            cell8.innerHTML = "<input type='button' value='상세정보' id='detailbtn' onclick=\"location.href='testdetail.jsp?name=" + tests[i].name + "'\"/>";
        }

        function get_search(){
            var temp = decodeURI(location.href).split("search=");
            var search = temp[1];
            return search;
        }

        function get_type(){
            var temp = decodeURI(location.href).split("sortType=");
            var type = temp[1];
            return type;
        }

        function delete_row() {
            // json 파일에서 해당 정보 삭제하는 함수

        }

        function copy_row() {
            // json 파일에 내용 복사하는 함수
            // 아래의 임시 코드는 json 수정하면 지울 것

        }

        function sortwithIndex(arr) {
            for (var i = 0; i < arr.length; i++) {
                arr[i] = [arr[i], i];
            }
            arr.sort(function (left, right) {
                return left[0] < right[0] ? -1 : 1;
            });
            var sortIndices = [];
            for (var j = 0; j < arr.length; j++) {
                sortIndices[j] = arr[j][1];
                arr[j] = arr[j][0];
            }
            return sortIndices;
        }

        function sortbyDate() {
            var array = [];
            for (var i = 0; i < length; i++) {
                array.push(tests[i].make);
            }
            var index = sortwithIndex(array);

            var table = document.getElementById('info_table');

            for (var i = 0; i < length; i++) {

                add_row(index[i], tests);
            }
        }

        function sortbyDuration() {
            var array = [];
            for (var i = 0; i < length; i++) {
                array.push(tests[i].duration);
            }
            var index = sortwithIndex(array);

            var table = document.getElementById('info_table');

            for (var i = 0; i < length; i++) {

                add_row(index[i], tests);
            }
        }

        function sortbyAvg() {
            var array = [];
            for (var i = 0; i < length; i++) {
                array.push(tests[i].average);
            }
            var index = sortwithIndex(array);

            var table = document.getElementById('info_table');

            for (var i = 0; i < length; i++) {

                add_row(index[i], tests);
            }
        }

        function search() {
            var s = document.getElementById('search').value;

            if (s == "") {
                alert("검색어를 입력해주세요");
                return;
            }

            location.href="professor.jsp?name=<%=name%>&search="+s;
        }

        function sortAvg() {
            location.href="professor.jsp?name=<%=name%>&sortType=average";
        }
        function sortDate() {
            location.href="professor.jsp?name=<%=name%>&sortType=madedate";
        }
        function sortDuration() {
            location.href="professor.jsp?name=<%=name%>&sortType=testduration";
        }


    </script>

</body>

</html>