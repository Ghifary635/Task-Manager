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

public class TaskManager {
    private List<Task> tasks;
    
    public TaskManager() {
        this.tasks = new ArrayList<>();
    }
    
    public void addTask(Task task) {
        tasks.add(task);
        System.out.println("Task '" + task.getTitle() + "' added successfully!");
    }
    
    public boolean removeTask(String taskId) {
        Task taskToRemove = null;
        for (Task task : tasks) {
            if (task.getTaskId().equals(taskId)) {
                taskToRemove = task;
                break;
            }
        }
        
        if (taskToRemove != null) {
            tasks.remove(taskToRemove);
            System.out.println("Task removed successfully!");
            return true;
        } else {
            System.out.println("Task with ID '" + taskId + "' not found.");
            return false;
        }
    }
    
    public Task findTask(String taskId) {
        for (Task task : tasks) {
            if (task.getTaskId().equals(taskId)) {
                return task;
            }
        }
        return null;
    }
    
    public List<Task> getAllTasks() {
        return new ArrayList<>(tasks);
    }
    
    public List<Task> getTasksByStatus(TaskStatus status) {
        List<Task> result = new ArrayList<>();
        for (Task task : tasks) {
            if (task.getStatus() == status) {
                result.add(task);
            }
        }
        return result;
    }
    
    public List<Task> getOverdueTasks() {
        List<Task> result = new ArrayList<>();
        for (Task task : tasks) {
            if (task.isOverdue()) {
                result.add(task);
            }
        }
        return result;
    }
    
    public List<Task> getTasksDueToday() {
        List<Task> result = new ArrayList<>();
        for (Task task : tasks) {
            if (task.isDueToday()) {
                result.add(task);
            }
        }
        return result;
    }
    
    public List<WorkTask> getHighPriorityWorkTasks() {
        List<WorkTask> result = new ArrayList<>();
        for (Task task : tasks) {
            if (task instanceof WorkTask) {
                WorkTask workTask = (WorkTask) task;
                if (workTask.isHighPriority()) {
                    result.add(workTask);
                }
            }
        }
        return result;
    }
    
    public List<PersonalTask> getPersonalTasks() {
        List<PersonalTask> result = new ArrayList<>();
        for (Task task : tasks) {
            if (task instanceof PersonalTask) {
                PersonalTask personalTask = (PersonalTask) task;
                result.add(personalTask);
            }
        }
        return result;
    }
    
    public List<WorkTask> getWorkTasks() {
        List<WorkTask> result = new ArrayList<>();
        for (Task task : tasks) {
            if (task instanceof WorkTask) {
                WorkTask workTask = (WorkTask) task;
                result.add(workTask);
            }
        }
        return result;
    }
    
    public List<Task> searchTasksByTitle(String keyword) {
        List<Task> result = new ArrayList<>();
        String lowerKeyword = keyword.toLowerCase();
        for (Task task : tasks) {
            String taskTitle = task.getTitle().toLowerCase();
            if (taskTitle.contains(lowerKeyword)) {
                result.add(task);
            }
        }
        return result;
    }
    
    public List<Task> searchTasksByDescription(String keyword) {
        List<Task> result = new ArrayList<>();
        String lowerKeyword = keyword.toLowerCase();
        for (Task task : tasks) {
            String taskDescription = task.getDescription().toLowerCase();
            if (taskDescription.contains(lowerKeyword)) {
                result.add(task);
            }
        }
        return result;
    }
    
    public boolean markTaskAsCompleted(String taskId) {
        Task task = findTask(taskId);
        if (task != null) {
            task.markAsCompleted();
            return true;
        }
        return false;
    }
    
    public boolean markTaskAsInProgress(String taskId) {
        Task task = findTask(taskId);
        if (task != null) {
            task.markAsInProgress();
            return true;
        }
        return false;
    }
    
    public void displayAllTasks() {
        System.out.println("\nALL TASKS (" + tasks.size() + " tasks)");
        System.out.println("==================================================");
        
        if (tasks.isEmpty()) {
            System.out.println("No tasks found.");
            return;
        }
        
        for (int i = 0; i < tasks.size(); i++) {
            Task task = tasks.get(i);
            System.out.println((i + 1) + ". " + task.getTitle() + " [" + task.getStatus() + "]");
        }
    }
    
    public void displayAllTasksWithDetails() {
        System.out.println("\nALL TASKS WITH DETAILS (" + tasks.size() + " tasks)");
        System.out.println("=================================================================================");
        
        if (tasks.isEmpty()) {
            System.out.println("No tasks found.");
            return;
        }
        
        for (Task task : tasks) {
            task.displayTaskDetails();
            System.out.println("----------------------------------------");
        }
    }
    
    public void displayTaskSummary() {
        int todoCount = getTasksByStatus(TaskStatus.TODO).size();
        int inProgressCount = getTasksByStatus(TaskStatus.IN_PROGRESS).size();
        int completedCount = getTasksByStatus(TaskStatus.COMPLETED).size();
        int overdueCount = getOverdueTasks().size();
        int dueTodayCount = getTasksDueToday().size();
        int personalCount = getPersonalTasks().size();
        int workCount = getWorkTasks().size();
        
        System.out.println("\nTASK SUMMARY");
        System.out.println("==============================");
        System.out.println("To Do: " + todoCount + " tasks");
        System.out.println("In Progress: " + inProgressCount + " tasks");
        System.out.println("Completed: " + completedCount + " tasks [DONE]");
        
        if (overdueCount > 0) {
            System.out.println("Overdue: " + overdueCount + " tasks [OVERDUE]");
        } else {
            System.out.println("Overdue: " + overdueCount + " tasks");
        }
        
        if (dueTodayCount > 0) {
            System.out.println("Due Today: " + dueTodayCount + " tasks [TODAY]");
        } else {
            System.out.println("Due Today: " + dueTodayCount + " tasks");
        }
        
        System.out.println("Personal Tasks: " + personalCount + " tasks");
        System.out.println("Work Tasks: " + workCount + " tasks");
        System.out.println("Total Tasks: " + tasks.size() + " tasks");
    }
    
    public int getTotalTasks() {
        return tasks.size();
    }
    
    public boolean hasTasks() {
        return !tasks.isEmpty();
    }
    
    public void clearAllTasks() {
        tasks.clear();
        System.out.println("All tasks cleared! [CLEARED]");
    }
}
