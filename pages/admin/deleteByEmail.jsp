<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
<%@page import="java.sql.*" %>
<%--����� �� ������ --%>
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
                    <h2 class="heading-text">����� ������� ��� ������</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

		<button onclick="redirectToFile('manage.jsp')">���� ������</button>

		<div>
			<form action="deleteByEmail.jsp" method="post">
				<label for="email">���� ������:</label>
				<input type="text" name="email">
				<input type="submit" value="���" name="delete">
			</form>
		</div>

		<%
		boolean userFound=false;  //���� ������ ����� ����� �� ������� �� ����� ���� ��� �����. ������:
		if(request.getParameter("delete")!=null)
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
	</body>
</html>