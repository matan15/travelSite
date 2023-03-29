<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>

<%@page import="java.sql.*" %>

<%--����� �� ������ --%>
<%!

java.sql.Connection con=null; //������ ���� �� ������ ���������
java.sql.Statement st=null;
java.sql.ResultSet usersResultSet=null;
%>
<%--����� ������ ������ �� ����� ���� �������� ������� ����� --%>
<%!

public String formatUsersForHtml(java.sql.ResultSet usersResultSet)
{
String str="<table class="users-grid">";
str+="<tr>";
str+="<td class="users-grid-heading">Full Name</td>";
str+="<td class="users-grid-heading">Email</td>";
str+="<td class="users-grid-heading">Password</td>";
str+="<td class="users-grid-heading">Love Traveling</td>";
str+="<td class="users-grid-heading">Age Range</td>";
str+="</tr>";
	      
	try
	{
		while(usersResultSet.next()) // �� �� ���� ���� ����� ��� ���� �� ��� ����
		{
		  str+="<tr class="user">";
		  str+="<td class="user-detail">"+usersResultSet.getString("fullName").toString()+"</td>";
		  str+="<td class="user-detail">"+usersResultSet.getString("email").toString()+"</td>";
		  str+="<td class="user-detail">"+usersResultSet.getString("password").toString()+"</td>";
		  str+="<td class="user-detail">"+usersResultSet.getString("loveTravel").toString()+"</td>";
		  str+="<td class="user-detail">"+usersResultSet.getString("ageRange").toString()+"</td>";
		  str+="</tr>";
	    }
		  str+="</table>";
	} //end of try
	catch(Exception ex)
	{
		System.out.print("����� ��������");
	}
	return str;
}
%>
<%--����� ���� ������ --%>

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
        <link rel="stylesheet" href="../../static/css/admin/users-list.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>����� ������� | �������</title>
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
                <li><a href="../blog.html">����</a></li>
                <li><a href="../index.html#contact">��� ���</a></li>
            </ul>

            <div class="login-and-sign-up">
                <button class="sign-up" onclick="redirectToFile('../login-sign-up/sign-up.html');">
                    �����
                </button>
                <button class="login" onclick="redirectToFile('../login-sign-up/login.html')">
                    �����
                </button>
            </div>
            <div class="user-menu">
                <img class="profile-img" src="../../pictures/icon.png" alt="profile" width="60" height="60"> <!-- fix source and alt -->
                <div class="dropdown">
                    <button class="dropbtn"><img src="../../pictures/arrow.png" alt="arrow" width="60" height="60"></button>
                    <div class="dropdown-content">
                        <a href="">����� �����</a>
                        <a href="">�������� ���</a>
                        <a href="">�����</a>
                    </div>
                </div>
            </div>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->
        <%
        if ((session.getAttribute("admin")== null) || !session.getAttribute("admin").equals("true"))
			response.sendRedirect ("noManage.jsp");
        %>

        <!-- header -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">������ ����</h2>
                </div>
            </div>
        </section>
        <!-- end header -->

        <!-- users list -->
        <button>���� ��� �����</button>
        <section class="users-list-section">
            <%
            //����� ��� ���� ������� 
            try{
		        Class.forName("com.mysql.jdbc.Driver").newInstance();
		        con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
		        st=con.createStatement();
	
                String sql="SELECT * FROM TBusers"; // ������ SQL    
                usersResultSet=st.executeQuery(sql);
            }
	        catch(Exception ex){
		        System.out.println("Error in connection");
	        }
	        //������� ����� ������� ���� ���� ������� �� ������� ��������� ������
            out.print(formatUsersForHtml(usersResultSet));
            usersResultSet.close();
            %>
            <%-------------------------------------------------------------- --%>
        </section>
        <!-- end user list -->

        <!-- footer -->
        <footer>
            <div class="footer_main">
                <a href="../index.html#home"><img class="icon" src="../../pictures/icon.png" alt="�������" width="70" height="70"></a>
                <p class="footer-menu">
                    <a href="../index.html#home">�� ����</a>
                    �
                    <a href="../index.html#about">�����</a>
                    �
                    <a href="../blog.html">����</a>
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
                    <p>�������</p> <!-- manager entry -->
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