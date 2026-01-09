<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="manager.AppManager, model.User" %>

<%
    Integer uidSidenav = (Integer) session.getAttribute("userId");
    User uSidenav = null;
    if (uidSidenav != null) {
        uSidenav = AppManager.getUserById(uidSidenav);
    }
%>

<style>
/* ================= SIDENAV ================= */
.sidenav {
    width: 280px;
    background: #ffffff;
    border-right: 1px solid #e2e8f0;
    display: flex;
    flex-direction: column;
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    z-index: 100;
    transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    overflow: hidden;
}

/* Scrollable area for menu items */
.sidenav-menu {
    flex: 1;
    overflow-y: auto;
    padding: 24px 16px;
    scrollbar-width: thin;
    scrollbar-color: #e2e8f0 transparent;
}

.sidenav-menu::-webkit-scrollbar {
    width: 4px;
}

.sidenav-menu::-webkit-scrollbar-track {
    background: transparent;
}

.sidenav-menu::-webkit-scrollbar-thumb {
    background: #e2e8f0;
    border-radius: 10px;
}

/* ================= USER PROFILE ================= */
.user-profile {
    display: flex;
    flex-direction: column;
    padding: 20px;
    margin-bottom: 24px;
    border-radius: 16px;
    background: #f8fafc;
    border: 1px solid #f1f5f9;
    text-decoration: none;
    transition: all 0.2s;
}

.user-profile:hover {
    background: #f1f5f9;
    border-color: #e2e8f0;
}

