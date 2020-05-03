<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/charge/payInfo/queryOrderNumPage'>
	<thead>
		<tr>
			<th field="id" width="80px" hidden="true" noSearch="true">ID</th>
			<th field="orderNum" width="120px" sortable="true" defaultSearch="true">订单编号</th>
			<th field="orderDt" width="100px" sortable="true" mark="DATE">订单日期</th>
			<th field="ouNum" width="120px" sortable="true">消费者编码</th>
			<th field="name" width="100px" sortable="true">消费者</th>
		</tr>
	</thead>
</table>