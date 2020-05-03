<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/order/platformOrder/queryCustomerNamePage'>
	<thead>
		<tr>
			<th field="accntId" width="80px" sortable="true" hidden="true" noSearch="true">accntId</th>
			<th field="o2oAcctType" width="80px" hidden="true" noSearch="true" lov="TB_O2O_STORE_TYPE">配送网点类型</th>
			<th field="name" width="130px" sortable="true">客户名称</th>
			<th field="ouNum" width="150px" sortable="true" >客户编码</th>
			<th field="o2oStoreType" width="80px" sortable="true">商户类型</th>
            <th field="o2oStatus" width="80px" sortable="true" lov="TB_O2O_STATUS">状态</th>
			<th field="o2oProvince" width="120px" sortable="true">省/直辖市</th>
			<th field="o2oCity" width="150px" sortable="true">城市</th>
			<th field="o2oDistrict" width="140px" sortable="true">区/县</th>
			<th field="o2oContact" width="120px" sortable="true">联系人</th>
			<th field="o2oContactPhone" width="100px" sortable="true">联系电话</th>
			<th field="o2oForcedStore" width="80px" sortable="true" lov="S_IF">是否兜底商户</th>
		</tr>
	</thead>
</table>