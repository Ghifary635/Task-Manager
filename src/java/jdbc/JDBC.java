package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class JDBC {
    private Connection con;
    private Statement stmt;
    private boolean isConnected;
    private String message;

    // Konfigurasi XAMPP Default
    private static final String DB_URL = "jdbc:mysql://localhost:3307/task_manager";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = ""; 

    public JDBC() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connect(); // Auto connect saat objek dibuat
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC tidak ditemukan: " + e.getMessage());
        }
    }

    public void connect() {
        try {
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = con.createStatement();
            isConnected = true;
        } catch (SQLException e) {
            isConnected = false;
            System.err.println("Koneksi Gagal: " + e.getMessage());
        }
    }

    public void disconnect() {
        try {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
            isConnected = false;
        } catch (SQLException e) { }
    }

    public Connection getConnection() {
        try {
            if (con == null || con.isClosed()) connect();
        } catch (SQLException e) { connect(); }
        return con;
    }

    public boolean isConnected() { return isConnected; }
}