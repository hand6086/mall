<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/orgnization/parentPicklist'>
	<thead>
		<tr>
			<th field="orgCode" width="35%" sortable="true">组织编码</th>
			<th field="text" width="30%" defaultSearch="true">组织名称</th>
			<th field="orgType" width="30%" lov="ORG_TYPE">组织类型</th>
		</tr>
	</thead>
</table>