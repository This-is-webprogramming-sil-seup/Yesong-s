<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<meta charset="UTF-8">
<html>

<head>
    <title>시험 생성</title>
    <h2>시험 생성</h2>

    <style>
        h2 {
            color: #00b4ab;
            text-align: center;
        }

        h3 {
            color: black;
            padding-left: 30px;
        }

        body {
            background-color: #DADADA;
        }

        #studentList {
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

        tr {
            height: 40px;
        }

        .title {
            background-color: #DADADA;
        }

        #createform,
        #btndiv {
            border-radius: 5px;
            display: table;
            width: 800px;
            margin-left: auto;
            margin-right: auto;
            background-color: white;
        }

        #testinfo {
            display: table;
            margin-left: auto;
            margin-right: auto;
            line-height: 30px;
        }

        #name {
            width: 303px;
        }

        #addbtn,
        #btndiv {
            text-align: center;
        }

        .btn {
            background-color: #00b4ab;
            border: 0px;
            color: white;
            width: 300px;
            height: 40px;
            margin-left: auto;
            margin-right: auto;
        }

        .q {
            border: 1px gray solid;
            width: 500px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 30px;
            padding-top: 20px;
        }

        .t {
            width: 430px;
        }

        #check {
            width: 40px;
        }

        #nametag {
            width: 100px;
        }

        #idtag {
            width: 100px;
        }
    </style>
</head>

