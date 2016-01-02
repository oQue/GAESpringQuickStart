<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
    <jsp:param name="active" value="news"/>
</jsp:include>

<div class="container">
    <c:choose>
        <c:when test="${!empty entries}">
            <c:forEach items="${entries}" var="entry">
                <h3><a href="<c:url value="/news/view/${entry.link}"/>" target="_blank">${entry.title}</a></h3>
                <div class="multiline-text">
                    <p>${entry.text}</p>
                </div>
                <br>
            </c:forEach>
            <!-- pagination block -->
            <nav>
                <c:if test="${pages > 1}">
                    <ul class="pagination">
                        <c:if test="${currentIndex != 1}">
                            <li>
                                <a href="<c:url value="/news/page/${currentIndex - 1}"/>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${pages}">
                            <c:url var="pageUrl" value="${i}"/>
                            <c:choose>
                                <c:when test="${i == currentIndex}">
                                    <li class="active"><a href="<c:url value="/news/page/${pageUrl}"/>"><c:out value="${i}"/></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="<c:url value="/news/page/${pageUrl}"/>"><c:out value="${i}"/></a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentIndex != pages}">
                            <li>
                                <a href="<c:url value="/news/page/${currentIndex + 1}"/>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </c:if>
            </nav>
        </c:when>
        <c:otherwise>
            <div class="page-header">
                <h1>
                    News
                </h1>
            </div>
            <p>No news found :(
        </c:otherwise>
    </c:choose>
    <p><a href="<c:url value="/news/add"/> ">Add news entry</a>*?</p>
    <p>* You have to be administrator of project in order to access this page.</p>
</div>
</body>
</html>