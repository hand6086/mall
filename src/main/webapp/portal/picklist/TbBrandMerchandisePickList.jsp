<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/goodsPrice/brandQueryMerchandisePage'>
	<thead>
		<tr>
			<th field="o2oDisplayName" defaultSearch="true" width="60%">商品名称</th>
			<th field="o2oIntCode" width="60%" hidden="true">商品编码</th>
			<th field="originalPrice" width="20%" noSearch="true">市场价</th>
			<th field="historyPrice" width="20%" noSearch="true">一口价</th>
		</tr>
	</thead>
</table>