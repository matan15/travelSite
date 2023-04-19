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
        <link rel="stylesheet" href="../../static/css/login-sign-up/sign-up.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <script language="javascript">
            function signUpFormTest() {
                var name = document.signUpForm.full_name.value;
                var email = document.signUpForm.email.value;
                var password = document.signUpForm.password.value;
                var re_password = document.signUpForm.re_password.value;
                var ageSelectedValue = document.querySelector('input[name="age"]:checked');

                var nameTest = nameCorrect(name, true, "");
                var emailTest = emailCorrect(email, nameTest[0], nameTest[1]);
                var passwordTest = passwordCorrect(password, emailTest[0], emailTest[1]);
                var totalTests = passwordTest;
                if (password != re_password) {
                    totalTests[0] = false;
                    totalTests[1] = totalTests[1] + "\n" + "* ���� ������ �� ������ �� ���� ������ ���� �� ��������.";
                }

                if (ageSelectedValue == null) {
                    totalTests[0] = false;
                    totalTests[1] = totalTests[1] + "\n" + "* �� ���� �� ���� ������� �� ���� ����, �� ���/� ���� ������.";
                }

                if (!totalTests[0]) {
                    window.alert(totalTests[1]);
                    event.preventDefault();
                    return false;
                }
                return true;
            }
        </script>
        <title>����� | �������</title>
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

            <div class="login-and-sign-up">
                <button class="sign-up" onclick="redirectToFile('./sign-up.html');">
                    �����
                </button>
                <button class="login" onclick="redirectToFile('./login.html')">
                    �����
                </button>
            </div>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->

        <!-- sign up form -->
        <section class="sign-up-section">
            <%
            if (session.getAttribute("user") != null && session.getAttribute("user").equals("true") && session.getAttribute("userId") != null) {
        		response.sendRedirect("../user-pages/usersMenu.jsp");
        	}
            
            if(!request.getMethod().equals("POST")) { 
            %>
                <div class="sign-up-main">
                    <h1>�����</h1>
                    <form name="signUpForm" onsubmit="return signUpFormTest();" method="post" action="sign-up.jsp">
                        <table>
                            <tr class="field-label">
                                <td>
                                    <label for="name">�� ��� (�������):</label>
                                </td>
                            </tr>
                            <tr class="field">
                                <td>
                                    <input name="full_name" type="text" required>
                                </td>
                            </tr>
                            <tr class="field-label">
                                <td>
                                    <label for="email">����:</label>
                                </td>
                            </tr>
                            <tr class="field">
                                <td>
                                    <input name="email" type="text" required>
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
                            <tr class="label">
                                <td>
                                    <label for="re_password">����� �����:</label>
                                </td>
                            </tr>
                            <tr class="field">
                                <td>
                                    <input type="password" name="re_password" required>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" value="yes" id="love_travel" name="love_travel">
                                    <label for="love_travel">��� ��/� ����/� �����?</label>
                                </td>
                            </tr>
                            <tr class="label">
                                <td>
                                    <label for="age-range">��� ����� ��� ���� ����?</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="age-range">
                                    <input type="radio" id="age1" value="8-18" name="age">
                                    <label for="age1" class="age">8-18</label><br>
                                    <input type="radio" id="age2" value="18-30" name="age">
                                    <label for="age2" class="age">18-30</label><br>
                                    <input type="radio" id="age3" value="30-50" name="age">
                                    <label for="age3" class="age">30-50</label><br>
                                    <input type="radio" id="age4" value="50-70" name="age">
                                    <label for="age4" class="age">50-70</label><br>
                                    <input type="radio" id="age5" value="70 and up" name="age">
                                    <label for="age5" class="age">70 �����</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="submit" value="�����">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <%
                }// 
                if(request.getMethod().equals("POST"))
                {	    
                    String fullName=request.getParameter("full_name").replace(" ", "-");
                    String email=request.getParameter("email");
                    String password=request.getParameter("password");

                    String loveTravelAnswer[] = request.getParameterValues("love_travel");
                    String loveTravel;
                    if (loveTravelAnswer != null && loveTravelAnswer.length != 0) {
                        loveTravel = "yes";
                    }
                    else {
                        loveTravel = "no";
                    }

                    String ageRange=request.getParameter("age");
                    String result [][]= null;
                    try 
                    {
                        // ��� �: ����� ������ - ������
                        Class.forName("com.mysql.jdbc.Driver").newInstance();	
                            
                        //��� �:����� ���� �������
                        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                        
                        //��� �: ����� ��� �������� "�����" �� ��� �������, ��� ������ �� ���
                        Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                                            ResultSet.CONCUR_UPDATABLE);
                            
                        // Statement st = con.createStatement(); // ���� ��� �������, �� �� ���� ���� ����� - ���� ���� ��������
                                
                        //��� �: ����� ������ ���� ��� �������
                    
                        String mySQL = "SELECT * FROM TBusers WHERE email='" + email +"'"; 
                        System.out.println(mySQL);
                        
                        //��� �: ����� ������� - ���� ������� ����� ��� �-(������ �� ��) ��� �������		  		
                        ResultSet oRS = st.executeQuery(mySQL);				
                            
                        //=====================��� �������� ���� �������======================
                                    
                        int numColumns = oRS.getMetaData().getColumnCount();
                        oRS.last();				
                        int numRows = oRS.getRow();
                            
                        result = new String[numRows][numColumns];	
                        oRS.beforeFirst();
                        int i = 0;
                        while (oRS.next())
                        {
                            for(int j = 0; j < numColumns; j++ )
                                result[i][j]=oRS.getString(j+1);				
                            i++;
                        }		
                        oRS.close();	
                        st.close();	
                    } 
                    catch (Exception e) 
                    {	  			
                        //e.printStackTrace();
                        System.out.println("Register-1- Error in connecting");
                    } //======================= the connection is closed

                    if(result.length>0)
                        out.print("���� ��� ����� �� ������� �� ");
                    else
                    {
                        try 
                        {
                            // ��� �: ����� ������ - ������
                            Class.forName("com.mysql.jdbc.Driver").newInstance();	
                            //��� �:����� ���� �������
                            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                            //��� �: ����� ��� �������� "�����" �� ��� �������, ��� ������ �� ���
                            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                                                    ResultSet.CONCUR_UPDATABLE);
                            // Statement st = con.createStatement(); // ���� ��� �������, �� �� ���� ���� ����� - ���� ���� ��������
                                    
                            //��� �: ����� ������ ���� ��� �������
                            String mySQL = "insert into TBUSERS (fullName, email, password, loveTravel, ageRange) values('" + fullName + "', '" + email + "', '" + password + "', '" + loveTravel + "', '"+ ageRange + "')";
                            System.out.println(mySQL);
                        
                            //��� �: ����� ��� �������
                            int n = st.executeUpdate(mySQL);  	// ���� �� ���� ������� ������� ������ ������� n ������  			//=====================��� �������� ���� �������======================
                                                                
                            //oRS.close();	- ����� �� �� ������ ������
                            st.close();
                            con.close();
                        } 
                        catch (Exception e) 
                        {	  			
                            //e.printStackTrace();
                            System.out.println("Register-2- Error in connecting");
                        }//======================= the connection is closed
                        out.print("������ ���� ������<br/><br/>");
                        out.print("<br />");
                    } // end else exist
                }// end requset post
                %>	
        </section>

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
                    <a href="../admin/admin-login.html">�������</a> <!-- manager entry -->
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