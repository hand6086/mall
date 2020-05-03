<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script>
<body style="margin:0 0 0 0">
	
	
	
	
	
	
	<script type="text/javascript">
		function exportExcel(){
			window.parent.document.location.href = '${AppContext.ctxPath}/action/portal/basic/export';
		}
	</script>
</body>
</html>