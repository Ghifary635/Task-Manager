/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author booma
 */
import java.util.Date;

public class WorkTask extends Task {

    public WorkTask(int id, String title, String description, Priority priority, TaskStatus status, Date dueDate) {
        super(id, title, description, priority, status, dueDate);
    }

    @Override
    public String getCategory() {
        return "Work";
    }
}