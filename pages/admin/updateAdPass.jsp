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
        <title>עדכון סיסמת מנהל | מטיילים</title>
    </head>
    <body>
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
        <%
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
			    response.sendRedirect ("noManage.jsp");
        %>
        <section>
            <div>
                <h3>עדכון פרטי מנהל</h3>
                <form action="post" action="updateAdName.jsp">
                    <label for="adName">הכנס שם מנהל:</label><br>
                    <input type="text" name="adName"><br>
                    <input type="submit" value="שלח" name="send">
                </form>
            </div>
        </section>
        <%
            boolean userFound=false;
            if(request.getParameter("send")!=null)
            {
                String adName=request.getParameter("adName"); //קריאת שם משתמש
                
                
                //יצירת קשר למסד הנתונים 
                try
                {
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                        st=con.createStatement();
                    
                String sql="SELECT * FROM TBadmin WHERE adName='"+adName+"' "; //שאילתת SQL
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
                    response.sendRedirect("doUpdateAdpass.jsp");
                }
                else
                {
                    out.print("שם המנהל שגוי");
                }
                }
                catch(Exception ex)
                {
                    System.out.println("Error in connection-1"+ex);
                }
            }
        %>
    </body>
</html>