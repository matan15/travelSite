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
        <link rel="stylesheet" href="../../static/css/user-pages/createPost.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>פוסט חדש | מטיילים</title>
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
                <button class="sign-up" onclick="redirectToFile('../login-sign-up/sign-up.html')">
                    הירשם
                </button>
                <button class="login" onclick="redirectToFile('../login-sign-up/login.html')">
                    התחבר
                </button>
            </div>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->
        
        <%
			if ((session.getAttribute("user")== null)|| !session.getAttribute("user").equals("true"))
				response.sendRedirect ("noUser.jsp");
		%>

        <!-- heading -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">פוסט חדש</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

        <!-- new post form -->
        <section>
            <%
            if(!request.getMethod().equals("POST")) {
            %>
            <div class="form-group">
                <form action="createPost.jsp" name="newPostForm" method="post">
                    <table class="form-layout">
                        <tr>
                            <td>
                                <label class="label" for="post-name">שם הפוסט:</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="field" type="text" name="post-name" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="label" for="post-text">הכנס כאן טקסט של הפוסט:</label>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <textarea class="field" name="post-text" cols="40" rows="10" required></textarea>
                            </td>
                        </tr>
						<tr>
                        	<td>
                        		<input class="field" type="checkbox" value="yes" name="is-annonymous">
                        		<label for="is-annonymous">האם להפוך את מחבר הפוסט לאנונימי?</label>
                        	</td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" name="submit" class="submit-btn">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <%
            }//
            else
            {
                String postName = request.getParameter("post-name");
                String postBody = request.getParameter("post-text");
                
                try {
                	Class.forName("com.mysql.jdbc.Driver").newInstance();
                	Connection con = java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan", "root", "");
                	Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                	
               		String mySQL = "SELECT * FROM TBusers WHERE id = " + session.getAttribute("userId");
               		
               		ResultSet oRS = st.executeQuery(mySQL);
               		
               		oRS.next();
               		
               		String isAnnonymousAnswer[] = request.getParameterValues("is-annonymous");
                    String isAnnonymous;
                    if (isAnnonymousAnswer != null && isAnnonymousAnswer.length != 0) {
                    	isAnnonymous = "annonymous";
                    }
                    else {
                    	isAnnonymous = oRS.getString("fullName");
                    }
                	
                	mySQL = "INSERT INTO TBposts (postName, authorName, authorNameDisplay, publishDate, postBody, userId) VALUES ('" + postName + "', '" + oRS.getString("fullName") + "', '" + isAnnonymous + "', curdate(), '" + postBody + "', " + session.getAttribute("userId") + ")";
                	
                	int n = st.executeUpdate(mySQL);
                	
                	st.close();
                	con.close();
                	
                	out.println("הפוסט נשמר בהצלחה!");
                	out.println("<br>");
                	out.println("<button class=" + '"' + "btn" + '"' + " onclick=" + '"' + "redirectToFile('./usersMenu.jsp')" + '"' + ">חזרה לתפריט</button>");
                }
                catch (Exception e)
                {
                	out.println("Error in connecting: " + e);
                }
            }   
            %>
        </section>
        <!-- end new post form -->

        <!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="../index.html#home"><img class="icon" src="../../pictures/icon.png" alt="מטיילים" width="70" height="70"></a>
                <p class="footer-menu">
                    <a href="../index.html#home">דף הבית</a>
                    •
                    <a href="../index.html#about">אודות</a>
                    •
                    <a href="../blog.jsp#">בלוג</a>
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
                    <a href="#">מטיילים</a> <!-- manager entry -->
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