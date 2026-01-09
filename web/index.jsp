<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="manager.AppManager, model.Task, model.TaskStatus" %>

<% 
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    if (tasks == null) {
        tasks = AppManager.getAllTasksFromDB(userId);
    }

    SimpleDateFormat fullFormat = new SimpleDateFormat("dd MMM yyyy, HH:mm");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | TaskPro</title>
    
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --primary: #4f46e5;
            --primary-light: #eef2ff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --bg-body: #f8fafc;
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
        }

        body.sidebar-collapsed .main-content {
            margin-left: 84px;
        }

        /* ===== PAGE HEADER ===== */
        .page-header {
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
        }

        .header-left-content {
            flex: 1;
        }

        .page-title {
            font-size: 32px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 8px 0;
            letter-spacing: -0.025em;
        }

        .page-subtitle {
            font-size: 16px;
            color: var(--text-muted);
            margin: 0;
        }

        .btn-add-main {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 24px;
            background: var(--primary);
            color: white;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.2);
            white-space: nowrap;
        }

        .btn-add-main:hover {
            background: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(79, 70, 229, 0.3);
        }

        /* ===== TASK GRID ===== */
        .task-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 24px;
        }

        .task-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            border: 1px solid var(--border);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .task-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 40px -12px rgba(0, 0, 0, 0.12); /* Premium shadow */
            border-color: #cbd5e1;
        }

        .task-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 20px;
            bottom: 20px;
            width: 4px;
            border-radius: 0 4px 4px 0;
        }
        
        /* Priority Stripes */
        .priority-HIGH::before { background: #ef4444; }
        .priority-MEDIUM::before { background: #f59e0b; }
        .priority-LOW::before { background: #10b981; }

        .task-card-overdue {
            background-color: #fff1f2 !important;
            border-color: #fecdd3 !important;
        }
        
        .task-card-overdue:hover {
             border-color: #fda4af !important;
        }

        /* Dedicated Date Box */
        .date-box {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            background: #f8fafc;
            border-radius: 8px;
            border: 1px solid #f1f5f9;
            color: #64748b;
            font-size: 13px;
            font-weight: 500;
            margin-top: auto;
        }
        
        .date-box.overdue {
            background: #fef2f2;
            border-color: #fecaca;
            color: #ef4444;
        }

        .task-body {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .task-title {
            font-size: 20px; /* Larger title */
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            line-height: 1.3;
            letter-spacing: -0.01em;
        }

        .task-desc {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* ===== BADGES & META ===== */
        .task-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: auto;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px; /* Pill shape */
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.02em;
        }

        .badge-pending { background: #fee2e2; color: #dc2626; }
        .badge-progress { background: #fef3c7; color: #d97706; }
        .badge-completed { background: #dcfce7; color: #16a34a; }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 700;
        }

        .status-pending { background: #fee2e2; color: #dc2626; }
        .status-inprogress { background: #fef3c7; color: #d97706; }
        .status-completed { background: #dcfce7; color: #16a34a; }
        .status-overdue { background: #ef4444; color: white; }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .meta-item i { width: 14px; height: 14px; }

        /* ===== ACTIONS ===== */
        .task-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9; /* Lighter divider */
        }

        /* ===== CUSTOM DROPDOWN ===== */
        .custom-dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-trigger {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            padding: 8px 16px;
            border-radius: 9999px;
            border: 1px solid #e2e8f0;
            font-size: 13px;
            font-weight: 600;
            background-color: white;
            color: var(--text-main);
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            min-width: 150px;
        }

        .dropdown-trigger:hover {
            border-color: #cbd5e1;
            background-color: #f8fafc;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transform: translateY(-1px);
        }

        .dropdown-menu {
            position: absolute;
            top: calc(100% + 8px);
            left: 0;
            min-width: 160px;
            width: 100%;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            border: 1px solid #f1f5f9;
            padding: 6px;
            z-index: 50;
            display: none;
            animation: fadeInUp 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-item {
            padding: 10px 12px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 500;
            color: #475569;
            cursor: pointer;
            transition: all 0.1s;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dropdown-item:hover {
            background-color: #f8fafc;
            color: var(--primary);
        }

        .dropdown-item.selected {
            background-color: #eef2ff;
            color: var(--primary);
            font-weight: 600;
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card-actions {
            display: flex;
            gap: 10px;
        }

        .btn-icon {
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-edit { background: #f1f5f9; color: #475569; }
        .btn-edit:hover { background: #e2e8f0; color: var(--primary); }
        
        .btn-delete { background: #fef2f2; color: #ef4444; }
        .btn-delete:hover { background: #ef4444; color: white; }

        .empty-state {
            text-align: center;
            padding: 100px 40px;
            background: white;
            border-radius: 24px;
            border: 2px dashed #e2e8f0;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 16px;
        }

        .empty-icon {
            width: 80px;
            height: 80px;
            color: #e2e8f0;
            margin-bottom: 8px;
        }

        .btn-empty-add {
            margin-top: 12px;
            padding: 14px 28px;
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0 !important;
                padding: 24px;
            }
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
            .btn-add-main {
                width: 100%;
                justify-content: center;
            }
        }
        /* ===== MODAL ===== */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(15, 23, 42, 0.5);
            backdrop-filter: blur(4px);
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.2s ease-out;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background-color: #ffffff;
            border-radius: 20px;
            width: 100%;
            max-width: 500px;
            padding: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            position: relative;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
        }

        .btn-close {
            background: #f1f5f9;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-close:hover {
            background: #e2e8f0;
            color: #ef4444;
        }

        .modal-form .form-group {
            margin-bottom: 16px;
        }

        .modal-form label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            margin-bottom: 6px;
        }

        .modal-form input, .modal-form select, .modal-form textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.2s;
        }

        .modal-form input:focus, .modal-form select:focus, .modal-form textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .modal-footer {
            margin-top: 24px;
            display: flex;
            gap: 12px;
        }

        .modal-footer .btn {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
        }

        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-cancel:hover {
            background: #e2e8f0;
        }

        .btn-submit {
            background: var(--primary);
            color: white;
        }

        .btn-submit:hover {
            background: var(--primary-hover);
        }
    </style>
</head>
<body>

    <jsp:include page="layout/header.jsp" />

    <div class="app-container">
        <jsp:include page="layout/sidenav.jsp" />

        <main class="main-content">
            <% 
                String activeMenu = (String) request.getAttribute("activeMenu");
                if (activeMenu == null) activeMenu = "inbox";
                
                String pageTitle = "Tugas Saya";
                String pageSub = "Tetap konsisten 🚀 satu task kecil mendekatkanmu ke tujuan";
                
                if ("today".equals(activeMenu)) { 
                    pageTitle = "Hari Ini";
                    pageSub = "Selesaikan prioritas utama kamu hari ini!";
                } else if ("upcoming".equals(activeMenu)) {
                    pageTitle = "Mendatang";
                    pageSub = "Persiapkan diri untuk tugas-tugas berikutnya.";
                } else if ("search".equals(activeMenu)) {
                    pageTitle = "Hasil Pencarian";
                    pageSub = "Menampilkan hasil untuk kata kunci yang kamu cari.";
                }
            %>

            <header class="page-header">
                <div class="header-left-content">
                    <h1 class="page-title"><%= pageTitle %></h1>
                    <p class="page-subtitle"><%= pageSub %></p>
                </div>
                <button onclick="openAddTaskModal()" class="btn-add-main">
                    <i data-lucide="plus-circle"></i>
                    Tambah Tugas Baru
                </button>
            </header>

            <% if (tasks == null || tasks.isEmpty()) { %>
                <div class="empty-state">
                    <i data-lucide="layout-list" class="empty-icon"></i>
                    <h2 style="color: #475569; margin: 0;">Belum ada tugas</h2>
                    <p class="page-subtitle">Mulai atur harimu dengan menambah tugas pertama sekarang juga!</p>
                    <button onclick="openAddTaskModal()" class="btn-add-main btn-empty-add">
                        <i data-lucide="sparkles"></i>
                        Tambah Tugas Sekarang
                    </button>
                </div>
            <% } else { %>
                <div class="task-list">
                    <% for (Task task : tasks) { 
                        boolean isPastDue = task.getDueDate() != null && task.getDueDate().before(new Date());
                        boolean isLocked = task.getStatus() == TaskStatus.OVERDUE || (task.getStatus() == TaskStatus.COMPLETED && isPastDue);
                        
                        String priorityClass = "priority-" + task.getPriority();
                        String cardClass = "task-card " + priorityClass;
                        if (task.getStatus() == TaskStatus.OVERDUE) {
                            cardClass += " task-card-overdue";
                        }
                    %>
                        <div class="<%= cardClass %>">

                            <div class="task-body">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px;">
                                    <span class="status-badge <%= 
                                        task.getStatus() == TaskStatus.COMPLETED ? "status-completed" : 
                                        task.getStatus() == TaskStatus.IN_PROGRESS ? "status-inprogress" : 
                                        task.getStatus() == TaskStatus.OVERDUE ? "status-overdue" : "status-pending" 
                                    %>">
                                        <%= 
                                            task.getStatus() == TaskStatus.COMPLETED ? "Selesai" : 
                                            task.getStatus() == TaskStatus.IN_PROGRESS ? "Sedang Jalan" : 
                                            task.getStatus() == TaskStatus.OVERDUE ? "Terlewat" : "Belum Selesai" 
                                        %>
                                    </span>
                                    <div class="meta-item" style="color: #94a3b8; font-size: 12px;">
                                        <%= task.getCategory() %>
                                    </div>
                                </div>

                                <h3 class="task-title"><%= task.getTitle() %></h3>
                                <% if (task.getDescription() != null && !task.getDescription().isEmpty()) { %>
                                    <p class="task-desc"><%= task.getDescription() %></p>
                                <% } %>

                                <% if (task.getDueDate() != null) { 
                                     boolean isOverdue = task.getStatus() == TaskStatus.OVERDUE;
                                %>
                                    <div class="date-box <%= isOverdue ? "overdue" : "" %>">
                                        <i data-lucide="<%= isOverdue ? "alert-circle" : "calendar" %>" style="width: 16px; height: 16px;"></i>
                                        <% if (isOverdue) { %>
                                            <span><%= fullFormat.format(task.getDueDate()) %> (Terlewat)</span>
                                        <% } else { %>
                                            <span><%= fullFormat.format(task.getDueDate()) %></span>
                                        <% } %>
                                    </div>
                                <% } else { %>
                                    <div class="date-box">
                                        <i data-lucide="calendar" style="width: 16px; height: 16px;"></i>
                                        <span>No deadline</span>
                                    </div>
                                <% } %>
                            </div>

                            <div class="task-footer">
                                <form action="${pageContext.request.contextPath}/UpdateStatusServlet" method="post" id="form_<%= task.getId() %>">
                                    <input type="hidden" name="taskId" value="<%= task.getId() %>">
                                    <input type="hidden" name="status" id="statusInput_<%= task.getId() %>" value="<%= task.getStatus() %>">
                                    
                                    <% if (isLocked) { %>
                                        <div class="dropdown-trigger" style="background: <%= task.getStatus() == TaskStatus.OVERDUE ? "#fee2e2" : "#f1f5f9" %>; color: <%= task.getStatus() == TaskStatus.OVERDUE ? "#ef4444" : "#94a3b8" %>; cursor: not-allowed; border-color: transparent;">
                                            <span><%= task.getStatus() == TaskStatus.OVERDUE ? "Terlewat" : "Locked" %></span>
                                            <i data-lucide="lock" style="width: 14px; height: 14px;"></i>
                                        </div>
                                    <% } else { %>
                                        <div class="custom-dropdown" id="dropdown_<%= task.getId() %>">
                                            <div class="dropdown-trigger" onclick="toggleDropdown(<%= task.getId() %>, event)">
                                                <span>
                                                    <%= task.getStatus() == TaskStatus.COMPLETED ? "Selesai" : 
                                                        task.getStatus() == TaskStatus.IN_PROGRESS ? "Sedang Jalan" : "Belum Selesai" %>
                                                </span>
                                                <i data-lucide="chevron-down" style="width: 14px; height: 14px; color: #94a3b8;"></i>
                                            </div>
                                            <div class="dropdown-menu">
                                                <div class="dropdown-item <%= task.getStatus() == TaskStatus.PENDING ? "selected" : "" %>" 
                                                     onclick="selectStatus(<%= task.getId() %>, 'PENDING')">
                                                    <i data-lucide="circle" style="width: 14px; height: 14px; color: #ef4444;"></i>
                                                    Belum Selesai
                                                </div>
                                                <div class="dropdown-item <%= task.getStatus() == TaskStatus.IN_PROGRESS ? "selected" : "" %>" 
                                                     onclick="selectStatus(<%= task.getId() %>, 'IN_PROGRESS')">
                                                     <i data-lucide="loader" style="width: 14px; height: 14px; color: #f59e0b;"></i>
                                                    Sedang Jalan
                                                </div>
                                                <div class="dropdown-item <%= task.getStatus() == TaskStatus.COMPLETED ? "selected" : "" %>" 
                                                     onclick="selectStatus(<%= task.getId() %>, 'COMPLETED')">
                                                     <i data-lucide="check-circle-2" style="width: 14px; height: 14px; color: #10b981;"></i>
                                                    Selesai
                                                </div>
                                            </div>
                                        </div>
                                    <% } %>
                                </form>

                                <div class="card-actions">
                                    <% if (!isLocked) { %>
                                        <button class="btn-icon btn-edit btn-edit-trigger" title="Edit"
                                                data-id="<%= task.getId() %>"
                                                data-title="<%= task.getTitle().replace("\"", "&quot;") %>"
                                                data-desc="<%= (task.getDescription() != null ? task.getDescription() : "").replace("\"", "&quot;").replace("\n", " ").replace("\r", "") %>"
                                                data-cat="<%= task.getCategory() %>"
                                                data-prio="<%= task.getPriority() %>"
                                                data-stat="<%= task.getStatus() %>"
                                                data-date="<%= task.getDueDate() != null ? new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(task.getDueDate()) : "" %>">
                                            <i data-lucide="edit-2"></i>
                                        </button>
                                    <% } %>
                                    <button onclick="confirmDelete('<%= task.getId() %>', '<%= task.getTitle().replace("'", "\\'") %>')"
                                            class="btn-icon btn-delete" title="Hapus">
                                        <i data-lucide="trash-2"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
    </div>

    <!-- ADD TASK MODAL -->
    <div id="addTaskModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Tambah Tugas Baru</h2>
                <button class="btn-close" onclick="closeAddTaskModal()">
                    <i data-lucide="x"></i>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/feature/AddTaskServlet" method="post" class="modal-form">
                <div class="form-group">
                    <label>Judul Tugas</label>
                    <input type="text" name="title" placeholder="Apa yang ingin kamu kerjakan?" required>
                </div>
                <div class="form-group">
                    <label>Deskripsi (Opsional)</label>
                    <textarea name="description" rows="3" placeholder="Detail tambahan..."></textarea>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label>Kategori</label>
                        <select name="category">
                            <option value="Personal">Personal</option>
                            <option value="Work">Work</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Prioritas</label>
                        <select name="priority">
                            <option value="LOW">Rendah</option>
                            <option value="MEDIUM" selected>Sedang</option>
                            <option value="HIGH">Tinggi</option>
                        </select>
                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label>Status</label>
                        <select name="status">
                            <option value="PENDING">Belum Selesai</option>
                            <option value="IN_PROGRESS">Sedang Jalan</option>
                            <option value="COMPLETED">Selesai</option>
                        </select>
                    </div>
                    <div class="form-group">
                    <label class="form-label">Tenggat Waktu</label>
                    <input type="datetime-local" name="dueDate" class="form-input">
                </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeAddTaskModal()">Batal</button>
                    <button type="submit" class="btn btn-submit">Simpan Tugas</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- EDIT TASK MODAL -->
    <div id="editTaskModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Edit Tugas</h2>
                <button class="btn-close" onclick="closeEditTaskModal()">
                    <i data-lucide="x"></i>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/UpdateTaskServlet" method="post" class="modal-form">
                <input type="hidden" name="taskId" id="editTaskId">
                <div class="form-group">
                    <label>Judul Tugas</label>
                    <input type="text" name="title" id="editTitle" required>
                </div>
                <div class="form-group">
                    <label>Deskripsi (Opsional)</label>
                    <textarea name="description" id="editDesc" rows="3"></textarea>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label>Kategori</label>
                        <select name="category" id="editCategory">
                            <option value="Personal">Personal</option>
                            <option value="Work">Work</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Prioritas</label>
                        <select name="priority" id="editPriority">
                            <option value="LOW">Rendah</option>
                            <option value="MEDIUM">Sedang</option>
                            <option value="HIGH">Tinggi</option>
                        </select>
                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label class="form-label">Status</label>
                        <select name="status" id="editStatus" class="form-input">
                            <option value="PENDING">Belum Selesai</option>
                            <option value="IN_PROGRESS">Sedang Jalan</option>
                            <option value="COMPLETED">Selesai</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tenggat Waktu</label>
                        <input type="datetime-local" name="dueDate" id="editDueDate" class="form-input">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeEditTaskModal()">Batal</button>
                    <button type="submit" class="btn btn-submit">Simpan Perubahan</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        lucide.createIcons();

        // Toast configuration
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true
        });

        // Notifications
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('login') === 'success') {
            Toast.fire({ icon: 'success', title: 'Selamat Datang Kembali!' });
            window.history.replaceState({}, document.title, window.location.pathname);
        }
        if (urlParams.has('task')) {
            const action = urlParams.get('task');
            let msg = '';
            if (action === 'added') msg = 'Tugas berhasil ditambah!';
            if (action === 'updated') msg = 'Tugas berhasil diperbarui!';
            if (action === 'deleted') msg = 'Tugas berhasil dihapus!';
            if (msg) {
                Toast.fire({ icon: 'success', title: msg });
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }

        if (urlParams.get('error') === 'addfailed') {
            Toast.fire({ icon: 'error', title: 'Gagal menambah tugas!' });
            window.history.replaceState({}, document.title, window.location.pathname);
        }

        function confirmDelete(taskId, taskTitle) {
            Swal.fire({
                title: 'Hapus Tugas?',
                text: `Tugas "${taskTitle}" akan dihapus permanen.`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#e11d48',
                cancelButtonColor: '#94a3b8',
                confirmButtonText: 'Ya, Hapus!',
                cancelButtonText: 'Batal'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '${pageContext.request.contextPath}/DeleteTaskServlet?id=' + taskId;
                }
            });
        }

        function openAddTaskModal() {
            document.getElementById('addTaskModal').classList.add('active');
        }

        function closeAddTaskModal() {
            document.getElementById('addTaskModal').classList.remove('active');
        }

        // Initialize triggers for modals
        document.querySelectorAll('.btn-edit-trigger').forEach(btn => {
            btn.addEventListener('click', function() {
                const task = {
                    id: this.dataset.id,
                    title: this.dataset.title,
                    desc: this.dataset.desc,
                    cat: this.dataset.cat,
                    prio: this.dataset.prio,
                    stat: this.dataset.stat,
                    date: this.dataset.date
                };
                openEditTaskModal(task);
            });
        });

        function openEditTaskModal(task) {
            document.getElementById('editTaskId').value = task.id;
            document.getElementById('editTitle').value = task.title;
            document.getElementById('editDesc').value = task.desc;
            document.getElementById('editCategory').value = task.cat;
            document.getElementById('editPriority').value = task.prio;
            document.getElementById('editStatus').value = task.stat;
            document.getElementById('editDueDate').value = task.date;
            
            document.getElementById('editTaskModal').classList.add('active');
            lucide.createIcons();
        }

        function closeEditTaskModal() {
            document.getElementById('editTaskModal').classList.remove('active');
        }



        // --- Custom Dropdown Logic ---
        
        function toggleDropdown(taskId, event) {
            event.stopPropagation();
            
            // Close all other dropdowns first
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                if (menu.closest('.custom-dropdown').id !== 'dropdown_' + taskId) {
                    menu.classList.remove('active');
                }
            });
            
            // Toggle current
            const menu = document.querySelector('#dropdown_' + taskId + ' .dropdown-menu');
            if (menu) {
                menu.classList.toggle('active');
                lucide.createIcons(); // Refresh icons inside menu if needed
            }
        }
        
        function selectStatus(taskId, status) {
            const input = document.getElementById('statusInput_' + taskId);
            if (input) {
                input.value = status;
                const form = document.getElementById('form_' + taskId);
                if (form) form.submit();
            }
        }
        
        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.closest('.custom-dropdown')) {
                document.querySelectorAll('.dropdown-menu.active').forEach(menu => {
                    menu.classList.remove('active');
                });
            }
            
            // Original modal close logic
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('active');
            }
        };
    </script>
</body>
</html>