<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
/* 
//造成弹出table没有列标题
table {
	margin: 0 auto;
	border-collapse:collapse;
} */
.left{
	float: left;
	width: 360px;
}
.center{
	float: left;
	width: 90%;
	margin-left:10px;
	
	/* position:absolute; */
}
.right{
	float: left;
	width: 360px;
	margin-left:10px;
}

.form-table{
	margin: 5px auto; 
	width: 1200px;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
.table-block tr{
	height:40px;
}
.td-label {
	width:90px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" title="企业管理初始化" border="false" style="width:100%;height:100%;">
			<form id="accountForm" method="post"> 
				<table class="form-table">
					<tr>
						<td>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>编号 : &nbsp;</label></td>
					         		<td class="td-content">
					         			<input class="easyui-validatebox" id="code" name="code"  disabled/>
					         		</td>
								</tr>
								<tr>
									<td class="td-label"><label>名称 : &nbsp;</label></td>
					         		<td class="td-content">
					         			<input class="easyui-validatebox" id="name" name="name" disabled/>
					         		</td>
								</tr>
								<tr>
									<td class="td-label"><label>用户名 : &nbsp;</label></td>
			         				<td class="td-content">
			         					<input id="userName" name="userName" class="easyui-validatebox"  disabled/>
			         				</td>
								</tr>								
								<tr>
									<td class="td-label"><label>CRM职责 : &nbsp;</label></td>
			         				<td class="td-content">
			         					<input id="crmDutyId" type="hidden" name="crmDutyId"/>
			         					<input id="crmDutyName" name="crmDutyName" class="easyui-validatebox" disabled/>
			         				</td>
								</tr>
								<tr>
									<td class="td-label"><label>APP职责 : &nbsp;</label></td>
					         		<td class="td-content">
					         			<input id="appDutyId" type="hidden" name="appDutyId" />
					         			<input id="appDutyName" name="appDutyName" class="easyui-validatebox" disabled/>
					         		</td>
								</tr>
								<tr>
									<td class="td-label"><label>价格表 : &nbsp;</label></td>
									<td class="td-content">
										 <input id="defaultPrice" type="hidden" name="defaultPrice" />
					         			 <input id="priceListName" name="priceListName" class="easyui-validatebox" disabled/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table-block" >
								<tr>
									<td class="td-label"><label>管理人姓名: &nbsp;</label></td>
									<td class="td-content">
										<input class="easyui-validatebox" id="firstname" name="firstname" disabled/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>管理人手机号 : &nbsp;</label></td>
					         		<td class="td-content">
					         			<input class="easyui-validatebox" type="text" id="mobilePhone" name="mobilePhone"  disabled/>
					         		</td>
								</tr>
								<tr>
									<td class="td-label"><label>行业版 : &nbsp;</label></td>
					         		<td class="td-content">
					         			<input id="industryVersion" name="industryVersion" class="easyui-combobox" disabled/>
					         		</td>
								</tr>
								<tr>
									<td class="td-label"><label>自助申请 : &nbsp;</label></td>
					         		<td class="td-content">
					         			<input id="dealerApplySelf" name="dealerApplySelf" type="checkbox" class="easyui-checkbox"  disabled
					         				   data-options="on:'Y',
															 off:'N' "/>
					         		</td>
								</tr>
								<tr>
									<td class="td-label" rowspan="3"><label>说明 :</label></td>
									<td class="td-content" rowspan="3">
										<input id="comments" name="comments" class="easyui-textbox" data-options="multiline:true,required:false" 
											style="height: 90px;" disabled/>
									</td>
								</tr>							
								
							</table>
						</td>
						<td>
							<table class="table-block" >
							
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="id" id="id">
				<input type="hidden" name="acctAddressId" id="acctAddressId">
				<input type="hidden" name="contactId" id="contactId">
			</form>
		</div>
	</div>
	<!-- table end -->
	<div id="floor" style="position:fixed; bottom: 0; left: 0; width: 100%; height: 40px; background:#e8f1ff;">
		<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
		<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="cancel()">返回&nbsp;&nbsp;&nbsp;</a> 
			&nbsp;
			<!-- <a class="easyui-linkbutton" iconCls="icon-redo" onclick="initializeCompany()">企业初始化&nbsp;&nbsp;&nbsp;</a>  -->
		</div>
	</div>
	<script type="text/javascript">
	$form = $("#accountForm");
	$priceListPickList   = $('#priceListName');//价格表
	$priceListIdInput  	= $('#defaultPrice');
	$crmDutyNamePickList   = $('#crmDutyName');//crm职责
	$crmDutyIdInput  	= $('#crmDutyId');
	$appDutyNamePickList   = $('#appDutyName');//app职责
	$appDutyIdInput  	= $('#appDutyId');
	$industryVersionCombobox = $("#industryVersion");//行业版
	$industryVersionCombobox.combobox({ 
		method:'get',
		data:getLovArray('INDUSTRY_VERSION'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	//选择价格表
	$priceListPickList.picklist({
		title:'选择价格表',
		//required:true,
		oauthFlag:false,
		completeFun:function(selectRow){
			$priceListIdInput.val(selectRow.id);
			return selectRow.priceListName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/enterprise/picklist/priceListPickList.jsp'
	});
	
	$crmDutyNamePickList.picklist({
		title:'选择CRM职责',
		//required:true,
		oauthFlag:false,
		completeFun:function(selectRow){
			$crmDutyIdInput.val(selectRow.id);
			return selectRow.name;
		},
		tableUrl:'${AppContext.ctxPath}/portal/enterprise/picklist/crmDutyPickList.jsp'
	});
	
	$appDutyNamePickList.picklist({
		title:'选择APP职责',
		//required:true,
		oauthFlag:false,
		completeFun:function(selectRow){
			$appDutyIdInput.val(selectRow.id);
			return selectRow.respName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/enterprise/picklist/appDutyPickList.jsp'
	});
	function cancel(){
		window.parent.closeEnterpriseReadOnlyWin();
	}
	
	/**
	* 初始化/刷新数据，若id不为空，则重新查询；
	* 若对象不为空，则加载对象
	* @id 对象id
	* @order 对象
	*/
	function infoInit(id, enterprise){
		//若id不为空，则重新查询
		if(id){ 
			$.post("${AppContext.ctxPath}/action/portal/enterprise/queryById", {id:id}, function(data){
				if(data.success){
					$form.form("load", data.result);
				}else if(data.result){
					$.messager.alert("错误", data.result, "error");
				}else{
					$.messager.alert("错误", "加载数据失败", "error");
				}
			});
		}else if(enterprise){ //若对象不为空，则加载订单对象
			if(enterprise.dealerApplySelf == 'Y'){
				enterprise.dealerApplySelf = 'on';
			}else if(enterprise.dealerApplySelf == 'N'){
				enterprise.dealerApplySelf = 'off';
			}
			$form.form("load", enterprise);
		}else{
			$.messager.alert("错误", "参数无效", "error");
		}
	}
	</script>

</body>
</html>