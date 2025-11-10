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

public class PersonalTask extends Task {
    
    public PersonalTask(String title, String description, Date dueDate) {
        super(title, description, dueDate);
    }
    
    @Override
    public void displayTaskDetails() {
        System.out.println("=== PERSONAL TASK ===");
        System.out.println("ID: " + taskId);
        System.out.println("Title: " + title);
        System.out.println("Description: " + description);
        System.out.println("Due: " + dueDate);
        System.out.println("Status: " + status);
        System.out.println("Overdue: " + (isOverdue() ? "YES [OVERDUE]" : "No"));
        System.out.println("Due Today: " + (isDueToday() ? "YES [TODAY]" : "No"));
        System.out.println("Days until due: " + getDaysUntilDue());
    }
    
    @Override
    public void updateProgress() {
        if (status == TaskStatus.TODO) {
            markAsInProgress();
            System.out.println("Started personal task: " + title);
        } else if (status == TaskStatus.IN_PROGRESS) {
            markAsCompleted();
            System.out.println("Completed personal task: " + title);
        }
    }
}
