<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>

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
        <link rel="stylesheet" href="../../static/css/admin/manage.css">
        <link rel="stylesheet" href="../../static/css/nav.css">
        <link rel="stylesheet" href="../../static/css/footer.css">
        <link rel="stylesheet" href="../../static/css/base.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <title>����� ���� | �������</title>
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

        <%
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true")) // ����� ��� ������ ���� ������ ��� ����� �� ���, ���� ����� �� ���� ������ ����
			    response.sendRedirect ("noManage.jsp");
        %>
        <!-- heading -->
        <section class="heading">
            <div class="heading-main">
                <img class="heading-img" src="../../pictures/heading.jpg" alt="nature" width="100%">
                <div class="heading-text-box">
                    <h2 class="heading-text">������ ����</h2>
                </div>
            </div>
        </section>
        <!-- end heading -->

        <!-- admin actions section -->
        <section>
            <form name="actionsForm" action="manage.jsp" method="post">
                <table class="actions-grid">
                    <tr class="row">
                        <td>
                            <input type="submit" value="Show all users" class="button" name="sendUser">
                        </td>
                    </tr>
                    <tr class="row">
                        <td>
                            <input type="submit" value="Delete User By Email" class="button" name="sendUser">
                        </td>
                    </tr>
                    <tr class="row">
                        <td>
                            <input type="submit" value="Update user by email" class="button" name="sendUser">
                        </td>
                    </tr>
                    <tr class="row">
                        <td>
                            <input type="submit" value="Show users by age" class="button" name="sendUser">
                        </td>
                    </tr>
                    <tr class="row">
                        <td>
                            <input type="submit" value="Show users by loving travel" class="button" name="sendUser">
                        </td>
                    </tr>
                    <tr class="row">
                        <td>
                            <input type="submit" value="Update admin name" class="button" name="sendUser">
                        </td>
                    </tr>
                    <tr class="row">
                        <td>
                            <input type="submit" value="Update admin password" class="button" name="sendUser">
                        </td>
                    </tr>
                </table>
            </form>
            <%
            //����� ���� ����� ������ ��� �����
            String s=request.getParameter("sendUser");
            System.out.println(s);
            try {
                if(s.equals("Show all users"))
                {
                    response.sendRedirect("listUsers.jsp");
                }
                else if(s.equals("Delete User By Email"))
                {
                    response.sendRedirect("deleteByEmail.jsp");
                }
                else if(s.equals("Update user by email"))
                {
                    response.sendRedirect("UpdateByEmail.jsp");
                }
                else if(s.equals("Show users by age"))
                {
                    response.sendRedirect("listUsersByAge.jsp");
                }
                else if(s.equals("Show users by loving travel"))
                {	
                    response.sendRedirect("listUsersByLoveTravel.jsp");
                }
                else if(s.equals("Update admin name"))
                {
                    response.sendRedirect("updateAdname.jsp");
                }else if(s.equals("Update admin password"))
                {
                    response.sendRedirect("updateAdPass.jsp");
                }
            }
            catch(Exception e)
            {
                System.out.println("Error");
            }
            %>
        </section>
        <!-- end admin actions section -->

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
                    <a href="./admin/admin-login.html">�������</a> <!-- manager entry -->
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