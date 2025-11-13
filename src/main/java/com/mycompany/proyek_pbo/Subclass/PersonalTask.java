package com.mycompany.proyek_pbo.Subclass;

import com.mycompany.proyek_pbo.Superclass.Task;
import java.util.*;

public class PersonalTask extends Task{
    private static int countPersonal = 0;

    public PersonalTask(String title, String description, Date dateDue){
        super(title, description, dateDue);
    }

    public String generateTaskId(){
        countPersonal += 1;
        return String.format("PT%03d", countPersonal);
    }

    public void printInfo(){
        System.out.println("======= PERSONAL TASK =======");
        System.out.println("ID: " + taskId);
        System.out.println("Title: " + title);
        System.out.println("Description: " + description);
        System.out.println("Due: " + dateDue);
        System.out.println("Days Remaining: " + getDaysUntilDue() + " days");
        System.out.println("Status: " + status);
        System.out.println();
    }
}
