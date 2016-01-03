<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="pull-left" href="<c:url value="/"/>">
                <img src="<c:url value="/resources/images/logo.png"/>" style="max-height: 30px;  margin-top: 10px; margin-right: 5px;"/>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav">
                <li <c:if test="${param.active == 'main'}">class="active"</c:if> >
                    <a href="<c:url value="/"/>">
                        Main
                    </a>
                </li>
                <li <c:if test="${param.active == 'news'}">class="active"</c:if>>
                    <a href="<c:url value="/news"/>">
                        News
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>