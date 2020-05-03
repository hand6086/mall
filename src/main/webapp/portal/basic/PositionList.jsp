<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<style>
/* 效果CSS开始 */
.btn-bar{margin:0 auto;text-align:center;}
.btn-bar p{margin-top:20px;}
.btn-bar p .btn{width:50px;height:30px;cursor:pointer;font-family:simsun;font-size:14px;}
/* 效果CSS结束 */
</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'east',split:true" title="职位树" border="false" style="width:300px;height:100%;padding:0px;">
			<div class="easyui-panel" style="height:100%;padding:0px" border="false">
				<ul id="postn-tree"></ul>
			</div>
		</div>
		<div data-options="region:'center'" border="false" style="padding:0px;">
			<table id="postn-table" fit="true">
				<thead>
						<th field="text" width="15%" editor="{type:'validatebox',options:{required:true}}">职位名称</th>
						<th field="positionType" lov="POSTN_TYPE" width="10%" editor="{type:'combobox',
							options:{valueField:'val',
							textField:'name',
							data : getLovArray('POSTN_TYPE'),
							editable:false,
							required:true}}">职位类型</th>
						<th field="parentPositionName" width="15%"
							editor="{type:'picklistbox',options:{title:'选择父职位',initParam:initParentPostnPicklistParam,
							completeFun:parentPostnPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/ParentPostnPickList.jsp'}}">父职位</th>							
						<th field="parentPositionId" width="15%" hidden="true" noSearch="true">父职位ID</th>
						<th field="deptName" width="15%"
							editor="{type:'picklistbox',options:{title:'选择部门',
																completeFun:deptOfPostnPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/DeptOfPostnPickList.jsp'}}">部门</th>
						<th field="deptId" width="15%" hidden="true" noSearch="true">部门ID</th>
						<th field="orgName" width="15%" >组织</th>
						<th field="fstName" width="15%" editor="{
							type:'mvgPickbox',
							options:{
								title:'主要负责人',completeFun:userMvgPickComplete,
								mvgMapperName:'user',
								tableId:'postn-table',
								optionsLeft:{
									tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/UserLeftMvgPick.jsp',
									initParam:userMvgPickParam
								},
								optionsRight:{
									tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/UserRightMvgPick.jsp'
								}
							}
						}" >主要负责人</th>
						<th field="userId" hidden="true" noSearch="true">主要负责人ID</th>
						<!-- <th field="isEffective" width="8%" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否有效</th> -->
						<th field="isEffective" lov="IS_EFFECTIVE" width="8%"
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
							<th field="corpName" width="120px" editor="{type:'textbox',options:{editable:false}}">公司账套</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="showgrah"></div>
	<script type="text/javascript">
		
		$datagrid = $('#postn-table');
		$datatree = $('#postn-tree');
		treeInit();
		getLovOfList("[POSTN_TYPE,IS_EFFECTIVE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			oauthFlag:true,
			striped:true,
			border:false,
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/position/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			     : row.id,
							parentPositionId : row.parentPositionId,
							text 		     : row.text,
							positionType 	 : row.positionType,
							deptId 	         : row.deptId,
							isEffective      : row.isEffective,
							userId			 : row.userId
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/position/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/position/upsert', {
					row_status   	 : row.row_status,
					id			     : row.id,
					parentPositionId : row.parentPositionId,
					text 		     : row.text,
					positionType 	 : row.positionType,
					deptId 	         : row.deptId,
					isEffective      : row.isEffective,
					userId			 : row.userId
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
						$.post('${AppContext.ctxPath}/action/portal/position/deleteWithChildById', {
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
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_run" class="easyui-linkbutton" iconCls="icon-network" plain="true" onclick="drawTreeGraph()">展现职位结构</a>',that);
		    },
		    
		  //初始化
			onInitNewData:function(that){
				return {
					corpName:appCtx.corpName
				};
			},
		});
		
		//初始化父组织Id--20160527
		function initParentPostnPicklistParam() {
			var rowId = $datagrid.hdatagrid('getCurrentRow').id;
			if (rowId == null || rowId == '') {
				return {
					id : 'noMatchId'
				};
			} else {
				return {
					id : rowId
				};
			}
		}
		//父职位picklist的添加--20160527
		function parentPostnPicklistComplete(selectRow) {
			/* $datagrid.hdatagrid('updateCurrentRow', {
				parentPositionId : selectRow.id
			}); */
			$datagrid.hdatagrid('getCurrentRow').parentPositionId = selectRow.id;
			return selectRow.text;
		}
		//部门picklist的添加--20160531
		function deptOfPostnPicklistComplete(selectRow) {
			/* $datagrid.hdatagrid('updateCurrentRow', {
				deptId : selectRow.id
			}); */
			$datagrid.hdatagrid('getCurrentRow').deptId = selectRow.id;
			return selectRow.text;
		}
		
		/**
		 * 职责mvgPick 按【确定】后执行的方法
		 */
		function userMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.userId = rightRowsMvg.id;
				currentRow.fstName = rightRowsMvg.firstName;
			}
			return currentRow.fstName;
		}
		/**
		 * 职责mvgPick 列表数据初始化参数
		 */
		function userMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
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
			    	$datagrid.hdatagrid("changeParentItemAndParams",{parentPositionId:parentId});
			    }
			});
			$.post('${AppContext.ctxPath}/action/portal/position/treelist',{}, function (data){
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
                href:'./dialog/showPosGraph.jsp', 
                queryParams: { id : row.id },
                resizable: true,  
                modal: true  
            });  */
			window.open("./dialog/showPosGraph.jsp?id="+row.id);
		}
	</script>
</body>
</html>