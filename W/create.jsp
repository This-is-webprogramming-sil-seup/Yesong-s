<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<meta charset="utf-8">
<html>

<head>
    <title>시험 생성</title>
    <h2>시험 생성</h2>
</head>

<body>
    <form name="frm">
        시험명:<input type="text" id="name" name="test_name" required><br>
        응시기간:<input type="date" id="date1" name="date1">~<input type="date" id="date2" name="date2" required><br>
        응시시간:<input type="number" id="time" name="time" required><br>
        채점방식:
        <input type="radio" name="auto" id="auto" value="auto" required>자동
        <input type="radio" name="manual" id="manual" value="manual">수동<br>

        <h4>문제</h4>
        <input type="button" id="shortAnswer" value="short" onclick="makeShortAnswer()">
        <input type="button" id="multipleChoice" value="choice" onclick="makeMultiple()">

        <div id="questionList"></div>

    </form>



    <input type="submit" value="저장" onclick="save()">
    <input type="button" value="취소" onclick="goBack()">


    <script>
        var cnt = 0;

        function makeShortAnswer() {
            cnt += 1;
            var body = document.getElementById("questionList");
            body.innerHTML += cnt + "번<br>";
            body.innerHTML += "<div>문제 : " + "<input type='text' id='question'><br>답  : " + "<input type='text' id='answer'><br>배점 : " + "<input type='text' id='score'><br><br></div>";
        }

        function makeMultiple() {
            cnt += 1;
            var body = document.getElementById("questionList");
            body.innerHTML += cnt + "번<br>";
            body.innerHTML += "<div>문제 : " + "<input type='text' id='question'><br>보기개수 : <select id='exNum' name='exampleNum'><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select><br>보기<br>1번:<input type='text' id='num1'><br>2번:<input type='text' id='num2'><br>3번:<input type='text' id='num3'><br>4번:<input type='text' id='num4'><br>5번:<input type='text' id='num5'><br>답  : " + "<input type='text' id='answer'><br>배점 : " + "<input type='text' id='score'><br><br></div>";
        }


        function goBack() {
            window.history.back();
        }

        function save() {
            // 빈칸 검사
            var excnt = 0;
            if (document.getElementById("num1").value != "") {
                excnt += 1;
            }
            if (document.getElementById("num2").value != "") {
                excnt += 1;
            }
            if (document.getElementById("num3").value != "") {
                excnt += 1;
            }
            if (document.getElementById("num4").value != "") {
                excnt += 1;
            }
            if (document.getElementById("num5").value != "") {
                excnt += 1;
            }

            if (document.getElementById("name").value == "") {
                alert("필수란을 입력해주세요");
            }
            else if (document.getElementById("date1").value == "") {
                alert("필수란을 입력해주세요");
            }
            else if (document.getElementById("date2").value == "") {
                alert("필수란을 입력해주세요");
            }
            else if (document.getElementById("time").value == "") {
                alert("필수란을 입력해주세요");
            }
            else if (document.getElementsByName("auto").value == "") {
                alert("필수란을 입력해주세요");
            }
            else if (document.getElementById("question").value == "") {
                alert("문제 정보를 알맞게 입력해주세요");
            }
            else if (document.getElementById("exNum").value != excnt) {
                alert("보기 개수를 맞춰주세요");
            }
            else {
                /* If not work, make new jsp file
                <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");

                String test_name = request.getParameter("test_name");
                String date1 = request.getParameter("date1");
                String date2 = request.getParameter("date2");
                String time=request.getParameter("time");
                String auto=request.getParameter("auto");
                if(auto==null) auto=request.getParameter("manual");

                Statement stmt = conn.createStatement();

                String query = "insert into test_data values(";
                query += "'" + Integer.toString(1) + "',";  // Test_id
                query += "'" + test_name + "',";
                query += "'" + Integer.toString(1) + "',";  // Professor ID
                query += "'" + time + "',";
                query += "'" + date1 + "',";
                query += "'" + date2 + "',";
                query += "'" + Integer.toString(1) + "',";  // Birthday
                query += "'" + auto + "')";

                stmt.executeUpdate(query);
                stmt.close();
                conn.close();
                %>
                */
                window.history.back();
            }
        }
    </script>
</body>

</html>