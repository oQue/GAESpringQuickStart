<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html>
<head>
    <title>
        Google App Engine and Spring MVC Quick Start Demo
    </title>

    <jsp:include page="templates/head.jsp"/>
</head>

<body>

<jsp:include page="templates/navbar.jsp">
    <jsp:param name="active" value="main"/>
</jsp:include>

<div class="container">
<div class="jumbotron">
    <h1>Google App Engine and Spring MVC Quick Start Demo</h1>
    <p>This is an example project with Spring MVC for deployment at Google App Engine</p>
    <p>Full source code is available at <a href="<c:url value="https://github.com/oQue/GAESpringQuickStart"/>" target="_blank">GitHub page</a>.</p>
    <p>There is a demo <a href="<c:url value="/news"/>">news page</a> where you can add and view added news. Adding new entries is only available for application administator.</p>
    <p>For data access this project uses an <a href="<c:url value="https://github.com/objectify/objectify"/>" target="_blank">open-source objectify library</a>.</p>
</div>
</div>
</body>
</html>