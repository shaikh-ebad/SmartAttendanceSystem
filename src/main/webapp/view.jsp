<%@ page import="java.sql.ResultSet" %> 
<html> 
<body> 
<h3>Attendance Records</h3> 
<table border="1"> 
<tr><th>Date</th><th>Student</th><th>Roll</th><th>Status</th></tr> 
<% ResultSet rs = (ResultSet) request.getAttribute("attendanceRs"); 
   while (rs != null && rs.next()) { %> 
<tr> 
<td><%= rs.getDate("date") %></td> 
<td><%= rs.getString("name") %></td> 
<td><%= rs.getString("roll_no") %></td> 
<td><%= rs.getString("status") %></td> 
</tr> 
<% } %> 
</table> 
</body> 
</html> 