<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',collapsible:false,tools:[
							{
								iconCls:'icon-reload',
								text:' 刷新',
								handler:function(){serviceInfoInit()}
							},
							{
								iconCls:'icon-edit',
								text:'编辑',
								handler:function(){serviceHeadEnable()}
							},
							{
								iconCls:'icon-save',
								text:'保存',
								handler:function(){saveServiceInfo()}
							}]"title="服务请求基本信息" border="false" style="width: 90%; height: 200px; padding: 0px;">
		<form id="serviceForm" method="post">
			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">服务编号：</label> 
					<input class="easyui-textbox form-control" name="id" id="id" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">概要：</label> 
					<input class="easyui-textbox form-control" name="abstracts" id="abstracts" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">类型：</label> 
					<input class="easyui-combobox form-control" name="type" id="type" 
						   data-options="{ valueField:'val',
										   textField:'name',
										   data:getLovArray('SERVICE_TYPE'),
										   editable:false,
										   required:true}"/> 
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">状态：</label> 
					<input class="easyui-combobox form-control" name="status" id="status" 
							data-options="{ valueField:'name',
											textField:'name',
											data:getLovArray('SERVICE_STATUS'),
											editable:false,
											required:true}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">客户：</label> 
					<input class="easyui-picklistbox form-control" name="acctName" id="acctName" />
					<input hidden="true" name="acctId" id="acctId" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">优先级：</label>
					<input class="easyui-combobox form-control" name="priorityLevel" id="priorityLevel" 
							data-options="{ valueField:'val',
											textField:'name',
											data:getLovArray('SER_PRIORITY_LEVEL'),
											editable:false,
											required:true}"/>
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">严重性：</label>
					<input class="easyui-combobox form-control" name="severityLevel" id="severityLevel" 
							data-options="{ valueField:'val',
											textField:'name',
											data:getLovArray('SER_SEVERITY_LEVEL'),
											editable:false,
											required:true}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">职位：</label>
					<input class="easyui-picklistbox form-control" name="posName" id="posName" />
					<input hidden="true" name="posId" id="posId" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">组织：</label>
					<input class="easyui-picklistbox form-control" name="orgName" id="orgName" />
					<input hidden="true" name="orgId" id="orgId" />
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">省：</label> 
					<input class="easyui-combobox form-control" name="province" id="province" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">市：</label> 
					<input class="easyui-combobox form-control" name="city" id="city" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">区/县：</label>
					<input class="easyui-combobox form-control" name="district" id="district" />
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">地址：</label> 
					<input class="easyui-textbox form-control" name="street" id="street" />
				</div>
				<div class="col-xs-3">
					<label class="input-label">备注：</label> 
					<input class="easyui-textbox form-control" name="comments" id="comments" />
				</div>
			</div>
		</form>
	</div>
	
	<div data-options="region:'center',fit:true,split:true,collapsible:false" border="false" style="width: 100%;">
		<div data-options="fit:true" border="false">
			<table id="service-flowup-table"  style="height: 380px;width: 100%" pagination="false">
				<thead>
					<tr>
						<th field="dt" width="10%" mark="DATE" editor="{type:'datetimebox'}">跟进时间</th>
						<th field="description" width="20%" editor="{type:'textbox',options:{required:true}}">跟进内容</th>
						<th field="emp" width="20%">跟进人</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
  </div>
	<script type="text/javascript">
	var serviceId = null;
	serviceId = getUrlParams("serviceId");
	var serviceHeadIsEditing = true; //服务头信息是否为编辑状态 标志
	$flowUpDatagrid = $('#service-flowup-table');
	
	$flowUpDatagrid.hdatagrid({
		title : "服务跟进列表",
		toolbarShow:true,
		buttonSearch:true,
		toolbarShow:true,
		buttonNew:true,
		buttonCopy:true,
		pagination:true,
		url:'${AppContext.ctxPath}/action/portal/flowUp/queryByExamplePage',
		onBeforeLoad:function(param){
			param.serviceId = serviceId
		},
		onInsertAction:function(row,successFun,errFun,that){
			if(serviceId == null){
				$.messager.alert('警告','获取服务请求Id失败,请刷新页面重试！');
			}
			console.log('serviceId'+serviceId);
			$.post('${AppContext.ctxPath}/action/portal/flowUp/insert',{
				serviceId	:serviceId,
				dt			:row.dt,
				description	:row.description,				
				orgId : appCtx.orgId,
				postnId : appCtx.postnId,
				empId		:appCtx.userId
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		onInitNewData:function(that){
			var time = new Date(+new Date() + 8 * 3600 * 1000)
			.toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/,
					'');//获取当前日期与时间	
			return {
				dt : time,
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName,
				emp : appCtx.firstName
			};
		}
	});
	
	/*
	 *picklist控件显示
	 */
	$('#acctName').picklist({
		title:'选择客户',
		completeFun:function(selectRow){
			$('#acctId').val(selectRow.id)
			return selectRow.acctName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'
	});
	
	$('#orgName').picklist({
		title:'选择组织',
		completeFun:function(selectRow){
			$('#orgId').val(selectRow.id)
			return selectRow.text;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'
	});
	
	$('#posName').picklist({
		title:'选择职位',
		completeFun:function(selectRow){
			$('#posId').val(selectRow.id)
			return selectRow.text;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'
	});
	/*
	 *combobox控件显示
	 *省市区级联
	 */
	$('#province').combobox({
		url : '${AppContext.ctxPath}/action/portal/address/provinceList',
		valueField : 'id',
		textField : 'addrName',
		editable : false,
		cache : false,
		onSelect : function() {
			$('#city').combobox("setValue", '');
			$('#district').combobox("setValue", '');
			var province = $('#province').combobox('getValue');
			if (province != '') {
				loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/childList?id=" + province, $('#city'));
			}
		}
	});
	$('#city').combobox({
		editable : false,
		cache : false,
		valueField : 'id',
		textField : 'addrName',
		onSelect : function() {
			$('#district').combobox("setValue", '');
			var city = $('#city').combobox('getValue');
			if (city != '') {
				loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/childList?id=" + city, $('#district'));
			}
		}
	});
	$('#district').combobox({
		editable : false,
		cache : false,
		valueField : 'id',
		textField : 'addrName'
	});
	/**
	 * 异步加载级联地址数据
	 */
	function loadAddrPstAjax(url, nextObjCombobox){
		$.ajax({
			type : "POST",
			url : url,
			cache : false,
			dataType : "json",
			success : function(data) {
				if(nextObjCombobox != null){
					nextObjCombobox.combobox("loadData", data);
				}
			}
		});
	}
	
	$(document).ready(function() { 
		serviceInfoInit();
	}); 
	
	function serviceInfoInit(){
		//form表单数据
		$.post("${AppContext.ctxPath}/action/portal/service/queryById",{id:serviceId}, function(data) {
			if (data.success) {
				record = data.result;
				$('#serviceForm').form("load", record);
			} else {
				$.messager.alert("警告", data.result);
			}
		});
		//设置输入框默认为不可编辑
		serviceHeadDisable();
	}
	
	/**
	 * 保存更新服务请求的头信息
	 */
	function saveServiceInfo(){		
		if(serviceHeadIsEditing){
			$('#serviceForm').form("submit",{
				url : '${AppContext.ctxPath}/action/portal/service/update',
				success : function(data){
					var data = eval('(' + data + ')'); // change the JSON string to javascript object
					if (data.success) {
						serviceHeadDisable();
						window.parent.operationtip('保存成功！','info');
					} else {
						serviceHeadEnable();
						window.parent.operationtip(data.result,'error');
					}
				}
			});
		} 
	}
	/**
	 * 设置消息请求头信息的输入框为 编辑 状态
	 */
	function serviceHeadEnable(){
		if(!serviceHeadIsEditing){
			readonly="true" 
			$('#id').textbox('enable');
			$('#id').textbox('readonly');
			$('#abstracts').textbox('enable');		
			$('#type').combobox('enable');
			$('#status').combobox('enable');
			$('#acctName').picklist('enable');
			$('#priorityLevel').combobox('enable');
			$('#severityLevel').combobox('enable');
			$('#posName').picklist('enable');
			$('#orgName').picklist('enable');
			$('#province').combobox('enable');
			$('#city').combobox('enable');
			$('#district').combobox('enable');
			$('#street').textbox('enable');
			$('#comments').textbox('enable');
			serviceHeadIsEditing = true;
		}
	}
	/**
	 * 设置消息请求头信息的输入框为 不可编辑 状态
	 */
	function serviceHeadDisable(){
		if(serviceHeadIsEditing){
			$('#id').textbox('disable');
			$('#abstracts').textbox('disable');
			$('#type').combobox('disable');
			$('#status').combobox('disable');
			$('#acctName').picklist('disable');
			$('#priorityLevel').combobox('disable');
			$('#severityLevel').combobox('disable');
			$('#posName').picklist('disable');
			$('#orgName').picklist('disable');
			$('#province').combobox('disable');
			$('#city').combobox('disable');
			$('#district').combobox('disable');
			$('#street').textbox('disable');
			$('#comments').textbox('disable');
			serviceHeadIsEditing = false;
		}
	}
	
	</script>
</body>
</html>