package servlets;

import manager.AppManager;
import model.TaskStatus;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int taskId = Integer.parseInt(req.getParameter("taskId"));
            TaskStatus status = TaskStatus.valueOf(req.getParameter("status"));

            AppManager.updateTaskStatus(taskId, status, userId);

            res.sendRedirect(req.getContextPath() + "/index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/index.jsp?error=update_status");
        }
    }
}