<!doctype html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>
        GAE + Spring Demo. Add news page
    </title>

    <jsp:include page="templates/head.jsp"/>
</head>

<body>

<jsp:include page="templates/navbar.jsp">
    <jsp:param name="active" value="news"/>
</jsp:include>

<div class="container">
    <h1>Add news entry</h1>
    <form:form method="post" action="/news/add" commandName="entry" role="form">
        <div class="form-group">
            <form:label path="title">Title:</form:label>
            <form:input path="title" class="form-control" placeholder="News Title" required="true"/>
        </div>
        <div class="form-group">
            <form:label path="link">Link (/news/{link}):</form:label>
            <form:input path="link" class="form-control" placeholder="News link" required="true"/>
            <c:if test="${notUniqueLink != null}">
                <div class="alert alert-danger" role="alert">link is not unique. Try another</div>
            </c:if>
        </div>
        <div class="form-group">
            <form:label path="text">Content:</form:label>
            <form:textarea path="text" class="form-control" placeholder="News content with <b>any html tags</b> here"/>
        </div>
        <button type="submit" class="btn btn-default">Add</button>
    </form:form>
</div>
</body>
</html>