<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<div class="page-wrapper">

<h2>📅 Weekly Timetable</h2>

<form action="<%=request.getContextPath()%>/timetableCreate" method="post">
<input type="hidden" name="classId" value="1">

<div class="table-container">
<table>
<tr>
    <th>Time</th>
    <th>Mon</th>
    <th>Tue</th>
    <th>Wed</th>
    <th>Thu</th>
    <th>Fri</th>
    <th>Sat</th>
</tr>

<%
String[] times = {"9-10","10-11","11-12","12-1","2-3","3-4"};
String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};

for(String time : times){
%>
<tr>
    <td class="time"><%=time%></td>

    <%
    for(String day : days){
        String name = day + "_" + time;
    %>

    <td>
        <input type="number" name="subject_<%=name%>" placeholder="SubID">
        <input type="number" name="teacher_<%=name%>" placeholder="TeachID">
        <select name="type_<%=name%>">
            <option>LECTURE</option>
            <option>LAB</option>
        </select>
    </td>

    <% } %>
</tr>
<% } %>

</table>
</div>

<button type="submit">Save Full Week</button>

</form>

<!-- BACK BUTTON -->
<div class="back-link">
   <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp" target="_top">
    ← Back to Dashboard
</a>
</div>

</div>

<style>

/* PAGE WRAPPER (DARK UI) */
.page-wrapper {
    background: #161513;
    padding: 25px;
    border-radius: 16px;
    border: 1px solid rgba(255,255,255,0.08);
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
    width: 100%;
    color: #f0e8dc;
}

/* TITLE */
h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #c8a97e;
}

/* TABLE SCROLL */
.table-container {
    overflow-x: auto;
}

/* TABLE STYLE */
table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
    min-width: 900px;
}

/* HEADER */
th {
    background: #0d0c0b;
    color: #c8a97e;
    padding: 10px;
    border: 1px solid rgba(255,255,255,0.1);
}

/* CELLS */
td {
    border: 1px solid rgba(255,255,255,0.08);
    padding: 6px;
}

/* TIME COLUMN */
.time {
    font-weight: bold;
    color: #c8a97e;
}

/* INPUT FIELDS */
input, select {
    width: 100%;
    padding: 6px;
    margin-bottom: 4px;
    font-size: 12px;
    border-radius: 6px;
    border: 1px solid rgba(255,255,255,0.15);
    background: #0d0c0b;
    color: #f0e8dc;
}

/* REMOVE WHITE FOCUS */
input:focus, select:focus {
    outline: none;
    border: 1px solid #c8a97e;
    box-shadow: 0 0 5px rgba(200,169,126,0.3);
}

/* DROPDOWN OPTIONS */
select option {
    background: #1a1814;
    color: #f0e8dc;
}

/* BUTTON */
button {
    margin-top: 15px;
    width: 100%;
    padding: 12px;
    background: #c8a97e;
    color: #0d0c0b;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

button:hover {
    opacity: 0.85;
}

/* BACK LINK */
.back-link {
    text-align: center;
    margin-top: 15px;
}

.back-link a {
    color: #c8a97e;
    text-decoration: none;
}

.back-link a:hover {
    text-decoration: underline;
}

</style>