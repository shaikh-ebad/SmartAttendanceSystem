<%@ page import="java.sql.ResultSet" %> 
<html> 
<body> 
<h3>Mark Attendance</h3> 
<form action="markAttendance" method="post"> 
<input type="hidden" name="subjectId" value="${requestScope.subjectId}"> 
<table border="1"> 
<tr><th>Student</th><th>Roll</th><th>Status</th></tr> 
<% ResultSet students = (ResultSet) request.getAttribute("studentsRs"); 
    while (students != null && students.next()) { %> 
   <tr> 
     <td><%= students.getString("name") %> 
       <input type="hidden" name="studentId" value="<%= students.getInt("id") %>"> 
     </td> 
     <td><%= students.getString("roll_no") %></td> 
     <td> 
       <select name="status"> 
         <option value="Present">Present</option> 
         <option value="Absent">Absent</option> 
         <option value="Late">Late</option> 
       </select> 
     </td> 
   </tr> 
<% } %> 
</table> 
<input type="submit" value="Save Attendance"> 
</form> 
</body> 
</html> 