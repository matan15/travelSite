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
		<link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link rel="icon" href="../../pictures/icon.png">
        <link rel="stylesheet" href="../../static/css/admin/deleteUserByEmail.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
		<script language="javascript" src="../../static/js/base.js"></script>
		<title>����� ��� ������ | �������</title>
	</head>
	<body dir="rtl">
		<!-- navbar -->
        <nav class="nav sticky-nav">
            <div class="nav-brand">
                <button onclick="redirectToFile('../index.html')" class="brand-link">
                    <img src="../../pictures/icon.png" alt="�������" width="70" height="70" id="logo">
                    <h1 class="nav-heading">�������</h1>
                </button>
            </div>
            
            <ul class="menu">
                <li><a href="../index.html#home">�� ����</a></li>
                <li><a href="../index.html#about">�����</a></li>
                <li><a href="../blog.jsp">����</a></li>
                <li><a href="../index.html#contact">��� ���</a></li>
            </ul>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->
        
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

		<button class="manage-btn" onclick="redirectToFile('manage.jsp')">���� ������</button>

		<div>
			<form action="deleteByEmail.jsp" method="post">
				<label class="label" for="email">���� ������:</label><br>
				<input class="field" type="text" name="email"><br>
				<input class="submit-btn" type="submit" value="���" name="delete">
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
				
			String sql="SELECT * FROM TBusers WHERE email='"+email+"'"; // ������ ������ �� ������� ����� ����� (�� ����� �� ������)
			usersResultSet=st.executeQuery(sql); /* ����� ������ �� ������ �������� resultset  */
			if (usersResultSet!=null && usersResultSet.next()) //����� ��� ����� ���� ��������� (������ ����� �� ������) ��� ��� ��� �� ����
			{
				userFound=true;  
			}
			if(userFound)  //����� ����
			{
				session.setAttribute("email",usersResultSet.getString("email")); //����� �� ������� ����� ������ . ������ ������� 
				session.setAttribute("userToDelete", usersResultSet.getString("id"));
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
        <!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="../index.html#home"><img class="icon" src="../../pictures/icon.png" alt="�������" width="70" height="70"></a>
                <p class="footer-menu">
                    <a href="../index.html#home">�� ����</a>
                    �
                    <a href="../index.html#about">�����</a>
                    �
                    <a href="../blog.jsp#">����</a>
                    �
                    <a href="../index.html#contact">��� ���</a>
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
                <p>
                    <a href="./admin-login.jsp">�������</a> <!-- manager entry -->
                    &copy;
                    <span id="copyrightYear">
                        <script>
                        document.write(new Date().getFullYear());
                        </script>
                    </span>
                </p>
            </div>
        </footer>
        <!-- footer -->
    </body>
</html>