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
		       		<td width="120" class="td-label"><label>优惠券类型：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="couponType" name="couponType" size="25" class="easyui-combobox td-input" disabled value="${couponType}" required="required"
		       			    data-options="valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('CAMPAIGN_TYPE'),
											editable:false, "/>
		       		</td>
		       		<td width="120" class="td-label"><label>优惠券名称：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="couponName" name="couponName" size="25" class="easyui-validatebox td-input" data-options="required:true, validType:'length[1,15]'" placeholder="不超过15个字"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>面额：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="faceValue" name="faceValue" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,precision:0"/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>发放数量(不超过2万)：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="releaseAmt" name="releaseAmt" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,max:20000,precision:0" />
		       		</td>
		       		<td width="120" class="td-label"><label>每人限领数量：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="amtPerConsumer" name="amtPerConsumer" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,precision:0" />
		       		</td>
		       		<td width="120" class="td-label"><label>门槛：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="minOrdPrice" name="minOrdPrice" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0" required="required"/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>领取方式：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="drawType" name="drawType" size="25" class="easyui-combobox td-input" required="required"
		       			    data-options="valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_COUPON_DRAW_TYPE'),
											editable:false, "/>
		       		</td>
		       		<td width="120" class="td-label"><label>有效开始时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="startTime" name="startTime" size="25" class="easyui-datetimebox td-input" required="required" data-options="editable:false"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>有效结束时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="endTime" name="endTime" size="25" class="easyui-datetimebox td-input" required="required" data-options="editable:false"/>
		       		</td>
		       	</tr>
		    </table>
		    
		    <div>
			   	<center>
			   		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAndPush()">发布</a>
			   		&nbsp;&nbsp;&nbsp;
			   		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="javascript:window.parent.closeBrandShopCouponWin()">取消</a>
				</center>
			</div>
		</div>
	</div>
</div>
    

<script type="text/javascript">
	function saveAndPush(){
		var couponUrl = '';
		var couponType = $('#couponType').combobox('getValue');
		var drawType = $('#drawType').combobox('getValue');
		var couponName = $('#couponName').val();
		var faceValue = $('#faceValue').val();
		var releaseAmt = $('#releaseAmt').val();
		var amtPerConsumer = $('#amtPerConsumer').val();
		var minOrdPrice = $('#minOrdPrice').val();
		var startTime = $('#startTime').datetimebox('getValue');
		var endTime = $('#endTime').datetimebox('getValue');
		
		if(couponType == '' || couponType == null){
			$.messager.alert("错误", '优惠券类型不能为空', "error");
			return false;
		}
		if(couponName == '' || couponName == null){
			$.messager.alert("错误", '优惠券名称不能为空', "error");
			return false;
		} else if(couponName.length > 15){
			$.messager.alert("错误", '优惠券名称不能超过15个字符', "error");
			return false;
		}
		if(faceValue == '' || faceValue == null){
			$.messager.alert("错误", '面额不能为空', "error");
			return false;
		}
		if(releaseAmt == '' || releaseAmt == null){
			$.messager.alert("错误", '发放数量不能为空', "error");
			return false;
		}
		if(amtPerConsumer == '' || amtPerConsumer == null){
			$.messager.alert("错误", '每人限领数量不能为空', "error");
			return false;
		}
		if(minOrdPrice == '' || minOrdPrice == null){
			$.messager.alert("错误", '门槛不能为空', "error");
			return false;
		}
		if(drawType == '' || drawType == null){
			$.messager.alert("错误", '领取类型不能为空', "error");
			return false;
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
		$.messager.confirm("操作提示", '优惠券发布后，消费者可直接领取使用，是否确认发布？', function(data) {
			if(data){
				if(couponType == 'shop'){
				    couponUrl = "${AppContext.ctxPath}/portal/brandShop/brandShopCoupon.jsp";
				} else{
					couponUrl = "${AppContext.ctxPath}/portal/brandShop/brandAllCoupon.jsp";
				}
				$.post("${AppContext.ctxPath}/action/portal/coupon/insert",{
					couponType        :  couponType,
					couponName        :  couponName,
					faceValue         :  faceValue,
					releaseAmt        :  releaseAmt,
					amtPerConsumer    :  amtPerConsumer,
					drawType          :  drawType,
				 	minOrdPrice       :  minOrdPrice,
				 	startTime         :  startTime,
				 	endTime           :  endTime,
				 	type              :  'Coupon',
					couponStatus      :  'Active',
					receivedQuantity  :  '0',
					brandCouponStatus :  'Give out'
				},function(data){
						if(data.success){
							$.messager.alert("成功", "优惠券:" + data.newRow.couponName + ",新建成功", "info");
							window.location.href = couponUrl;
						}else{
							$.messager.alert("错误", data.result, "error");
							return false;
						}
					});
			}
		});
	}
	
</script>
</body>
</html>