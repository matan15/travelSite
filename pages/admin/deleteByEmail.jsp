<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
<%@page import="java.sql.*" %>
<%--הצהרה על משתנים --%>
<%!

java.sql.Connection con=null;
java.sql.Statement st=null;
java.sql.ResultSet usersResultSet=null;
%>


<html>
<head>
<link rel="stylesheet" type="text/css" href="jedesign.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<title>find user from database</title>
</head>
<body>
<%
if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
			response.sendRedirect ("noManage.jsp");
      %>
      
<div style="text-align:center"><br>  
<h3>מחיקת פרטי משתמש</h3>
<form method="post" action="delete.jsp">
הכנס אימייל: <input type="text"  name="email" size="20"><br>
 <input type="submit" value="send" name="send"><br>
</form>
</div>
<br>
<%
boolean userFound=false;  //בחלק הראשון המנהל הכניס את האימייל של הלקוח שהוא רצה למחוק. ועכשיו:
if(request.getParameter("send")!=null)
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
<br>
<a href="manage.jsp"> חזרה </a>
</body>
</html>