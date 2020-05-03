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
		       		<td width="120" class="td-label"><label>活动名称：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="activityName" name="activityName" size="25" class="easyui-validatebox td-input" data-options="required:true, validType:'length[1,10]'" placeholder="不超过10个字"/>
		       		</td>
		       		<td width="120" class="td-label"><label>优惠方式：&nbsp;</label></td>
		       		<td>
						<label><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Bargain_Price" checked="checked"/>&nbsp;特价&nbsp;&nbsp;&nbsp;</label>
						<label><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Discount"/>&nbsp;打折&nbsp;&nbsp;&nbsp;</label>
						<label><input class="brandDiscountType" type="radio" name="brandDiscountType" value="BOFO"/>&nbsp;买赠&nbsp;&nbsp;&nbsp;</label>
					</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>开始时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="startTime" name="startTime" size="25" class="easyui-datetimebox td-input" required="required" data-options="editable:false"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>结束时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="endTime" name="endTime" size="25" class="easyui-datetimebox td-input" required="required" data-options="editable:false"/>
		       		</td>
		       	</tr>
		       	<tr>
					<%--是否同享满减--%>
					<td width="120" class="td-label"><label>是否同享满减：&nbsp;&nbsp;&nbsp;</label></td>
					<td>
						<label><input class="if_Cash_Deduction" type="radio" name="ifCashDeduction" value="Y"/>&nbsp;是&nbsp;&nbsp;&nbsp;</label>
						<label><input class="if_Cash_Deduction" type="radio" name="ifCashDeduction" value="N"/>&nbsp;否&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td width="120" class="td-label"><label>活动备注：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="activityNotes" name="activityNotes" size="25" class="easyui-textbox td-input" data-options="multiline:true" style="height:50px"/>
		       		</td>
		       	</tr>
		    </table>
		    
		    <div>
			   	<center>
			   		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAndPush()">创建活动</a>
			   		&nbsp;&nbsp;&nbsp;
			   		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancel()">取消</a>
				</center>
			</div>
		</div>
	</div>
</div>
    

<script type="text/javascript">
	function saveAndPush(){
		var productCampaignUrl = '';
		var activityName = $('#activityName').val();
		var brandDiscountType = $('.brandDiscountType:checked').val();
		var startTime = $('#startTime').datetimebox('getValue');
		var endTime = $('#endTime').datetimebox('getValue');
		//
		var ifCashDeduction=$('.if_Cash_Deduction:checked').val();
		var activityNotes = $('#activityNotes').val();
		
		if(activityName == '' || activityName == null){
			$.messager.alert("错误", '活动名称不能为空', "error");
			return false;
		} else if(activityName.length > 10){
			$.messager.alert("错误", '活动名称不能超过10个字符', "error");
			return false;
		}
		
		if(brandDiscountType == '' || brandDiscountType == null){
			$.messager.alert("错误", '优惠方式不能为空', "error");
			return false;
		}
		//是否-判断
		if(ifCashDeduction == null){
		    $.messager.alert("错误","不能为空","error");
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
		
		$.messager.confirm("操作提示", '确认要创建活动？', function(data) {
			if(data){
				if(brandDiscountType == 'Bargain_Price'){
					productCampaignUrl = "${AppContext.ctxPath}/portal/brandShop/brandBargainPriceProductEdit.jsp";
				} else if(brandDiscountType == 'Discount'){
					productCampaignUrl = "${AppContext.ctxPath}/portal/brandShop/brandDiscountProductEdit.jsp";
				} else if( brandDiscountType == 'BOFO'){
					productCampaignUrl = "${AppContext.ctxPath}/portal/brandShop/brandBuyFreeProductEdit.jsp";
				}
				$.post("${AppContext.ctxPath}/action/portal/promotion/insert",{
					activityName      :  activityName,
					brandDiscountType :  brandDiscountType,
				 	startTime         :  startTime,
				 	endTime           :  endTime,
                    ifCashDeduction   :  ifCashDeduction,
				 	activityNotes     :  activityNotes,
				 	brandStatus       :  'GOING',
				 	status            :   'Active'
				},function(data){
						if(data.success){
							$.messager.alert("成功", "单品优惠活动:" + data.newRow.activityName + ",新建成功", "info");
							window.location.href = productCampaignUrl + "?headId=" + data.newRow.id + "&startTime=" + data.newRow.startTime + "&endTime=" + data.newRow.endTime;
						}else{
							$.messager.alert("错误", data.result, "error");
							return false;
						}
					});
			}
		});
	}
	
	function cancel(){
		window.history.back();
	}
</script>
</body>
</html>