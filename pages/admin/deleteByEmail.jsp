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
		<script language="javascript" src="../../static/js/base.js"></script>
		<title>Document</title>
	</head>
	<body>
		<%
		if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
					response.sendRedirect ("noManage.jsp");
		%>
		<!-- heading -->    
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">מחיקת משתמשים לפי אימייל</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

		<button onclick="redirectToFile('manage.jsp')">חזרה לתפריט</button>

		<div>
			<form action="deleteByEmail.jsp" method="post">
				<label for="email">הכנס אימייל:</label>
				<input type="text" name="email">
				<input type="submit" value="מחק" name="delete">
			</form>
		</div>

		<%
		boolean userFound=false;  //בחלק הראשון המנהל הכניס את האימייל של הלקוח שהוא רצה למחוק. ועכשיו:
		if(request.getParameter("delete")!=null)
		{
			String email=request.getParameter("email"); //לוקחים אימייל מהטופס שמילא מנהל האתר (מה שלמעהל בדף) ושומרים את האימייל במשתנה (המירה בשרת))
			//יצירת קשר למסד הנתונים 
			try
			{
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root",""); // התחברות למסד נתונים
					st=con.createStatement();
				
			String sql="SELECT * FROM TBUSERS WHERE email='"+email+"'"; // שאילתה ששולפת את האימייל שקודם בחרנו (זה עדיין לא השליפה)
			usersResultSet=st.executeQuery(sql); /* תוצאת הביצוע של שאילתה כאובייקט resultset  */
			if (usersResultSet!=null && usersResultSet.next()) //בדיקה האם קיימת טבלה וירטואלית (התוצאת ביצוע של שאילתה) וגם האם היא לא ריקה
			{
				userFound=true;  
			}
			if(userFound)  //משתמש קיים
			{
				session.setAttribute("email",usersResultSet.getString("email")); //שמירת שם האימייל שאמור להימחק . שומרים בסאשיין 
				response.sendRedirect("doDeleteByEmail.jsp"); //הפניה לביצוע הביטול
			}
			else //משתמש לא קיים למחיקה
			{
				out.print("המשתמש לא נמצא");
			}
			st.close();
			con.close();
			}
			catch(Exception ex){
					System.out.println("Error in connection");
			}
		}
		%>
	</body>
</html>