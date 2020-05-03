<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="pickListTable" url='${AppContext.ctxPath}/action/portal/accnt/queryByExamplePage'>
	<thead>
		<tr>
			<th field="acctCode" width="150px">客户编码</th>
			<th field="acctName" width="150px">客户名称</th>
			<th field="acctType" lov="ACCT_TYPE" width="150px">客户类型</th>
			<th field="province" width="150px">省</th>
			<th field="city" width="150px">市</th>
			<th field="district" width="150px">区/县</th>
		</tr>
	</thead>
</table>