<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
	   <fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">筛选条件</span>
			</legend>
			<div class="row keyfilter-border">
				<ul id="agrTypeKeyfilter" data-toggle="keyfilter"
					data-title="合同类型" data-filter-filed="agrType"
					data-table-Id="agreement-table">
				</ul>
			</div>
			<div class="row keyfilter-border">
				<ul id="agrStatusKeyfilter" data-toggle="keyfilter"
					data-title="状态" data-filter-filed="agrStatus"
					data-table-Id="agreement-table">
				</ul>
			</div>
		</fieldset>
		
		<table id="agreement-table" keyFilterDiv="keyFilter" fit="true">
			<thead>
				<tr>
					<th field="agrCode" width="120px" formatter="captionFormatter">审批编号</th>
					<th field="agrNumber" width="120px" editor="{type:'validatebox', options:{required:true}}">合同编号</th>
					<th field="agrType" width="120px" lov="AGR_TYPE" editor="{type:'combobox',options:{
																		valueField:'name',
																		textField:'name',
																		method:'get',
																		data:getLovArray('AGR_TYPE'),
																		editable:false}}">合同类型</th>
					<th field="prodProperties" width="120px" lov="AGR_PRODPRO" editor="{type:'combobox',options:{
																		valueField:'name',
																		textField:'name',
																		method:'get',
																		data:getLovArray('AGR_PRODPRO'),
																		editable:false}}">产品性质</th>
					<th field="agrStatus" width="80px" >状态</th>
					<th field="agrVersion" width="120px" editor="{type:'validatebox'}">合同版本</th>
					<th field="optyName" width="120px" editor="{type:'picklistbox',options:{title:'选择商机',
																completeFun:optyPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp'
																}}">商机名称</th>
					<th field="optyAddr" width="120px" >商机地址</th>
					<th field="acctName" width="120px" editor="{type:'picklistbox',options:{title:'选择客户',
																completeFun:acctPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp',
																required:true}}">客户名称</th>
					<th field="orgName" width="120px" editor="{type:'picklistbox',options:{title:'选择所属区域',
																completeFun:orgPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'
																}}">所属区域</th>
					<th field="fstName" width="120px" editor="{type:'picklistbox',options:{title:'选择所属区域',
																completeFun:postnPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/PostnJoinByEmpPickList.jsp',
																required:true}}">业务员姓名</th>
					<th field="empTel" width="120px" >业务员电话</th>
					<th field="agrAbstract" width="120px" formatter="tooltipFormatter" editor="{type:'validatebox'}">合同摘要</th>
				</tr>
			</thead>
		</table>
	</div>
   	
	<script type="text/javascript">
		getLovOfList("[AGR_BUSTYPE]");
		getLovOfList("[AGR_TYPE]");
		getLovOfList("[AGR_PRODPRO]");
		getLovOfList("[AGR_STATUS]");
		$datagrid = $('#agreement-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			oauthFlag:true,
			url:'${AppContext.ctxPath}/action/portal/agreement/queryIntlAgrListPage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(21,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addAgreement()">新建</a>',that);
				addButtonFun(41,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="agrSubmit()">提交</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_initiateForum" class="easyui-linkbutton" iconCls="icon-discussAdd" plain="true" onclick="initiateForum()">发起讨论</a>',that);
			},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/agreement/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
				$.post('${AppContext.ctxPath}/action/portal/agreement/upsert',row , function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/agreement/deleteById', {
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
			}
		});

		/** 提交合同审批表 */
		function agrSubmit(){
			if(true){
				$.messager.alert('提示',"功能待完善。");
				return;
			}
			var row = $datagrid.hdatagrid('getCurrentRow');
			$.post('${AppContext.ctxPath}/action/portal/agreement/submit', row, function(data){
				if(data.success){
					$datagrid.datagrid('reload');
				}else{
					$.messager.alert("警告",data.result);
				}
			});
		}
		
		$('#agrTypeKeyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/AGR_TYPE'
		});
		$('#agrStatusKeyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/AGR_STATUS'
		});
		function addAgreement(){
			gotoContentPage('${AppContext.ctxPath}/portal/agreement/IntlAgrEdit.jsp?id=noMatchId');
		}
		
		function captionFormatter(val,row){
		     if(val != null){
		     	return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/agreement/IntlAgrEdit.jsp?id=" + row.id +"\")'>" + val + "</a>";
		     }
		}
		
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}
		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.fstName;
		}
		function acctPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
			return selectRow.acctName;
		}
		function optyPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').optyId = selectRow.id;
			return selectRow.optyName;
		}
		function initiateForum(){
			var row = $datagrid.datagrid('getSelected');
			if(row==null){
				return;
			}
			if(row.length>1){
				$.messager.alert('提示','请选择一条信息发起讨论');
				return;
			}
			window.top.gotoNewForum(row.id,'agreement_intel',row.optyName);
		}
	</script>
</body>
</html>