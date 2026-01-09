<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="manager.AppManager, model.User" %>

<%
    Integer uidHeader = (Integer) session.getAttribute("userId");
    User uHeader = null;
    if (uidHeader != null) {
        uHeader = AppManager.getUserById(uidHeader);
    }
%>

<style>
/* ================= HEADER ================= */
.header {
    height: 72px;
    padding: 0 40px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: #ffffff;
    border-bottom: 1px solid #e2e8f0;
    position: sticky;
    top: 0;
    z-index: 50;
}

/* ================= BRANDING ================= */
.header-left {
    display: flex;
    align-items: center;
    gap: 20px;
}

.sidebar-toggle {
    background: #f1f5f9;
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #475569;
    cursor: pointer;
    transition: all 0.2s;
}

.sidebar-toggle:hover {
    background: #e2e8f0;
    color: #4f46e5;
}

.header-brand {
    display: flex;
    align-items: center;
    gap: 12px;
    text-decoration: none;
}

.brand-icon {
    width: 36px;
    height: 36px;
    background: #4f46e5;
    color: white;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}

.brand-name {
    font-size: 18px;
    font-weight: 700;
    color: #1e293b;
    letter-spacing: -0.025em;
}

/* ================= SEARCH ================= */
.header-search {
    flex: 1;
    max-width: 480px;
    margin: 0 32px;
}

.search-box {
    position: relative;
    width: 100%;
    display: flex;
    align-items: center;
}

.search-box i, .search-box svg {
    position: absolute;
    left: 14px;
    color: #94a3b8;
    width: 18px;
    height: 18px;
    pointer-events: none;
}

.search-input {
    width: 100%;
    height: 44px;
    padding: 0 44px 0 16px;
    background: #f1f5f9;
    border: 2px solid transparent;
    border-radius: 12px;
    font-size: 14px;
    color: #1e293b;
    transition: all 0.2s;
}

.search-input:focus {
    background: #ffffff;
    border-color: #4f46e5;
    box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    outline: none;
}

.search-btn {
    position: absolute;
    right: 4px;
    top: 50%;
    transform: translateY(-50%);
    height: 36px;
    width: 36px;
    border: none;
    background: transparent;
    color: #64748b;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.2s;
}

.search-btn:hover {
    background: #f1f5f9;
    color: #4f46e5;
}

.search-btn i {
    position: static;
    width: 18px;
    height: 18px;
}

/* ================= ACTIONS ================= */
.header-actions {
    display: flex;
    align-items: center;
    gap: 16px;
}

.header-user {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 6px;
    padding-left: 12px;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    text-decoration: none;
    transition: all 0.2s;
}

.header-user:hover {
    background: #f1f5f9;
    border-color: #cbd5e1;
}

.user-info {
    text-align: right;
}

.user-name {
    display: block;
    font-size: 14px;
    font-weight: 600;
    color: #1e293b;
}

.user-role {
    display: block;
    font-size: 11px;
    color: #64748b;
}

.user-avatar {
    width: 32px;
    height: 32px;
    background: #4f46e5;
    color: white;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 14px;
}

.btn-logout-header {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ef4444;
    background: #fef2f2;
    border-radius: 10px;
    text-decoration: none;
    transition: all 0.2s;
}

        .btn-logout-header:hover {
            background: #ef4444;
            color: white;
        }

        @media (max-width: 640px) {
            .header {
                padding: 0 16px;
            }
            .header-search {
                display: none;
            }
            .user-info {
                display: none;
            }
            .brand-name {
                display: none;
            }
        }
            .task-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
            border-color: #c7d2fe;
        }
            .task-title {
            font-size: 19px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 10px;
            line-height: 1.3;
            letter-spacing: -0.01em;
        }
    </style>


<div class="header">
    <div class="header-left">
        <button class="sidebar-toggle" id="sidebarToggle" title="Toggle Sidebar">
            <i data-lucide="menu"></i>
        </button>
        <!-- Branding -->
        <a href="${pageContext.request.contextPath}/Inbox" class="header-brand">
            <div class="brand-icon">
                <i data-lucide="check-square"></i>
            </div>
            <span class="brand-name">TaskPro</span>
        </a>
    </div>

    <!-- Search Tool -->
    <div class="header-search">
        <form action="${pageContext.request.contextPath}/SearchTask" method="get" class="search-box">
            <input type="text" name="keyword" 
                   class="search-input" 
                   placeholder="Cari tugas kamu..." 
                   value="${searchKeyword}">
            <button type="submit" class="search-btn" title="Cari">
                <i data-lucide="search"></i>
            </button>
        </form>
    </div>

    <!-- Actions -->
    <div class="header-actions">
        <% if (uHeader != null) { %>
            <a href="${pageContext.request.contextPath}/feature/edit_profile.jsp" class="header-user">
                <div class="user-info">
                    <span class="user-name"><%= uHeader.getDisplayName() %></span>
                    <span class="user-role">Member</span>
                </div>
                <% if (uHeader.getProfileImage() == null || uHeader.getProfileImage().isEmpty()) { %>
                    <div class="user-avatar">
                        <%= uHeader.getInitials() %>
                    </div>
                <% } else { %>
                    <img src="${pageContext.request.contextPath}/<%= uHeader.getProfileImage() %>" class="user-avatar" alt="Avatar" style="object-fit: cover;">
                <% } %>
            </a>
            <a href="javascript:void(0)" class="btn-logout-header" onclick="confirmLogout()" title="Logout">
                <i data-lucide="log-out"></i>
            </a>
        <% } %>
    </div>
</div>

<script>
    // Sidebar toggle logic
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const body = document.body;
        
        // Initialize state from local storage
        if (localStorage.getItem('sidebarCollapsed') === 'true') {
            body.classList.add('sidebar-collapsed');
        }

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                body.classList.toggle('sidebar-collapsed');
                localStorage.setItem('sidebarCollapsed', body.classList.contains('sidebar-collapsed'));
            });
        }
    });

    function confirmLogout() {
        Swal.fire({
            title: 'Keluar?',
            text: "Kamu akan keluar dari sesi ini.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#4f46e5',
            cancelButtonColor: '#ef4444',
            confirmButtonText: 'Ya, Keluar!',
            cancelButtonText: 'Batal'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '${pageContext.request.contextPath}/logout';
            }
        });
    }

    lucide.createIcons();
</script>