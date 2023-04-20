<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
    
<%@ page import = "java.sql.*"%>

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
        <link rel="stylesheet" href="../../static/css/admin/admin-login.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>������� ���� | �������</title>
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
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->
        
        <!-- login form -->
        <section class="sign-up-section">
            <%
                // the first time the page is sent to the user
                // the SUBMIT button was not pressed yet.
                if(request.getParameter("submit") == null )	//it means that the form is seen the first time
                {
            %>
            <div class="sign-up-main">
                <h1>������� ����</h1>
                <form name="sign-up-form" action="">
                    <table>
                        <tr class="field-label">
                            <td>
                                <label for="name">�� �����:</label>
                            </td>
                        </tr>
                        <tr class="field">
                            <td>
                                <input type="text" name="name" required>
                            </td>
                        </tr>
                        <tr class="field-label">
                            <td>
                                <label for="password">�����:</label>
                            </td>
                        </tr>
                        <tr class="field">
                            <td>
                                <input type="password" name="password" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" name="submit" value="�������">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <% 	 
	            }
	            else	// ������ ������ ���� �������
	            {
	                String adName = request.getParameter("name"); //���� ����� ��� ��� ������
	                String adPass = request.getParameter("password");
	            try 
	            {
	                // ��� �: ����� ������ - ������
	                Class.forName("com.mysql.jdbc.Driver");	
	                //��� �:����� ���� �������
	                Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                    
	                //��� �:����� ���� �������
	                Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
	                	                						   ResultSet.CONCUR_UPDATABLE);
	                // Statement st = con.createStatement(); // ���� ��� �������, �� �� ���� ���� ����� - ���� ���� ��������
	                //��� �: ����� ������ ���� ��� �������
	                String mySQL = "SELECT * FROM TBadmin WHERE adName='" + adName + "' AND adPass ='" + adPass + "'";//���� ���� ������ �� ���� ������ ������ ������� �� �� ��� � mysql
	                //��� �: ����� ������� - ���� ������� ����� ��� �-(������ �� ��) ��� �������	
	                ResultSet oRS = st.executeQuery(mySQL);				
	                //=====================��� �������� ���� �������======================
	                session.setAttribute("admin", "false");			
	                oRS.last(); // ������ ����� �� ������ ������		
	                int numRows = oRS.getRow();
	                if (numRows > 0) // ����� ������ ����� �� ������ �� ���� ����. �� �� ��� ���
	                {
	                	//System.out.println("no. = "+ oRS.getRow()+  "   Name = " + oRS.getString("Name")+ "    password= "+ oRS.getString("Pwd"));					
	                    session.setAttribute("admin","true");	
	                    session.setAttribute("adminId", oRS.getString("id"));
                    }
	                oRS.close();
	                st.close();
				} 
	            catch (Exception e) {
	              	    //e.printStackTrace();
	            	    out.println("Error in connection"+e);
	            } // the connection is closed	
	              	if ( session.getAttribute("admin").equals("true") )
	            		response.sendRedirect ("manage.jsp");
	            	else
	            		response.sendRedirect ("noManage.jsp");				
	            }	
            %>
        </section>
        <!-- end login form -->

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