package com.mycompany.proyek_pbo.Manager;

import java.util.*;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import com.mycompany.proyek_pbo.Superclass.Task;
import com.mycompany.proyek_pbo.Enumerate.Priority;
import com.mycompany.proyek_pbo.Enumerate.TaskStatus;
import com.mycompany.proyek_pbo.Subclass.PersonalTask;
import com.mycompany.proyek_pbo.Subclass.WorkTask;

public class AppManager {
    public static List<Task> taskList = new ArrayList<>();
    public static Scanner scanner = new Scanner(System.in);

    public static void addNewTask()throws ParseException{
        System.out.println("=== ADD NEW TASK ===");
        System.out.println("1. Personal Task");
        System.out.println("2. Work Task");
        System.out.println();
        int typeChoice = inputMenu("Choose task type: ");

        if (typeChoice != 1 && typeChoice != 2){
            System.out.println("Invalid task type!");
            return;
        }

        if (typeChoice == 1){
            System.out.print("Enter title: ");
            String title = scanner.nextLine();
            System.out.print("Enter description: ");
            String description = scanner.nextLine();
            System.out.print("Enter due date (yyyymmdd): ");
            String dateInput = scanner.nextLine();
            Date dueDate = parseDate(dateInput);
            if (dueDate == null) {
                System.out.println("Invalid date format! Please use yyyy-mm-dd format.");
                return;
            }
            PersonalTask tp = new PersonalTask(title, description, dueDate);
            taskList.add(tp);
        }
        else if (typeChoice == 2){
            System.out.print("Enter title: ");
            String title = scanner.nextLine();
            System.out.print("Enter description: ");
            String description = scanner.nextLine();
            System.out.print("Enter due date (yyyymmdd): ");
            String dateInput = scanner.nextLine();
            Date dueDate = parseDate(dateInput);
            if (dueDate == null) {
                System.out.println("Invalid date format! Please use yyyy-mm-dd format.");
                return;
            }
            System.out.print("Enter project name: ");
            String projectName = scanner.nextLine();
            WorkTask tw = new WorkTask(title, description, dueDate, projectName);
            System.out.println("Select priority:");
            System.out.println("1. Low");
            System.out.println("2. Medium"); 
            System.out.println("3. High");
            int priorityChoice = inputMenu("Choose Priority: ");
            switch (priorityChoice) {
                case 1:
                    tw.setPriority(Priority.LOW);
                    break;
                case 2:
                    tw.setPriority(Priority.MEDIUM);
                    break;
                case 3:
                    tw.setPriority(Priority.HIGH);
                    break;
                default:
                    System.out.println("Invalid option! Please try again.");
                    break;
            }
            taskList.add(tw);
        }
    }

    public static void viewTaskInfo(){
        if (taskList.isEmpty()){
            System.out.println("No task found");
            return;
        }
        else{
            System.out.println("\n=== VIEW TASK ===");
            System.out.println("1. View all task");
            System.out.println("2. View single task");
            System.out.println("3. View overdue task");
            System.out.println("4. View due today task");
            int viewChoice = inputMenu("Choose view option: ");
            switch (viewChoice){
                case 1:
                    System.out.println("\n=== VIEW ALL TASK ===");
                    for (int i = 0; i < taskList.size(); i++){
                        taskList.get(i).printInfo();
                    }
                    break;
                case 2:
                    System.out.println("\n=== VIEW SINGLE TASK ===");
                    for (int i = 0; i < taskList.size(); i++) {
                        Task t = taskList.get(i);
                        System.out.printf("%d. (%s) %s [%s]\n",
                            i + 1,
                            t.getTaskId(),
                            t.getTitle(),
                            t.getStatus()
                        );
                    }
                    System.out.print("Select task number to update: ");
                    int taskChoice = inputMenu("");
                    if (taskChoice < 1 || taskChoice > taskList.size()){
                        System.out.println("Invalid choice!");
                        return;
                    }
                    Task selectedTask = taskList.get(taskChoice - 1);
                    selectedTask.printInfo();
                    break;
                case 3:
                    System.out.println("\n=== VIEW OVERDUE TASK ===");
                    for (int i = 0; i < taskList.size(); i++){
                        if (taskList.get(i).isOverdue()){
                            taskList.get(i).printInfo();
                        }
                    }
                    break;
                case 4:
                    System.out.println("\n=== VIEW TASK DUE TODAY===");
                    for (int i = 0; i < taskList.size(); i++){
                        if (taskList.get(i).isDueToday()){
                            taskList.get(i).printInfo();
                        }
                    }
                    break;
                default:
                    System.out.println("Invalid option! Please try again.");
                    break;
            }
        }
    }

