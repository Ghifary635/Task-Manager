package servlets;

import manager.AppManager;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteTaskServlet")
public class DeleteTaskServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            AppManager.deleteTask(Integer.parseInt(idStr));
        }
        res.sendRedirect("index.jsp?task=deleted");
    }
}