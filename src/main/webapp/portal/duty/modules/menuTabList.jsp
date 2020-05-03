<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
			<table id="menu-table" title="菜单列表" height="385px">
				<thead>
					<tr>
						<th field="text" width="25%">菜单名称</th>
						<th field="parentMenuName" width="25%">父菜单名称</th>
						<th field="platformType" width="10%">所属系统</th>
						<th data-options="field:'dutyReadonlyFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">只读</th>
				      	<th data-options="field:'dutyAddFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可新建</th>
				      	<th data-options="field:'dutyEditFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可修改</th>
				      	<th data-options="field:'dutyDeleteFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可删除</th>
				      	<th data-options="field:'dutyExportFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可导出</th>
						<th field="comments" width="30%">说明</th>
					</tr>
				</thead>
			</table>
		
			<table id="sub-menuItem-table" height="385px" title="安全性菜单列表">
				<thead>
					<tr>
						<th field="text" width="30%">菜单名称</th>
						<th field="parentMenuName" width="30%">父菜单名称</th>
						<th data-options="field:'dutyReadonlyFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">只读</th>
				      	<th data-options="field:'dutyAddFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可新建</th>
				      	<th data-options="field:'dutyEditFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可修改</th>
				      	<th data-options="field:'dutyDeleteFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可删除</th>
				      	<th data-options="field:'dutyExportFlag'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">可导出</th>
						<th field="comments" width="30%">说明</th>
					</tr>
				</thead>
			</table>	
		
		<script type="text/javascript">
		
	$datamenuitemgrid = $('#menu-table');
		
		$subdatagrid = $('#sub-menuItem-table');
		
		$subdatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			pagination:true,
		    parentGridId : 'menu-table',
		    parentGridField : 'attr1',
		    linkGridField : 'parentMenuId',
			url:'${AppContext.ctxPath}/action/portal/duty/subMenuDutySelect',
		    pageSize: 10,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
		    buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				batchUpdateMenuOfDuty(rows, successFun, errFun, that);
			},	
		    onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="selectSubItemBtn" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectSubMenuItemWindow()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delSelectedSubMenu()">删除</a>',that);
			},
			onUpdateAction:function(row,successFun,errFun,that) {
		    	$.post('${AppContext.ctxPath}/action/portal/duty/updateMenuOfDuty', {
		    		id        :row.id,
		    		dutyReadonlyFlag : row.dutyReadonlyFlag,
		    		dutyAddFlag : row.dutyAddFlag,
		    		dutyEditFlag : row.dutyEditFlag,
		    		dutyDeleteFlag : row.dutyDeleteFlag,
		    		dutyExportFlag : row.dutyExportFlag,
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
		    },
		});
		
		$datamenuitemgrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:false,
		    parentGridId : 'duty-table',
		    parentGridField : 'id',
		    linkGridField : 'dutyId',
		    subGridIds: ['sub-menuItem-table'],
			url:'${AppContext.ctxPath}/action/portal/duty/dutyOfMenuList',
		    pageSize: 10,//每页显示的记录条数，默认为10 
		    pageList: [10,20,30],//可以设置每页记录条数的列表 
		    buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				batchUpdateMenuOfDuty(rows, successFun, errFun, that);
			},
			onChangeSelectedItem:function(row,that){
				var dutyRecord = $datagrid.hdatagrid('getSelected');
				if(dutyRecord != null){
					$subdatagrid.hdatagrid('changeParentItemAndParams',{dutyId:dutyRecord.id});
				}
			},
		    onAddMoreButton:function(that,addButtonFun){
		    	addButtonFun(91,'<a href="javascript:void(0)" id="selectMenuBtn" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectMenuItemWindow()">新建</a>',that);
		    	addButtonFun(92,'<a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delSelectedMenu()">删除</a>',that);
			},
			onUpdateAction:function(row,successFun,errFun,that) {
		    	$.post('${AppContext.ctxPath}/action/portal/duty/updateMenuOfDuty', {
		    		id        :row.id,
		    		dutyReadonlyFlag : row.dutyReadonlyFlag,
		    		dutyAddFlag : row.dutyAddFlag,
		    		dutyEditFlag : row.dutyEditFlag,
		    		dutyDeleteFlag : row.dutyDeleteFlag,
		    		dutyExportFlag : row.dutyExportFlag,
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
		    },
		});
		
		function selectMenuItemWindow()
		{
			var dutyRecord = $datagrid.hdatagrid('getSelected');
			$('#selectMenuBtn').multiSelect({
				title:'添加菜单项',
				initParam:function(){
					return {id:dutyRecord.id};
				},
				tableUrl:'${AppContext.ctxPath}/portal/duty/dialog/menuItemMultiSelect.jsp',
				completeFun:function(selectedRow){
					var dutyRow = $datagrid.hdatagrid('getSelected');
					var records = [];
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						records.push({
							rearObjId:selectedRow[i].id,
							preObjId:dutyRow.id
						});
					}
					$.ajax({	
							type: "POST",
				            url: "${AppContext.ctxPath}/action/portal/duty/addMenuOfDuty",
				            data: JSON.stringify(records),
				            dataType: "json",	
				            contentType: 'application/json', 
				            success:function(data){
								if(data.success){
									$datamenuitemgrid.hdatagrid("reload");
								}else{
									$.messager.alert("警告",data.result);
								}
							}
					});
				}
			});
		}
		
		function selectSubMenuItemWindow()
		{
			var dutyRecord = $datagrid.hdatagrid('getSelected');
			var menuItemRecord = $datamenuitemgrid.hdatagrid('getSelected');
			$('#selectSubItemBtn').multiSelect({
				title:'添加安全性菜单',
				initParam:function(){
					return {dutyId:dutyRecord.id,
							menuItemId:menuItemRecord.attr1};
				},
				tableUrl:'${AppContext.ctxPath}/portal/duty/dialog/subMenuItemMultiSelect.jsp',
				completeFun:function(selectedRow){
					var dutyRow = $datagrid.hdatagrid('getSelected');
					var records = [];
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						records.push({
							rearObjId:selectedRow[i].id,
							preObjId:dutyRow.id
						});
					}
					$.ajax({	
							type: "POST",
				            url: "${AppContext.ctxPath}/action/portal/duty/addMenuOfDuty",
				            data: JSON.stringify(records),
				            dataType: "json",	
				            contentType: 'application/json', 
				            success:function(data){
								if(data.success){
									$subdatagrid.hdatagrid("reload");
								}else{
									$.messager.alert("警告",data.result);
								}
							}
					});
				}
			});
		}
		
		function delSelectedMenu(){
			$.post('${AppContext.ctxPath}/action/portal/duty/delMenuOfDuty',{
				preObjId:$datagrid.datagrid('getSelected').id,
				rearObjId:$datamenuitemgrid.datagrid('getSelected').attr1
			},
			function(data){
				if(!data.success){
					$.messager.alert(data.result, 'error');
				}
				$datamenuitemgrid.datagrid('reload');
			});
		}
		
		function delSelectedSubMenu(){
			$.post('${AppContext.ctxPath}/action/portal/duty/delMenuOfDuty',{
				preObjId:$datagrid.datagrid('getSelected').id,
				rearObjId:$subdatagrid.datagrid('getSelected').attr1
			},
			function(data){
				if(!data.success){
					$.messager.alert("警告",data.result);
				}
				$subdatagrid.datagrid('reload');
			});
		}
		

		function batchUpdateMenuOfDuty(rows, successFun, errFun, that){
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id        :row.id,
			    		dutyReadonlyFlag : row.dutyReadonlyFlag,
			    		dutyAddFlag : row.dutyAddFlag,
			    		dutyEditFlag : row.dutyEditFlag,
			    		dutyDeleteFlag : row.dutyDeleteFlag,
			    		dutyExportFlag : row.dutyExportFlag,
				}
				rows_2.push(row_2);
			}	
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/duty/batchUpdateMenuOfDuty",
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
		}
		</script>
</body>
</html>