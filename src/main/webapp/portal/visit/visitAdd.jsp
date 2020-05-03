<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',collapsible:false" title="拜访计划信息" border="false" style="width:100%;height:200px;padding-left:10px;padding-top:10px;">
			<div class="container-fluid">
				<form id="visitForm" method="post">
					<div class="row row-control">
						<div class="col-xs-3">
							<label class="input-label" >拜访编号：</label>
							<input class="easyui-textbox form-control" disabled="true" name="id"  id="id"/>
						</div>
						<div class="col-xs-3">
							<label class="input-label">拜访开始时间：</label>
							<input class="easyui-datebox form-control" name="beginTime" id="beginTime"/>
						</div>
						<div class="col-xs-3">
							<label class="input-label">拜访结束时间：</label>
							<input class="easyui-datebox form-control" name="endTime" id="endTime"/>
						</div>
					</div>
					<div class="row row-control">
						<div class="col-xs-3">
							<label class="input-label">状态：</label>
							<input class="easyui-combobox form-control" name="status"  id="status" value="未开始" disabled="disabled"/>
						</div>
						<div class="col-xs-3">
							<label class="input-label">计划描述：</label>
							<input class="easyui-textbox form-control" name="dec"  id="dec"/>
						</div>
					</div>
					</form>
					<div style="width:100%;height:30px;padding:0px;margin-top:30px;">
						<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
							plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="goBack()">返回</a>
				    </div>
			    </div>
			</div>
			<div data-options="region:'center',split:true,collapsible:false" border="false">
				<table id="visit-account-table" fit="true">
					<thead>
						<th field="acctName" width="200px" >客户名称</th>
						<th field="contact" width="300px" >地址</th>
						<th field="contactTel" width="200px" >联系方式</th>
					</thead>
				</table>
			</div>
	</div>
	
	<script type="text/javascript">
		var record = {};
		$datagrid = $('#visit-account-table');
		$.post("${AppContext.ctxPath}/action/portal/visitplan/preDefaultValue",function(data){
			if(data.success){
				record = data.result;
				$('#visitForm').form("load",record);
				$datagrid.hdatagrid("reload",{planNo:record.id});
			}else{
				$.messager.alert("警告",data.result);
			}
		});
		
		$datagrid.hdatagrid({
			title:"客户信息列表",
			toolbarShow:true,
			pagination:false,
			queryParams:{planNo:'noMatchId'},
			url:'${AppContext.ctxPath}/action/portal/visit/queryListSelectByPlanNo',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a id="selectAccountBtn" href="javascript:void(0)" class="easyui-linkbutton" onClick="selectAccountWindow()" iconCls="icon-add" plain="true">选择客户</a>',that);
			}
		});
		
		var saveAction = false;
		var selectAccountWindow = function(){
			if(saveAction == false){
				saveAction = true;
				saveForm();
				saveAction = false;
			}else{
				return;
			}
			$('#selectAccountBtn').multiSelect({
				title:'选择客户',
				completeFun:function(selectedRow){
					var visitRecords = [];
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						visitRecords.push({
							acctNo:selectedRow[i].id,
							planNo:record.id
						});
					}
					$.ajax({	
							type: "POST",
				            url: "${AppContext.ctxPath}/action/portal/visit/batchInsert",
				            data: JSON.stringify(visitRecords),
				            dataType: "json",	
				            contentType: 'application/json', 
				            success:function(data){
								if(data.success){
									$datagrid.hdatagrid("reload");
								}else{
									$.messager.alert("警告",data.result);
								}
							}
					});
				},
				initParam:function(){
					return {visitPlanId:record.id};
				},
				tableUrl:'${AppContext.ctxPath}/portal/visit/dialog/accntMultiSelect.jsp'
			});
		};
		
		var row_status = 'NEW';
		function saveForm(){
			$("#visitForm").form("submit",{
				url:"${AppContext.ctxPath}/action/portal/visitplan/upsert",
			    onSubmit: function(param){
			    	param.row_status = row_status;
			    	param.id = record.id;
			    },
			    onLoadSuccess:function(data){
			    	if(!data.success){
			    		$.messager.alert("警告",data.result);
			    		return;
			    	}
			    	selectAccountWindow();
			    }
			});
			row_status = 'UPDATE';
		}
		function goBack(){
			gotoContentPage('${AppContext.ctxPath}/portal/visit/visitList.jsp');
	    }
	</script>
</body>
</html>