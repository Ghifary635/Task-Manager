package servlets;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import manager.AppManager;
import util.PasswordUtil; // Pastikan pakai PasswordUtil

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String oldPass = req.getParameter("oldPassword");
        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (!newPass.equals(confirm)) {
            res.sendRedirect(req.getContextPath() + "/feature/edit_profile.jsp?error=confirm");
            return;
        }

        // Hash input lama untuk dicocokkan
        String hashedOldPass = PasswordUtil.hash(oldPass);

        if (!AppManager.checkPassword(userId, hashedOldPass)) {
            res.sendRedirect(req.getContextPath() + "/feature/edit_profile.jsp?error=oldpass");
            return;
        }

        // Hash password baru sebelum disimpan
        AppManager.updatePassword(userId, PasswordUtil.hash(newPass));
        
        res.sendRedirect(req.getContextPath() + "/feature/edit_profile.jsp?success=password");
    }
}