package servlets;

import manager.AppManager;
import model.Task;
import model.TaskStatus;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/FilterTask")
public class FilterTaskServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 1. Cek Login
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        // 2. Ambil parameter status dari link (misal: ?status=PENDING)
        String statusStr = req.getParameter("status");
        
        try {
            TaskStatus status = TaskStatus.valueOf(statusStr); // Convert String ke Enum
            
            // 3. Ambil data dari Database
            List<Task> tasks = AppManager.getTasksByStatus(userId, status);
            
            // 4. Kirim ke JSP
            req.setAttribute("tasks", tasks);
            req.setAttribute("activeMenu", statusStr.toLowerCase()); // Untuk highlight sidebar (opsional)
            req.getRequestDispatcher("index.jsp").forward(req, res);
            
        } catch (Exception e) {
            // Jika status tidak valid, balik ke Inbox
            res.sendRedirect("Inbox");
        }
    }
}