    public static void updateTaskStatus(){
        if (taskList.isEmpty()){
            System.out.println("No task found");
            return;
        }

        System.out.println("\n=== UPDATE TASK STATUS ===");
        for (int i = 0; i < taskList.size(); i++) {
            Task t = taskList.get(i);
            System.out.printf("%d. (%s) %s [%s]\n",
                i + 1,
                t.getTaskId(),
                t.getTitle(),
                t.getStatus()
            );
        }
        System.out.print("Select task number to update: ");
        int taskChoice = inputMenu("");
        if (taskChoice < 1 || taskChoice > taskList.size()){
            System.out.println("Invalid choice!");
            return;
        }
        Task selectedTask = taskList.get(taskChoice - 1);

        System.out.println("Current status: " + selectedTask.getStatus());
        System.out.println("Choose new status:");
        System.out.println("1. In Progress");
        System.out.println("2. Completed");
        System.out.println("3. Cancelled");
        System.out.print("Enter choice: ");
        int statusChoice = inputMenu("");
        switch(statusChoice){
            case 1:
                selectedTask.setStatus(TaskStatus.IN_PROGRESS);
                System.out.println("Status updated");
                break;
            case 2:
                selectedTask.setStatus(TaskStatus.COMPLETED);
                System.out.println("Status updated");
                break;
            case 3:
                selectedTask.setStatus(TaskStatus.CANCELLED);
                System.out.println("Status updated");
                break;
            default:
                System.out.println("Invalid status choice!");
                break;
        }
    }
    
    public static void deleteTask(){
        if (taskList.isEmpty()){
            System.out.println("No task found");
            return;
        }

        System.out.println("\n=== DELETE TASK ===");
        for (int i = 0; i < taskList.size(); i++) {
            Task t = taskList.get(i);
            System.out.printf("%d. (%s) %s [%s]\n",
                i + 1,
                t.getTaskId(),
                t.getTitle(),
                t.getStatus()
            );
        }
        System.out.print("Select task number to update: ");
        int taskChoice = inputMenu("");
        if (taskChoice < 1 || taskChoice > taskList.size()){
            System.out.println("Invalid choice!");
            return;
        }
        taskList.remove(taskChoice - 1);
        System.out.println("Task deleted successfully!");
    }
    
    public static void searchTask(){
        if (taskList.isEmpty()) {
            System.out.println("No tasks available to search.");
            return;
        }

        System.out.println("\n=== SEARCH TASK ===");
        System.out.println("1. Search by ID");
        System.out.println("2. Search by Title");
        int choice = inputMenu("Choose an option: ");
        switch (choice) {
            case 1:
                System.out.print("Enter Task ID: ");
                String id = scanner.nextLine();

                boolean found = false;
                for (int i = 0; i < taskList.size(); i++) {
                    Task t = taskList.get(i);
                    if (t.getTaskId().equals(id)) {
                        System.out.printf("%d. (%s) %s [%s]\n",
                        1,
                        t.getTaskId(),
                        t.getTitle(),
                        t.getStatus()
                        );
                        found = true;
                    }
                }

                if (!found) {
                    System.out.println("No task found with ID " + id);
                }
                break;

            case 2:
                System.out.print("Enter title keyword: ");
                String keyword = scanner.nextLine().toLowerCase();

                List<Task> results = new ArrayList<>();
                for (Task t : taskList) {
                    if (t.getTitle().toLowerCase().contains(keyword)) {
                        results.add(t);
                    }
                }

                if (results.isEmpty()) {
                    System.out.println("No tasks found matching '" + keyword + "'");
                }
                else{
                    int i = 1;
                    for(Task r : results){
                        System.out.printf("%d. (%s) %s [%s]\n",
                        i,
                        r.getTaskId(),
                        r.getTitle(),
                        r.getStatus()
                        );
                        i++;
                    }
                }
                break;
            default:
                System.out.println("Invalid option!");
                break;
        }
    
    }
    
    public static void viewSummary(){
        System.out.println("=== TASK SUMMARY ===");

        if (taskList.isEmpty()) {
            System.out.println("No tasks available!");
            return;
        }

        int totalTasks = taskList.size();
        int personalCount = 0;
        int workCount = 0;

        int todoCount = 0;
        int inProgressCount = 0;
        int completedCount = 0;

        int dueTodayCount = 0;
        int overdueCount = 0;

        for (Task t : taskList) {
            if (t instanceof PersonalTask) personalCount++;
            else if (t instanceof WorkTask) workCount++;

            switch (t.getStatus()) {
                case TODO:
                    todoCount++;
                    break;
                case IN_PROGRESS:
                    inProgressCount++;
                    break;
                case COMPLETED:
                    completedCount++;
                    break;
                default:
            }

            if (t.isDueToday()) dueTodayCount++;
            if (t.isOverdue()) overdueCount++;
        }

        System.out.println("Total tasks: " + totalTasks);
        System.out.println("Personal tasks: " + personalCount);
        System.out.println("Work tasks: " + workCount);
        System.out.println();

        System.out.println("Status breakdown:");
        System.out.println("TODO: " + todoCount);
        System.out.println("IN PROGRESS: " + inProgressCount);
        System.out.println("COMPLETED: " + completedCount);
        System.out.println();

        System.out.println("Deadlines:");
        System.out.println("Due today: " + dueTodayCount);
        System.out.println("Overdue: " + overdueCount);
    }

    // Fungsional
    public static int inputMenu(String prompt) {
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

    public static Date parseDate(String d) throws ParseException{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar cal = Calendar.getInstance();
        Date date = sdf.parse(d);

        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 0);

        return cal.getTime();
    }

}
