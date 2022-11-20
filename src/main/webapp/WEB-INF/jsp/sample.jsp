<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
   @author aunabil.chakma
   @since 17/10/2022
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <c:forEach items="${qs}" var="item">
        <c:out value="${item}"/><br>
    </c:forEach>
</body>
</html>
