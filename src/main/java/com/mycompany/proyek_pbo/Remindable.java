/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mycompany.proyek_pbo;

/**
 *
 * @author alghi
 */
import java.util.Date;
public interface Remindable {
    void setReminder(Date reminderTime);
    void cancelReminder();
    boolean isReminderSet();
    Date getReminderTime();
}
