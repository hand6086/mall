<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">服务筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="service-status-keyfilter" data-toggle="keyfilter" 
			data-title="服务状态" data-filter-filed="status"
				data-table-Id="service-table">
			</ul>
		</div>
	</fieldset>
	
	<table id="service-table" fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" formatter="idFormatter">服务编号</th>
				<th field="abstracts" width="200px" editor="{type:'textbox',options:{required:true}}">概要</th>
				<th field="type" width="90px" lov="SERVICE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('SERVICE_TYPE'),
																		editable:false,
																		required:true}}">类型</th>													
				<th field="status" width="90px" lov="SERVICE_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('SERVICE_STATUS'),
																		editable:false,
																		required:true}}">状态</th>
				<th field="acctName" width="150px" editor="{type:'picklistbox',options:{title:'选择客户',
																					completeFun:accntPicklistComplete,
																					tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp',
																					required:true}}">客户</th>
				<th field="acctId" width="100px" hidden="true">客户ID</th>																	
				<th field="priorityLevel" width="60px" lov="SER_PRIORITY_LEVEL" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('SER_PRIORITY_LEVEL'),
																		editable:false,
																		required:true}}">优先级</th>
				<th field="severityLevel" width="60px" lov="SER_SEVERITY_LEVEL" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('SER_SEVERITY_LEVEL'),
																		editable:false,
																		required:true}}">严重性</th>
				<th field="posName" width="100px" editor="{type:'picklistbox',options:{title:'选择职位',
															completeFun:postnPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'}}">职位</th>
				<th field="posId" width="100px" hidden="true">职位ID</th>	
				<th field="orgName" width="100px" editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:orgPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
				<th field="orgId" width="100px" hidden="true">组织ID</th>												
				<th field="province" width="100px" editor="{type:'combobox',options:{
																		valueField:'addrName',
																		textField:'addrName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/provinceList',
																		editable:false,
																		onSelect:selectedProvince}}">省</th>
				<th field="city" width="100px" editor="{type:'combobox',options:{
																		valueField:'addrName',
																		textField:'addrName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/queryAddressListSelect',
																		onBeforeLoad:beforeSelectCity,
																		onSelect:selectedCity,
																		editable:false}}">市</th>
                <th field="district" width="100px" editor="{type:'combobox',options:{
																		valueField:'addrName',
																		textField:'addrName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/queryAddressListSelect',
																		onBeforeLoad:beforeSelectDistrict,
																		onSelect:selectedDistrict,
																		editable:false
																		}}">区/县</th>
				<th field="street" width="200px" editor="{type:'textbox'}">地址</th>
				<th field="comments" width="200px" editor="{type:'textbox',options:{required:true}}">备注</th>
				
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		getLovOfList("[SERVICE_TYPE,SERVICE_STATUS,SER_PRIORITY_LEVEL,SER_SEVERITY_LEVEL]");
		$datagrid = $('#service-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			oauthFlag:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/service/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			:row.id,
							acctId		:row.acctId,
							status		:row.status,
							type		:row.type,
							priorityLevel:row.priorityLevel,
							severityLevel:row.severityLevel,
							abstracts	:row.abstracts,
							street		:row.street,
							acctId		:row.acctId,
							dutyPersonId:row.dutyPersonId,
							posId		:row.posId,
							orgId		:row.orgId,
							country		:'中国',
							province	:row.province,
							city		:row.city,
							district	:row.district,
							comments	:row.comments
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/service/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},				
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				 $.post('${AppContext.ctxPath}/action/portal/service/upsert', {
					row_status  : row.row_status,
					id			:row.id,
					acctId		:row.acctId,
					status		:row.status,
					type		:row.type,
					priorityLevel:row.priorityLevel,
					severityLevel:row.severityLevel,
					abstracts	:row.abstracts,
					street		:row.street,
					acctId		:row.acctId,
					dutyPersonId:row.dutyPersonId,
					posId		:row.posId,
					orgId		:row.orgId,
					country		:'中国',
					province	:row.province,
					city		:row.city,
					district	:row.district,
					comments	:row.comments
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				}); 
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/service/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});		 
			},
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(91,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-css-go" plain="true" onclick="goodConfirm()">提交</a>',that);
			},
			onInitCopyData:function(that){
				//return {submit:'N'};
			},
			onInitNewData:function(that){
				return {
					status : '未完成',
					priorityLevel : '中',
					severityLevel : '一般',
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					posId : appCtx.postnId,
					posName : appCtx.postnName
				};
			}
		});
		
	 	$('#service-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/SERVICE_STATUS'
	    });
		
		//选择省份
		function selectedProvince(selectRow){
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.addrName;
			$datagrid.hdatagrid('getCurrentRow').city = '';
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').provinceId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').cityId = '';
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('setValue','');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
		}
		
		//初始化选择城市
		function beforeSelectCity(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			
			if(province == null || province == ''){
				param.parentAddrName='noMatchId';
			}else{
				param.parentAddrName=province;
			}
		}
		//选择城市
		function selectedCity(selectRow){
			$datagrid.hdatagrid('getCurrentRow').city = selectRow.addrName;
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
		}
		//初始化选择区/县
		function beforeSelectDistrict(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			var city = $datagrid.hdatagrid('getCurrentRow').city;
			if(province == null || province == ''){
				param.parentAddr2Name='noMatchId';
			}else{
				param.parentAddr2Name=province;
			}
			if(city == null || city == ''){
				param.parentAddrName='noMatchId';
			}else{
				param.parentAddrName=city;
			}
		}
		//选择区/县 
		function selectedDistrict(selectRow){
			$datagrid.hdatagrid('getCurrentRow').districtId = selectRow.id;
		}
		//pickList
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').acctId = selectRow.id;
			return selectRow.acctName;
		}
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').posId = selectRow.id;
			return selectRow.text;
		}
		
		function idFormatter(val,row){
			return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/serviceRequest/serviceRequestDetail.jsp?serviceId=" + row.id +"\")'>" + row.id + "</a>";
		}	
	</script>
</body>
</html>