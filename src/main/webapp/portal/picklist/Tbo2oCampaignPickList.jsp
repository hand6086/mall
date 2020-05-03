<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/campaign/queryByExamplePage'>
	<thead>
		<tr>
			<th field="name" width="20%">活动名称</th>
			<th field="cityName" defaultSearch="true" width="20%">城市</th>
			<th field="code" width="20%" hidden="true" noSearch = "true">编码</th>
			<th field="type" width="16%" lov="TB_O2O_SHEET_TYPE">类型</th>
			<th field="status" width="20%" lov="TB_O2O_STATUS">状态</th>
		</tr>
	</thead>
</table>