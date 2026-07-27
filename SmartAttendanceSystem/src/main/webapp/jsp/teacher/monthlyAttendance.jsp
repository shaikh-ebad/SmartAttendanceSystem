<%@ page import="java.util.*" %>

<%
List<Map<String,String>> list =
(List<Map<String,String>>) request.getAttribute("data");
%>

<!DOCTYPE html>
<html>
<head>
<title>Monthly Attendance</title>

<style>
:root {
    --gold: #c8a97e;
    --bg-dark: #0d0c0b;
    --bg-card: #161513;
    --text: #f0e8dc;
    --muted: #6b6259;
    --border: #ffffff14;
}

body{
    margin:0;
    padding:30px;
    font-family: 'Segoe UI', sans-serif;
    background: var(--bg-dark);
    color: var(--text);
}

/* CARD */
.container{
    width:90%;
    margin:auto;
    background: var(--bg-card);
    padding:25px;
    border-radius:12px;
    border:1px solid var(--border);
}

/* TITLE */
h2{
    text-align:center;
    margin-bottom:20px;
    font-weight:300;
}

/* TOP BAR */
.topBar{
    margin-bottom:20px;
    text-align:center;
}

/* INPUT */
input[type="number"]{
    padding:8px;
    background:#111009;
    border:1px solid var(--border);
    border-radius:6px;
    color: var(--text);
}

/* BUTTON */
.btn{
    background: var(--gold);
    color:#000;
    border:none;
    padding:8px 15px;
    border-radius:6px;
    cursor:pointer;
}

/* TABLE */
table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#111009;
    color: var(--gold);
    padding:10px;
    border-bottom:1px solid var(--border);
}

td{
    padding:10px;
    text-align:center;
}

tr{
    border-bottom:1px solid var(--border);
}

tr:hover{
    background:#111009;
}

/* STATUS COLORS */
.present{
    color:#4cd964;
    font-weight:600;
}

.absent{
    color:#ff4d4d;
    font-weight:600;
}

/* BACK LINK */
.back-link{
    margin-top:20px;
    text-align:center;
}

.back-link a{
    color: var(--gold);
    text-decoration:none;
}
</style>

</head>

<body>

<div class="container">

<h2>Monthly Attendance Report</h2>

<!-- Month Search -->
<div class="topBar">

<form action="<%=request.getContextPath()%>/monthlyAttendance" method="get">

    Enter Month (1-12):
    <input type="number" name="month" min="1" max="12" required>

    <input type="submit" value="View" class="btn">

</form>

</div>

<table>

<tr>
    <th>Student ID</th>
    <th>Name</th>
    <th>Date</th>
    <th>Status</th>
</tr>

<%
if(list != null){
    for(Map<String,String> row : list){
%>

<tr>
    <td><%=row.get("id")%></td>
    <td><%=row.get("name")%></td>
    <td><%=row.get("date")%></td>
    <td>
        <%
        String st = row.get("status");
        if(st.equals("P")){
        %>
            <span class="present">Present</span>
        <%
        } else {
        %>
            <span class="absent">Absent</span>
        <%
        }
        %>
    </td>
</tr>

<%
    }
}
%>

</table>

<!-- CLEAN BACK BUTTON -->
<%-- <div class="back-link">
    <a href="${pageContext.request.contextPath}/jsp/teacher/dashboard.jsp">
        ← Back to Dashboard
    </a>
</div> --%>

</div>

</body>
</html>