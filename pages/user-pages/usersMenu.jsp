<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
    
<%@ page import = "java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link rel="icon" href="../../pictures/icon.png">
        <link rel="stylesheet" href="../../static/css/user-pages/usersMenu.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>תפריט משתמש | מטיילים</title>
    </head>
    <body dir="rtl">
        <!-- navbar -->
        <nav class="nav sticky-nav">
            <div class="nav-brand">
                <button onclick="redirectToFile('../index.html')" class="brand-link">
                    <img src="../../pictures/icon.png" alt="מטיילים" width="70" height="70" id="logo">
                    <h1 class="nav-heading">מטיילים</h1>
                </button>
            </div>
            <ul class="menu">
                <li><a href="../index.html#home">דף הבית</a></li>
                <li><a href="../index.html#about">אודות</a></li>
                <li><a href="../blog.jsp">בלוג</a></li>
                <li><a href="../index.html#contact">צור קשר</a></li>
            </ul>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->
        <%
            if ((session.getAttribute("user")== null) || !session.getAttribute("user").equals("true"))
                response.sendRedirect("noUser.jsp");
        %>
        <!-- heading -->    
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">תפריט</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

        <!-- menu -->
        <section class="users-menu">
        	<%
			if (request.getParameter("sendUser") == null) {
			%>
            <form method="post" class="main">
                <table class="users-menu-layout">
                    <tr>
                        <td>
                            <input type="submit" name="sendUser" class="btn" value="My Posts">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="sendUser" value="Create Post" class="btn">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="sendUser" value="Update Details" class="btn">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="sendUser" value="logout" class="btn">
                        </td>
                    </tr>
                </table>
            </form>
        </section>
        <!-- end menu -->
        <%
			}
			else {
            	String s=request.getParameter("sendUser");
            	if(s.equals("My Posts")) {
            		response.sendRedirect("myPosts.jsp");
            	}
            	else if(s.equals("Create Post")) {
            		response.sendRedirect("createPost.jsp");
           		}
            	else if(s.equals("Update Details")) {
            		response.sendRedirect("updateDetails.jsp");
           		}
            	else if(s.equals("logout")) {
            		session.setAttribute("user", "false");
            		response.sendRedirect("../index.html");
            	}
			}
        %>

        <!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="../index.html#home"><img class="icon" src="../../pictures/icon.png" alt="מטיילים" width="70" height="70"></a>
                <p class="footer-menu">
                    <a href="../index.html#home">דף הבית</a>
          			•
                    <a href="../index.html#about">אודות</a>
                    •
                    <a href="../blog.jsp">בלוג</a>
                    •
                    <a href="../index.html#contact">צור קשר</a>
                </p>

                <table class="social-icons">
                    <tr>
                        <td>
                            <a href="https://www.facebook.com">
                                <img src="../../pictures/social/facebook.png" alt="facebook" width="60" height="60">
                            </a>
                        </td>
                        <td>
                            <a href="https://www.instagram.com">
                                <img src="../../pictures/social/instagram.png" alt="instagram" width="60" height="60">
                            </a>
                        </td>
                        <td>
                            <a href="https://www.github.com">
                                <img src="../../pictures/social/github.png" alt="github" width="60" height="60">
                            </a>
                        </td>
                    </tr>
                </table>
                <p>
                    <a href="../admin/admin-login.jsp">מטיילים</a> <!-- manager entry -->
                    &copy;
                    <span id="copyrightYear">
                        <script>
                        document.write(new Date().getFullYear());
                        </script>
                    </span>
                </p>
            </div>
        </footer>
        <!-- footer -->
    </body>
</html>