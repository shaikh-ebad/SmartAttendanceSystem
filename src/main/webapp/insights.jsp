<%@ page import="java.sql.ResultSet" %> 
<html> 
<body> 
<h3>Insights</h3> 
<p>Regularity: ${regularity}%</p> 
<p>Late count: ${lateCount}</p> 
<p>Present in last 7 days: ${present7}</p> 
<h4>Monthly Summary</h4> 
<table border="1"> 
<tr><th>Month</th><th>Present</th><th>Absent</th><th>Late</th></tr> 
<% ResultSet m = (ResultSet) request.getAttribute("monthlyRs"); 
   while (m != null && m.next()) { %> 
<tr> 
<td><%= m.getInt("m") %></td> 
<td><%= m.getInt("present") %></td> 
<td><%= m.getInt("absent") %></td> 
<td><%= m.getInt("late") %></td> 
</tr> 
<% } %> 
</table> 
</body> 
</html> 