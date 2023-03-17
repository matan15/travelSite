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
    </head>
    <body>
        <%
        if ((session.getAttribute("MyADMIN")== null)|| !session.getAttribute("MyADMIN").equals("OK"))
                    response.sendRedirect ("noManage.jsp");
        %>
            
        <div style="text-align:center">
            <h3> עידכון פרטים</h3>
            <form id="theForm" action="doUpdateByEmail.jsp">
                <table>
                    <tr>
                        <td> שם מלא </td>
                        <th> <input type="text" size="10" name="fullName" value=<%=session.getAttribute("fullName")%>></th>
                    </tr>
                    <tr>
                        <td> אימייל </td>
                        <th> <input type="text" size="10" name="email" value=<%=session.getAttribute("email")%>></th>
                    </tr>
                    <tr>
                        <td> סיסמה </td>
                        <th><input type="text" size="20" name="password" value=<%=session.getAttribute("password")%>></th>
                    </tr>
                    <tr>
                        <td> אוהב לטייל </td>
                        <th> <input type="text" size="10" name="loveTravel" value=<%=session.getAttribute("loveTravel")%>></th>
                    </tr>
                    <tr>
                        <td> טווח שבו נמצא הגיל </td>
                        <th> <input type="text" size="10" name="ageRange" value=<%=session.getAttribute("ageRange")%>></th>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <input type="submit" id="send" name="send" value="שלח">
                            <input type="reset" id="reset" name="reset" value="אפס">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <br>
        <%
        if(request.getParameter("send")!=null)
            {
            String fullName=request.getParameter("fullName");
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            String loveTravel=request.getParameter("loveTravel");
            String ageRange=request.getParameter("ageRange");
            
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
                String sql="UPDATE TBusers SET fullName='"+fullName+"',email='"+email+"',password='"+password+"',loveTravel='"+loveTravel+"',ageRange='"+ageRange+"' WHERE email='"+email+"'";
                try
                {
                    st.executeUpdate(sql);
                    out.print("העדכון התבצע בהצלחה!"); 
                    st.close();
                    con.close();
                }
                catch(Exception ex)
                {
                    System.out.print("Error in connection-2"+ex);
                }
            }
        %>
        <br><br>
        <a href="manage.jsp"> חזרה </a><br> 
        <a href="select.jsp"> הראה טבלה מעודכנת </a>
    </body>
</html>