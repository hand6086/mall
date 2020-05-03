<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<style type="text/css" >
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north'" title="" border="false" style="width:100%;height:100%;padding:0px;">
				
				<table id="listofvalue-table" fit="true">
					<thead>
						<tr>
							<th field="name" width="15%" editor="{type:'validatebox',options:{required:true}}">显示值</th>
							<th field="val" width="20%" editor="{type:'validatebox',options:{required:true}}">独立源代码</th>
							<th field="type" width="20%" editor="{type:'validatebox',options:{required:true}}" formatter="toUpperFormatter">类型</th>
							<th field="parentName" width="15%" editor="{type:'picklistbox',options:{title:'选择父值列表',
															initParam:parentInitPickParam,
															completeFun:parentPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ParentLovPickList.jsp'}}">父对象</th>
							<th field="langId" width="7%">语言</th>
							<th field="seq" width="6%" editor="{type:'numberbox',options:{
																				min:1,
																				required:true}}">排序</th>
							<th field="corpName" width="7%" hidden=true>公司账套</th>
							<th field="activeFlag" width="6%" editor="{type:'checkbox',options:{off:'N',on:'Y'}}">有效</th>
						</tr>
					</thead>
				</table>
		</div>
	</div>
	
	<script type="text/javascript">
	$datagrid = $('#listofvalue-table');
	getLovOfList("[CORP_ID]");
	var rex = /^\s+|\s+$/g; //匹配前后空格
	$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			newDefaultValue:true,
			oauthFlag:true,
			url:'${AppContext.ctxPath}/action/portal/basic/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_export" class="easyui-linkbutton" style="" iconCls="icon-page-white-excel" plain="true" onclick="$('+"'#listofvalue-table').datagrid('searchHelp')"+'">查询助手</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_export" class="easyui-linkbutton" style="" iconCls="icon-reload" plain="true" onclick="flushCache()">清除缓存</a>',that);

			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id      	: row.id,
							name    	: row.name.replace(rex,""),
							val     	: row.val.replace(rex,""),
							type    	: row.type.replace(rex,""),
							seq     	: row.seq,
							langId  	: row.langId,
							corpid  	: row.corpid,
							parentId	: row.parentId,
							activeFlag  : row.activeFlag
					}
					rows_2.push(row_2);
				}	
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/basic/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/basic/upsert',{
					row_status	: row.row_status,
					id      	: row.id,
					name    	: row.name.replace(rex,""),
					val     	: row.val.replace(rex,""),
					type    	: row.type.replace(rex,""),
					seq     	: row.seq,
					langId  	: row.langId,
					corpid  	: row.corpid,
					parentId	: row.parentId,
					activeFlag  : row.activeFlag
				},function(data){
					if (!data.success) {
						errFun(data.result,that);
					} else {
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/basic/deleteById', {
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
					corpName:appCtx.corpName,
					corpid:appCtx.corpId
				};
			}
	});
	
	function toUpperFormatter(value, rowData, rowIndex) {
		if (value != undefined && value != '') {
			return value.toUpperCase();
		} else {
			return "";
		}
	}
	
	/**
	 * 父对象picklist初始化参数方法
	 */
	function parentInitPickParam(){
		/* var row = $datagrid.datagrid('getSelected');
		if(row == null){
			window.parent.operationtip('您当前操作的行信息未找到！', 'error');
		}
		if(row.id == null){
			row.id = 'noMatchId';
		}
		var param = {id:row.id};
		return param; */
	}
	/**
	 * 父对象picklist回调方法
	 */
	function parentPicklistComplete(selectRow){
		var row = $datagrid.datagrid('getSelected');
		row.parentId = selectRow.id;
		return selectRow.name;
	}
	
	function enterpPicklistComplete(selectRow){
		var row = $datagrid.datagrid('getSelected');
		row.corpid = selectRow.code;
		return selectRow.name;
	}
	
	function flushCache(){
		$.post("${AppContext.ctxPath}/action/portal/basic/flushCache", {}, function(data){
			if(data.success){
				$.messager.alert("成功", "清除缓存成功", "info");
			}else{
				$.messager.alert("错误", data.result, "error");
			}
		});
	}
	</script>
</body>
</html>