<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<meta charset="UTF-8" />
<!DOCTYPE html>
<html>
    <head>
        <h2>시험 상세정보</h2>
        <style>
            table{
                border-collapse: collapse;
                border:1px solid black;
            }

            th, td{
                border:1px solid black;
            }

            .title{
                font-weight:bold;
            }
        </style>
    </head>

    <body onload="init()">
        <h3>시험 정보</h3>
        <table id="testInfo">
            <tr>
                <td class="title">시험명</td>
                <td id="testName"></td>
            </tr>
            <tr>
                <td class="title">응시기간</td>
                <td id="testDuration"></td>
            </tr>
            <tr>
                <td class="title">시험시간</td>
                <td id="testTime"></td>
            </tr>
            <tr>
                <td class="title">자동/수동채점여부</td>
                <td id="testAuto"></td>
            </tr>
        </table>

        <br>

        <h3>문제</h3>
        <table id="questionInfo">
            <thead>
                <td class="title">문제</td>
                <td class="title">정답</td>
                <td class="title">배점</td>
                <td class="title">평균</td>
                <td class="title">오답률</td>
            </thead>
        </table>
        <br>
        <input type="button" value="수정" onclick="modify()">

        <h3>응시 정보</h3>
        <h4>응시생</h4>
        <table id="doneInfo">
            <thead>
                <td class="title">이름</td>
                <td class="title">점수</td>
                <td class="title">채점</td>
            </thead>
        </table>

        <br>

        <h4>미응시생</h4>
        <table id="notdoneInfo">
            <thead>
                <td class="title">이름</td>
                <td class="title">점수</td>
                <td class="title">채점</td>
            </thead>
        </table>

        <br>

        <input type="button" value="돌아가기" onclick="goBack()">
        <span id="asdf"></span>


        <script>
            <% String name=request.getParameter("name");%>
            //var s = '[{"name": "나의 기분","duration": 7,"time": 2,"auto": "false","applicantsInfo": [{"done":2,"total":5,"list":[{"done":[{"id":"ga","name":"가","score":100},{"id":"na","name":"나","score":90}],"notDone":[{"id":"da","name":"다","score":0},{"id":"ra","name":"라","score":0},{"id":"ma","name":"마","score":0}]}]}],"average": 78,"shortAnswer":[{"question":"내 기분을 맞춰봐!","answer":"하기싫다","points":50,"average":50,"wrongrate":0},{"question":"하기 싫을 땐 어떻게 해야하지","answer":"때려치면된다","points":40,"average":25,"wrongrate":50}],"multipleChoice":[{"question":"가장 급한 과제는?","exampleNum":5,"examples":[{"보기":"컴네"},{"보기":"컴비"},{"보기":"웹프실"},{"보기":"오토마타 공부"},{"보기":"휴학"}],"answer":"5","points":10,"average":50,"wrongrate":0}]},{"name": "하기 싫다","make":"2019-12-07","duration": 3,"time": 1,"auto": "true","applicantsInfo": [{"done":0,"total":41,"list":[{}]}],"average": 0,"shortAnswer":[],"multipleChoice":[{"question":"집에 가고 싶다","exampleNum":4,"examples":[{"보기":"살려줘"},{"보기":"배고파"},{"보기":"밥먹고 싶다"},{"보기":"힝힝"}],"answer":"1","points":10,"average":10,"wrongrate":0},{"question":"아랫분도 이미 동의하신 내용","exampleNum":5,"examples":[{"보기":"ㅇㅇ"},{"보기":"ㄴㄴ"},{"보기":"ㄷㄷ"},{"보기":"ㄹㅇ"},{"보기":"ㅇㅎ"}],"answer":"4","points":50,"average":25,"wrongrate":50}]}]';
            var s="[";
            <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data?serverTimezone=UTC", "root", "3br3br");
            String query="SELECT * FROM test_data where test_name=";
            query+="'"+name+"';";
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(query);
            rs.first();
            %>
            
    
            s+='{"name": "<%=rs.getString("test_name")%>",';
            //s+='"make":"<%=rs.getString("Birthday")%>",';
            s+='"duration": "<%=rs.getString("test_start_period")%>~<%=rs.getString("test_end_period")%>"';
            s+=',"time": "<%=rs.getString("test_start_time")%>",';
            s+='"auto": "false",';
            s+='"applicantsInfo": [{"done":10,"total":30,';//"list":[{}]}],';
            //s+='"average": 78}';
            s+='"list":[{"done":[{"id":"ga","name":"가","score":100},{"id":"na","name":"나","score":90}],"notDone":[{"id":"da","name":"다","score":0},{"id":"ra","name":"라","score":0},{"id":"ma","name":"마","score":0}]}]}],"average": 78,"shortAnswer":[{"question":"내 기분을 맞춰봐!","answer":"하기싫다","points":50,"average":50,"wrongrate":0},{"question":"하기 싫을 땐 어떻게 해야하지","answer":"때려치면된다","points":40,"average":25,"wrongrate":50}],"multipleChoice":[{"question":"가장 급한 과제는?","exampleNum":5,"examples":[{"보기":"컴네"},{"보기":"컴비"},{"보기":"웹프실"},{"보기":"오토마타 공부"},{"보기":"휴학"}],"answer":"5","points":10,"average":50,"wrongrate":0}]},{"name": "하기 싫다","make":"2019-12-07","duration": 3,"time": 1,"auto": "true","applicantsInfo": [{"done":0,"total":41,"list":[{}]}],"average": 0,"shortAnswer":[],"multipleChoice":[{"question":"집에 가고 싶다","exampleNum":4,"examples":[{"보기":"살려줘"},{"보기":"배고파"},{"보기":"밥먹고 싶다"},{"보기":"힝힝"}],"answer":"1","points":10,"average":10,"wrongrate":0},{"question":"아랫분도 이미 동의하신 내용","exampleNum":5,"examples":[{"보기":"ㅇㅇ"},{"보기":"ㄴㄴ"},{"보기":"ㄷㄷ"},{"보기":"ㄹㅇ"},{"보기":"ㅇㅎ"}],"answer":"4","points":50,"average":25,"wrongrate":50}]}]';
            
            
            //s=s.substr(0,s.length-1);
            //s+="]";
            
            var tests = eval("(" + s + ")");
            var length = Object.keys(tests).length;
            var name = "<%=name%>";
            var i = getTestNum(name);

            function init(){
                showBasicInfo(i);
                showQuestion(i);
                showStudents(i);
            }

            function goBack(){
                window.history.back();
            }

            function getTestNum(name){
                for(var i=0;i<length;i++){
                    if(name == tests[i].name){
                        return i;
                    }
                }
            }

            function showBasicInfo(i){
                document.getElementById("testName").innerHTML=tests[i].name;
                document.getElementById("testDuration").innerHTML=tests[i].duration+"일";
                document.getElementById("testTime").innerHTML=tests[i].time+"시간";
                if(tests[i].auto == true){
                    document.getElementById("testAuto").innerHTML="자동";
                }
                else{
                    document.getElementById("testAuto").innerHTML="수동";
                }
                
            }

            function showQuestion(i){
                var table=document.getElementById("questionInfo");
                for(var j=0;j<tests[i].multipleChoice.length;j++){
                    var row = table.insertRow(table.rows.length);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);

                    var q = tests[i].multipleChoice[j].question+ "<br>";
                    for(var k=0;k<tests[i].multipleChoice[j].exampleNum;k++){
                        q += ((k+1)+") "+ tests[i].multipleChoice[j].examples[k].보기+"<br>");
                    }

                    cell1.innerHTML = q;
                    cell2.innerHTML = tests[i].multipleChoice[j].answer;
                    cell3.innerHTML = tests[i].multipleChoice[j].points;
                    cell4.innerHTML = tests[i].multipleChoice[j].average;
                    cell5.innerHTML = tests[i].multipleChoice[j].wrongrate;
                }
                for(var j=0;j<tests[i].shortAnswer.length;j++){
                    var row = table.insertRow(table.rows.length);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);

                    cell1.innerHTML = tests[i].shortAnswer[j].question;
                    cell2.innerHTML = tests[i].shortAnswer[j].answer;
                    cell3.innerHTML = tests[i].shortAnswer[j].points;
                    cell4.innerHTML = tests[i].shortAnswer[j].average;
                    cell5.innerHTML = tests[i].shortAnswer[j].wrongrate;
                }
            }

            function showStudents(i){
                var table=document.getElementById("doneInfo");
                for(var j=0;j<tests[i].applicantsInfo[0].done;j++){
                    var row = table.insertRow(table.rows.length);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);

                    cell1.innerHTML = tests[i].applicantsInfo[0].list[0].done[j].name;
                    cell2.innerHTML = tests[i].applicantsInfo[0].list[0].done[j].score;
                    cell3.innerHTML = "<input type='button' value='채점하기' onclick=\"location.href='grading.html?"+tests[i].applicantsInfo[0].list[0].done[j].name+"'\"/>";
                }

                var table=document.getElementById("notdoneInfo");
                for(var j=0;j<tests[i].applicantsInfo[0].total-tests[i].applicantsInfo[0].done;j++){
                    var row = table.insertRow(table.rows.length);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);

                    cell1.innerHTML = tests[i].applicantsInfo[0].list[0].notDone[j].name;
                    cell2.innerHTML = tests[i].applicantsInfo[0].list[0].notDone[j].score;
                    cell3.innerHTML = "<input type='button' value='채점하기' onclick=\"location.href='grading.html?"+tests[i].name+"&"+tests[i].applicantsInfo[0].list[0].notDone[j].name+"'\"/>";
                }
            }

            function modify(){
                if(tests[i].applicantsInfo[0].done != 0){
                    alert("응시자 수가 0명보다 많으므로 수정할 수 없습니다.");
                }
                else{
                    location.href='modify.html?'+tests[i].name;
                }
            }
        </script>
    </body>

</html>