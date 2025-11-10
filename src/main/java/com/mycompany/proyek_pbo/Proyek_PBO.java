/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.proyek_pbo;

import java.util.*;

/*
 * @author alghi
 */
public class Proyek_PBO {
    private static TaskManager taskManager = new TaskManager();
    private static Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        System.out.println("=== WELCOME TO TASK MANAGEMENT SYSTEM ===");
        System.out.println("==========================================");
        
        boolean running = true;
        
        while (running) {
            displayMainMenu();
            int choice = getIntInput("Choose an option: ");
            
            switch (choice) {
                case 1:
                    addNewTask();
                    break;
                case 2:
                    viewAllTasks();
                    break;
                case 3:
                    viewTaskDetails();
                    break;
                case 4:
                    updateTaskStatus();
                    break;
                case 5:
                    searchTasks();
                    break;
                case 6:
                    viewTaskSummary();
                    break;
                case 7:
                    deleteTask();
                    break;
                case 0:
                    running = false;
                    System.out.println("Thank you for using Task Manager! Goodbye!");
                    break;
                default:
                    System.out.println("Invalid option! Please try again.");
                    break;
            }
        }
        
        scanner.close();
        System.out.println("Program ended.");
    }
    
    private static void displayMainMenu() {
        System.out.println("\n=== MAIN MENU ===");
        System.out.println("1. Add New Task");
        System.out.println("2. View All Tasks");
        System.out.println("3. View Task Details");
        System.out.println("4. Update Task Status");
        System.out.println("5. Search Tasks");
        System.out.println("6. View Summary");
        System.out.println("7. Delete Task");
        System.out.println("0. Exit Program");
    }
    
    private static void addNewTask() {
        System.out.println("\n=== ADD NEW TASK ===");
        System.out.println("1. Personal Task");
        System.out.println("2. Work Task");
        int typeChoice = getIntInput("Choose task type: ");
        
        if (typeChoice != 1 && typeChoice != 2) {
            System.out.println("Invalid task type!");
            return;
        }
        
        System.out.print("Enter title: ");
        String title = scanner.nextLine();
        
        System.out.print("Enter description: ");
        String description = scanner.nextLine();
        
        System.out.print("Enter due date (yyyy-mm-dd): ");
        String dateInput = scanner.nextLine();
        Date dueDate = parseDate(dateInput);
        
        if (dueDate == null) {
            System.out.println("Invalid date format! Please use yyyy-mm-dd format.");
            return;
        }
        
        if (typeChoice == 1) {
            addPersonalTask(title, description, dueDate);
        } else {
            addWorkTask(title, description, dueDate);
        }
    }
    
    private static void addPersonalTask(String title, String description, Date dueDate) {
        PersonalTask personalTask = new PersonalTask(title, description, dueDate);
        taskManager.addTask(personalTask);
        System.out.println("Personal task added successfully!");
    }
    
    private static void addWorkTask(String title, String description, Date dueDate) {
        System.out.print("Enter project name: ");
        String projectName = scanner.nextLine();
        
        WorkTask workTask = new WorkTask(title, description, dueDate, projectName);
        
        System.out.println("Select priority:");
        System.out.println("1. Low");
        System.out.println("2. Medium"); 
        System.out.println("3. High");
        System.out.println("4. Urgent");
        
        int priorityChoice = getIntInput("Choose priority: ");
        Priority priority = getPriorityFromChoice(priorityChoice);
        workTask.setPriority(priority);
        
        taskManager.addTask(workTask);
        System.out.println("Work task added successfully!");
    }
    
    private static Priority getPriorityFromChoice(int choice) {
        switch (choice) {
            case 1:
                return Priority.LOW;
            case 2:
                return Priority.MEDIUM;
            case 3:
                return Priority.HIGH;
            case 4:
                return Priority.URGENT;
            default:
                System.out.println("Invalid priority choice, using MEDIUM as default.");
                return Priority.MEDIUM;
        }
    }
    
    private static void viewAllTasks() {
        taskManager.displayAllTasksWithDetails();
    }
    
    private static void viewTaskDetails() {
        taskManager.displayAllTasks();
        
        if (!taskManager.hasTasks()) {
            System.out.println("No tasks available.");
            return;
        }
        
        System.out.print("Enter task number to view details: ");
        int taskNumber = scanner.nextInt();
        scanner.nextLine();
        
        List<Task> tasks = taskManager.getAllTasks();
        if (taskNumber > 0 && taskNumber <= tasks.size()) {
            Task selectedTask = tasks.get(taskNumber - 1);
            selectedTask.displayTaskDetails();
        } else {
            System.out.println("Invalid task number! Please choose from 1 to " + tasks.size());
        }
    }
    
    private static void updateTaskStatus() {
        taskManager.displayAllTasks();
        
        if (!taskManager.hasTasks()) {
            System.out.println("No tasks available.");
            return;
        }
        
        System.out.print("Enter task number to update: ");
        int taskNumber = scanner.nextInt();
        scanner.nextLine();
        
        List<Task> tasks = taskManager.getAllTasks();
        if (taskNumber > 0 && taskNumber <= tasks.size()) {
            Task task = tasks.get(taskNumber - 1);
            
            System.out.println("Current status: " + task.getStatus());
            System.out.println("1. Mark as In Progress");
            System.out.println("2. Mark as Completed"); 
            System.out.println("3. Mark as Cancelled");
            
            int statusChoice = getIntInput("Choose new status: ");
            
            switch (statusChoice) {
                case 1:
                    task.markAsInProgress();
                    break;
                case 2:
                    task.markAsCompleted();
                    break;
                case 3:
                    task.markAsCancelled();
                    break;
                default:
                    System.out.println("Invalid choice! No changes made.");
                    break;
            }
        } else {
            System.out.println("Invalid task number! Please choose from 1 to " + tasks.size());
        }
    }
    
    private static void searchTasks() {
        System.out.println("\n=== SEARCH TASKS ===");
        System.out.println("1. Search by title");
        System.out.println("2. Search by description"); 
        System.out.println("3. Show overdue tasks");
        System.out.println("4. Show tasks due today");
        
        int searchChoice = getIntInput("Choose search type: ");
        
        switch (searchChoice) {
            case 1:
                searchByTitle();
                break;
            case 2:
                searchByDescription();
                break;
            case 3:
                showOverdueTasks();
                break;
            case 4:
                showTasksDueToday();
                break;
            default:
                System.out.println("Invalid choice!");
                break;
        }
    }
    
    private static void searchByTitle() {
        System.out.print("Enter title keyword: ");
        String keyword = scanner.nextLine();
        List<Task> results = taskManager.searchTasksByTitle(keyword);
        displaySearchResults(results);
    }
    
    private static void searchByDescription() {
        System.out.print("Enter description keyword: ");
        String keyword = scanner.nextLine();
        List<Task> results = taskManager.searchTasksByDescription(keyword);
        displaySearchResults(results);
    }
    
    private static void showOverdueTasks() {
        List<Task> results = taskManager.getOverdueTasks();
        displaySearchResults(results);
    }
    
    private static void showTasksDueToday() {
        List<Task> results = taskManager.getTasksDueToday();
        displaySearchResults(results);
    }
    
    private static void displaySearchResults(List<Task> results) {
        if (results.isEmpty()) {
            System.out.println("No tasks found.");
        } else {
            System.out.println("\nSEARCH RESULTS (" + results.size() + " tasks found)");
            for (int i = 0; i < results.size(); i++) {
                Task task = results.get(i);
                System.out.println((i + 1) + ". " + task.getTitle() + " [" + task.getStatus() + "]");
            }
        }
    }
    
    private static void viewTaskSummary() {
        taskManager.displayTaskSummary();
    }
    
    private static void deleteTask() {
        taskManager.displayAllTasks();
        
        if (!taskManager.hasTasks()) {
            System.out.println("No tasks available.");
            return;
        }
        
        System.out.print("Enter task number to delete: ");
        int taskNumber = scanner.nextInt();
        scanner.nextLine();
        
        List<Task> tasks = taskManager.getAllTasks();
        if (taskNumber > 0 && taskNumber <= tasks.size()) {
            Task task = tasks.get(taskNumber - 1);
            boolean success = taskManager.removeTask(task.getTaskId());
            if (success) {
                System.out.println("Task deleted successfully!");
            }
        } else {
            System.out.println("Invalid task number! Please choose from 1 to " + tasks.size());
        }
    }
    
    private static int getIntInput(String prompt) {
        System.out.print(prompt);
        try {
            int input = scanner.nextInt();
            scanner.nextLine();
            return input;
        } catch (InputMismatchException e) {
            scanner.nextLine();
            System.out.println("Invalid input! Please enter a number.");
            return -1;
        }
    }
    
    private static Date parseDate(String dateStr) {
        try {
            String[] parts = dateStr.split("-");

            if (parts.length != 3) {
                return null;
            }

            int year = Integer.parseInt(parts[0]) - 1900;
            int month = Integer.parseInt(parts[1]) - 1;
            int day = Integer.parseInt(parts[2]);

            if (month < 0 || month > 11 || day < 1 || day > 31) {
                return null;
            }

            // Set waktu menjadi 23:59:59
            Date date = new Date(year, month, day, 23, 59, 59);
            return date;

        } catch (Exception e) {
            return null;
        }
    }
}
