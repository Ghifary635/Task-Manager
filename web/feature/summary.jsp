<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statistik Tugas | TaskPro</title>
    
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        :root {
            --primary: #4f46e5;
            --bg-body: #f8fafc;
            --text-main: #1e293b;
            --text-muted: #64748b;
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
        }

        body.sidebar-collapsed .main-content {
            margin-left: 84px;
        }

        /* ===== PAGE HEADER ===== */
        .page-header {
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
        }

        /* ===== SUMMARY GRID ===== */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 24px;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            text-align: center;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px -5px rgba(0, 0, 0, 0.1);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            color: white;
        }

        .icon-total { background: linear-gradient(135deg, #6366f1, #4f46e5); }
        .icon-pending { background: linear-gradient(135deg, #f87171, #ef4444); }
        .icon-progress { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .icon-completed { background: linear-gradient(135deg, #4ade80, #22c55e); }

        .stat-value {
            font-size: 32px;
            font-weight: 800;
            color: #1e293b;
            margin-bottom: 4px;
        }

        .stat-label {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-muted);
        }

        /* ===== MOTIVATION ===== */
        .motivation-box {
            margin-top: 48px;
            background: #eef2ff;
            border: 1px solid #e0e7ff;
            border-radius: 16px;
            padding: 24px;
            text-align: center;
            color: #4338ca;
            font-weight: 500;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            background: white;
            color: var(--text-main);
            border: 1px solid var(--border);
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-back:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }
    </style>
</head>
<body>

    <jsp:include page="../layout/header.jsp" />

    <div class="app-container">
        <jsp:include page="../layout/sidenav.jsp" />

        <main class="main-content">
            <header class="page-header">
                <h1 class="page-title">Statistik Tugas</h1>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn-back">
                    <i data-lucide="arrow-left"></i> Kembali
                </a>
            </header>

            <div class="summary-grid">
                <div class="stat-card">
                    <div class="stat-icon icon-total"><i data-lucide="layers"></i></div>
                    <div class="stat-value"><%= request.getAttribute("total") %></div>
                    <div class="stat-label">Total Tugas</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon icon-pending"><i data-lucide="clock"></i></div>
                    <div class="stat-value"><%= request.getAttribute("pending") %></div>
                    <div class="stat-label">Belum Selesai</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon icon-progress"><i data-lucide="activity"></i></div>
                    <div class="stat-value"><%= request.getAttribute("inprogress") %></div>
                    <div class="stat-label">Sedang Jalan</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon icon-completed"><i data-lucide="check-circle-2"></i></div>
                    <div class="stat-value"><%= request.getAttribute("completed") %></div>
                    <div class="stat-label">Sudah Selesai</div>
                </div>
            </div>

            <div class="motivation-box">
                <i data-lucide="sparkles" style="margin-bottom: 8px;"></i>
                <p>Tetap konsisten! Setiap tugas kecil yang kamu selesaikan membawa kamu lebih dekat ke tujuan besar kamu. 🚀</p>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
