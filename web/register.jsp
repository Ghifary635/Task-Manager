<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="id">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar | TaskPro</title>
        <!-- Google Fonts: Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Lucide Icons -->
        <script src="https://unpkg.com/lucide@latest"></script>
        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            :root {
                --primary: #4f46e5;
                --primary-hover: #4338ca;
                --secondary: #64748b;
                --bg-glass: rgba(255, 255, 255, 0.85);
                --text-main: #1e293b;
            }

            body {
                font-family: 'Inter', sans-serif;
                margin: 0;
                background-color: #f8fafc;
                color: var(--text-main);
                overflow-x: hidden;
            }

            .auth-container {
                min-height: 100vh;
                display: flex;
            }

            /* Left Side: Visual */
            .auth-visual {
                flex: 1;
                background: linear-gradient(rgba(79, 70, 229, 0.1), rgba(79, 70, 229, 0.1)), url('img/productivity_bg.png') center/cover no-repeat;
                display: none;
                position: relative;
            }

            @media (min-width: 992px) {
                .auth-visual {
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    padding: 60px;
                    color: white;
                }

                .visual-overlay {
                    position: absolute;
                    inset: 0;
                    background: linear-gradient(135deg, rgba(30, 41, 59, 0.8) 0%, rgba(79, 70, 229, 0.4) 100%);
                    z-index: 1;
                }

                .visual-content {
                    position: relative;
                    z-index: 2;
                    max-width: 500px;
                }
            }

            /* Right Side: Form */
            .auth-form-section {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
                background-color: #ffffff;
            }

            .form-card {
                width: 100%;
                max-width: 420px;
                padding: 20px;
            }

            .brand-logo {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 32px;
                color: var(--primary);
                text-decoration: none;
            }

            .brand-name {
                font-size: 24px;
                font-weight: 700;
                letter-spacing: -0.5px;
            }

            h1 {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 8px;
                color: #0f172a;
            }

            .subtitle {
                color: var(--secondary);
                margin-bottom: 32px;
            }

            .form-label {
                font-weight: 500;
                font-size: 14px;
                margin-bottom: 8px;
                color: #475569;
            }

            .input-group-custom {
                position: relative;
                margin-bottom: 20px;
                width: 100%;
            }

            .input-group-custom i:not(.password-toggle i),
            .input-group-custom svg:not(.password-toggle svg) {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                color: #94a3b8;
                width: 20px;
                height: 20px;
                pointer-events: none;
                z-index: 10;
            }

            .password-toggle {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: #94a3b8;
                cursor: pointer;
                border: 1px solid transparent;
                background: transparent;
                padding: 4px;
                z-index: 20;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                border-radius: 8px;
            }

            .password-toggle:hover {
                color: var(--primary);
                background-color: #f1f5f9;
            }

            .password-toggle:focus {
                outline: none;
            }

            .password-toggle svg {
                width: 20px;
                height: 20px;
                pointer-events: auto !important;
            }

            .form-control-custom {
                width: 100%;
                padding: 12px 16px 12px 48px;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                transition: all 0.2s;
                font-size: 15px;
            }

            .form-control-custom:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
            }

            .btn-primary-custom {
                width: 100%;
                padding: 14px;
                background-color: var(--primary);
                color: white;
                border: none;
                border-radius: 12px;
                font-weight: 600;
                font-size: 16px;
                transition: background 0.2s;
                margin-top: 10px;
            }

            .btn-primary-custom:hover {
                background-color: var(--primary-hover);
            }

            .alert-error {
                background-color: #fef2f2;
                border: 1px solid #fee2e2;
                color: #b91c1c;
                padding: 12px;
                border-radius: 10px;
                font-size: 14px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .footer-links {
                text-align: center;
                margin-top: 32px;
                font-size: 14px;
                color: var(--secondary);
            }

            .footer-links a {
                color: var(--primary);
                font-weight: 600;
                text-decoration: none;
            }

            .footer-links a:hover {
                text-decoration: underline;
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .form-card {
                animation: fadeInUp 0.5s ease-out;
            }
        </style>
    </head>

    <body>

        <div class="auth-container">
            <!-- Left Visual -->
            <div class="auth-visual">
                <div class="visual-overlay"></div>
                <div class="visual-content">
                    <h2 class="display-4 fw-bold mb-4">Mulai Perjalanan Anda Hari Ini</h2>
                    <p class="lead opacity-75">Kelola waktu Anda dengan lebih baik. Buat akun sekarang dan mulai atur
                        tugas harian Anda dengan TaskPro.</p>
                    <div class="mt-5 d-flex gap-4">
                        <div class="stat">
                            <h3 class="fw-bold mb-0">Gratis</h3>
                            <p class="small opacity-50">Selamanya</p>
                        </div>
                        <div class="stat">
                            <h3 class="fw-bold mb-0">Aman</h3>
                            <p class="small opacity-50">Enkripsi Data</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Form -->
            <div class="auth-form-section">
                <div class="form-card">
                    <a href="#" class="brand-logo">
                        <i data-lucide="check-circle"></i>
                        <span class="brand-name">TaskPro</span>
                    </a>

                    <h1>Buat Akun</h1>
                    <p class="subtitle">Bergabung dengan TaskPro dan tetap produktif.</p>

                    <%-- Alert logic moved to SweetAlert2 script at the bottom --%>

                        <form action="register" method="post">
                            <div class="input-group-custom">
                                <i data-lucide="user"></i>
                                <input type="text" name="username" class="form-control-custom" placeholder="Username"
                                    required>
                            </div>

                            <div class="input-group-custom">
                                <i data-lucide="credit-card"></i>
                                <input type="text" name="fullName" class="form-control-custom" placeholder="Nama Lengkap"
                                    required>
                            </div>

                            <div class="input-group-custom">
                                <i data-lucide="mail"></i>
                                <input type="email" name="email" class="form-control-custom" placeholder="Alamat Email"
                                    required>
                            </div>

                            <div class="input-group-custom">
                                <i data-lucide="lock"></i>
                                <input type="password" id="password" name="password" class="form-control-custom"
                                    placeholder="Password" required style="padding-right: 48px;">
                                <button type="button" class="password-toggle" id="togglePassword">
                                    <i data-lucide="eye" id="eyeIcon"></i>
                                </button>
                            </div>

                            <button type="submit" class="btn-primary-custom">Daftar Sekarang</button>
                        </form>

                        <div class="footer-links">
                            Sudah punya akun? <a href="login.jsp">Masuk di sini</a>
                        </div>
                </div>
            </div>
        </div>

        <script>
            lucide.createIcons();

            // Handle URL parameters for alerts
            const urlParams = new URLSearchParams(window.location.search);

            if (urlParams.has('error')) {
                let title = 'Gagal Daftar';
                let message = 'Terjadi kesalahan saat pendaftaran.';
                if (urlParams.get('error') === 'exists') {
                    message = 'Username atau email sudah terdaftar.';
                }
                Swal.fire({
                    icon: 'error',
                    title: title,
                    text: message,
                    confirmButtonColor: '#4f46e5'
                });
            }

            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#password');
            const eyeIcon = document.querySelector('#eyeIcon');

            if (togglePassword) {
                togglePassword.addEventListener('click', function (e) {
                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                    password.setAttribute('type', type);

                    if (type === 'password') {
                        eyeIcon.setAttribute('data-lucide', 'eye');
                    } else {
                        eyeIcon.setAttribute('data-lucide', 'eye-off');
                    }
                    lucide.createIcons();
                });
            }
        </script>
    </body>

    </html>