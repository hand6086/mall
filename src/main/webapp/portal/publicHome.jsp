<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta charset="utf-8" />
<%
	
	Cookie cookie = new Cookie("LNK_USER_ID", user.getId());
   	cookie.setDomain(request.getContextPath());
   	cookie.setPath("/");
    response.addCookie(cookie);
%>

<html>
<script type="text/javascript">

</script>
</html>