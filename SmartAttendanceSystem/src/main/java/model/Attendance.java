package model;

import java.sql.Date;

public class Attendance {

    private int attendanceId;
    private int timetableId;
    private int studentId;
    private Date date;
    private String status; // P / A

    // Constructors
    public Attendance() {}

    public Attendance(int timetableId, int studentId, Date date, String status) {
        this.timetableId = timetableId;
        this.studentId = studentId;
        this.date = date;
        this.status = status;
    }

    // Getters & Setters
    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }

    public int getTimetableId() {
        return timetableId;
    }

    public void setTimetableId(int timetableId) {
        this.timetableId = timetableId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
