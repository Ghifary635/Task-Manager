# TaskPro - Aplikasi Manajemen Tugas

Aplikasi web manajemen tugas modern yang dibangun dengan Java Servlet, JSP, dan MySQL. TaskPro membantu Anda mengatur tugas harian dengan sistem gamifikasi XP untuk meningkatkan produktivitas.

## ✨ Fitur Utama

- 📋 **Manajemen Tugas Lengkap** - Tambah, edit, hapus, dan filter tugas berdasarkan status
- ⏰ **Deadline dengan Waktu Spesifik** - Atur deadline hingga jam dan menit
- 🎯 **Kategori & Prioritas** - Organisir tugas dengan kategori (Personal, Work) dan level prioritas
- 🏆 **Sistem XP** - Dapatkan poin pengalaman saat menyelesaikan tugas
- 🚨 **Deteksi Overdue Otomatis** - Sistem otomatis menandai tugas yang terlewat deadline
- 🎨 **UI Modern & Responsif** - Desain yang elegan dengan animasi smooth
- 👤 **Profil User** - Upload foto profil dan kelola akun
- 🔍 **Pencarian** - Cari tugas dengan mudah

## 🛠️ Tech Stack

- **Backend**: Java Servlet, JSP
- **Database**: MySQL 8.0
- **Frontend**: HTML, CSS, JavaScript
- **Libraries**:
  - SweetAlert2 (Notifikasi)
  - Lucide Icons (Ikon)
  - Google Fonts (Typography)

## 📋 Prerequisites

Pastikan Anda sudah menginstall:

- [Java JDK 8+](https://www.oracle.com/java/technologies/downloads/)
- [Apache NetBeans IDE](https://netbeans.apache.org/download/index.html) atau IDE lain yang support Java Web
- [Apache Tomcat 9+](https://tomcat.apache.org/download-90.cgi)
- [MySQL 8.0+](https://dev.mysql.com/downloads/mysql/)
- [XAMPP](https://www.apachefriends.org/) (optional, untuk MySQL GUI)

## 🚀 Cara Install & Menjalankan

### 1. Clone/Download Project

```bash
git clone https://github.com/baysatriow/task_manager
cd TUBES
```

### 2. Setup Database

1. Buka MySQL (via XAMPP atau command line)
2. Buat database baru:
   ```sql
   CREATE DATABASE task_manager;
   ```
3. Import file SQL:

   - Buka phpMyAdmin atau MySQL Workbench
   - Pilih database `task_manager`
   - Import file `task_manager.sql` yang ada di root project

   **Atau via command line:**

   ```bash
   mysql -u root -p task_manager < task_manager.sql
   ```

### 3. Konfigurasi Database Connection

Edit file `src/java/jdbc/JDBC.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/task_manager";
private static final String USER = "root"; // sesuaikan username MySQL Anda
private static final String PASSWORD = ""; // sesuaikan password MySQL Anda
```

### 4. Setup Library Dependencies

1. Buka project di NetBeans
2. Klik kanan pada project → **Properties**
3. Pilih **Libraries** → **Add JAR/Folder**
4. Tambahkan file `mysql-connector-java.jar` dari folder `lib/`

### 5. Build & Run

1. Di NetBeans, klik kanan project → **Clean and Build**
2. Klik **Run** (atau tekan F6)
3. Browser akan otomatis membuka aplikasi di `http://localhost:8080/TUBES/`

## 👤 Default User

Setelah import database, Anda bisa login dengan:

- **Username**: `akmaludin`
- **Password**: `akmaludin`

## 📁 Struktur Project

```
TUBES/
├── src/java/
│   ├── jdbc/           # Database connection
│   ├── manager/        # Business logic
│   ├── model/          # Data models
│   └── servlets/       # Request handlers
├── web/
│   ├── layout/         # Header, Sidenav components
│   ├── feature/        # Feature pages
│   ├── index.jsp       # Main dashboard
│   ├── login.jsp       # Login page
│   └── register.jsp    # Register page
├── lib/                # External libraries
├── task_manager.sql    # Database structure & sample data
└── update_schema.sql   # Schema updates (REQUIRED)
```

## 🎯 Cara Pakai

1. **Register/Login** - Buat akun baru atau login dengan akun demo
2. **Tambah Tugas** - Klik tombol "Tambah Tugas Baru"
3. **Kelola Tugas** - Edit status, prioritas, atau deadline langsung dari card
4. **Dapatkan XP** - Tandai tugas sebagai "Selesai" untuk mendapat +10 XP
5. **Filter** - Gunakan sidebar untuk filter berdasarkan status atau waktu

## ⚠️ Troubleshooting

### Error: ClassNotFoundException (MySQL Connector)

- Pastikan `mysql-connector-java.jar` sudah ditambahkan ke Libraries
- Rebuild project (Clean and Build)

### Error: Database Connection Failed

- Cek apakah MySQL server sudah running
- Verifikasi username, password, dan database name di `JDBC.java`
- Pastikan port `3306` tidak diblokir

### Error: 404 Not Found

- Pastikan context path di `web.xml` sesuai
- Clear cache browser dan restart Tomcat

## 📝 Notes

- Sistem menggunakan **datetime** untuk deadline (bukan hanya tanggal)
- XP hanya diberikan **sekali** per task completion (anti-cheat)
- Task yang lewat deadline otomatis menjadi status **Overdue**
- Overdue task tidak bisa di-edit

## 👨‍💻 Developer

Dibuat dengan ❤️ untuk tugas PBO

---

**Happy Tasking! 🚀**
