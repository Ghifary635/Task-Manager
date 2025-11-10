/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package com.mycompany.proyek_pbo;

/**
 *
 * @author alghi
 */
public enum Priority {
    LOW("Low", "[LOW]"),
    MEDIUM("Medium", "[MEDIUM]"), 
    HIGH("High", "[HIGH]"),
    URGENT("Urgent", "[URGENT]");
    
    private final String displayName;
    private final String symbol;
    
    Priority(String displayName, String symbol) {
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