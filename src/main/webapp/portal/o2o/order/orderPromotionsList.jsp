<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<table id="orderPromotions-table" height="100%">
		<thead>
			<tr>
				<th field="name" width="200px">活动名称</th>
				<th field="code" width="250px">活动编码</th>
				
				<th field="orderId" width="100px" noSearch="true" hidden="true">>orderId</th>
			</tr>
		</thead>
	</table>		
 <script type="text/javascript">
	 $datagrid = $('#orderPromotions-table');
	 $datagrid.hdatagrid({
			updateable:true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/order/platformOrder/queryOrderPromotions?orderId=${param.orderId}',
	 });	
 </script>
</body>
</html>