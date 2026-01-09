<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="manager.AppManager, model.User" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    User user = AppManager.getUserById(userId);
    if (user == null) {
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profil | TaskPro</title>
    
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg-body: #f8fafc;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
        }

        .app-container {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            padding: 32px 48px;
            transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-left: 280px;
            min-width: 0; /* Prevents flex items from overflowing */
        }

        body.sidebar-collapsed .main-content {
            margin-left: 84px;
        }

        /* ===== PAGE HEADER ===== */
        .page-header {
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 8px;
        }

        .page-subtitle {
            font-size: 15px;
            color: var(--text-muted);
        }

        /* ===== SETTINGS GRID ===== */
        .settings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 32px;
            max-width: 1000px;
        }

        .settings-card {
            background: white;
            border-radius: 20px;
            padding: 32px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            animation: slideUp 0.4s ease-out;
            max-width: 500px;
            width: 100%;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card-header {
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border);
        }

        .card-icon {
            color: var(--primary);
            width: 24px;
            height: 24px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: #1e293b;
        }

        /* ===== FORMS (MATCHING LOGIN STYLE) ===== */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 8px;
            color: #475569;
            display: block;
        }

        .input-group-custom {
            position: relative;
            width: 100%;
            display: flex;
            align-items: center;
        }

        .input-group-custom i:not(.password-toggle i),
        .input-group-custom svg:not(.password-toggle svg) {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            width: 18px;
            height: 18px;
            pointer-events: none;
            z-index: 10;
        }

        .form-control-custom {
            display: block;
            width: 100%;
            padding: 12px 16px 12px 48px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            transition: all 0.2s;
            font-size: 14px;
            background: #ffffff;
            line-height: 1.5;
        }

        .form-control-custom:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .form-control-custom:disabled {
            background-color: #f1f5f9;
            color: #94a3b8;
            cursor: not-allowed;
        }

        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            cursor: pointer;
            border: none;
            background: transparent;
            padding: 8px;
            z-index: 20;
            display: flex;
            align-items: center;
            transition: all 0.2s;
            border-radius: 8px;
        }

        .password-toggle:hover {
            color: var(--primary);
            background-color: #f1f5f9;
        }

        /* ===== PROFILE IMAGE ===== */
        .profile-upload-container {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 24px;
        }

        .profile-preview, .profile-preview-initials {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            object-fit: cover;
            border: 2px solid var(--border);
            background: #f1f5f9;
        }

        .profile-preview-initials {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 800;
            color: white;
            background: linear-gradient(135deg, var(--primary), #818cf8);
            border: none;
        }

        .file-input-custom {
            display: none;
        }

        .file-label-custom {
            padding: 10px 16px;
            background: #f1f5f9;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .file-label-custom:hover {
            background: #e2e8f0;
            border-color: #cbd5e1;
        }

        /* ===== BUTTONS ===== */
        .btn-primary-custom {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
        }

        .btn-primary-custom:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
        }

        .btn-danger-custom {
            width: 100%;
            padding: 14px;
            background: #fef2f2;
            color: #ef4444;
            border: 1px solid #fecaca;
            border-radius: 12px;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
        }

        .btn-danger-custom:hover {
            background: #ef4444;
            color: white;
            border-color: #ef4444;
        }
    </style>
