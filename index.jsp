<%-- 
    Document   : index
    Created on : Mar 14, 2021, 10:43:55 PM
    Author     : George
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/index.css">
        <script type = "text/javascript" src="js/index.js"></script>
        <title>Home Page</title>
    </head>
    <body onload="startTime()">
        <div id="bar">
            ISD Demo
            <span id="links"><a href="login.jsp">Login</a> | <a href="register.jsp">Register</a></span>
        </div>
        
        <div id="clock" class="footer"></div>
    </body>
</html>
