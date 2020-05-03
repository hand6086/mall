<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file = "/portal/header.jsp" %>

<title>职责</title>
</head>
<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="duty-table"  width="100%" height="50%" >
		<thead>
			<tr>
				<th field="id" width="80px" sortable="true" hidden="true">职责 ID</th>
				<th field="respName"  width="40%" defaultSearch="true"  editor="{type:'validatebox',options:{required:true}}">职责</th>
				<th field="comments" width="60%" editor="{type:'validatebox',options:{}}">备注</th>
			</tr>
		</thead>
	</table>
<!-- </div>
<div data-options="region:'center'" border="false" style="width:100%;height:50%;padding:0px;">
 -->		<table id="duty-menu-table" width="100%" height="50%" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="moduleName"  sortable="true">菜单名称</th>
					<th field="moduleType" width="100px">菜单类型</th>
					<th field="moduleCode" width="100px">菜单编码</th>
					<th field="activeFlag" width="100px" editor="{type:'checkbox', 
											options:{on:'Y', off:'N'}}">有效标记</th>
											
					<th data-options="field:'universalInd'" width="100px">通用版</th>
				      <th data-options="field:'fmcgInd'" width="100px">快消行业版</th>
				      <th data-options="field:'highTechInd'" width="100px">制造/高科技版</th>
				      <th data-options="field:'homeInd'" width="100px">家居行业版</th>
				      <th data-options="field:'finInd'" width="100px">金融行业版</th>
				      <th data-options="field:'retailInd'" width="100px">零售行业版</th>
				      <th data-options="field:'autoInd'" width="100px">汽车行业版</th>
					<th field="showInHome" width="100px" editor="{type:'checkbox', options:{on:'Y',off:'N' }}">是否显示在首页</th>
					<th field="orderNum" width="200px" editor="{type:'validatebox'}">序号</th>
					<th field="menuSecurity" lov="MENU_SECURITY" width="20%" editor="{type:'combobox',options:{valueField:'val',
						textField:'name',data:getLovArray('MENU_SECURITY'),editable:false,required:true}}">安全性</th>
					<th field="description" width="400px" >菜单描述</th>
					<th field="comments" width="400px" editor="{type:'validatebox'}">备注</th>
					
					
					
			   </tr>
			</thead>
		</table>
</div>
<script type="text/javascript">
	$datagrid = $('#duty-table');
	//$treegrid = $('#message-table');
	$menugrid= $('#duty-menu-table');
	
	$datagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		buttonCopy:true,
		//buttonExport:true,
		//buttonImport:true,
		striped:true,
		border:false,
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/appduty/queryByExamplePage',
		
		subGridIds: ['duty-menu-table'],
		
		onAddMoreButton:function(that,addButtonFun){
			
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/appduty/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
			$.post("${AppContext.ctxPath}/action/portal/appduty/upsert",row, 
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
					$.post('${AppContext.ctxPath}/action/portal/appduty/deleteById', {
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
			if(row.id){
				$menugrid.hdatagrid("changeParentItemAndParams",{dutyId:row.id});
			}else{
				$menugrid.hdatagrid("changeParentItemAndParams",{dutyId:'no_match_id'});
			}
				
			//refreshMsgToolBar();
		},
		onLoadSuccess:function(data){
			
			/* if( !$menugrid.hdatagrid("options").url){
				$menugrid.hdatagrid("options").url = "${AppContext.ctxPath}/action/portal/appDutyMenu/queryByExamplePage";
				
				 if(data.rows.length > 0){
					$datagrid.hdatagrid('selectRow', 0);
					var row = $datagrid.hdatagrid('getSelected');
					$menugrid.hdatagrid("changeParentItemAndParams",{dutyId:row.id});// 自扩展功能，参数会重新包装
				}
				else{
					$menugrid.hdatagrid("changeParentItemAndParams",{dutyId:'no_data_id'});
				} 
			} */
			//refreshMsgToolBar();
	    },
		onInitNewData : function(that){
			return {
				activeFlag : 'Y'
			};
		}
	});
	
$menugrid.hdatagrid({
	updateable:true,
	toolbarShow:true,
	buttonSearch:true,
	//buttonNew:true,
	buttonDelete:true,
	striped:true,
	title:'App菜单列表',
	border:false,
	pageSize: 10, 
    pageList: [5,10,15],
    url : "${AppContext.ctxPath}/action/portal/appDutyMenu/queryByExamplePage",
    
    parentGridId : 'duty-table',
    parentGridField : 'id',
    linkGridField : 'dutyId',
    
   	onDeleteAction: function(row, successFun, errFun, that){
   		$.messager.confirm("操作提示", "是否确定删除信息？", function(data){
   			if(data){
   				$.post("${AppContext.ctxPath}/action/portal/appDutyMenu/deleteById",{
   					id : row.id
   				}, function(data){
   					if(!data.success){
   						errFun(data.result, that);
   					}else{
   						successFun(that, data);
   					}
   				});//post
   			}
   		})
   		},
   		
   		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/appDutyMenu/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
			$.post("${AppContext.ctxPath}/action/portal/appDutyMenu/upsert",row, 
			function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		
   		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(89,'<a href="javascript:void(0)" id="btn-selectMenu" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectMenuWindow()">新建</a>',that);
		}
    });
    
function selectMenuWindow()
{
	var msgRecord = $datagrid.hdatagrid('getSelected');
	$('#btn-selectMenu').multiSelect({
		title:'添加菜单',
		initParam:function(){
			return {attr1 : msgRecord.id};
		},
		tableUrl:'${AppContext.ctxPath}/portal/appDuty/dialog/appMenuMultiSelect.jsp',
		completeFun:function(selectedRow){
			var dutyRow = $datagrid.hdatagrid('getSelected');
			var records = [];
			for(var i =0; selectedRow != null && i<selectedRow.length;i++){
				records.push({
					menuId:selectedRow[i].id,
					dutyId:dutyRow.id
				});
			}
			$.ajax({	
					type: "POST",
		            url: "${AppContext.ctxPath}/action/portal/appDutyMenu/batchInsert",
		            data: JSON.stringify(records),
		            dataType: "json",	
		            contentType: 'application/json', 
		            success:function(data){
						if(data.success){
							$menugrid.hdatagrid("reload");
						}else{
							$.messager.alert(data.result, "警告");
						}
					}
			});
		}
	});
}
</script>
</body>
</html>