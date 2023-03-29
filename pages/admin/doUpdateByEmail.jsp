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
        <script src="../../static/js/base.js"></script>
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
    <body>
        <section>
            <%
                if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
                    response.sendRedirect ("noManage.jsp");
            %>
            <div class="sign-up-main">
                <h1>הרשמה</h1>
                <form name="updateForm" onsubmit="return updateFormTest();" method="post" action="doUpdateByEmail.jsp">
                    <table>
                        <tr class="field-label">
                            <td>
                                <label for="fullName">שם מלא:</label>
                            </td>
                        </tr>
                        <tr class="field">
                            <td>
                                <input name="fullName" type="text" required>
                            </td>
                        </tr>
                        <tr class="field-label">
                            <td>
                                <label for="email">מייל:</label>
                            </td>
                        </tr>
                        <tr class="field">
                            <td>
                                <input name="email" type="text" required>
                            </td>
                        </tr>
                        <tr class="field-label">
                            <td>
                                <label for="password">סיסמה:</label>
                            </td>
                        </tr>
                        <tr class="field">
                            <td>
                                <input type="password" name="password" required>
                            </td>
                        </tr>
                        <tr class="label">
                            <td>
                                <label for="re_password">אימות סיסמה:</label>
                            </td>
                        </tr>
                        <tr class="field">
                            <td>
                                <input type="password" name="re_password" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" value="yes" id="love_travel" name="love_travel">
                                <label for="love_travel">האם את/ה אוהב/ת לטייל?</label>
                            </td>
                        </tr>
                        <tr class="label">
                            <td>
                                <label for="age-range">מהו הטווח שבו נמצא גילך?</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="age-range">
                                <input type="radio" id="age1" value="8-18" name="age">
                                <label for="age1" class="age">8-18</label><br>
                                <input type="radio" id="age2" value="18-30" name="age">
                                <label for="age2" class="age">18-30</label><br>
                                <input type="radio" id="age3" value="30-50" name="age">
                                <label for="age3" class="age">30-50</label><br>
                                <input type="radio" id="age4" value="50-70" name="age">
                                <label for="age4" class="age">50-70</label><br>
                                <input type="radio" id="age5" value="70 and up" name="age">
                                <label for="age5" class="age">70 ומעלה</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" name="submit" value="הירשם">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <%
                if(request.getParameter("send")!=null)
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
                    
                    String ageRange=request.getParameter("ageRange");
                    
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
                        String sql="UPDATE TBusers SET fullName='"+fullName+"',email='"+email+"',password='"+password+"',loveTravel='"+loveTravel+"',ageRange='"+ageRange+"'";		
                        try
                        {
                            st.executeUpdate(sql);
                            out.print("העדכון התבצע בהצלחה!"); 
                            st.close();
                            con.close();
                        }
                        catch(Exception ex)
                        {
                            System.out.print("Error in connection-2"+ex);
                        }
                    }
            %>
        </section>
    </body>
</html>