</head>
<body>

    <jsp:include page="../layout/header.jsp" />

    <div class="app-container">
        <jsp:include page="../layout/sidenav.jsp" />

        <main class="main-content">
            <header class="page-header">
                <h1 class="page-title">Profil & Keamanan</h1>
                <p class="page-subtitle">Kelola informasi akun dan tingkatkan keamanan kamu</p>
            </header>

            <div class="settings-grid">
                <!-- Profile Information -->
                <div class="settings-card">
                    <div class="card-header">
                        <i data-lucide="user" class="card-icon"></i>
                        <h2 class="card-title">Informasi Dasar</h2>
                    </div>
                    <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post" enctype="multipart/form-data">
                        <div class="profile-upload-container">
                            <div id="previewWrapper">
                                <% if (user.getProfileImage() == null || user.getProfileImage().isEmpty()) { %>
                                    <div class="profile-preview-initials" id="initialsPreview"><%= user.getInitials() %></div>
                                    <img src="" id="profilePreview" class="profile-preview" alt="Avatar" style="display: none;">
                                <% } else { %>
                                    <div class="profile-preview-initials" id="initialsPreview" style="display: none;"><%= user.getInitials() %></div>
                                    <img src="<%= request.getContextPath() + "/" + user.getProfileImage() %>" id="profilePreview" class="profile-preview" alt="Avatar">
                                <% } %>
                            </div>
                            <div>
                                <input type="file" name="profileImage" id="profileInput" class="file-input-custom" accept="image/*">
                                <label for="profileInput" class="file-label-custom">
                                    <i data-lucide="camera"></i> Unggah Foto
                                </label>
                                <p style="font-size: 11px; color: var(--text-muted); margin-top: 8px;">Format: JPG, PNG. Maks 5MB.</p>
                            </div>
                        </div>

                        <input type="hidden" name="currentImagePath" value="<%= user.getProfileImage() != null ? user.getProfileImage() : "" %>">

                        <div class="form-group">
                            <label class="form-label">Username (Tidak bisa diubah)</label>
                            <div class="input-group-custom">
                                <i data-lucide="at-sign"></i>
                                <input type="text" value="<%= user.getUsername() %>" class="form-control-custom" disabled>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Nama Lengkap</label>
                            <div class="input-group-custom">
                                <i data-lucide="credit-card"></i>
                                <input type="text" name="fullName" value="<%= user.getFullName() != null ? user.getFullName() : "" %>" 
                                       class="form-control-custom" placeholder="Masukkan nama lengkap" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <div class="input-group-custom">
                                <i data-lucide="mail"></i>
                                <input type="email" name="email" value="<%= user.getEmail() %>" 
                                       class="form-control-custom" placeholder="contoh@gmail.com" required>
                            </div>
                        </div>

                        <button type="submit" class="btn-primary-custom">
                            <i data-lucide="save"></i> Simpan Perubahan
                        </button>
                    </form>
                </div>

                <!-- Security / Password -->
                <div class="settings-card">
                    <div class="card-header">
                        <i data-lucide="shield-check" class="card-icon"></i>
                        <h2 class="card-title">Ganti Password</h2>
                    </div>
                    <form action="${pageContext.request.contextPath}/ChangePasswordServlet" method="post">
                        <div class="form-group">
                            <label class="form-label">Password Lama</label>
                            <div class="input-group-custom">
                                <i data-lucide="lock"></i>
                                <input type="password" name="oldPassword" class="form-control-custom password-input" 
                                       placeholder="••••••••" required>
                                <button type="button" class="password-toggle">
                                    <i data-lucide="eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password Baru</label>
                            <div class="input-group-custom">
                                <i data-lucide="key"></i>
                                <input type="password" name="newPassword" class="form-control-custom password-input" 
                                       placeholder="••••••••" required>
                                <button type="button" class="password-toggle">
                                    <i data-lucide="eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Konfirmasi Password Baru</label>
                            <div class="input-group-custom">
                                <i data-lucide="check-circle-2"></i>
                                <input type="password" name="confirmPassword" class="form-control-custom password-input" 
                                       placeholder="••••••••" required>
                                <button type="button" class="password-toggle">
                                    <i data-lucide="eye"></i>
                                </button>
                            </div>
                        </div>
                        <button type="submit" class="btn-danger-custom">
                            <i data-lucide="shield"></i> Perbarui Password
                        </button>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();

        // Image Preview
        document.getElementById('profileInput').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const img = document.getElementById('profilePreview');
                    const initials = document.getElementById('initialsPreview');
                    img.src = event.target.result;
                    img.style.display = 'block';
                    if (initials) initials.style.display = 'none';
                };
                reader.readAsDataURL(file);
            }
        });

        // Password Toggle
        document.querySelectorAll('.password-toggle').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.parentElement.querySelector('input');
                const icon = this.querySelector('i');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.setAttribute('data-lucide', 'eye-off');
                } else {
                    input.type = 'password';
                    icon.setAttribute('data-lucide', 'eye');
                }
                lucide.createIcons();
            });
        });

        // Alerts
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'updated') {
            Swal.fire({
                icon: 'success',
                title: 'Profil Diperbarui',
                text: 'Informasi profil kamu telah berhasil disimpan.',
                confirmButtonColor: '#4f46e5'
            });
            window.history.replaceState({}, document.title, window.location.pathname);
        }
        if (urlParams.get('error') === 'wrong_password') {
            Swal.fire({
                icon: 'error',
                title: 'Password Salah',
                text: 'Password lama yang kamu masukkan tidak sesuai.',
                confirmButtonColor: '#4f46e5'
            });
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    </script>
</body>
</html>