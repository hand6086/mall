<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/goodsPrice/queryMerchandisePage'>
	<thead>
		<tr>
			<th field="o2oDisplayName" defaultSearch="true" width="40%">商品名称</th>
			<th field="o2oIntCode" width="60%">商品编码</th>
			<th field="retailPrice" width="60%" hidden="true" noSearch="true">组合总价</th>
			<th field="suitProductFlg" width="60%" hidden="true" noSearch="true">是否套装商品</th>
			<th field="totalPrice" width="60%" hidden="true" noSearch="true">零售价</th>
		</tr>
	</thead>
</table>