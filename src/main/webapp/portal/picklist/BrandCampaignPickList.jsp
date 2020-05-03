<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/campaign/queryByExamplePage'>
	<thead>
		<tr>
			<th field="name" width="30%">承接页名称</th>
			<th field="code" width="30%" hidden="true">承接页编码</th>
			<th field="type" width="30%" lov="TB_O2O_SHEET_TYPE">承接页类型</th>
		</tr>
	</thead>
</table>