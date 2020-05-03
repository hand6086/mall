<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/goods/queryProdPicklist'>
	<thead>
		<tr>
			<th field="name" defaultSearch="true" width="30%">产品名称</th>
			<th field="part" width="30%">产品编码</th>
			<th field="type" width="20%" lov="PRODUCT_TYPE">类型</th>
			<th field="unitOfMeasure" width="20%">主单位</th>
		</tr>
	</thead>
</table>