<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable"
	url='${AppContext.ctxPath}/action/portal/agrDetail/queryByExamplePage'>
	<thead>
		<tr>
		    <th field="check" checkbox="true"></th>
		    <th field="prodName" width="100px" editor="{type:'textbox'}" readonly="true">产品名称或分类</th>
			<th field="totalPrice" width="120px" currency="CNY" editor="{type:'numberbox'}" readonly="true">总售价</th>
			<th field="estiMcost" width="120px" currency="CNY" editor="{type:'numberbox'}" readonly="true">预估材料成本</th>
			<th field="estiLcost" width="120px" currency="CNY" editor="{type:'numberbox'}" readonly="true">预估人工成本</th>
			<th field="estiMprofit" width="120px" currency="CNY" editor="{type:'numberbox'}" readonly="true">预估边际利润</th>
			<th field="comments" width="200px" editor="{type:'textbox'}" readonly="true">备注</th>
		</tr>
	</thead>
</table>