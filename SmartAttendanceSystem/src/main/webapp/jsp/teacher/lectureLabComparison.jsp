<%@ page import="java.sql.*, dao.DBConnection, java.util.List, java.util.ArrayList" %>

<%
int studentId = 1; // You can make this dynamic later

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
 "SELECT t.session_type, COUNT(*) AS total, SUM(a.status='P') AS present " +
 "FROM attendance a JOIN timetable t ON a.timetable_id=t.timetable_id " +
 "WHERE a.student_id=? GROUP BY t.session_type"
);
ps.setInt(1, studentId);
ResultSet rs = ps.executeQuery();

// Prepare data for chart
List<String> sessionTypes = new ArrayList<>();
List<Integer> totalSessions = new ArrayList<>();
List<Integer> presentSessions = new ArrayList<>();

while(rs.next()){
    sessionTypes.add(rs.getString("session_type"));
    totalSessions.add(rs.getInt("total"));
    presentSessions.add(rs.getInt("present"));
}

rs.close();
ps.close();
con.close();
%>

<div class="page-wrapper">

    <h2>Lecture vs Lab Attendance</h2>

    <!-- Attendance Table -->
    <div class="table-container">
        <table>
            <tr>
                <th>Session Type</th>
                <th>Total Sessions</th>
                <th>Present</th>
            </tr>
            <% for(int i=0; i<sessionTypes.size(); i++) { %>
            <tr>
                <td><%= sessionTypes.get(i) %></td>
                <td class="total-sessions"><%= totalSessions.get(i) %></td>
                <td class="present-sessions"><%= presentSessions.get(i) %></td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- Chart -->
    <canvas id="attendanceChart" style="margin-top:30px; max-width:600px;"></canvas>

    <div class="footer-note">
        Attendance comparison between lectures and labs
    </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const sessionTypes = [<%= sessionTypes.stream().map(s -> "'" + s + "'").reduce((a,b)->a+","+b).orElse("") %>];
const totalSessions = [<%= totalSessions.stream().map(String::valueOf).reduce((a,b)->a+","+b).orElse("0") %>];
const presentSessions = [<%= presentSessions.stream().map(String::valueOf).reduce((a,b)->a+","+b).orElse("0") %>];

const ctx = document.getElementById('attendanceChart').getContext('2d');
const attendanceChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: sessionTypes,
        datasets: [
            {
                label: 'Total Sessions',
                data: totalSessions,
                backgroundColor: 'rgba(200, 169, 126, 0.6)',
                borderColor: 'rgba(200, 169, 126, 1)',
                borderWidth: 1
            },
            {
                label: 'Present',
                data: presentSessions,
                backgroundColor: 'rgba(100, 200, 150, 0.6)',
                borderColor: 'rgba(100, 200, 150, 1)',
                borderWidth: 1
            }
        ]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { position: 'top', labels: { color: '#ffffff' } },
            title: { display: true, text: 'Lecture vs Lab Attendance', color:'#ffffff' }
        },
        scales: {
            x: { ticks: { color: '#ffffff' }, grid: { color: '#222' } },
            y: { beginAtZero: true, ticks: { color: '#ffffff' }, grid: { color: '#222' } }
        }
    }
});
</script>

<style>
.page-wrapper {
    background: #161513;
    padding: 25px;
    border-radius: 12px;
    width: 100%;
    color: #ffffff;
}

h2 { text-align: center; margin-bottom: 20px; font-weight: 400; }

.table-container { overflow-x: auto; margin-bottom: 20px; }
table { width: 100%; border-collapse: collapse; text-align: center; }
th { padding: 12px; background: #c8a97e; color: #0d0c0b; font-size: 14px; }
td { padding: 10px; font-size: 14px; border-bottom: 1px solid #222; color: #ffffff; } /* added color */
td.total-sessions { color: #c8a97e; } /* optional: match header gold */
td.present-sessions { color: #64c896; } /* optional: match chart green */
tr:nth-child(even) { background: #1e1c19; }
tr:hover { background: rgba(200,169,126,0.1); }

.footer-note { margin-top: 15px; text-align: center; font-size: 12px; color: #6b6259; }
</style>