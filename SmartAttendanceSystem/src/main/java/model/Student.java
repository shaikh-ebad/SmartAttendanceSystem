package model;

public class Student {

    private int studentId;
    private String name;
    private int classId;

    // Constructors
    public Student() {}

    public Student(int studentId, String name, int classId) {
        this.studentId = studentId;
        this.name = name;
        this.classId = classId;
    }

    // Getters & Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
}