.profile-main {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.profile-avatar {
    width: 44px;
    height: 44px;
    min-width: 44px;
    border-radius: 12px;
    background: linear-gradient(135deg, #4f46e5, #4338ca);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: 700;
    font-size: 18px;
    object-fit: cover;
}

.profile-info {
    flex: 1;
    overflow: hidden;
    white-space: nowrap;
}

.profile-name {
    font-size: 15px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 2px;
}

.profile-rank {
    font-size: 11px;
    color: #64748b;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.025em;
}

/* ================= LEVEL STATS ================= */
.profile-stats {
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.level-badge {
    display: flex;
    justify-content: space-between;
    font-size: 11px;
    font-weight: 700;
    color: #4f46e5;
}

.xp-container-side {
    height: 6px;
    background: #e2e8f0;
    border-radius: 999px;
    overflow: hidden;
}

.xp-bar-side {
    height: 100%;
    background: linear-gradient(90deg, #4f46e5, #818cf8);
    border-radius: 999px;
    transition: width 0.6s ease;
}

/* ================= NAV SECTION ================= */
.nav-group {
    margin-bottom: 24px;
}

.nav-label {
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #94a3b8;
    margin-bottom: 12px;
    padding-left: 12px;
    white-space: nowrap;
}

/* ================= NAV ITEM ================= */
.nav-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px;
    border-radius: 12px;
    color: #475569;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.2s;
    margin-bottom: 2px;
    white-space: nowrap;
}

.nav-link i {
    width: 20px;
    height: 20px;
    min-width: 20px;
}

.nav-link:hover {
    background: #f1f5f9;
    color: #4f46e5;
}

.nav-link.active {
    background: #eef2ff;
    color: #4f46e5;
    box-shadow: inset 0 0 0 1px rgba(79, 70, 229, 0.1);
}

.sidenav-footer {
    padding: 16px;
    border-top: 1px solid #e2e8f0;
}

.nav-link.logout {
    color: #ef4444;
}

.nav-link.logout:hover {
    background: #fef2f2;
}

/* ================= COLLAPSED STATE ================= */
body.sidebar-collapsed .sidenav {
    width: 84px;
}

body.sidebar-collapsed .profile-info,
body.sidebar-collapsed .profile-stats,
body.sidebar-collapsed .nav-label,
body.sidebar-collapsed .nav-link span {
    display: none;
}

body.sidebar-collapsed .user-profile {
    padding: 10px;
}

body.sidebar-collapsed .profile-main {
    margin-bottom: 0;
    justify-content: center;
}

body.sidebar-collapsed .nav-link {
    justify-content: center;
    padding: 12px 0;
}

body.sidebar-collapsed .nav-link i {
    margin: 0;
}
</style>

<div class="sidenav">
    <div class="sidenav-menu">
        <!-- User Profile -->
        <% if (uSidenav != null) { %>
            <a href="${pageContext.request.contextPath}/feature/edit_profile.jsp" class="user-profile" title="<%= uSidenav.getUsername() %>">
                <div class="profile-main">
                    <% if (uSidenav.getProfileImage() == null || uSidenav.getProfileImage().isEmpty()) { %>
                        <div class="profile-avatar"><%= uSidenav.getInitials() %></div>
                    <% } else { %>
                        <img src="${pageContext.request.contextPath}/<%= uSidenav.getProfileImage() %>" class="profile-avatar" alt="Avatar">
                    <% } %>
                    <div class="profile-info">
                        <div class="profile-name"><%= uSidenav.getDisplayName() %></div>
                        <div class="profile-rank"><%= uSidenav.getTitle() %></div>
                    </div>
                </div>
                <div class="profile-stats">
                    <div class="level-badge">
                        <span>Lvl <%= uSidenav.getLevel() %></span>
                        <span><%= uSidenav.getLevelProgress() %>%</span>
                    </div>
                    <div class="xp-container-side">
                        <div class="xp-bar-side" style="width: <%= uSidenav.getLevelProgress() %>%;"></div>
                    </div>
                </div>
            </a>
        <% } %>

        <!-- Tasks Group -->
        <div class="nav-group">
            <div class="nav-label">Navigasi</div>
            <a href="${pageContext.request.contextPath}/Inbox" class="nav-link ${activeMenu == 'inbox' ? 'active' : ''}" title="Semua Tugas">
                <i data-lucide="layers"></i> <span>Semua Tugas</span>
            </a>
            <a href="${pageContext.request.contextPath}/Today" class="nav-link ${activeMenu == 'today' ? 'active' : ''}" title="Hari Ini">
                <i data-lucide="calendar"></i> <span>Hari Ini</span>
            </a>
            <a href="${pageContext.request.contextPath}/Upcoming" class="nav-link ${activeMenu == 'upcoming' ? 'active' : ''}" title="Mendatang">
                <i data-lucide="clock"></i> <span>Mendatang</span>
            </a>
        </div>

        <!-- Filter Group -->
        <div class="nav-group">
            <div class="nav-label">Status</div>
            <a href="${pageContext.request.contextPath}/FilterTask?status=PENDING" class="nav-link ${activeMenu == 'pending' ? 'active' : ''}" title="Belum Selesai">
                <i data-lucide="circle"></i> <span>Belum Selesai</span>
            </a>
            <a href="${pageContext.request.contextPath}/FilterTask?status=IN_PROGRESS" class="nav-link ${activeMenu == 'in_progress' ? 'active' : ''}" title="Sedang Jalan">
                <i data-lucide="loader"></i> <span>Sedang Jalan</span>
            </a>
            <a href="${pageContext.request.contextPath}/FilterTask?status=COMPLETED" class="nav-link ${activeMenu == 'completed' ? 'active' : ''}" title="Sudah Selesai">
                <i data-lucide="check-circle-2"></i> <span>Sudah Selesai</span>
            </a>
        </div>

        <!-- Analytics Group -->
        <div class="nav-group">
            <div class="nav-label">Wawasan</div>
            <a href="${pageContext.request.contextPath}/SummaryServlet" class="nav-link ${activeMenu == 'summary' ? 'active' : ''}" title="Statistik">
                <i data-lucide="pie-chart"></i> <span>Statistik</span>
            </a>
        </div>
    </div>

    <!-- Sidenav Footer -->
    <div class="sidenav-footer">
        <a href="javascript:void(0)" class="nav-link logout" onclick="confirmLogout()" title="Keluar">
            <i data-lucide="log-out"></i> <span>Keluar</span>
        </a>
    </div>
</div>

<script>
    // Lucide is handled by header usually, but we call it here to ensure icons in sidenav are rendered
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>