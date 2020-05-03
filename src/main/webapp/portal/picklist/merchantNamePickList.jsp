<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/order/shoppingCart/queryMerchantPage'>
	<thead>
		<tr>
			<th field="o2oDisplayName" width="160px" sortable="true" defaultSearch="true">商品名称</th>
			<th field="o2oIntCode" width="160px" sortable="true">商品编码</th>

			<th field="id" width="100px" hidden="true" noSearch="true">id</th>
			<th field="merchId" width="100px" hidden="true" noSearch="true">merchId</th>
		</tr>
	</thead>
</table>