<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
    
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script language="javascript" src="../../static/js/base.js"></script>
        <link rel="stylesheet" href="../../static/css/base.css">
        <link rel="stylesheet" href="../../static/css/admin/noManage.css">
        <title>Document</title>
	</head>
    <body>
        <table class="main">
            <tr>
                <img class="warning-img" src="../../pictures/warning.png" alt="warning">
            </tr>
            <tr>
                <td>
                    <h1 class="heading">אתה לא מנהל אתר!</h1>
                </td>
            </tr>
            <tr>
                <td>
                    <h4 class="sub-heading">אם אתה בכל זאת מנהל האתר, נסה להיכנס שוב כמנהל</h4>
                </td>
            </tr>
            <tr>
                <td>
                    <button class="retry-btn" onclick="redirectToFile('admin-login.jsp')">לניסיון נוסף</button>
                </td>
            </tr>
        </table>
   </body>
</html>
