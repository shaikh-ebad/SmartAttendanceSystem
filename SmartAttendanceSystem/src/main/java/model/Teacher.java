package model;

public class Teacher {

    private int teacherId;
    private String name;
    private String username;
    private String password;

    // Constructors
    public Teacher() {}

    public Teacher(int teacherId, String name, String username) {
        this.teacherId = teacherId;
        this.name = name;
        this.username = username;
    }

    // Getters & Setters
    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
}
