<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html>
<head>
    <title>
        GAE + Spring Demo. ${entry.title}
    </title>

    <jsp:include page="templates/head.jsp"/>
</head>

<body>

<jsp:include page="templates/navbar.jsp">
    <jsp:param name="active" value="news"/>
</jsp:include>

<div class="container">
    <h2>${entry.title}</h2>

    <div class="small">
        ${entry.date}
    </div>
    <div class="multiline-text">
        <p>${entry.text}</p>
    </div>
    <c:if test="${isAdmin}">
        <c:set var="entry" value="${entry}" scope="request" />
        Admin only feature:
        <form:form method="post" action="/news/delete/${entry.link}" role="form">
            <button type="submit" class="btn btn-danger">Delete entry</button>
        </form:form>
    </c:if>
    <br>
</div>
</body>
</html>