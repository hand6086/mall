<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" fit="true">
   			<fieldset class="x-fieldset" id="addressLabelKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="addressLabel-isvalid-keyfilter" data-toggle="keyfilter"
						data-title="是否有效" data-filter-filed="labelActive" data-table-id="addressLabel-table">
					</ul>
				</div>
			</fieldset>
			<table id="addressLabel-table" singleSelect="true" rownumbers="true" keyFilterDiv="addressLabelKeyFilter" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="id" width="140px">id</th>
						<th field="labelName" width="160px" editor="{type:'text'}">地址标签名称</th>
						<th field="labelActive" width="120px" lov="S_IF" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('S_IF'),editable:false}}">是否有效</th>
						<th field="labelComments" width="130px" editor="{type:'text'}">备注</th>
						
					</tr>
				</thead>
			</table>
		</div>
	<script type="text/javascript">
		$datagrid = $('#addressLabel-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			title:'',
			border:false,
			url : '${AppContext.ctxPath}/action/portal/params/addressLabel/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/params/addressLabel/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onAddMoreButton : function(that, addButtonFun) {
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setStatus(\'invalid\')" iconCls="icon-cancel" plain="true">失效</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setStatus(\'valid\')" iconCls="icon-ok" plain="true">生效</a>',that);
			}
		});
		
		function setStatus(param){
			var row = $datagrid.datagrid('getSelected');
			if(param == 'invalid'){
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,labelActive:'N'});
			} else if(param == 'valid'){
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,labelActive:'Y'});
			}
		};
		$('#addressLabel-isvalid-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/S_IF'
		});
	</script>
</body>
</html>