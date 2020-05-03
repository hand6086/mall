<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable" url='${AppContext.ctxPath}/action/portal/product/queryByExamplePage'>
	<thead>
		<tr>
			<th field="prodCode" width="100px" align="center" sortable="true">产品编码</th>
			<th field="prodName" width="100px" align="center" defaultSearch="true">产品名称</th>
			<th field="factoryPrice" currency="CNY" width="100px" align="center">出厂价</th>
			<th field="price" width="100px" currency="CNY" align="center">销售价</th>
			<th field="promoPrice" width="100px" currency="CNY" align="center">促销价</th>
			<th field="prodModelName" width="150px" align="center">产品型号</th>
			<th field="prodUnit" width="100px" lov="PROD_UNIT" align="center">单位</th>
			<th field="prodMatSeries" lov="PROD_MAT_SERIES" width="100px">产品系列</th>
			<th field="isEffective" width="50px" lov="S_IF" align="center" sortable="true">是否有效</th>
			<th field="comments" width="100px" align="center">产品描述</th>
		</tr>
	</thead>
</table>