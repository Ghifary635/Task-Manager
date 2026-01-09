package servlets;

import jdbc.JDBC;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String newFullName = req.getParameter("fullName");
        String newEmail = req.getParameter("email");
        String currentImagePath = req.getParameter("currentImagePath");

        // --- Handle Profile Image Upload ---
        String imagePath = currentImagePath;
        Part filePart = req.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator + "profiles";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);
            imagePath = "uploads/profiles/" + fileName;
        }

        JDBC db = new JDBC();
        String sql = "UPDATE users SET full_name=?, email=?, profile_image=? WHERE id=?";

        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newFullName);
            ps.setString(2, newEmail);
            ps.setString(3, imagePath);
            ps.setInt(4, userId);

            int result = ps.executeUpdate();
            if (result > 0) {
                // Redirect balik ke folder feature/edit_profile.jsp
                res.sendRedirect(req.getContextPath() + "/feature/edit_profile.jsp?success=updated");
            } else {
                res.sendRedirect(req.getContextPath() + "/feature/edit_profile.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/feature/edit_profile.jsp?error=exception");
        } finally {
            db.disconnect();
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
