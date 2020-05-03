<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/account/queryAccountPickListPage'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true" hidden="true">账户id</th>
			<th field="cardNum"  width="150px"  >银行卡号</th>
			<th field="bank" width="200px" lov="TB_O2O_BANK" editor="{type:'combobox',options:{valueField:'val',
																					textField:'name',
																					data : getLovArray('TB_O2O_BANK'),
																					editable:true,
																					required:true}}">开户行</th>
			<th field="accntHolder" width="100px">开户人</th>
			<th field="merchantAccount" width="100px">提现账户</th>
		</tr>
	</thead>
</table>