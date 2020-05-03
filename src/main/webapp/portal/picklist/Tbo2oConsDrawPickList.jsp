<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/campaign/queryByConsDrawPage'>
	<thead>
		<tr>
			<th field="amtPerConsumer" defaultSearch="true" width="15%">每人限领数量</th>
			<th field="code" width="15%">编码</th>
			<th field="drawType" width="15%" lov="TB_O2O_COUPON_DRAW_TYPE">领取方式</th>
			<th field="faceValue" width="15%">面额</th>
			<th field="name" width="15%">优惠券名称</th>
			<th field="restriction" width="20%" lov="TB_O2O_COUPON_USE_CONSTRAIN">使用限制</th>
		</tr>
	</thead>
</table>