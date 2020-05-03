<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>
<style type="text/css">
#typeTable{
	border-collapse:separate; border-spacing:10px;/*表table的tr间距 */
	width:1000px;
	margin: 20px auto;
}
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
}
.td-input{
	width:180px;
	height:20px;
}
#form {
	width: 1000px;
	margin: 30px auto;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;" title="">
		<div id="p1" class="easyui-panel" title="" border="false" style="width:'$(window).width() - 18';padding:0px;">
			<table id="typeTable">
		       	<tr>
		       		<td width="120" class="td-label"><label>活动名称：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="activityName" name="activityName" size="25" class="easyui-validatebox td-input" data-options="required:true" />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>订单门槛：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="minOrdAmount" name="minOrdAmount" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,precision:0"/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td style="font-size:14px;font-weight:200;height:30px;" colspan="2" align="center">
						<label style="width: 8%;display:inline-block; text-align:right "><input class="brandDiscountType" type="radio" checked="checked" name="brandDiscountType" value="Cash Deduction" onchange="$('#onCouponName').textbox('setValue','');$('#couponId').val('');$('.coupon').hide();$('#freeMerchName').textbox('setValue','');$('#freeMerchId').val('');$('.freeMerch').hide();$('.deduction').show();$('#enableCouponTr').show()"/>&nbsp;订单满减&nbsp;&nbsp;&nbsp;</label>
						<label style="width: 12%;display:inline-block;text-align:left "><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Dispatch Coupon" onchange="$('.coupon').show();$('.freeMerch').hide();$('#freeMerchName').textbox('setValue','');$('#freeMerchId').val('');$('#deducedCash').numberbox('setValue','');$('.deduction').hide();$('.searchbox').width(180);$('#enableCouponTr').hide();"/>&nbsp;订单满赠优惠券&nbsp;&nbsp;&nbsp;</label>
						<label style="width: 15%;display:inline-block; text-align:left "><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Reward for gifts" onchange="$('#onCouponName').textbox('setValue','');$('#couponId').val('');$('.coupon').hide();$('.freeMerch').show();$('#deducedCash').numberbox('setValue','');$('.deduction').hide();$('#enableCouponTr').hide();"/>&nbsp;订单满赠商品&nbsp;&nbsp;&nbsp;</label>
					</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>开始时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="startTime" name="startTime" size="25" class="easyui-datetimebox td-input" required="required" data-options="editable:false"/>
		       		</td>
		       	</tr>
		       	
		       	<tr>	
		       		<td width="120" class="td-label"><label>结束时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="endTime" name="endTime" size="25" class="easyui-datetimebox td-input" required="required" data-options="editable:false"/>
		       		</td>
		       	</tr>
		       	<tr class="coupon">
     				<td class="td-label"><label>优惠券&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
					<td class="td-input">
						<input class="easyui-validatebox" name="onCouponName" type="text" id="onCouponName" size="29" width="100px"/>
					</td>
					<td hidden="true">
						<input name="couponId" id="couponId" />
						<input name="releaseAmt" type="text" id="couponReleaseAmt" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
					</td>
				</tr>
				<tr class="freeMerch">	
     				<td class="td-label"><label>赠品&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
					<td class="td-input">
						<input name="freeMerchName" type="text" id="freeMerchName" size="29" />
					</td>
					
					<td hidden="true">
						<input name="freeMerchId" id="freeMerchId" />
					</td>
				</tr>	
				<tr class="freeMerch">	
     				<td class="td-label"><label>限赠总量&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
					<td class="td-input">
						<input name="releaseAmt" type="text" id="releaseAmt" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,precision:0"/>
					</td>
				</tr>	
				
				<tr class="deduction">
					<td width="120" class="td-label"><label>满减金额：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="deducedCash" name="deducedCash" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,precision:0"/>
		       		</td>
		       	</tr>
		       	<tr id="enableCouponTr">
		       		<td width="120" class="td-label">
		       			<label>是否可用优惠券：&nbsp;</label>
		       		</td>
		       		<td style="font-size:14px;font-weight:200;height:30px;"  >
						<label style="width: 8%;display:inline-block; text-align:right ">
							<input  type="radio"  class="noCouponUse" checked="checked" name="noCouponUse" value="Y" />&nbsp;是&nbsp;&nbsp;&nbsp;
						</label>
						<label style="width: 12%;display:inline-block;text-align:left ">
							<input  type="radio" class="noCouponUse"  name="noCouponUse" value="N" />&nbsp;否&nbsp;&nbsp;&nbsp;
						</label>
					</td>
		       	</tr>
		       	
		       	<tr>
					<td width="120" class="td-label"><label>活动备注：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="activityNotes" name="activityNotes" size="25" class="easyui-textbox td-input" data-options="multiline:true" style="height:50px;width:180px"/>
		       		</td>
		       	</tr>
		    </table>
		    
		    <div style="position:relative; left:-20px;">
			   	<center>
			   		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAndPush()">发布</a>
			   		&nbsp;&nbsp;&nbsp;
			   		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="javascript:window.parent.closebrandShopPromotionWin()">取消</a>
				</center>
			</div>
		</div>
	</div>
