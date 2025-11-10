/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.proyek_pbo;

/**
 *
 * @author alghi
 */

import java.util.Date;

public abstract class Task {
    protected String taskId;
    protected String title;
    protected String description;
    protected Date dueDate;
    protected Date createdAt;
    protected TaskStatus status;
    private static int personalTaskCount = 0;
    private static int workTaskCount = 0;
    
    public Task(String title, String description, Date dueDate) {
        this.taskId = generateTaskId();
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.createdAt = new Date();
        this.status = TaskStatus.TODO;
    }
    
    private String generateTaskId() {
        if (this instanceof PersonalTask) {
            personalTaskCount++;
            return String.format("PT%03d", personalTaskCount);
        } else if (this instanceof WorkTask) {
            workTaskCount++;
            return String.format("WT%03d", workTaskCount);
        }
        return "TASK001";
    }
    
    // Abstract methods (harus diimplement subclass)
    public abstract void displayTaskDetails();
    public abstract void updateProgress();
    
    // Concrete methods (sudah ada implementasi)
    public void markAsCompleted() {
        this.status = TaskStatus.COMPLETED;
        System.out.println("Task '" + title + "' completed! [DONE]");
    }

    public void markAsInProgress() {
        this.status = TaskStatus.IN_PROGRESS;
        System.out.println("Task '" + title + "' in progress... [IN PROGRESS]");
    }

    public void markAsCancelled() {
        this.status = TaskStatus.CANCELLED;
        System.out.println("Task '" + title + "' cancelled [CANCELLED]");
    }
    
    public boolean isOverdue() {
        return new Date().after(dueDate) && status != TaskStatus.COMPLETED;
    }
    
    public long getDaysUntilDue() {
        long diff = dueDate.getTime() - new Date().getTime();
        return diff / (1000 * 60 * 60 * 24);
    }
    
    public boolean isDueToday() {
        Date today = new Date();
        Date due = this.dueDate;
        
        // Cara sederhana untuk bandingkan tanggal saja (tanpa waktu)
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        return sdf.format(today).equals(sdf.format(due));
    }
    
    // Getters
    public String getTaskId() { return taskId; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public Date getDueDate() { return dueDate; }
    public Date getCreatedAt() { return createdAt; }
    public TaskStatus getStatus() { return status; }
    
    // Setters
    public void setTitle(String title) { 
        this.title = title; 
    }
    
    public void setDescription(String description) { 
        this.description = description; 
    }
    
    public void setDueDate(Date dueDate) { 
        this.dueDate = dueDate; 
    }
    
    public void setStatus(TaskStatus status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return String.format("Task[ID=%s, Title=%s, Status=%s, Due=%s]", 
            taskId, title, status, dueDate);
    }
}