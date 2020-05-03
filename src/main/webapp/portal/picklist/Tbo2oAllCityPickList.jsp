<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/mesPush/queryByAllCityPage'>
	<thead>
		<tr>
			<th field="code" defaultSearch="true" width="40%">编码</th>
			<th field="isO2OArea" width="60%">是否平台区域</th>
			<th field="isO2ODistrict" width="40%">是否地配区域</th>
			<th field="name" width="60%">城市</th>
			<th field="parentName" width="40%">省/直辖市</th>
		</tr>
	</thead>
</table>