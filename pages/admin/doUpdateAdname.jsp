<%@ page language="java" contentType="text/html; charset=windows-1255" pageEncoding="windows-1255"%>
<%@page import="java.sql.*" %>
<%--הצהרה על משתנים --%>
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
        <title>עדכון שם מנהל במסד נתונים</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("admin")== null)|| !session.getAttribute("admin").equals("true"))
                response.sendRedirect ("noManage.jsp");
        %>
        <div>
            <h3>עדכון שם המנהל</h3>
            <form action="doUpdateAdname.jsp">
                <table>
                    <tr>
                        <td>
                            <label for="adName">שם מנהל</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" name="adName" value=<%=session.getAttribute("adName")%>>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="שלח" name="send">
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
                
                
                //יצירת קשר למסד הנתונים 
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
                        out.print("העדכון בוצע בהצלחה!"); 
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