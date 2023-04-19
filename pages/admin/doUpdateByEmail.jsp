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
        <link rel="stylesheet" href="../../static/css/admin/doUpdateByEmail.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript">
            function updateForm() {
                var email = document.signUpForm.full_name.value;
                var email = document.signUpForm.email.value;
                var password = document.signUpForm.password.value;
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
        <title>עדכן פרטי משתמש במסד נתונים | מטיילים</title>
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
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->
        
        <!-- heading -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">עדכון פרטי משתמש</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->
        
        <section>
            <%
                if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
                    response.sendRedirect ("noManage.jsp");
            	if (request.getParameter("send")== null) {
            %>
            <form name="updateForm" onsubmit="return updateFormTest();" method="post">
                <table class="layout">
                    <tr class="label">
                        <td>
                            <label for="name">שם מלא:</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <%
    						String fullName = (String) session.getAttribute("fullName");
                        	fullName = fullName.replace('-', ' ');
                        	System.out.println(fullName);
						%>
                            <input class="field" name="fullName" type="text" value=<%=fullName.replace('-', ' ') %> required>
                        </td>
                    </tr>
                    <tr class="label">
                        <td>
                            <label for="email">מייל:</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="field" name="email" type="text" value=<%=session.getAttribute("email") %> required>
                        </td>
                    </tr>
                    <tr class="label">
                        <td>
                            <label for="password">סיסמה:</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="field" type="password" name="password" value=<%=session.getAttribute("password") %> required>
                        </td>
                    </tr>
                    <tr class="label">
                        <td>
                            <label for="re_password">אימות סיסמה:</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="field" type="password" name="re_password" value=<%=session.getAttribute("password") %> required>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        	<% if (session.getAttribute("loveTravel").equals("yes")){ %>
                            	<input class="field" type="checkbox" value="yes" id="love_travel" name="loveTravel" checked>
                            <% } else { %>
                            	<input class="field" type="checkbox" value="yes" id="love_travel" name="loveTravel">
                            <% } %>
                            <label for="loveTravel">האם את/ה אוהב/ת לטייל?</label>
                        </td>
                    </tr>
                    <tr class="label">
                        <td>
                            <label for="age-range">מהו הטווח שבו נמצא גילך?</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="age-range">
                        	<% if (session.getAttribute("ageRange").equals("8-18")){ %>
                            <input class="field" type="radio" id="age1" value="8-18" name="age" checked>
                            <% } else { %>
                            <input class="field" type="radio" id="age1" value="8-18" name="age">
                            <% } %>
                            <label for="age1" class="age">8-18</label><br>
                            
                            <% if (session.getAttribute("ageRange").equals("18-30")){ %>
                            <input class="field" type="radio" id="age2" value="18-30" name="age" checked>
                            <% } else { %>
                            <input class="field" type="radio" id="age2" value="18-30" name="age">
                            <% } %>
                            <label for="age2" class="age">18-30</label><br>
                            
                            <% if (session.getAttribute("ageRange").equals("30-50")){ %>
                            <input class="field" type="radio" id="age3" value="30-50" name="age" checked>
                            <% } else { %>
                            <input class="field" type="radio" id="age3" value="30-50" name="age">
                            <% } %>
                            <label for="age3" class="age">30-50</label><br>
                            
                            <% if (session.getAttribute("ageRange").equals("50-70")){ %>
                            <input class="field" type="radio" id="age4" value="50-70" name="age" checked>
                            <% } else { %>
                            <input class="field" type="radio" id="age4" value="50-70" name="age">
                            <% } %>
                            <label for="age4" class="age">50-70</label><br>
                            
                            <% if (session.getAttribute("ageRange").equals("70 and up")){ %>
                            <input class="field" type="radio" id="age5" value="70 and up" name="age" checked>
                            <% } else { %>
                            <input class="field" type="radio" id="age5" value="70 and up" name="age">
                            <% } %>
                            <label for="age5" class="age">70 ומעלה</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="send" value="עדכן">
                        </td>
                    </tr>
                </table>
            </form>
            <%
            	}
            	else
                {
                    String fullName=request.getParameter("fullName");
                    String email=request.getParameter("email");
                    String password=request.getParameter("password");

                    String loveTravelAnswer[] = request.getParameterValues("love_travel");
                    String loveTravel;
                    if (loveTravelAnswer != null && loveTravelAnswer.length != 0) {
                        loveTravel = "yes";
                    }
                    else {
                        loveTravel = "no";
                    }
                    
                    String ageRange=request.getParameter("age");
                    
                    //יצירת קשר למסד הנתונים 
                    try
                        {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                            st=con.createStatement();
                        }
                        catch(Exception ex){
                            System.out.println("Error in connection-1"+ex);
                        }
                        String sql="UPDATE TBusers SET fullName='"+fullName.replace(' ', '-')+"',email='"+email+"',password='"+password+"',loveTravel='"+loveTravel+"',password='" + password + "', ageRange='"+ageRange+"' WHERE email = '" + email + "'";
                        System.out.println(sql);
                        try
                        {
                            st.executeUpdate(sql);
                            out.print("העדכון התבצע בהצלחה!"); 
                            st.close();
                            con.close();
                        }
                        catch(Exception ex)
                        {
                            out.print("Error in connection-2"+ex);
                        }
                    }
            %>
        </section>
        
		<!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="#home"><img class="icon" src="../../pictures/icon.png" alt="מטיילים" width="70" height="70"></a>
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