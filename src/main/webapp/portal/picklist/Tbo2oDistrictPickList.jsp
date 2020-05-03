<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/goodsCity/queryCityPicklist'>
	<thead>
		<tr>
			<th field="name" defaultSearch="true"width="30%">城市</th>
			<th field="code" width="30%">编码</th>
			<th field="parentName" width="40%">省</th>
		</tr>
	</thead>
</table>