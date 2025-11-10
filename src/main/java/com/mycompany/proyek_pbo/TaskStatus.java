/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package com.mycompany.proyek_pbo;

/**
 *
 * @author alghi
 */
public enum TaskStatus {
    TODO("To Do", "[TODO]"),
    IN_PROGRESS("In Progress", "[IN PROGRESS]"),
    COMPLETED("Completed", "[DONE]"),
    CANCELLED("Cancelled", "[CANCELLED]");
    
    private final String displayName;
    private final String symbol;
    
    TaskStatus(String displayName, String symbol) {
        this.displayName = displayName;
        this.symbol = symbol;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public String getEmoji() {
        return symbol;
    }
    
    @Override
    public String toString() {
        return symbol + " " + displayName;
    }
}