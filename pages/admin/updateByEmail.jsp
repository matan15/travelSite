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
        <title>עדכן פרטי משתמש לפי אימייל | מטיילים</title>
    </head>
    <body>
        <section>
            <%
                if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
                    response.sendRedirect ("noManage.jsp");
            %>
            <div>
                <h3>עדכון פרטי משתמש</h3>
                <form action="updateByEmail.jsp" method="post">
                    <table>
                        <tr>
                            <td>
                                <label for="email">הכנס אימייל:</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="email">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" value="שלח" name="send">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <%
                boolean userFound=false;
                if(request.getParameter("send")!=null)
                {
                    String email=request.getParameter("email"); //קריאת שם משתמש
                    //יצירת קשר למסד הנתונים 
                    try
                    {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                            st=con.createStatement();
                        
                    String sql="SELECT * FROM TBusers WHERE email='"+email+"'"; //שאילתת SQL
                    usersResultSet=st.executeQuery(sql);                  //קולט את הטבלה של ה sql
                    if (usersResultSet!=null && usersResultSet.next())
                    {
                        userFound=true;  
                    }
                    if(userFound) //שמירת נתוני משתמש שמצאנו
                    {
                        session.setAttribute("fullName",usersResultSet.getString("fullName"));
                        session.setAttribute("email",usersResultSet.getString("email"));
                        session.setAttribute("password",usersResultSet.getString("password"));
                        session.setAttribute("loveTravel",usersResultSet.getString("loveTravel"));
                        session.setAttribute("ageRange",usersResultSet.getString("ageRange"));
                        //הפניה לדף לביצוע העדכון
                        response.sendRedirect("doUpdateByEmail.jsp");
                    }
                    else
                    {
                        out.print("המשתמש לא נמצא");
                    }
                    }
                    catch(Exception ex)
                    {
                        System.out.println("Error in connection"+ex);
                    }
                }
            %>
        </section>
    </body>
</html>