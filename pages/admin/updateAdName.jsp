<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@page import="java.sql.*" %>
<%--הצהרה על משתנים --%>
<%!
java.sql.Connection con=null;
java.sql.Statement st=null;
java.sql.ResultSet usersResultSet=null;
%>

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
        <link rel="stylesheet" href="../../static/css/admin/listUsersByAge.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>עדכון שם מנהל | מטיילים</title>
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
                <button class="sign-up" onclick="redirectToFile('../login-sign-up/sign-up.html');">
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
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
			    response.sendRedirect ("noManage.jsp");
        %>
        <!-- heading -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">עדכון שם מנהל</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->
        
        <section>
	        <form action="post" action="updateAdName.jsp">
	            <label for="adName" class="label">הכנס שם מנהל:</label><br>
	            <input type="text" name="adName" class="field"><br>
	            <input type="submit" value="שלח" name="send" class="submit-btn">
	        </form>
        </section>
        <%
            boolean userFound=false;    
                
            //יצירת קשר למסד הנתונים 
            try
            {
            		String id = session.getAttribute("adminId").toString();
            	
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                    st=con.createStatement();
                
            String sql="SELECT * FROM TBadmin WHERE id='"+id+"' "; //שאילתת SQL
            usersResultSet=st.executeQuery(sql);                  //קולט את הטבלה של ה sql
            if (usersResultSet!=null && usersResultSet.next())
            {
                userFound=true;  
            }
            if(userFound) //שמירת נתוני משתמש שמצאנו
            {
                session.setAttribute("adName",usersResultSet.getString("adName"));
                session.setAttribute("adPass",usersResultSet.getString("adPass"));
                
                //הפניה לדף לביצוע העדכון
                response.sendRedirect("doUpdateAdname.jsp");
            }
            }
            catch(Exception ex)
            {
                System.out.println("Error in connection-1"+ex);
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
                <div>
                    <p>מטיילים</p> <!-- manager entry -->
                    &copy;
                    <span id="copyrightYear">
                        <script>
                        document.write(new Date().getFullYear());
                        </script>
                    </span>
                </div>
            </div>
        </footer>
        <!-- footer -->
    </body>
</html>