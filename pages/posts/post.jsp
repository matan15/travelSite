<!DOCTYPE html>
<html lang="en">
	<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>

	<%@page import="java.sql.*" %>
		
	<%--הצהרה על משתנים --%>
	<%!

		java.sql.Connection con=null; //משתנים מסוג זה נקראים אובייקטים
		java.sql.Statement st=null;
		java.sql.ResultSet postsResultSet=null;
	%>
	
	<%
	//יצירת קשר למסד הנתונים 
	try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
		st=con.createStatement();

		String mySQL="SELECT * FROM TBposts WHERE id = " + request.getParameter("id").toString(); // שאילתת SQL    
		postsResultSet=st.executeQuery(mySQL);
		postsResultSet.next(); // המצביע מצביע על הרשומה היחידה	
	}
	catch(Exception ex){
		System.out.println("Error in connection");
	}
	%>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link rel="icon" href="../../pictures/icon.png">
        <link rel="stylesheet" href="../../static/css/posts/post.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title><%=postsResultSet.getString("postName").toString() %> | מטיילים</title>
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
    
            <div class="login-and-sign-up">
                <button class="sign-up" onclick="redirectToFile('../login-sign-up/sign-up.jsp');">
                    הירשם
                </button>
                <button class="login" onclick="redirectToFile('../login-sign-up/login.jsp')">
                    התחבר
                </button>
            </div>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->

        <!-- post section -->
        <section>
            <button onclick="redirectToFile('../blog.jsp')" class="back-to-blog-btn">חזרה לבלוג</button>
            <article class="post">
                <h2 class="article-title" class="article-title"><%=postsResultSet.getString("postName").toString() %></h2>
                <p class="article-credits"><i>פורסם על-ידי <%=postsResultSet.getString("authorNameDisplay").toString() %> בתאריך <%=postsResultSet.getString("publishDate") %></i></p>
				<hr>
                <p class="article-text"><%=postsResultSet.getString("postBody").toString() %></p>
                <%
					postsResultSet.close();
				%>
            </article>
        </section>
        <!-- end post section -->

        <!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="../index.html#home"><img class="icon" src="../../pictures/icon.png" alt="מטיילים" width="70" height="70"></a>
                <p class="footer-menu">
                    <a href="../index.html#home">דף הבית</a>
                    •
                    <a href="../index.html#about">אודות</a>
                    •
                    <a href="..blog.jsp#">בלוג</a>
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
                    <a href="../admin/admin-login.jsp">מטיילים</a> 
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