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
        <title>����� �� ���� ���� ������</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
                response.sendRedirect ("noManage.jsp");
        %>
        <div>
            <h3>����� �� �����</h3>
            <form action="doUpdateAdname.jsp">
                <table>
                    <tr>
                        <td>
                            <label for="adName">�� ����</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" name="adName" value=<%=session.getAttribute("adName")%>>
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
                String adName=request.getParameter("adName");
                String adPass=(String)session.getAttribute("adPass");
                
                
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
                    String sql="UPDATE TBadmin SET adName='"+adName+"',adPass='"+adPass+"' WHERE adPass='"+adPass+"'";		
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