<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/org/cometd.js"></script>
    <script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/jquery/jquery.cometd.js"></script>
    <script type="text/javascript" src="application.js"></script>
    <script type="text/javascript">
        var config = {
            contextPath: '${AppContext.ctxPath}'
        };
    </script>
<title>Insert title here</title>
</head>
<body>
	<div id="body"></div>
</body>
</html>