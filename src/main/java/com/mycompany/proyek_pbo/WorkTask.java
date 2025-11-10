/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.proyek_pbo;

/**
 *
 * @author alghi
 */
import java.util.*;

public class WorkTask extends Task implements Prioritizable {
    private Priority priority;
    private String projectName;
    
    public WorkTask(String title, String description, Date dueDate, String projectName) {
        super(title, description, dueDate);
        this.projectName = projectName;
        this.priority = Priority.MEDIUM;
    }
    
    @Override
    public void displayTaskDetails() {
        System.out.println("=== WORK TASK ===");
        System.out.println("ID: " + taskId);
        System.out.println("Title: " + title);
        System.out.println("Description: " + description);
        System.out.println("Project: " + projectName);
        System.out.println("Priority: " + priority);
        System.out.println("Due: " + dueDate);
        System.out.println("Status: " + status);
        System.out.println("Overdue: " + (isOverdue() ? "YES [OVERDUE]" : "No"));
        System.out.println("High Priority: " + (isHighPriority() ? "YES [HIGH PRIORITY]" : "No"));
        System.out.println("Days until due: " + getDaysUntilDue());
    }
    
    @Override
    public void updateProgress() {
        if (status == TaskStatus.TODO) {
            markAsInProgress();
            System.out.println("Started work task: " + title);
        } else if (status == TaskStatus.IN_PROGRESS) {
            markAsCompleted();
            System.out.println("Completed work task: " + title);
        }
    }
    
    @Override
    public void setPriority(Priority priority) {
        this.priority = priority;
    }
    
    @Override
    public Priority getPriority() {
        return priority;
    }
    
    @Override
    public boolean isHighPriority() {
        return priority == Priority.HIGH || priority == Priority.URGENT;
    }
    
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    
    public String getProjectName() {
        return projectName;
    }
}
