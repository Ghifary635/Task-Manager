package com.mycompany.proyek_pbo.Main;

import java.util.*;
import java.text.ParseException;
import com.mycompany.proyek_pbo.Manager.AppManager;

public class Main {
    public static Scanner scanner = new Scanner(System.in);
    public static void main(String[] args) throws ParseException{
        boolean running = true;
        while (running){
            displayMainMenu();
            int choice = AppManager.inputMenu("Choose an option: ");

            switch(choice){
                case 1:
                    AppManager.addNewTask();
                    break;
                case 2:
                    AppManager.viewTaskInfo();
                    break;
                case 3:
                    AppManager.updateTaskStatus();
                    break;
                case 4:
                    AppManager.deleteTask();                   
                    break;
                case 5:
                    AppManager.searchTask();
                    break;
                case 6:
                    AppManager.viewSummary();
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

    public static void displayMainMenu() {
        System.out.println("\n=== MAIN MENU ===");
        System.out.println("1. Add New Task");
        System.out.println("2. View Tasks");
        System.out.println("3. Update Task Status");
        System.out.println("4. Delete Task");
        System.out.println("5. Search Task");
        System.out.println("6. View Task Summary");
        System.out.println("0. Exit Program");
        System.out.println();
    }

}