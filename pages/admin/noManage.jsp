<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
    
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
        <link rel="stylesheet" href="../../static/css/nav.css">
        <script language="javascript" src="../../static/js/base.js"></script>
        <link rel="stylesheet" href="../../static/css/base.css">
        <link rel="stylesheet" href="../../static/css/admin/noManage.css">
        <title>לא מנהל | מטיילים</title>
	</head>
    <body>
        <!-- navbar -->
        <nav class="nav sticky-nav">
            <div class="nav-brand">
                <button onclick="redirectToFile('../index.html')" class="brand-link">
                    <img src="../../pictures/icon.png" alt="מטיילים" width="70" height="70" id="logo">
                    <h1 class="nav-heading">מטיילים</h1>
                </button>
            </div>
            <ul class="menu">
                <li><a href="../index.html#home">דף הבית</a></li>
                <li><a href="../index.html#about">אודות</a></li>
                <li><a href="../blog.html">בלוג</a></li>
                <li><a href="../index.html#contact">צור קשר</a></li>
            </ul>
    
            <div class="login-and-sign-up">
                <button class="sign-up" onclick="redirectToFile('../login-sign-up/sign-up.html');">
                    הירשם
                </button>
                <button class="login" onclick="redirectToFile('../login-sign-up/login.html')">
                    התחבר
                </button>
            </div>
        </nav>
        <div class="white-space"></div>
        <!-- end navbar -->

        <table class="main">
            <tr>
                <td>
                    <img class="warning-img" src="../../pictures/warning.png" alt="warning">
                </td>
            </tr>
            <tr>
                <td>
                    <h1 class="heading">!אתה לא מנהל האתר</h1>
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
