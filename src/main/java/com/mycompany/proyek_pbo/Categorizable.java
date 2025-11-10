/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mycompany.proyek_pbo;

/**
 *
 * @author alghi
 */
import java.util.List;

public interface Categorizable {
    void addCategory(String category);
    void removeCategory(String category);
    List<String> getCategories();
    boolean hasCategory(String category);
}