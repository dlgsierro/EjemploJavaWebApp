<%@page import="cl.dl.services.PersonService" %>
<%@page import="cl.dl.domain.Person" %>
<%
PersonService service = new PersonService();
Person gonzalo = service.buildPerson("Gonzalo", "Sierro", 41);
%>
<html>
<body>
<h2>Hola <%=gonzalo.getFirstName() + " " + gonzalo.getLastName()%>!</h2>
</body>
</html>
