<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<div id="menu_layout" class="easyui-layout" data-options="fit:true" border="false">
	 <div data-options="region:'north',split:true" fit="true" border="false">
		<div data-options="region:'north'" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<table id="menu-table" fit="true" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
					  <th data-options="field:'text',width:'25%'" editor="{type:'textbox',options:{required:true}}">菜单名</th>
					  <th data-options="field:'menuType',width:'25%'" editor="{type:'textbox',options:{required:true}}">菜单编码</th>
					  <th data-options="field:'menuIcon',width:'25%'" editor="{type:'textbox',options:{required:true}}">菜单图标</th>
				      <th data-options="field:'sortNumber',width:'10%'" editor="{type:'numberbox',options:{
				      																				min:0,
																									precision:2,
				      																				required:true}}">排序</th>
			           <th data-options="field:'defaultFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">默认职责</th>
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'center'" border="false" style="width:100%;height: 450px;">
			<table id="menuItem-table" fit="true" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
					  <th data-options="field:'text',width:'150px'" editor="{type:'textbox',options:{required:true}}">菜单名</th>
				      <th data-options="field:'menuUrl',width:'300px'" editor="{type:'textbox',options:{required:true}}">菜单Url</th>
				      <th data-options="field:'readonlyFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">只读</th>
				      <th data-options="field:'addFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可新建</th>
				      <th data-options="field:'editFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可修改</th>
				      <th data-options="field:'deleteFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可删除</th>
				      <th data-options="field:'exportFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可导出</th>
				      <th data-options="field:'universalInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">通用版</th>
				      <th data-options="field:'fmcgInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">快消行业版</th>
				      <th data-options="field:'highTechInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">制造/高科技版</th>
				      <th data-options="field:'homeInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">家居行业版</th>
				      <th data-options="field:'finInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">金融行业版</th>
				      <th data-options="field:'retailInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">零售行业版</th>
				      <th data-options="field:'autoInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">汽车行业版</th>
				      <th data-options="field:'comments',width:'200px'" editor="{type:'textbox'}">说明</th>
				      <th data-options="field:'sortNumber',width:'80px'" editor="{type:'textbox',options:{required:true}}">排序号码</th>
				      <th data-options="field:'defaultFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">默认职责</th>
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'south'" border="false" style="width:100%;height: 450px;">
			<table id="menuSub-Item-table" fit="true" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
					  <th data-options="field:'text',width:'150px'" editor="{type:'textbox',options:{required:true}}">菜单名</th>
				      <!-- <th data-options="field:'menuUrl',width:'300px'" editor="{type:'textbox'}">菜单Url</th> -->
				      <th data-options="field:'readonlyFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">只读</th>
				      <th data-options="field:'addFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可新建</th>
				      <th data-options="field:'editFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可修改</th>
				      <th data-options="field:'deleteFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可删除</th>
				      <th data-options="field:'exportFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可导出</th>
				      <th data-options="field:'oauthType',width:'15%'" lov="MENU_OAUTH" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('MENU_OAUTH'),
																		editable:false,
																		required:true}}">安全性</th>
				      <!-- <th data-options="field:'oauthSql',width:'200px'" editor="{type:'textbox'}">其他安全性逻辑</th> -->
				      <th data-options="field:'comments',width:'200px'" editor="{type:'textbox'}">说明</th>
				      <th data-options="field:'sortNumber',width:'80px'" editor="{type:'numberbox',options:{
				      																				min:0,
																									precision:2,
				      																				required:true}}">排序号码</th>
					</tr>
				</thead>
			</table>
		</div>
		</div>
	</div>
	<script type="text/javascript">
	$('#menu_layout').layout();
	$datagrid = $('#menu-table');
	$dataitemgrid = $('#menuItem-table');
	$subdataitemgrid = $('#menuSub-Item-table');

	
	$subdataitemgrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		buttonCopy:true,
		title:'安全性菜单列表',
		pageSize: 10, 
		url:"${AppContext.ctxPath}/action/portal/menu/subItemList",
	    pageList: [5,10,15],
	    
	    parentGridId : 'menuItem-table',
	    parentGridField : 'id',
	    linkGridField : 'parentMenuId',
	    
	    buttonBatchEdit : true,
	    onInitNewData:function(that){
	    	var headRow = $dataitemgrid.datagrid('getSelected');
			return {
				addFlag : 'Y',
				editFlag : 'Y',
				deleteFlag : 'Y',
				exportFlag : 'Y',
			};
		},
		
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var headRow = $dataitemgrid.datagrid('getSelected');
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id        :row.id,
						text      :row.text,
						menuUrl   :row.menuUrl,
						comments  :row.comments,
						oauthType	  :row.oauthType,
						oauthSql  :row.oauthSql,
						sortNumber:row.sortNumber,
						menuType	:headRow.menuType,
						readonlyFlag : row.readonlyFlag,
						addFlag : row.addFlag,
						editFlag : row.editFlag,
						deleteFlag : row.deleteFlag,
						exportFlag : row.exportFlag,
						platformType:'CRM',
				}
				rows_2.push(row_2);
			}	
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/menu/batchUpdate",
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
		
	    onInsertAction:function(row,successFun,errFun,that){
	    	var headRow = $dataitemgrid.datagrid('getSelected');
	    	$.post('${AppContext.ctxPath}/action/portal/menu/insert', {
	    		text		:row.text,
				menuUrl		:row.menuUrl,
				comments	:row.comments,
				sortNumber	:row.sortNumber,
				oauthType		:row.oauthType,
				oauthSql	:row.oauthSql,
				menuType	:headRow.menuType,
				parentMenuId:headRow.id,
				menuGrade:'2',
				readonlyFlag : row.readonlyFlag,
				addFlag : row.addFlag,
				editFlag : row.editFlag,
				deleteFlag : row.deleteFlag,
				exportFlag : row.exportFlag,
				platformType:'CRM',
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
	    },
	    onUpdateAction:function(row,successFun,errFun,that) {
	    	var headRow = $dataitemgrid.datagrid('getSelected');
	    	
	    	
	    	$.post('${AppContext.ctxPath}/action/portal/menu/update', {
	    		id        :row.id,
				text      :row.text,
				menuUrl   :row.menuUrl,
				comments  :row.comments,
				oauthType	  :row.oauthType,
				oauthSql  :row.oauthSql,
				sortNumber:row.sortNumber,
				menuType	:headRow.menuType,
				readonlyFlag : row.readonlyFlag,
				addFlag : row.addFlag,
				editFlag : row.editFlag,
				deleteFlag : row.deleteFlag,
				exportFlag : row.exportFlag,
				platformType:'CRM',
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
					$.post('${AppContext.ctxPath}/action/portal/menu/deleteById', {
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
	
	$dataitemgrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		buttonCopy:true,
		title:'菜单行列表',
		url:"${AppContext.ctxPath}/action/portal/menu/items",
		pageSize: 10, 
	    pageList: [5,10,15],
	    
	    parentGridId : 'menu-table',
	    parentGridField : 'menuType',
	    linkGridField : 'menuType',
	    subGridIds: ['menuSub-Item-table'],
	    buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id        		: row.id,
						text      		: row.text,
						menuUrl   		: row.menuUrl,
						comments  		: row.comments,
						menuType  		: row.menuType,
						sortNumber		: row.sortNumber,
						readonlyFlag 	: row.readonlyFlag,
						addFlag 		: row.addFlag,
						editFlag 		: row.editFlag,
						deleteFlag 		: row.deleteFlag,
						exportFlag 		: row.exportFlag,
						platformType	: 'CRM',
						universalInd	: row.universalInd,
						fmcgInd			: row.fmcgInd,
						highTechInd		: row.highTechInd,
						homeInd			: row.homeInd,
						finInd			: row.finInd,
						retailInd		: row.retailInd,
						autoInd			: row.autoInd,
				}
				rows_2.push(row_2);
			}	
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/menu/batchUpdate",
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
		
		
	    onInsertAction:function(row,successFun,errFun,that){
	    	var headRow = $datagrid.datagrid('getSelected');
	    	$.post('${AppContext.ctxPath}/action/portal/menu/insert', {
	    		text			: row.text,
				menuUrl			: row.menuUrl,
				comments		: row.comments,
				sortNumber		: row.sortNumber,
				menuType		: headRow.menuType,
				parentMenuId	: headRow.id,
				menuGrade		: '1',
				readonlyFlag 	: row.readonlyFlag,
				addFlag 		: row.addFlag,
				editFlag 		: row.editFlag,
				deleteFlag 		: row.deleteFlag,
				exportFlag 		: row.exportFlag,
				platformType	: 'CRM',
				universalInd	: row.universalInd,
				fmcgInd			: row.fmcgInd,
				highTechInd		: row.highTechInd,
				homeInd			: row.homeInd,
				finInd			: row.finInd,
				retailInd		: row.retailInd,
				autoInd			: row.autoInd,
				defaultFlag:row.defaultFlag,
				
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
	    },
	    onUpdateAction:function(row,successFun,errFun,that) {
	    	$.post('${AppContext.ctxPath}/action/portal/menu/update', {
	    		id        		: row.id,
				text      		: row.text,
				menuUrl   		: row.menuUrl,
				comments  		: row.comments,
				menuType  		: row.menuType,
				sortNumber		: row.sortNumber,
				readonlyFlag 	: row.readonlyFlag,
				addFlag 		: row.addFlag,
				editFlag 		: row.editFlag,
				deleteFlag 		: row.deleteFlag,
				exportFlag 		: row.exportFlag,
				platformType	: 'CRM',
				universalInd	: row.universalInd,
				fmcgInd			: row.fmcgInd,
				highTechInd		: row.highTechInd,
				homeInd			: row.homeInd,
				finInd			: row.finInd,
				retailInd		: row.retailInd,
				autoInd			: row.autoInd,
				defaultFlag:row.defaultFlag,
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
					$.post('${AppContext.ctxPath}/action/portal/menu/deleteById', {
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
		onChangeSelectedItem:function(row){
			//$subdataitemgrid.hdatagrid("changeParentItemAndParams",{parentMenuId:row.id,menuGrade:'2'});
			$subdataitemgrid.hdatagrid("changeParentItemAndParams",{menuGrade:'2'});
		},
	});
	
	$datagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		buttonCopy:true,
		buttonExport:true,
		buttonImport:true,
		pageSize: 15, 
	    pageList: [15,30,50], 
		url:'${AppContext.ctxPath}/action/portal/menu/queryFstLevel',
		
		subGridIds: ['menuItem-table'],
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id         :row.id,
						text       :row.text,
						menuUrl    :row.menuUrl,
						comments   :row.comments,
						menuType   :row.menuType,
						menuIcon   :row.menuIcon,
						sortNumber :row.sortNumber,
						platformType:'CRM',
						
				}
				rows_2.push(row_2);
			}	
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/menu/batchUpdate",
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
		onInsertAction:function(row,successFun,errFun,that){
			$.post('${AppContext.ctxPath}/action/portal/menu/addBefore', {
				menuType : row.menuType
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
					$datagrid.hdatagrid('beginEdit', 0);
				}else{
					$.post('${AppContext.ctxPath}/action/portal/menu/insert', 
					{
						text      :row.text,
						sortNumber:row.sortNumber,
						menuType  :row.menuType,
						menuIcon  :row.menuIcon,
					defaultFlag   :row.defaultFlag,
						menuGrade :'0',
						menuUrl   :'/',
						platformType:'CRM',
						
				    },
					function(data){
				    	if (!data.success) {
							errFun(data.result,that);
						}else{
							successFun(that, data);
						}
					});
				}
			});
		},
		onUpdateAction:function(row,successFun,errFun,that) {

				$.post('${AppContext.ctxPath}/action/portal/menu/update', {
					id         :row.id,
					text       :row.text,
					menuUrl    :row.menuUrl,
					comments   :row.comments,
					menuType   :row.menuType,
					menuIcon   :row.menuIcon,
					sortNumber :row.sortNumber,
					defaultFlag   :row.defaultFlag,
					platformType:'CRM',
				}, function(data) {
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
					$.post('${AppContext.ctxPath}/action/portal/menu/deleteById', {
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
		onChangeSelectedItem:function(row){
			//$dataitemgrid.hdatagrid("changeParentItemAndParams",{menuType:row.menuType,menuGrade:'1'});
			$dataitemgrid.hdatagrid("changeParentItemAndParams",{menuGrade:'1'});
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(99,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="clearMenuCache()">清除缓存</a>',that);
		}
	});
	function clearMenuCache(){
		window.top.clearMenuCache();
	}
	
	</script>
</body>
</html>