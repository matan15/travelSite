<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
<%@page import="java.sql.*" %>
<%--����� �� ������ --%>
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
<h3>����� ���� �����</h3>
<form method="post" action="delete.jsp">
���� ������: <input type="text"  name="email" size="20"><br>
 <input type="submit" value="send" name="send"><br>
</form>
</div>
<br>
<%
boolean userFound=false;  //���� ������ ����� ����� �� ������� �� ����� ���� ��� �����. ������:
if(request.getParameter("send")!=null)
{
	String email=request.getParameter("email"); //������ ������ ������ ����� ���� ���� (�� ������ ���) ������� �� ������� ������ (����� ����))
	//����� ��� ���� ������� 
	   try
	   {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root",""); // ������� ���� ������
			st=con.createStatement();
		
	   String sql="SELECT * FROM TBUSERS WHERE email='"+email+"'"; // ������ ������ �� ������� ����� ����� (�� ����� �� ������)
	   usersResultSet=st.executeQuery(sql); /* ����� ������ �� ������ �������� resultset  */
	   if (usersResultSet!=null && usersResultSet.next()) //����� ��� ����� ���� ��������� (������ ����� �� ������) ��� ��� ��� �� ����
	   {
		 userFound=true;  
	   }
	   if(userFound)  //����� ����
	   {
		   session.setAttribute("email",usersResultSet.getString("email")); //����� �� ������� ����� ������ . ������ ������� 
		   response.sendRedirect("doDeleteByEmail.jsp"); //����� ������ ������
	   }
	   else //����� �� ���� ������
	   {
		   out.print("������ �� ����");
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
<a href="manage.jsp"> ���� </a>
</body>
</html>