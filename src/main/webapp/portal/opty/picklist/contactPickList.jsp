<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/contacts/listByAcctId'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true">联系人编码</th>
			<th field="contactsName" width="80px">联系人姓名</th>
			<th field="position" width="10%">职位</th>
			<th field="acctName" width="120px;">客户名称</th>
			<th field="mobilePhone" width="10%">移动电话</th>
			<th field="fixedPhone" width="10%">固定电话</th>
			<th field="fax" width="10%" >传真</th>
			<th field="comments" width="15%" >备注</th>
			<th field="isEffective" width="10%">是否生效</th>
		</tr>
	</thead>
</table>