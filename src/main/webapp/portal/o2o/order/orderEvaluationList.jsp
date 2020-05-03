<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<table id="orderEvaluation-table" height="100%">
		<thead>
			<tr>
				<th field="type" width="100px" lov='TB_O2O_EVALU_LBL_TYPE'>类型</th>
				<th field="tAttr02" width="100px" lov='TB_O2O_APPRAISE_RATE'>订单评级</th>
				<th field="context" width="400px">具体评价内容</th>
				<th field="isPositive" width="100px" lov='S_IF'>是否正面评价</th>
			</tr>
		</thead>
	</table>		
 <script type="text/javascript">
	 $datagrid = $('#orderEvaluation-table');
	 $datagrid.hdatagrid({
			updateable:true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/order/platformOrder/queryOrderEvaluation?orderId=${param.orderId}',
	 });
 </script>
</body>
</html>