package com.mycompany.proyek_pbo.Superclass;

import java.util.Date;
import com.mycompany.proyek_pbo.Enumerate.TaskStatus;

public abstract class Task {
    protected String title, taskId, description;
    protected Date dateCreated, dateDue;
    protected TaskStatus status;

    public Task(String judul, String deskripsi, Date tenggat){
        this.title = judul;
        this.description = deskripsi;
        this.dateDue = tenggat;
        this.status = TaskStatus.TODO;
        this.taskId = generateTaskId();
        this.dateCreated = new Date();
    }

    // Setter - Getter
    public String getTaskId() { return taskId; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public Date getDueDate() { return dateDue; }
    public Date getCreatedAt() { return dateCreated; }
    public TaskStatus getStatus() { return status; }
    
    public void setTitle(String title){this.title = title;}
    public void setDescription(String description){this.description = description;}
    public void setDueDate(Date dueDate){this.dateDue = dueDate;}
    public void setStatus(TaskStatus status){this.status = status;}

    // Abstract Method
    public abstract String generateTaskId();
    public abstract void printInfo();

    // Addition
    public boolean isOverdue() {
        return new Date().after(dateDue) && status != TaskStatus.COMPLETED;
    }
    
    public long getDaysUntilDue() {
        long diff = dateDue.getTime() - new Date().getTime();
        return diff / (1000 * 60 * 60 * 24);
    }
    
    public boolean isDueToday() {
        Date today = new Date();
        Date due = this.dateDue;
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        return sdf.format(today).equals(sdf.format(due));
    }
}
