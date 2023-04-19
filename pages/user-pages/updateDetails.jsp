<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
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
        <link rel="stylesheet" href="../../static/css/user-pages/updateDetails.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <script>
            function updateFormTest() {
                var email = document.signUpForm.full_name.value;
                var email = document.signUpForm.email.value;
                var password = document.signUpForm.password.value;
                var re_password = document.signUpForm.re_password.value;
                var ageSelectedValue = document.querySelector('input[name="age"]:checked');

                var nameTest = nameCorrect(name, true, "");
                var emailTest = emailCorrect(email, nameTest[0], nameTest[1]);
                var passwordTest = passwordCorrect(password, emailTest[0], emailTest[1]);
                var totalTests = passwordTest;
                if (password != re_password) {
                    totalTests[0] = false;
                    totalTests[1] = totalTests[1] + "\n" + "* שדות הסיסמה לא תואמים נא וודא שהקלדת נכון את הסיסמאות.";
                }

                if (ageSelectedValue == null) {
                    totalTests[0] = false;
                    totalTests[1] = totalTests[1] + "\n" + "* לא בחרת את טווח הגילאים בו נמצא גילך, נא בחר/י טווח גילאים.";
                }

                if (!totalTests[0]) {
                    window.alert(totalTests[1]);
                    event.preventDefault();
                    return false;
                }
                return true;
            }
        </script>
        <title>עדכון פרטים | מטיילים</title>
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

        <!-- heading -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">עדכון פרטים</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

        <!-- update details section -->
        <section class="update-section">
            <%
            if ((session.getAttribute("user")== null)|| !session.getAttribute("user").equals("true"))
                response.sendRedirect ("noUser.jsp");
            %>
            <%
                boolean userFound=false;
                String id=session.getAttribute("userId").toString();
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan", "root", "");
                    st = con.createStatement();

                    String sql="SELECT * FROM TBusers WHERE id=" + id;
                    usersResultSet=st.executeQuery(sql);
                    if (usersResultSet!=null && usersResultSet.next()) {
                        userFound=true;
                    }
                    if(userFound) {
                        session.setAttribute("fullName", usersResultSet.getString("fullName"));
                        session.setAttribute("email", usersResultSet.getString("email"));
                        session.setAttribute("password", usersResultSet.getString("password"));
                        session.setAttribute("loveTravel", usersResultSet.getString("loveTravel"));
                        session.setAttribute("ageRange", usersResultSet.getString("ageRange"));

                        response.sendRedirect("doUpdateDetails.jsp");
                    }
                    else {
                        out.print("המשתמש לא נמצא");
                    }
                }
                catch(Exception ex) {
                    System.out.println("Error in connection" + ex);
                }
            %>
        </section>
        <!-- end update details section -->

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