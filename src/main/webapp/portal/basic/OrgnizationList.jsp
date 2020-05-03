<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<body>
		<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'east',split:true" title="组织树" border="false" style="width:300px;height:100%;padding:0px;">
				<div class="easyui-panel" style="height:100%;padding:0px" border="false">
					<ul id="org-tree"></ul>
				</div>
			</div>
			
			<div data-options="region:'center'" border="false">
				<table id="org-table" fit="true">
				<thead>
					<tr>
						<th field="orgCode" width="20%" editor="{type:'validatebox',options:{required:true}}">组织编码</th>
						<th field="text" width="20%" defaultSearch="true" editor="{type:'validatebox',options:{required:true}}">名称</th>
						<th field="orgType" lov="ORG_TYPE" width="20%" editor="{type:'combobox',
														options:{valueField:'val',
														textField:'name',
														data : getLovArray('ORG_TYPE'),
														editable:false,
														required:true}}">组织类型</th>
						<th field="parentOrgName" width="20%"
							editor="{type:'picklistbox',options:{title:'选择父组织',initParam:initPickParentOrgParam,
																completeFun:completePickParentOrg,
																tableUrl:'${AppContext.ctxPath}/portal/basic/picklist/parentOrgPickList.jsp'}}">父组织</th>
						<th field="parentOrgId" width="20%" hidden="true" noSearch="true">父组织ID</th>
						<th field="isEffective" lov="IS_EFFECTIVE" width="10%" editor="{type:'combobox',
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
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- <div id="showgrah" class="easyui-dialog" style="width:40%;height:80%;padding:10px 20px"
		closed="true" maximizable="true" buttons="#msg-dlg-buttons">
		<div id="chart-container"></div>
	</div> -->
	<div id="showgrah"></div>
	<script type="text/javascript">
		var pickSelectedRow = undefined;
		var orgInsertFlag = false;
		var parentId = null; //记录当前的父组织的ID
		$datagrid = $('#org-table');
		$datatree = $('#org-tree');
		treeInit();
		getLovOfList("[ORG_TYPE,IS_EFFECTIVE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			oauthFlag:true,
		    url:'${AppContext.ctxPath}/action/portal/orgnization/queryByExamplePage',
		    onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_run" class="easyui-linkbutton" iconCls="icon-car" plain="true" onclick="run()">更新组织结构</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_drawTreeGraph" class="easyui-linkbutton" iconCls="icon-network" plain="true" onclick="drawTreeGraph()">展现组织结构</a>',that);
		    },
		    buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id           : row.id,
							orgCode      : row.orgCode,
							text         : row.text,
							parentOrgId  : row.parentOrgId,
							orgType      : row.orgType,
						    carShelfLife : row.carShelfLife,
						    isEffective  : row.isEffective
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/orgnization/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/orgnization/upsert',{
					row_status	 : row.row_status,
					id           : row.id,
					orgCode      : row.orgCode,
					text         : row.text,
					parentOrgId  : row.parentOrgId,
					orgType      : row.orgType,
				    carShelfLife : row.carShelfLife,
				    isEffective  : row.isEffective
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
		    			$.post('${AppContext.ctxPath}/action/portal/orgnization/deleteWithChildById',{
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
		
		function completePickParentOrg(selectRow){
			/* $datagrid.hdatagrid('updateCurrentRow', {
				parentOrgId : selectRow.id
			}); */
			$datagrid.hdatagrid('getCurrentRow').parentOrgId = selectRow.id;
			return selectRow.text;
		};
		//初始化父组织ID
		function initPickParentOrgParam(){
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
		
		function run(){
			$('#btn_run').linkbutton('disable');
			$.post('${AppContext.ctxPath}/action/portal/orgnization/run',{}, function (data){
			  if(data.success){
				  $('#btn_run').linkbutton('enable');
				  window.parent.operationtip('更新组织架构成功！', 'success');
			  }else{
				  $('#btn_run').linkbutton('enable');
				  window.parent.operationtip(data.result, 'error');
			  }
		    });
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
			    	$datagrid.hdatagrid("changeParentItemAndParams",{parentOrgId:parentId});
			    }
			});
			$.post('${AppContext.ctxPath}/action/portal/orgnization/treelist',{}, function (data){
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
                href:'./dialog/showOrgGraph.jsp', 
                queryParams: { id : row.id },
                resizable: true,  
                modal: true  
            }); */
			window.open("./dialog/showOrgGraph.jsp?id="+row.id);
		}
	</script>
</body>
</html>