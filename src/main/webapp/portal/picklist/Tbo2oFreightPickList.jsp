<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/freight/queryByExamplePage'>
	<thead>
		<tr>
			<th field="cityName" width="80px">城市</th>
			<th field="name" width="80px">模板名称</th>
			<th field="firstFee" width="80px">基础费用</th>
			<th field="firstNumber" width="75px">基础件数</th>
			<th field="addFee" width="75px">累计费用</th>
			<th field="addNumber" width="80px">累计配件数</th>
			<th field="notes" width="80px">说明</th>
		</tr>
	</thead>
</table>