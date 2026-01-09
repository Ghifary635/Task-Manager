package servlets;

import manager.AppManager;
import model.Priority;
import model.TaskStatus;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/UpdateTaskServlet")
public class UpdateTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            if (session.getAttribute("userId") == null) {
                res.sendRedirect("login.jsp");
                return;
            }

            int taskId = Integer.parseInt(req.getParameter("taskId"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String category = req.getParameter("category");
            Priority priority = Priority.valueOf(req.getParameter("priority"));
            TaskStatus status = TaskStatus.valueOf(req.getParameter("status"));

            String dateStr = req.getParameter("dueDate");
            Date dueDate = null;
            if (dateStr != null && !dateStr.trim().isEmpty()) {
                try {
                    dueDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(dateStr);
                } catch (Exception e) {
                    dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
                }
            }

            boolean success = AppManager.updateTask(taskId, title, description, category, priority, status, dueDate);

            if (success) {
                res.sendRedirect("index.jsp?task=updated");
            } else {
                res.sendRedirect("feature/update_task.jsp?id=" + taskId + "&error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/index.jsp?error=exception");
        }
    }
}