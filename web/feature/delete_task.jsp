<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Task</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background:
                linear-gradient(rgba(255,255,255,0.85), rgba(255,255,255,0.85)),
                url("https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1920&q=80")
                center / cover no-repeat;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .confirm-card {
            background: #ffffff;
            border-radius: 22px;
            padding: 45px 40px;
            max-width: 480px;
            width: 100%;
            text-align: center;
            box-shadow: 0 18px 45px rgba(0,0,0,0.18);
            animation: popIn 0.4s ease;
        }

        @keyframes popIn {
            from {
                transform: scale(0.9);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .emoji {
            font-size: 64px;
            margin-bottom: 15px;
            animation: shake 1.2s infinite;
        }

        @keyframes shake {
            0%, 100% { transform: rotate(0); }
            25% { transform: rotate(-5deg); }
            75% { transform: rotate(5deg); }
        }

        .confirm-card h4 {
            font-weight: 700;
            color: #b91c1c;
            margin-bottom: 10px;
        }

        .confirm-card p {
            color: #6b7280;
            font-size: 15px;
            margin-bottom: 30px;
        }

        .task-id {
            font-weight: 700;
            color: #1e40af;
        }

        .btn-danger {
            padding: 10px 28px;
            font-weight: 600;
            border-radius: 12px;
        }

        .btn-secondary {
            padding: 10px 28px;
            font-weight: 600;
            border-radius: 12px;
        }

        .btn-danger:hover {
            transform: translateY(-1px);
        }

        .btn-secondary:hover {
            transform: translateY(-1px);
        }
    </style>
</head>

<body>

<div class="confirm-card">
    <div class="emoji">😢</div>

    <h4>Hapus Task?</h4>

    <p>
        Task ini akan dihapus secara permanen.
        <br>
        Aksi ini tidak bisa dibatalkan.
    </p>

    <div class="d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/DeleteTaskServlet?id=<%=request.getParameter("id")%>"
           class="btn btn-danger">
            Ya, Hapus
        </a>

        <a href="${pageContext.request.contextPath}/index.jsp"
           class="btn btn-secondary">
            Batal
        </a>
    </div>
</div>

</body>
</html>
