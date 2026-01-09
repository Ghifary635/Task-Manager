<%-- 
    Document   : search_task
    Created on : Dec 11, 2025, 3:13:07 PM
    Author     : booma
--%>

<%@ page import="java.util.*, model.Task" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Search Task</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        body {
            min-height: 100vh;
            margin: 0;
            background:
                linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.45)),
                url("https://images.unsplash.com/photo-1506784983877-45594efa4cbe")
                center/cover no-repeat;
            color: white;
        }

        .header {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(8px);
            padding: 22px 35px;
            font-size: 30px;
            font-weight: 700;
            border-bottom: 1px solid rgba(255,255,255,0.25);
            color: white;
        }

        .search-box {
            background: rgba(255,255,255,0.18);
            backdrop-filter: blur(10px);
            padding: 25px;
            border-radius: 18px;
            margin-top: 30px;
            max-width: 600px;
            border: 1px solid rgba(255,255,255,0.3);
        }

        .form-control {
            background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.4);
            color: white;
        }

        .form-control::placeholder { color: #eee; }

        .form-control:focus {
            background: rgba(255,255,255,0.3);
            color: white;
            border-color: rgba(255,255,255,0.8);
        }

        .task-bubble {
            background: rgba(255,255,255,0.18);
            backdrop-filter: blur(8px);
            border-radius: 18px;
            padding: 20px;
            color: white;
            margin-bottom: 20px;
            border: 1px solid rgba(255,255,255,0.25);
            transition: 0.25s ease;
        }

        .task-bubble:hover {
            background: rgba(255,255,255,0.28);
            transform: translateY(-3px);
        }

        .task-meta b { color: #fff; }

        button {
            margin-top: 15px;
        }
    </style>
</head>

<body>

<div class="header">Search Task</div>

<div class="container d-flex flex-column align-items-center">

    <div class="search-box w-100">
        <form action="SearchTaskServlet" method="get">
            <input type="text" name="keyword" class="form-control" placeholder="Search by title" 
                value="<%= request.getParameter("keyword") == null ? "" : request.getParameter("keyword") %>">
            <button class="btn btn-light mt-3">Search</button>
        </form>
    </div>

    <%
        List<Task> results = (List<Task>) request.getAttribute("results");
        if (results != null) {
    %>

    <div class="mt-4 w-100">

        <% if (results.isEmpty()) { %>
            <div class="alert alert-warning text-dark">No tasks found.</div>
        <% } %>

        <% for (Task t : results) { %>
            <div class="task-bubble">
                <h4><%= t.getTitle() %></h4>
                <p><%= t.getDescription() %></p>

                <div class="row task-meta mt-2">
                    <div class="col-md-4"><b>Category:</b> <%= t.getCategory() %></div>
                    <div class="col-md-4"><b>Priority:</b> <%= t.getPriority() %></div>
                    <div class="col-md-4"><b>Status:</b> <%= t.getStatus() %></div>
                </div>
            </div>
        <% } %>

    </div>

    <% } %>

</div>

</body>
</html>
