<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="goodsSeriesCity-table" width="98%" height="347px">
		<thead>
			<tr>
				<th field="cityName" width=20% editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
				<th field="cityNotes" width=76% editor="{type:'textbox'}">说明</th>
			</tr>
		</thead>
	</table>
	
	<table id="goodsSeries-table" width="98%" height="65%" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="code" width="100px" >系列编码</th>
					<th field="name" width="100px" editor="{type:'combobox',options:{
																		valueField:'name',
																		textField:'name',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/goodsSeries/queryByPkAll',
																		editable:false,
																		onSelect:selectedProd,}}">系列名称</th>
					<th field="fpDisplay" width="100px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否首页显示</th>
					<th field="displayOrder" width="200px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">显示顺序</th>
					<th field="status" width="400px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_STATUS'),
																		editable:false}}">状态</th>
					<th field="notes" width="180px" editor="{type:'textbox'}">备注</th>
			   </tr>
			</thead>
		</table>
		
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#goodsSeriesCity-table');
		$subdatagrid = $('#goodsSeries-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:false,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			subGridIds: ['goodsSeries-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goodsCity/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsCity/deleteById', {
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
			}, 
			
		});
		
		$subdatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			newDefaultValue:true,
			title:'商品系列',
			oauthFlag:true,
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/goodsSeriesCity/queryByExamplePage',
		    parentGridId : 'goodsSeriesCity-table',
		    parentGridField : 'cityId',
		    linkGridField : 'cityId',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
		    	row.cityId = $datagrid.datagrid('getSelected').cityId;
				$.post("${AppContext.ctxPath}/action/portal/goodsSeriesCity/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsSeriesCity/deleteById', {
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
			/*  
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
			},  
			*/

		});
		
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		//失效
		function Invalid(){
			var row = $subdatagrid.datagrid('getSelected');
			$subdatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
		}
		
		function selectedProd(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').o2oSeriesId = selectRow.id;
		}
	</script>
</body>
</html>