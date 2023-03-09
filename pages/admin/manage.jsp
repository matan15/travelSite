<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>

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
        <link rel="stylesheet" href="../../static/css/admin/manage.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>פעולות מנהל | מטיילים</title>
    </head>
    <body dir="rtl">
        <!-- navbar -->
        <nav class="nav sticky-nav">
            <div class="nav-brand">
                <button onclick="redirectToFile('./index.html')" class="brand-link">
                    <img src="../../pictures/icon.png" alt="מטיילים" width="70" height="70" id="logo">
                    <h1 class="nav-heading">מטיילים</h1>
                </button>
            </div>
            <ul class="menu">
                <li><a href="../index.html#home">דף הבית</a></li>
                <li><a href="../index.html#about">אודות</a></li>
                <li><a href="../blog.html">בלוג</a></li>
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
            <div class="user-menu">
                <img class="profile-img" src="../../pictures/icon.png" alt="profile" width="60" height="60"> <!-- fix source and alt -->
                <div class="dropdown">
                    <button class="dropbtn"><img src="../../pictures/arrow.png" alt="arrow" width="60" height="60"></button>
                    <div class="dropdown-content">
                        <a href="">עדכון פרטים</a>
                        <a href="">המסלולים שלי</a>
                        <a href="">התנתק</a>
                    </div>
                </div>
            </div>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->

        <%
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true")) // בדיקה האם המשתמש רשאי להיכנס לדף ניהול של אתר, צריך לבדוק מה הערך במשתנה סאשן
			    response.sendRedirect ("noManage.jsp");
        %>
        <!-- heading -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">פעולות מנהל</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

        <!-- admin actions section -->
        <section>
            <table class="actions-grid">
                <tr class="row">
                    <td>
                        <input type="submit" value="הצגת כל הנרשמים" class="button" name="sendUser">
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <input type="submit" value="מחיקת משתמש לפי אימייל" class="button" name="sendUser">
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <input type="submit" value="עדכון פרטי משתמש לפי אימייל" class="button" name="sendUser">
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <input type="submit" value="הצגת משתמשים לפי גיל" class="button" name="sendUser">
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <input type="submit" value="הצגת משתמשים לפי האם הם אוהבים לטייל" class="button" name="sendUser">
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <input type="submit" value="עדכון שם מנהל" class="button" name="sendUser">
                    </td>
                </tr>
                <tr class="row">
                    <td>
                        <input type="submit" value="עדכון סיסמת מנהל" class="button" name="sendUser">
                    </td>
                </tr>
            </table>
            <%
            //אחזור בקשת משתמש והפניה לדף מתאים
            String s=request.getParameter("sendUser");
            try {
                if(s.equals("הצגת כל הנרשמים"))
                {
                    response.sendRedirect("./amin-actions/list-users.jsp");
                }
                else if(s.equals("מחיקת משתמש לפי אימייל"))
                {
                    response.sendRedirect("delete.jsp");
                }
                else if(s.equals("עדכון פרטי משתמש לפי אימייל"))
                {
                    response.sendRedirect("UpdateByEmail.jsp");
                }
                else if(s.equals("הצגת משתמשים לפי גיל"))
                {
                    response.sendRedirect("UpdateByDetails.jsp");
                }
                else if(s.equals("הצגת משתמשים לפי האם הם אוהבים לטייל"))
                {	
                    response.sendRedirect("ShowByCityAndMuseum.jsp");
                }
                else if(s.equals("עדכון שם מנהל"))
                {
                    response.sendRedirect("ShowByCityAndRestaurant.jsp");
                }else if(s.equals("עדכון סיסמת מנהל"))
                {
                    response.sendRedirect("updateAdname.jsp");
                }
            }
            catch(Exception e)
            {
                System.out.println("Error");
            }
            %>
        </section>
        <!-- end admin actions section -->

        <!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="../index.html#home"><img class="icon" src="../../pictures/icon.png" alt="מטיילים" width="70" height="70"></a>
                <p class="footer-menu">
                    <a href="../index.html#home">דף הבית</a>
                    •
                    <a href="../index.html#about">אודות</a>
                    •
                    <a href="../blog.html">בלוג</a>
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
                    <a href="./admin/admin-login.html">מטיילים</a> <!-- manager entry -->
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