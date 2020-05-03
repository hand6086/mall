正在跳转到登录页，请稍后...
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<%
		String ctxPath = request.getContextPath();
	%>
<script language='javascript'>
	window.top.document.location = '<%=ctxPath%>/login.jsp';
</script>
<body>
</html>
