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
		<link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link rel="icon" href="../../pictures/icon.png">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <link rel="stylesheet" href="../../static/css/admin/doDeleteByEmail.css">
		<script src="../../static/js/base.js"></script>
		<title>מחק משתמש ממסד נתונים | מטיילים</title>
	</head>
	<body dir="rtl">
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
			String sql = "DELETE FROM TBposts WHERE userId=" + session.getAttribute("userToDelete");
			
			try {
				int n = st.executeUpdate(sql);
			}
			catch(SQLException e) {
				System.out.println("SQLException:"+e.getMessage());
				System.out.println("SQLState:" +e.getSQLState());
			}
			
			sql="DELETE FROM TBusers WHERE email='"+session.getAttribute("email")+"'";
			System.out.println(str);
			try
			{
				int n=st.executeUpdate(sql);
				st.close();
				con.close();
				out.println("המשתמש נמחק בהצלחה!");
			}
			catch(SQLException ex)
			{
				System.out.println("SQLException:"+ex.getMessage());
				System.out.println("SQLState:" +ex.getSQLState());
			}
		%>
		<br>
		
		<button class="btn" onclick="redirectToFile('manage.jsp')">חזרה לתפריט</button>
		<button class="btn" onclick="redirectToFile('listUsers.jsp')">רשימת המשתמשים</button>
	</body>
</html>