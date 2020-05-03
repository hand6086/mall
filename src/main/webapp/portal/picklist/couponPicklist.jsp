<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/platformfavorable/querycouponpicklistPage'>
	<thead>
		<tr>
		    <th field="onCouponName" width="100px" >优惠券名称</th>
			<th field="onCouponCode" width="100px" >优惠券编码</th>
			<th field="faceValue"  width="150px"  >面额</th>
			<th field="amtPerConsumer"  width="150px">每人领取的数量</th>
			<th field="drawType"  width="150px" lov="TB_O2O_COUPON_DRAW_TYPE">领取方式</th>
			<th field="restriction"  width="150px"  >使用限制</th>
			
			
		</tr>
	</thead>
</table>
