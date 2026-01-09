package servlets;

import manager.AppManager;
import model.Task;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchTask")
public class SearchTaskServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String keyword = req.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            res.sendRedirect("Inbox");
            return;
        }

        List<Task> tasks = AppManager.searchTasks(userId, keyword);

        req.setAttribute("tasks", tasks);
        req.setAttribute("activeMenu", "search");
        req.setAttribute("searchKeyword", keyword);

        req.getRequestDispatcher("index.jsp").forward(req, res);
    }
} 