</div>
    

<script type="text/javascript">

	$freeMerchNamePicklist = $('#freeMerchName');
	$onCouponNamePicklist = $('#onCouponName');
	
	function saveAndPush(){
		var activityName = $('#activityName').val();
		var brandDiscountType = $('.brandDiscountType:checked').val();
		var minOrdAmount = $('#minOrdAmount').val();
		var startTime = $('#startTime').datetimebox('getValue');
		var endTime = $('#endTime').datetimebox('getValue');
		
		var deducedCash = $('#deducedCash').val();
		var freeMerchName = $('#freeMerchName').val();
		var releaseAmt = $('#releaseAmt').val();
		var onCouponName = $('#onCouponName').val();
		var couponReleaseAmt = $('#couponReleaseAmt').val();
		var couponId = $('#couponId').val();
		var freeMerchId = $('#freeMerchId').val();
		
		var noCouponUse = $('.noCouponUse:checked').val();
		 
		var activityNotes = $('#activityNotes').val();
		
		if(activityName == '' || activityName == null){
			$.messager.alert("错误", '活动名称不能为空', "error");
			return false;
		}
		
		if(minOrdAmount == '' || minOrdAmount == null){
			$.messager.alert("错误", '订单门槛不能为空', "error");
			return false;
		}
		
		if(brandDiscountType == '' || brandDiscountType == null){
			$.messager.alert("错误", '优惠方式不能为空', "error");
			return false;
		} else if( brandDiscountType == 'Cash Deduction' ){
			if(deducedCash == '' || deducedCash == null){
				$.messager.alert("错误", '满减金额不能为空', "error");
				return false;
			} else if(parseInt(deducedCash) >= parseInt(minOrdAmount)){
				$.messager.alert("错误", '满减金额要小于订单门槛', "error");
				return false;
			}
		} else if( brandDiscountType == 'Reward for gifts' ){
			if(freeMerchId == '' || freeMerchId == null){
				$.messager.alert("错误", '满赠商品不能为空', "error");
				return false;
			} else if( releaseAmt == '' || releaseAmt == null ){
				$.messager.alert("错误", '满赠商品限赠总量不能为空', "error");
				return false;
			}
		} else if( brandDiscountType == 'Dispatch Coupon' ){
			if(couponId == '' || couponId == null){
				$.messager.alert("错误", '优惠券不能为空', "error");
				return false;
			} else if( couponReleaseAmt == '' || couponReleaseAmt == null ){
				$.messager.alert("错误", '满赠优惠券限赠总量不能为空', "error");
				return false;
			} else{
				releaseAmt = couponReleaseAmt;
			}
		}
		
		if(startTime == '' || startTime == null){
			$.messager.alert("错误", '有效开始时间不能为空', "error");
			return false;
		}
		if(endTime == '' || endTime == null){
			$.messager.alert("错误", '有效结束时间不能为空', "error");
			return false;
		}
		
		startTime1 = new Date( startTime.replace(/-/g,"/") );
		endTime1 = new Date( endTime.replace(/-/g,"/") );
		
		if(startTime1 > endTime1){
			$.messager.alert("错误", '有效开始时间不能晚于有效结束时间', "error");
			return false;
		}
		
		$.messager.confirm("操作提示", '创建之后不能修改,确认要创建活动？', function(data) {
			if(data){
				$.post("${AppContext.ctxPath}/action/portal/promotion/insert",{
					activityName      :  activityName,
					brandDiscountType :  brandDiscountType,
				 	minOrdAmount      :  minOrdAmount,
				 	startTime         :  startTime,
				 	endTime           :  endTime,
				 	activityNotes     :  activityNotes,
				 	brandStatus       :  'GOING',
				 	deducedCash       :  deducedCash,
				 	freeMerchId       :  freeMerchId,
				 	releaseAmt        :  releaseAmt,
				 	couponId          :  couponId,
				 	status            :   'Active',
				 	noCouponUse       :  noCouponUse
				},function(data){
						if(data.success){
							window.parent.closebrandShopPromotionWin();
						}else{
							$.messager.alert("错误", data.result, "error");
							return false;
						}
					});
			}
		});
	}
	
	function brandShopPromotionInit(refreshDatagrid){
	}
	
	$onCouponNamePicklist.picklist({
		title : '选择优惠券',
		tableUrl : '/portal/picklist/brandCouponPicklist.jsp',
		required : true,
		completeFun : function(selectRow) {
			$('#couponId').val(selectRow.id);
			$('#couponReleaseAmt').val(selectRow.releaseAmt);
			return selectRow.onCouponName;
		}
	});
	
	$freeMerchNamePicklist.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		required : true,
		completeFun : function(selectRow) {
			$('#freeMerchId').val(selectRow.id);
			return selectRow.o2oDisplayName;
		}
	});
	
	$(".freeMerch").hide();
	$(".deduction").show();
	$(".coupon").hide();
	
</script>
</body>
</html>