<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'east',split:true" title="部门树" border="false" style="width:300px;height:100%;padding:0px;">
			<div class="easyui-panel" style="height:100%;padding:0px" border="false">
				<ul id="dept-tree"></ul>
			</div>
		</div>
		<div data-options="region:'center'" border="false" style="padding:0px;">
			<table id="dept-table" fit="true">
				<thead>
					<tr>
						<th field="deptCode" width="10%" editor="{type:'validatebox',options:{required:true}}">部门编码</th>
						<th field="text" width="20%" defaultSearch="true" editor="{type:'validatebox',options:{required:true}}">名称</th>
						<th field="parentDeptName" width="23%"
							editor="{type:'picklistbox',options:{title:'选择父部门',initParam:initParentDeptPicklistParam,
																completeFun:parentDeptPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/ParentDepartmentPickList.jsp'}}">父部门</th>
						<th field="parentDeptId" width="20%" hidden="true" noSearch="true">父部门ID</th>
						<th field="orgName" width="20%" editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:orgPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
						<th field="isEffective" lov="IS_EFFECTIVE" width="10%"
							editor="{type:'combobox',
							options:{valueField:'val',
							textField:'name',
							data : getLovArray('IS_EFFECTIVE'),
							onLoadSuccess:function(data){
								 var val = $(this).combobox('getData');
								 for (var i=0; i<val.length; i++) {
				                    if (val[i].name == '是') {
				                        $(this).combobox('select', val[i].name);
				                    }
				                }
	                    	},
							editable:false}}">是否有效</th>
						<th field="isOrg" width="70px">是否为组织</th>
						<th field="corpName" width="120px">公司账套</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="showgrah"></div>
	<script type="text/javascript">
		$datatree = $('#dept-tree');
		$datagrid = $('#dept-table');
		treeInit();
		getLovOfList("[IS_EFFECTIVE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			oauthFlag:true,
			url:'${AppContext.ctxPath}/action/portal/dept/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id          : row.id,
							parentDeptId : row.parentDeptId,
							orgId		: row.orgId,
							deptCode 	: row.deptCode,
							text 		: row.text,
							isOrg		: row.isOrg,
							deptType 	: row.deptType,
							isEffective : row.isEffective
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/dept/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/dept/upsert', {
					row_status  : row.row_status,
					id          : row.id,
					parentDeptId : row.parentDeptId,
					orgId		: row.orgId,
					deptCode 	: row.deptCode,
					text 		: row.text,
					isOrg		: row.isOrg,
					deptType 	: row.deptType,
					isEffective : row.isEffective
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
						$.post('${AppContext.ctxPath}/action/portal/dept/deleteWithChildById', {
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
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_run" class="easyui-linkbutton" iconCls="icon-network" plain="true" onclick="drawTreeGraph()">展现部门结构</a>',that);
		    },
			onInitNewData : function(that){
				return{
					corpName : appCtx.corpName,// 默认显示公司账套
				};
			}
		});	
		
		//初始化父部门Id--20160531
		function initParentDeptPicklistParam() {
			var row = $datagrid.hdatagrid('getCurrentRow');
			if (row.id == null || row.id == '') {
				return {
					id 		: 'noMatchId',
					attr1	: row.isOrg
				};
			} else {
				return {
					id 		: row.id,
					attr1	: row.isOrg
				};
			}
		}
		//父部门picklist的添加--20160531
		function parentDeptPicklistComplete(selectRow) {
			/* $datagrid.hdatagrid('updateCurrentRow', {
				parentDeptId : selectRow.id,
				orgId 		 : selectRow.orgId
			}); */
			$datagrid.hdatagrid('getCurrentRow').parentDeptId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.orgId;
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			//不支持多行编辑，先注释
			//$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'orgName'}).target).picklist('setValue',selectRow.orgName); 
			return selectRow.text;
		}
		function orgPicklistComplete(selectRow){
			/* $datagrid.hdatagrid('updateCurrentRow', {
				orgId 		 : selectRow.id
			}); */
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}
		//公司账套
		function enterpPicklistComplete(selectRow){
			var row = $datagrid.datagrid('getSelected');
			row.corpid = selectRow.code;
			return selectRow.name;
		}
		/* -------------------------------------------------------------------- */
		/**
		 * 初始化树形表格
		 */
		function treeInit(){
			/* 树形表格 */
			$datatree.tree({
			    onClick: function(node){
			    	var parentId = node.id;
			    	if(!parentId){
			    		parentId = 'noMatchId';
			    	}
			    	$datagrid.hdatagrid("changeParentItemAndParams",{parentDeptId:parentId});
			    }
			});
			$.post('${AppContext.ctxPath}/action/portal/dept/treelist',{}, function (data){
				  if(data.success){
					  var array = new Array();
					  array.push(data.list);
					  $datatree.tree('loadData', array);
				  }
			    });
		}
		
		function drawTreeGraph(){
			var row = $datagrid.datagrid('getSelected');
			/* $("#showgrah").dialog({  
                title:"组织信息",  
                cache:false,
                //closed:"false",
                width:600,
                height:500,
                //collapsible:true,
                maximizable:true,
                href:'./dialog/showGraph.jsp', 
                queryParams: { id : row.id },
                resizable: true,  
                modal: true  
            }); */ 
			window.open("./dialog/showGraph.jsp?id="+row.id);
		}
	</script>
</body>
</html>