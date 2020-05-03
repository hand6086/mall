<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/goodsPrice/queryAccountPage'>
	<thead>
		<tr>
			<th field="name" defaultSearch="true" width="10%">客户名称</th>
			<th field="csn" width="10%">客户编码</th>
			<th field="o2oStoreType" width="10%" lov="TB_O2O_STORE_TYPE">商户类型</th>
			<th field="o2oAccountStatus" width="10%" lov="TB_O2O_STATUS">状态</th>
			<th field="o2oProvince" width="10%">省/直辖市</th>
			<th field="o2oCity" width="10%">城市</th>
			<th field="o2oDistrict" width="10%">区/县</th>
			<th field="o2oContact" width="10%">联系人</th>
			<th field="o2oContactPhone" width="10%">联系电话</th>
			<th field="o2oForcedStore" width="10%" lov="TB_O2O_JUDGE_TYPE">是否兜底商户</th>
		</tr>
	</thead>
</table>