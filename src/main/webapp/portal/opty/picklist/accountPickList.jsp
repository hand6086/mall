<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/accnt/queryByExamplePage'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true" hidden="true">客户ID</th>
			<th field="acctCode" width="80px" sortable="true">客户编码</th>
			<th field="acctName" width="230px" sortable="true">客户名称</th>
			<th field="contactName" width="80px"  sortable="true">联系人</th>
            <th field="mobilePhone" width="80px"  sortable="true">联系电话</th>
			<th field="acctType" width="80px" lov="ACCT_TYPE" sortable="true">客户分类</th>
			<th field="orgName" width="150px"  sortable="true">组织</th>
			<th field="province" width="80px"  sortable="true">省</th>
			<th field="city" width="80px"  sortable="true">市</th>
			<th field="district" width="80px"  sortable="true">区/县</th>
			<th field="acctStatus" width="80px" lov="ACCT_STATUS" sortable="true">客户状态</th>
		</tr>
	</thead>
</table>