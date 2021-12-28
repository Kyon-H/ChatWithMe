<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>退出登录</title>
<script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<h1>退出登录中......</h1>
<script type="text/javascript">
	window.location.href="doLogout";
</script>
</body>
</html>