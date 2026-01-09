package servlets;

import manager.AppManager;
import model.Task;
import model.TaskStatus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SummaryServlet")
public class SummaryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Task> tasks = AppManager.getAllTasksFromDB(userId);

        int total = tasks.size();
        int pending = 0, inprogress = 0, completed = 0;

        for (Task t : tasks) {
            if (t.getStatus() == TaskStatus.PENDING)
                pending++;
            else if (t.getStatus() == TaskStatus.IN_PROGRESS)
                inprogress++;
            else if (t.getStatus() == TaskStatus.COMPLETED)
                completed++;
        }

        request.setAttribute("total", total);
        request.setAttribute("pending", pending);
        request.setAttribute("inprogress", inprogress);
        request.setAttribute("completed", completed);
        request.setAttribute("activeMenu", "summary");

        request.getRequestDispatcher("feature/summary.jsp")
                .forward(request, response);
    }
}
