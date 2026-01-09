package servlets;

import jdbc.JDBC;
import util.PasswordUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String input = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");

        String hashedPassword = PasswordUtil.hash(password); // Hash input user

        JDBC db = new JDBC();
        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn
                        .prepareStatement("SELECT * FROM users WHERE (username=? OR email=?) AND password_hash=?")) {

            ps.setString(1, input);
            ps.setString(2, input);
            ps.setString(3, hashedPassword); // Bandingkan hash

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("username", rs.getString("username"));
                response.sendRedirect("Inbox?login=success");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=error");
        } finally {
            db.disconnect();
        }
    }
}