# Smart Attendance System

A web-based **Smart Attendance Management System** developed using **Java Servlets, JSP, JDBC, MySQL, and Apache Tomcat**.

The system helps colleges manage teachers, students, classes, subjects, timetables, holidays, and session-wise attendance through separate **Admin** and **Teacher** roles.

---

## 📌 Features

### 👨‍💼 Admin

The Admin can:

* Login securely
* Create and manage classes
* Add and manage students
* Add and manage teachers
* Create subjects
* Create weekly timetables
* Add college holidays
* Manage the academic structure of the system

### 👨‍🏫 Teacher

The Teacher can:

* Login to the system
* View today's scheduled sessions
* Mark attendance for a particular session
* View attendance information
* Prevent duplicate attendance marking
* Prevent attendance marking on college holidays

### 📊 Attendance Management

The system records attendance based on **individual sessions rather than simply marking attendance once per day**.

Attendance is associated with:

* Student
* Timetable/session
* Date
* Attendance status

Monthly attendance is calculated using:

```text
Attendance % = (Attended Sessions / Conducted Sessions) × 100
```

---

## 🛠️ Technologies Used

| Technology      | Purpose                             |
| --------------- | ----------------------------------- |
| Java            | Backend programming                 |
| Java Servlets   | Request handling and business logic |
| JSP             | Frontend / dynamic web pages        |
| JDBC            | Database connectivity               |
| MySQL           | Database management                 |
| Apache Tomcat 9 | Web server / Servlet container      |
| HTML            | Page structure                      |
| CSS             | Page styling                        |
| Eclipse IDE     | Development environment             |
| JDK 25          | Java Development Kit                |

---

## 🏗️ Project Architecture

The project follows a basic layered architecture:

```text
User
  │
  ▼
 JSP Pages
  │
  ▼
 Servlets
  │
  ▼
 DAO Classes
  │
  ▼
 JDBC
  │
  ▼
 MySQL Database
```

### Flow

```text
Browser
   ↓
JSP
   ↓
Servlet
   ↓
DAO
   ↓
JDBC
   ↓
MySQL
```

---

## 🗄️ Database

Database name:

```text
smart_attendance
```

### Main Tables

```text
Teacher
Student
Subject
Class
Timetable
Attendance
Holiday
```

### Attendance Relationship

Attendance is linked to a timetable/session and date so that the system can determine exactly **which session was conducted and whether a student attended it**.

```text
Timetable
    │
    ├── Subject
    ├── Teacher
    └── Class
          │
          ▼
      Attendance
          │
          ├── Student
          └── Date
```

---

## 📂 Main JSP Pages

Some of the main pages in the application include:

```text
login.jsp
teacherDashboard.jsp
todaySessions.jsp
markAttendance.jsp
monthlyReport.jsp
admin/dashboard.jsp
createSubject.jsp
```

---

## 🔐 User Roles

### Admin

```text
Admin Login
     ↓
Admin Dashboard
     ↓
 ┌───────────────┐
 │ Manage Class  │
 │ Manage Student│
 │ Manage Teacher│
 │ Manage Subject│
 │ Manage Timetable
 │ Manage Holiday│
 └───────────────┘
```

### Teacher

```text
Teacher Login
     ↓
Teacher Dashboard
     ↓
Today's Sessions
     ↓
Select Session
     ↓
Mark Attendance
     ↓
Save Attendance
```

---

## ⚙️ Attendance Rules

The system follows these rules:

1. Attendance is recorded **session-wise**.
2. A teacher can mark attendance only for their scheduled session.
3. A session cannot be marked more than once for the same date.
4. Attendance cannot be marked on a registered college holiday.
5. Monthly attendance is calculated from conducted and attended sessions.
6. Attendance is associated with the relevant timetable entry and date.

---

## 🚀 Installation & Setup

### 1. Prerequisites

Make sure the following are installed:

* Java JDK
* Eclipse IDE
* Apache Tomcat 9
* MySQL Server
* MySQL Connector/J
* A web browser

---

### 2. Clone the Repository

```bash
git clone https://github.com/shaikh-ebad/Smart-Attendance-System.git
```

Then open the project in **Eclipse IDE**.

> Replace the repository URL above with your actual GitHub repository URL if the repository name is different.

---

### 3. Configure MySQL

Create the database:

```sql
CREATE DATABASE smart_attendance;
```

Import/create the required tables:

```text
Teacher
Student
Subject
Class
Timetable
Attendance
Holiday
```

---

### 4. Configure Database Connection

Update the database connection details in the JDBC/DAO configuration.

Example:

```java
String url = "jdbc:mysql://localhost:3306/smart_attendance";
String username = "root";
String password = "YOUR_PASSWORD";
```

**Do not commit your actual database password to GitHub.**

---

### 5. Configure Tomcat

Add **Apache Tomcat 9** to Eclipse:

```text
Window
 → Preferences
 → Server
 → Runtime Environments
 → Add
 → Apache Tomcat v9.0
```

Select the project and configure it to run on Tomcat.

---

### 6. Run the Project

Start the Tomcat server from Eclipse.

Then open the application in your browser:

```text
http://localhost:8080/SmartAttendanceSystem/
```

The exact URL depends on your project's configured context path.

---

## 📊 Future Improvements

Possible future improvements include:

* Student login
* Student attendance dashboard
* Attendance notifications
* Low-attendance alerts
* Export attendance reports to PDF/Excel
* Attendance analytics and charts
* Responsive mobile-friendly UI
* Password hashing and stronger authentication
* Role-based access control
* REST API integration
* Cloud database deployment
* Automated email notifications

---

## 🎯 Project Objective

The main objective of the **Smart Attendance System** is to simplify and digitize the traditional attendance process.

Instead of maintaining attendance manually, teachers can record attendance digitally for individual scheduled sessions while administrators manage the academic structure, timetable, and holidays.

This helps reduce:

* Manual paperwork
* Calculation errors
* Duplicate attendance
* Unauthorized attendance marking
* Time required for attendance management

---

## 👥 Project Roles

### Admin

Responsible for managing the academic structure and system data.

### Teacher

Responsible for viewing scheduled sessions and recording student attendance.

---

## 📚 Project Type

**Academic / Diploma Project**

### Backend

Java Servlets + JDBC

### Frontend

JSP + HTML + CSS

### Database

MySQL

### Server

Apache Tomcat 9

---

## 📄 License

This project was developed as an academic project for educational purposes.
