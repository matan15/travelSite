<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
<%@page import="java.sql.*" %>
<%--הצהרה על משתנים --%>
<%!

java.sql.Connection con=null;
java.sql.Statement st=null;
java.sql.ResultSet usersResultSet=null;
String str;
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>מחק משתמש ממסד נתונים | מטיילים</title>
	</head>
	<body>
		<%
		if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
					response.sendRedirect ("noManage.jsp");
			%>
			
		<%
		//יצירת קשר למסד הנתונים 
		try
		{
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
				st=con.createStatement();
		}
			catch(Exception ex){
				System.out.println("Error in connection");
			}
			str="DELETE FROM TBusers WHERE email='"+session.getAttribute("email")+"'";
			try
			{
				int n=st.executeUpdate(str);
				st.close();
				con.close();
			}
			catch(SQLException ex)
			{
				System.out.println("SQLException:"+ex.getMessage());
				System.out.println("SQLState:" +ex.getSQLState());
			}
		%>
		<button onclick="redirectToFile('manage.jsp')">חזרה לתפריט</button>
		<button onclick="redirectToFile('listUsers.jsp')">רשימת המשתמשים</button>
	</body>
</html>