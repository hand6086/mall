<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable"
	url='${AppContext.ctxPath}/action/portal/agrDetail/queryByExamplePage'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="prodName" width="100px" editor="{type:'textbox'}" readonly="true">产品名称/型号</th>
			<th field="prodDesc" width="150px" editor="{type:'textbox'}" readonly="true">产品详细说明</th>
			<th field="spec" width="100px" editor="{type:'textbox'}" readonly="true">规格</th>
			<th field="buildNum" width="80px" editor="{type:'textbox'}" readonly="true">栋数个数</th>
			<th field="area" width="100px" editor="{type:'textbox'}" readonly="true">面积(平方米)</th>
			<th field="price" width="80px" currency="CNY" editor="{type:'textbox'}" readonly="true">单价</th>
			<th field="amount" width="80px" currency="CNY" editor="{type:'textbox'}" readonly="true">金额</th>
		</tr>
	</thead>
</table>