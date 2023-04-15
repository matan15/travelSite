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
        <title>����� ����� ���� ���� ������ | �������</title>
    </head>
    <body>
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
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
                response.sendRedirect ("noManage.jsp");
        %>
        <div>
            <h3>����� �� �����</h3>
            <form action="doUpdateAdpass.jsp">
                <table>
                    <tr>
                        <td>
                            <label for="adPass">����� ����</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" name="adName" value=<%=session.getAttribute("adPass")%>>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="���" name="send">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <%
            if(request.getParameter("send")!=null)
                {
                String adPass=request.getParameter("adPass");
                String adName=(String)session.getAttribute("adName");
                
                
                //����� ��� ���� ������� 
                try
                    {
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        con=java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/DBMatan","root","");
                        st=con.createStatement();
                    }
                    catch(Exception ex){
                        System.out.println("Error in connection-1"+ex);
                    }
                    String sql="UPDATE TBadmin SET adName='"+adName+"',adPass='"+adPass+"' WHERE adName='"+adName+"'";		
                    try
                    {
                        st.executeUpdate(sql);
                        out.print("������ ���� ������!"); 
                        st.close();
                        con.close();
                    }
                    catch(Exception ex)
                    {
                        System.out.print("Error in connection-2"+ex);
                    }
                }
        %>
    </body>
</html>