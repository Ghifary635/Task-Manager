package servlets;

import manager.AppManager;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/feature/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            Priority priority = Priority.valueOf(request.getParameter("priority").toUpperCase());
            TaskStatus status = TaskStatus.valueOf(request.getParameter("status").toUpperCase());

            String dateStr = request.getParameter("dueDate");
            Date dueDate = null;
            if (dateStr != null && !dateStr.isEmpty()) {
                try {
                    // Try parsing with time (datetime-local format)
                    dueDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(dateStr);
                } catch (Exception e) {
                    // Fallback to simple date
                    dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
                }
            }

            boolean success = AppManager.addTask(title, description, category, priority, status, dueDate, userId);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?task=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=addfailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=addfailed");
        }
    }
}
