package model;

public class User {
    private int id;
    private String username;
    private String fullName; // Field Baru
    private String email;
    private String profileImage;
    private int xp;

    public User(int id, String username, String fullName, String email, String profileImage, int xp) {
        this.id = id;
        this.username = username;
        this.fullName = fullName;
        this.email = email;
        this.profileImage = profileImage;
        this.xp = xp;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public int getXp() {
        return xp;
    }

    // --- LOGIKA GAME ---

    // Level naik setiap 100 XP
    public int getLevel() {
        return 1 + (xp / 100);
    }

    // Hitung progress bar ke level selanjutnya (0% - 100%)
    public int getLevelProgress() {
        return xp % 100;
    }

    // Julukan Lucu berdasarkan Level
    public String getTitle() {
        int lvl = getLevel();
        if (lvl < 5)
            return "🌱 Kaum Rebahan";
        if (lvl < 10)
            return "🔥 Pejuang Deadline";
        if (lvl < 20)
            return "⚡ Dewa Produktivitas";
        return "👽 Maaf, Anda Kurang Piknik";
    }

    public String getDisplayName() {
        if (fullName != null && !fullName.trim().isEmpty()) {
            return fullName;
        }
        return username;
    }

    public String getInitials() {
        String name = getDisplayName();
        if (name != null && !name.isEmpty()) {
            return name.substring(0, 1).toUpperCase();
        }
        return "?";
    }
}