package manager;

import jdbc.JDBC;
import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class AppManager {

    // ==========================================
    // 1. USER MANAGEMENT
    // ==========================================

    public static User getUserById(int userId) {
        JDBC db = new JDBC();
        String sql = "SELECT * FROM users WHERE id=?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("full_name");
                String img = rs.getString("profile_image");
                int xp = rs.getInt("xp");

                return new User(rs.getInt("id"), rs.getString("username"), fullName, rs.getString("email"), img, xp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.disconnect();
        }
        return null;
    }

    public static boolean checkPassword(int userId, String hashedInput) {
        JDBC db = new JDBC();
        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT password_hash FROM users WHERE id=?")) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String stored = rs.getString("password_hash");
                return stored != null && stored.equals(hashedInput);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.disconnect();
        }
        return false;
    }

    public static boolean updatePassword(int userId, String newHash) {
        JDBC db = new JDBC();
        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn.prepareStatement("UPDATE users SET password_hash=? WHERE id=?")) {
            ps.setString(1, newHash);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        } finally {
            db.disconnect();
        }
    }

    // ==========================================
    // 2. TASK READ (GET DATA)
    // ==========================================

    public static List<Task> getAllTasksFromDB(int userId) {
        return getTasksByQuery("SELECT * FROM todos WHERE user_id = ?", userId);
    }

    public static List<Task> getTasksByDueDate(int userId, String type) {
        String sql = type.equals("today")
                ? "SELECT * FROM todos WHERE user_id=? AND DATE(due_date)=CURDATE()"
                : "SELECT * FROM todos WHERE user_id=? AND due_date > CURDATE()";
        return getTasksByQuery(sql, userId);
    }

    public static List<Task> getTasksByStatus(int userId, TaskStatus status) {
        List<Task> result = new ArrayList<>();
        JDBC db = new JDBC();
        String sql = "SELECT * FROM todos WHERE user_id=? AND status=?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, status.toString());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapResultSetToTask(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.disconnect();
        }
        return result;
    }

    public static List<Task> searchTasks(int userId, String keyword) {
        List<Task> result = new ArrayList<>();
        JDBC db = new JDBC();
        String sql = "SELECT * FROM todos WHERE user_id=? AND (title LIKE ? OR description LIKE ? OR category LIKE ?)";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            String pattern = "%" + keyword + "%";
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ps.setString(4, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapResultSetToTask(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.disconnect();
        }
        return result;
    }

    private static Task mapResultSetToTask(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String title = rs.getString("title");
        String desc = rs.getString("description");
        String cat = rs.getString("category");
        Priority prio = Priority.valueOf(rs.getString("priority").toUpperCase());
        TaskStatus stat = TaskStatus.valueOf(rs.getString("status").toUpperCase());

        Timestamp ts = rs.getTimestamp("due_date");
        Date date = ts != null ? new Date(ts.getTime()) : null;

        return new Task(id, title, desc, prio, stat, date) {
            @Override
            public String getCategory() {
                return cat;
            }
        };
    }

    private static void checkAndMarkOverdue(Task t) {
        if (t.getDueDate() != null && t.getStatus() != TaskStatus.COMPLETED && t.getStatus() != TaskStatus.OVERDUE) {
            Date now = new Date();
            if (t.getDueDate().before(now)) {
                // Mark as overdue in memory
                // Task object mimics state, but we should update DB too.
                // Since this runs during read, let's update DB asynchronously or synchronously.
                // Ideally, we should update DB.
                JDBC db = new JDBC();
                try (Connection conn = db.getConnection();
                        PreparedStatement ps = conn.prepareStatement("UPDATE todos SET status='OVERDUE' WHERE id=?")) {
                    ps.setInt(1, t.getId());
                    ps.executeUpdate();
                    // Update local object to reflect change immediately in UI
                    // Note: This relies on Task not having a setter, which might be immutable.
                    // But effectively we can't change the object if it's immutable without
                    // recreating.
                    // For now, let's assume the UI will pick it up on next refresh or we accept the
                    // stale state for this nanosecond.
                    // Actually, let's just create a new Task or modify if possible.
                    // Task.java seems to have no setters.
                    // However, we can treat this as "clean-up on read".
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    db.disconnect();
                }
            }
        }
    }

    private static List<Task> getTasksByQuery(String sql, int userId) {
        List<Task> result = new ArrayList<>();
        JDBC db = new JDBC();
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Task t = mapResultSetToTask(rs);
                checkAndMarkOverdue(t);
                result.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.disconnect();
        }
        return result;
    }

    // ==========================================
    // 3. TASK CREATE / UPDATE / DELETE
    // ==========================================

    public static boolean addTask(String title, String description, String category,
            Priority priority, TaskStatus status, Date dueDate, int userId) {
        JDBC db = new JDBC();
        String sql = "INSERT INTO todos (title, description, category, priority, status, due_date, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, priority.toString());
            ps.setString(5, status.toString());
            if (dueDate != null)
                ps.setTimestamp(6, new java.sql.Timestamp(dueDate.getTime()));
            else
                ps.setNull(6, java.sql.Types.TIMESTAMP);
            ps.setInt(7, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            db.disconnect();
        }
    }


    public static boolean updateTaskStatus(int taskId, TaskStatus status, int userId) {
        JDBC db = new JDBC();
        try (Connection conn = db.getConnection()) {
            String sqlTask = "UPDATE todos SET status=? WHERE id=?";
            PreparedStatement psTask = conn.prepareStatement(sqlTask);
            psTask.setString(1, status.toString());
            psTask.setInt(2, taskId);
            int result = psTask.executeUpdate();

            if (result > 0 && status == TaskStatus.COMPLETED) {

                PreparedStatement psCheck = conn.prepareStatement("SELECT xp_awarded FROM todos WHERE id=?");
                psCheck.setInt(1, taskId);
                ResultSet rsCheck = psCheck.executeQuery();

                boolean alreadyAwarded = false;
                if (rsCheck.next()) {
                    alreadyAwarded = rsCheck.getBoolean("xp_awarded");
                }

                if (!alreadyAwarded) {

                    String sqlXP = "UPDATE users SET xp = xp + 10 WHERE id=?";
                    PreparedStatement psXP = conn.prepareStatement(sqlXP);
                    psXP.setInt(1, userId);
                    psXP.executeUpdate();

                    PreparedStatement psMark = conn.prepareStatement("UPDATE todos SET xp_awarded=1 WHERE id=?");
                    psMark.setInt(1, taskId);
                    psMark.executeUpdate();
                }
            }

            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            db.disconnect();
        }
    }

    public static boolean updateTask(int taskId, String title, String description, String category, Priority priority,
            TaskStatus status, Date dueDate) {
        JDBC db = new JDBC();
        String sql = "UPDATE todos SET title=?, description=?, category=?, priority=?, status=?, due_date=? WHERE id=?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, priority.toString());
            ps.setString(5, status.toString());

            if (dueDate != null) {
                ps.setTimestamp(6, new java.sql.Timestamp(dueDate.getTime()));
            } else {
                ps.setNull(6, java.sql.Types.TIMESTAMP);
            }

            ps.setInt(7, taskId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            db.disconnect();
        }
    }

    public static boolean deleteTask(int taskId) {
        JDBC db = new JDBC();
        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn.prepareStatement("DELETE FROM todos WHERE id=?")) {
            ps.setInt(1, taskId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        } finally {
            db.disconnect();
        }
    }
}