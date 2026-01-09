package servlets;

import manager.AppManager;
import model.Task;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Today")
public class TodayServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        List<Task> tasks = AppManager.getTasksByDueDate(userId, "today");

        req.setAttribute("tasks", tasks);
        req.setAttribute("activeMenu", "today");

        req.getRequestDispatcher("index.jsp").forward(req, res);
    }
}
