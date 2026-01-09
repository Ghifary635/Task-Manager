package servlets;

import jdbc.JDBC;
import util.PasswordUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // HASH PASSWORD SEBELUM SIMPAN!
        String hashedPassword = PasswordUtil.hash(password);

        JDBC db = new JDBC();
        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn
                        .prepareStatement(
                                "INSERT INTO users(username, full_name, email, password_hash) VALUES (?, ?, ?, ?)")) {

            ps.setString(1, username);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, hashedPassword); // Simpan hash

            ps.executeUpdate();
            response.sendRedirect("login.jsp?register=success");
        } catch (SQLIntegrityConstraintViolationException e) {
            response.sendRedirect("register.jsp?error=exists");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=true");
        } finally {
            db.disconnect();
        }
    }
}