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
		   <fieldset class="x-fieldset" id="clientUpdateKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="clientUpdate-forceUpdate-keyfilter" data-toggle="keyfilter"
						data-title="是否强制更新" data-filter-filed="forceUpdate" data-table-id="clientUpdate-table">
					</ul>
					<ul id="clientUpdate-deviceType-keyfilter" data-toggle="keyfilter"
						data-title="设备类型" data-filter-filed="deviceType" data-table-id="clientUpdate-table">
					</ul>
					<ul id="clientUpdate-appType-keyfilter" data-toggle="keyfilter"
						data-title="APP类型" data-filter-filed="tAttr01" data-table-id="clientUpdate-table">
					</ul>
				</div>
			</fieldset>
		 <table id="clientUpdate-table" singleSelect="true" rownumbers="true" keyFilterDiv="clientUpdateKeyFilter" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="deviceType" width="80px" lov="TB_O2O_OS_TYPE" editor="{type:'combobox',options:{valueField:'name',textField:'val',method:'get',
											data:getLovArray('TB_O2O_OS_TYPE'),editable:false,required:true}}">设备类型</th>
						<th field="tAttr01" width="100px" lov="TB_O2O_APP_TYPE" editor="{type:'combobox',options:{valueField:'name',textField:'val',method:'get',
											data:getLovArray('TB_O2O_APP_TYPE'),editable:false,required:true}}">APP类型</th>
						<th field="versionCode" width="70px" editor="{type:'text'}">版本号</th>
						<th field="versionName" width="80px" editor="{type:'text'}">版本名称</th>
						<th field="tAttr04" width="160px" editor="{type:'text'}">链接地址</th>
						<th field="newVerDescription" width="130px" editor="{type:'text'}">新版本描述</th>
						<th field="forceUpdate" width="80px" lov="S_IF" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('S_IF'),editable:false}}">是否强制更新</th>
						<th field="updateTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}">更新时间</th>
						
						<th field="id" width="60px" noSearch="true" hidden="true">id</th>
					</tr>
				</thead>
		  </table>
		</div>
	<script type="text/javascript">
		$datagrid = $('#clientUpdate-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			title:'',
			border:false,
			url : '${AppContext.ctxPath}/action/portal/params/clientUpdate/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/params/clientUpdate/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/params/clientUpdate/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},
		});
		
		   $('#clientUpdate-forceUpdate-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/S_IF'
		   });
		   $('#clientUpdate-deviceType-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				dataValue : 'name',
				dataName : 'val',
				remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_OS_TYPE'
		   });
		   $('#clientUpdate-appType-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				dataValue : 'name',
				dataName : 'val',
				remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_APP_TYPE'
		   });
	</script>
</body>
</html>