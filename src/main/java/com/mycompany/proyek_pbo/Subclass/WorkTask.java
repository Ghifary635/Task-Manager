package com.mycompany.proyek_pbo.Subclass;

import com.mycompany.proyek_pbo.Interface.Prioritizable;
import com.mycompany.proyek_pbo.Superclass.Task;
import com.mycompany.proyek_pbo.Enumerate.Priority;
import java.util.*;

public class WorkTask extends Task implements Prioritizable{
    private Priority priority;
    private String projectName;
    private static int countWork = 0;

    public WorkTask(String title, String description, Date dateDue, String projectName){
        super(title, description, dateDue);
        this.priority = Priority.NOT_SETTED;
        this.projectName = projectName;
    }
    
    public String generateTaskId(){
        countWork += 1;
        return String.format("WT%03d", countWork);
    }

    public void printInfo(){
        System.out.println("======= WORK TASK =======");
        System.out.println("ID: " + taskId);
        System.out.println("Title: " + title);
        System.out.println("Project Name: " + projectName);
        System.out.println("Description: " + description);
        System.out.println("Priority: " + priority);
        System.out.println("Due: " + dateDue);
        System.out.println("Days Remaining: " + getDaysUntilDue() + " days");
        System.out.println("Status: " + status);
        System.out.println();
    }

    // Interface
    public void setPriority(Priority p){this.priority = p;}
    public Priority getPriority(){return priority;}
    public boolean isHighPriority(){return priority == Priority.HIGH;}
}
