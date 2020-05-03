<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable" url='${AppContext.ctxPath}/action/portal/accnt/queryVisitAccountPage'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="id" width="80px">客户编码</th>
			<th field="acctName" width="230px">客户名称</th>
			<th field="contactName" width="80px">联系人</th>
            <th field="mobilePhone" width="80px">联系电话</th>
			<th field="acctType" lov="ACCT_TYPE" width="80px">客户分类</th>
			<th field="orgName" width="150px">组织</th>
			<th field="province" width="80px">省</th>
			<th field="city" width="80px">市</th>
			<th field="district" width="80px">区/县</th>
			<th field="acctStatus" lov="ACCT_STATUS" width="80px">客户状态</th>
		</tr>
	</thead>
</table>