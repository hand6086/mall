<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
.td-label {
	font-size: 12px;
	text-align: right;
	height: 30px;
}
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" border="false" style="width: 100%; height:70px; padding: 0px;">
		<fieldset class="x-fieldset">
			<legend class="x-fieldset-header" style="width: 70px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">筛选条件</span>
			</legend>
			<div class="row keyfilter-border">
				<ul data-toggle="keyfilter" data-title="状态" data-filter-filed="status"
					data-table-Id="postn-imp-table">
					<li data-value="NEW">新建</li>
					<li data-value="CHECK_SUCCESS">校验成功</li>
					<li data-value="CHECK_FAIL">校验失败</li>
					<li data-value="IMP_FAIL">导入失败</li>
				</ul>
			</div>
		</fieldset>
	</div>
	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
		<table id="postn-imp-table">
			<thead>
				<tr>
					<th field="text" width="100px" editor="{type:'validatebox',options:{required:true}}">职位名称</th>
					<!-- <th field="positionType" lov="POSTN_TYPE" width="10%" editor="{type:'combobox',
						options:{valueField:'val',
						textField:'name',
						data : getLovArray('POSTN_TYPE'),
						editable:false,
						required:true}}">职位类型</th> -->
					<th field="positionType" width="120px" editor="{type:'validatebox',options:{required:true}}">职位类型</th>
					<th field="parentPositionName" width="100px" editor="{type:'validatebox',options:{required:true}}">父职位</th>							
					<%-- <th field="deptName" width="200px"
						editor="{type:'picklistbox',options:{title:'选择部门',completeFun:deptOfPostnPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/DeptOfPostnPickList.jsp'}}">部门</th> --%>
					<th field="deptName" width="200px" editor="{type:'validatebox'}">部门</th>
					<th field="fstName" width="100px" editor="{type:'validatebox'}">主要负责人</th>
					<th field="status" lov="IMP_STATUS" width="100px">状态</th>
					<th field="errorMessage" width="500px" formatter="titleFormatter">错误信息</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
	$('.fixed-keyfilter-ul').keyFilter();
		$datagrid = $('#postn-imp-table');
		getLovOfList("[POSTN_TYPE,IMP_STATUS]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			buttonImport:true,
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
			oauthFlag:true,
			striped : true,
			border : false,
			width:'100%',
			height:'100%',
			url:'${AppContext.ctxPath}/action/portal/positionImp/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-folder-page" plain="true" onclick="check()">校验数据</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="postnImpInsert()">提交数据</a>',that);
			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			     : row.id,
							parentPositionName : row.parentPositionName,
							text 		     : row.text,
							positionType 	 : row.positionType,
							deptName 	     : row.deptName,
							fstName			 : row.fstName
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/positionImp/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/positionImp/upsert',{
					row_status   	 : row.row_status,
					id			     : row.id,
					parentPositionName : row.parentPositionName,
					text 		     : row.text,
					positionType 	 : row.positionType,
					deptName 	     : row.deptName,
					fstName			 : row.fstName
				}, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					status:'新建'
				};
			},	
			onDeleteAction:function(row,successFun,errFun,that) {
		    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
		    		if(data){
		    			$.post('${AppContext.ctxPath}/action/portal/positionImp/deleteById',{
		    				id : row.id
		    			},function(data){
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
		function titleFormatter(val,row){
		     if(val != null){
		        var content = '';
		        var content = val.replace(/\\n/g,'\n');
		        var val = val.replace(/\\n/g,'; ');
		     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
		     }
		}
		
		//部门picklist的添加
		function deptOfPostnPicklistComplete(selectRow) {
			return selectRow.text;
		}
		
		function check(){
			$.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/positionImp/check', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		function postnImpInsert(){
			$.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/positionImp/positionImpInsert', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}

	</script>
</body>
</html>