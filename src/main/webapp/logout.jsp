<%@ include file="include.jsp" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="<c:url value="/style.css"/>"/>
</head>
<body onload="document.getElementById('logout_form').submit();return false;">

<h2>If you are not automatically redirected, click the 'Logout' button.</h2>

<form id="logout_form" name="logout_form" action="<c:url value="/logout"/>" method="post">
    <input type="submit" value="Logout">
</form>

</body>
</html>