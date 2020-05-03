<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<table class="mvgPickTable">
	<thead>
		<tr>
			<th field="prodCode" width="100px">产品编码</th>
			<th field="prodName" width="120px">产品名称</th>
			<th field="prodUnit" lov="PROD_UNIT" width="100px">单位</th>
			<th field="currency" width="100px">货币</th>
			<th field="price" currency="CNY" width="100px">原价</th>
			<th field="promoPrice" currency="CNY" width="100px">促销价</th>
			<th field="prodModelName" width="120px">产品型号</th>
			<th field="prodGroup" lov="PROD_GROUP" width="120px">产品品牌</th>
			<th field="prodSeries" lov="PROD_MAT_SERIES" width="120px">产品系列</th>
			<th field="comments" width="200px">产品描述</th>
		</tr>
	</thead>
</table>