<body onload="init()">
    <% String name=request.getParameter("name");%>
    <form name="frm" id="createform" action="createSend.jsp?name=<%=name%>" method="post">
        <h3>시험 정보</h3>
        <div id="testinfo">
            시 험 명&nbsp;&nbsp;: <input type="text" id="name" name="test_name" required><br>
            응시기간 : <input type="date" id="date1" name="date1"> ~ <input type="date" id="date2" name="date2"required><br>
            응시시간 : <input type="number" id="time" name="time" required> 시간<br>
            채점방식 :
            <input type="radio" name="auto" id="auto" name="auto" value="자동" required>자동
            <input type="radio" name="auto" id="manual" name="manual" value="수동">수동<br>
        </div>

        <h3>문제</h3>
        <div id="addbtn">
            <input type="button" class="btn" id="shortAnswer" value="주관식" onclick="makeShortAnswer()">&nbsp;
            <input type="button" class="btn" id="multipleChoice" value="객관식" onclick="makeMultiple()">
        </div>

        <br>

        <div id="questionList"></div>
        <br>

        <h3>응시자 선택</h3>
        <div id="selectStd">
            <table id="studentList">
                <tr id="tag">
                    <th class="title" id="check"></th>
                    <th class="title" id="nametag">이름</th>
                    <th class="title" id="idtag">ID</th>
                </tr>
                <tbody id="list"></tbody>

            </table>
        </div>
        <br>
        

        <br>
        <div id="btndiv">
            <br>
            <input type="submit" class="btn" id="save" value="저장" onclick="save()">&nbsp;
            <input type="button" class="btn" id="cancle" value="취소" onclick="goBack()">
            <br><br>
        </div>
    </form>

    <script>
        var cnt = 0;
        var shortcnt = 0;
        var mulcnt = 0;
        var mul = [];

        var s = '[{"name": "나의 기분","duration": 7,"time": 2,"auto": "false","applicantsInfo": [{"done":10,"total":30,"list":[{}]}],"average": 78,"shortAnswer":[{"question":"내 기분을 맞춰봐!","answer":"하기싫다","points":50,"average":50,"wrongrate":0},{"question":"하기 싫을 땐 어떻게 해야하지","answer":"때려치면된다","points":40,"average":25,"wrongrate":50}],"multipleChoice":[{"question":"가장 급한 과제는?","exampleNum":5,"examples":[{"보기":"컴네"},{"보기":"컴비"},{"보기":"웹프실"},{"보기":"오토마타 공부"},{"보기":"휴학"}],"answer":"5","points":10,"average":50,"wrongrate":0}]},{"name": "하기 싫다","make":"2019-12-07","from":"2019-12-07", "to":"2019-12-15","time": 1,"auto": "true","applicantsInfo": [{"done":0,"total":41,"list":[{}]}],"average": 0,"shortAnswer":[],"multipleChoice":[{"question":"집에 가고 싶다","exampleNum":4,"examples":[{"보기":"살려줘"},{"보기":"배고파"},{"보기":"밥먹고 싶다"},{"보기":"힝힝"}],"answer":"1","points":10,"average":10,"wrongrate":0},{"question":"아랫분도 이미 동의하신 내용","exampleNum":5,"examples":[{"보기":"ㅇㅇ"},{"보기":"ㄴㄴ"},{"보기":"ㄷㄷ"},{"보기":"ㄹㅇ"},{"보기":"ㅇㅎ"}],"answer":"4","points":50,"average":25,"wrongrate":50}]}]';

        var str = '[{"name":"가","id":"ga"},{"name":"나","id":"na"},{"name":"다","id":"da"},{"name":"라","id":"ra"},{"name":"마","id":"ma"},{"name":"바","id":"ba"},{"name":"사","id":"sa"},{"name":"아","id":"aa"},{"name":"자","id":"ja"},{"name":"차","id":"cha"}]';

        var tests = eval("(" + s + ")");
        var students = eval("(" + str + ")");
        var length = Object.keys(tests).length;
        var slen = Object.keys(students).length;
        var name = getName();
        var i = getTestNum(name);

        function init() {
            studentlists();
        }

        function goBack() {
            window.history.back();
        }

        function getName() {
            var temp = decodeURI(location.href).split("?");
            var testName = temp[1];
            return testName;
        }

        function getTestNum(name) {
            for (var i = 0; i < length; i++) {
                if (name == tests[i].name) {
                    return i;
                }
            }
        }

        function studentlists() {
            var table_body = document.getElementById('list');

            for (var k = 0; k < students.length; k++) {
                var row = table_body.insertRow(table_body.rows.length);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);

                cell1.innerHTML = "<input type='checkbox'/>";
                cell2.innerHTML = students[k].name;
                cell3.innerHTML = students[k].id;
            }

        }


        function listcontent(){
            var list=document.getElementById("questionList");
            var text=document.getElementById("questionListContent");
            document.window.alert(list.value);
            document.write(list.value);
            text.value=list.value;
            return false;
        }

        function makeShortAnswer() {
            shortcnt++;
            cnt += 1;
            var body = document.getElementById("questionList");

            var div = document.createElement('div');
            div.className = "q";
            div.id = "q" + cnt;
            var ss = cnt + "번<br><br>문제 : " + "<input class='t' type='text' id='question" + cnt + "'><br>&nbsp;&nbsp;답&nbsp;&nbsp;: " + "<input type='text' class='t' id='answer" + cnt + "'><br>배점 : " + "<input type='text'  class='t' id='score" + cnt + "'><br><br>"
            div.innerHTML = ss;

            body.append(div);
        }

        function makeMultiple() {
            mul.push(cnt);
            mulcnt++;
            cnt += 1;
            var body = document.getElementById("questionList");

            var div = document.createElement('div');
            div.className = "q";
            div.id = "q" + cnt;
            var ss = cnt + "번<br><br>문제 : " + "<input type='text' id='question" + cnt + "' class='t'><br>보기개수 : <select id='exNum" + cnt + "' name='exampleNum'><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select><br><br>보기<br>1번&nbsp;:&nbsp;&nbsp;<input type='text' id='num1" + cnt + "' class='t'><br>2번&nbsp;:&nbsp;&nbsp;<input type='text' id='num2" + cnt + "' class='t'><br>3번&nbsp;:&nbsp;&nbsp;<input type='text' id='num3" + cnt + "' class='t'><br>4번&nbsp;:&nbsp;&nbsp;<input type='text' id='num4" + cnt + "' class='t'><br>5번&nbsp;:&nbsp;&nbsp;<input type='text' id='num5" + cnt + "' class='t'><br>&nbsp;&nbsp;답&nbsp;&nbsp;: " + "<input type='text' id='answer" + cnt + "' class='t'><br>배점 : " + "<input type='text' id='score" + cnt + "' class='t'><br><br>";
            div.innerHTML = ss;
            body.append(div);
        }

        function goBack() {
            window.history.back();
        }

        function save() {
            var sOK = false;
            var mOK = false;
            var essential = false;
            var stuOK = true;

            if (document.getElementById("name").value == "") {
                alert("필수란을 입력해주세요");
                return;
            }
            if (document.getElementById("date1").value == "") {
                alert("필수란을 입력해주세요");
                return;
            }
            if (document.getElementById("date2").value == "") {
                alert("필수란을 입력해주세요");
                return;
            }
            if (document.getElementById("time").value == "") {
                alert("필수란을 입력해주세요");
                return;
            }
            if (document.getElementsByName("auto").value == "") {
                alert("필수란을 입력해주세요");
                return;
            }
            essential = true;

            for (var k = 1; k <= cnt; k++) {
                console.log(k);

                if (document.getElementById("question" + k).value == "") {
                    alert("문제를 입력해주세요");
                    return;
                }
                if (document.getElementById("answer" + k).value == "") {
                    alert("답을 입력해주세요");
                    return;
                }
                if (document.getElementById("score" + k).value == "") {
                    alert("배점을 입력해주세요");
                    return;
                }
            }
            sOK = true;

            if (mulcnt != 0) {
                for (var k = 0; k < mulcnt; k++) {
                    var index = mul[k] + 1;
                    var excnt = 0;
                    var ex = document.getElementById("exNum" + index).value;

                    if (document.getElementById("num1" + index).value != "") {
                        excnt += 1;
                    }
                    if (document.getElementById("num2" + index).value != "") {
                        excnt += 1;
                    }
                    if (document.getElementById("num3" + index).value != "") {
                        excnt += 1;
                    }
                    if (document.getElementById("num4" + index).value != "") {
                        excnt += 1;
                    }
                    if (document.getElementById("num5" + index).value != "") {
                        excnt += 1;
                    }

                    if (ex != excnt) {
                        alert("보기 개수를 맞춰주세요");
                    }
                }
            }
            mOK = true;

            var checkcnt = 0;
            var table = document.getElementById("studentList");
            for (var k = 1; k <= students.length; k++) {
                if (document.getElementsByTagName("tr")[k].cells[0].firstChild.checked) {
                    checkcnt++;
                }
            }
            if (checkcnt == 0) {
                alert("응시자를 선택해주세요");
                stuOK = false;
            }

            if (essential && sOK && mOK && stuOK) {
                //디비 저장
                window.history.back();
            }
        }
    </script>
</body>

</html>