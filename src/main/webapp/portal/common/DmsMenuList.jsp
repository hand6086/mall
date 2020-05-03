<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<div id="menu_layout" class="easyui-layout" data-options="fit:true" border="false">
		<table id="menu-table" fit="true">
			<thead>
				<tr>
				  <th data-options="field:'text',width:'20%'" editor="{type:'textbox',options:{required:true}}">菜单名</th>
				  <th data-options="field:'menuIcon',width:'15%'" editor="{type:'textbox',options:{required:true}}">菜单图标</th>
				  <th data-options="field:'menuUrl',width:'25%'" editor="{type:'textbox',options:{required:true}}">菜单Url</th>
				  <th data-options="field:'universalInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">通用版</th>
			      <th data-options="field:'fmcgInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">快消行业版</th>
			      <th data-options="field:'highTechInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">制造/高科技版</th>
			      <th data-options="field:'homeInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">家居行业版</th>
			      <th data-options="field:'finInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">金融行业版</th>
			      <th data-options="field:'retailInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">零售行业版</th>
			      <th data-options="field:'autoInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">汽车行业版</th>
			      <th data-options="field:'sortNumber',width:'10%'" editor="{type:'numberbox',options:{
				      																				min:0,
																									precision:2,
				      																				required:true}}">排序</th>
			      <th data-options="field:'comments',width:'25%'" editor="{type:'textbox'}">说明</th>
			      <!-- <th data-options="field:'addFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}"></th> -->
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
	$('#menu_layout').layout();
	$menuDatagrid = $('#menu-table');

	$menuDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		buttonCopy:true,
		url:"${AppContext.ctxPath}/action/portal/menu/queryByExamplePage",
		onBeforeLoad:function(param){
			param.filtersRaw = '[{"id":"platformType","property":"platformType","value":"DMS"}]';
		},
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id        : row.id,
						text      : row.text,
						menuUrl   : row.menuUrl,
						comments  : row.comments,
						menuIcon  : row.menuIcon,
						sortNumber: row.sortNumber,
						menuGrade : row.menuGrade,
						platformType:row.platformType,
						universalInd	: row.universalInd,
						fmcgInd			: row.fmcgInd,
						highTechInd		: row.highTechInd,
						homeInd			: row.homeInd,
						finInd			: row.finInd,
						retailInd		: row.retailInd,
						autoInd			: row.autoInd
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
		onInsertOrUpdateAction:function(row,successFun,errFun,that){
	    	$.post('${AppContext.ctxPath}/action/portal/menu/upsert', {
	    		row_status: row.row_status,
	    		id        : row.id,
				text      : row.text,
				menuUrl   : row.menuUrl,
				comments  : row.comments,
				menuIcon  : row.menuIcon,
				sortNumber: row.sortNumber,
				menuGrade : row.menuGrade,
				platformType:row.platformType,
				universalInd	: row.universalInd,
				fmcgInd			: row.fmcgInd,
				highTechInd		: row.highTechInd,
				homeInd			: row.homeInd,
				finInd			: row.finInd,
				retailInd		: row.retailInd,
				autoInd			: row.autoInd
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
	    onInitNewData:function(that){
			return {
				platformType:'DMS',
				menuGrade:'1'
			};
		},
	
	});
	
	</script>
</body>
</html>