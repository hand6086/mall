<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/order/shoppingCart/queryCustomerPage'>
	<thead>
		<tr>
			<th field="ouNum" width="120px" sortable="true" defaultSearch="true">消费者编码</th>
			<th field="customerName" width="100px" sortable="true">姓名</th>
			<th field="mainPhNum" width="100px" sortable="true">手机号</th>

			<th field="id" width="100px" hidden="true" noSearch="true">id</th>
			<th field="customerId" width="100px" hidden="true" noSearch="true">customerId</th>
		</tr>
	</thead>
</table>