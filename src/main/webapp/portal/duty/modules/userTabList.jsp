<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<table id="user-table" title="用户列表" fit="true">
				<thead>
					<tr>
						<th field="username" width="40%">用户名</th>
						<th field="firstName" width="50%">说明</th>
					</tr>
				</thead>
			</table>

<script type="text/javascript">
$datauseritemgrid = $('#user-table');
$datauseritemgrid.hdatagrid({
	toolbarShow:true,
	buttonSearch:true,
    parentGridId : 'duty-table',
    parentGridField : 'id',
    linkGridField : 'dutyId',
	url:'${AppContext.ctxPath}/action/portal/duty/dutyOfUserList',
    pageSize: 10,//每页显示的记录条数，默认为10 
    pageList: [5,10,15],//可以设置每页记录条数的列表 
    onAddMoreButton:function(that,addButtonFun){
		addButtonFun(91,'<a href="javascript:void(0)" id="selectUserBtn" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectUserWindow()">新建</a>',that);
		addButtonFun(92,'<a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delSelectedUser()">删除</a>',that);
	}
});

function selectUserWindow()
{
	var dutyRecord = $datagrid.hdatagrid('getSelected');
	if(dutyRecord.corpid != appCtx.corpId){
		$.messager.alert("警告","选中的职责不属于当前账套，您没有权限为其添加用户。");
		return;
	}
	$('#selectUserBtn').multiSelect({
		title:'添加用户',
		initParam:function(){
			return {id:dutyRecord.id};
		},
		tableUrl:'${AppContext.ctxPath}/portal/duty/dialog/userMultiSelect.jsp',
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
		            url: "${AppContext.ctxPath}/action/portal/duty/addUserOfDuty",
		            data: JSON.stringify(records),
		            dataType: "json",	
		            contentType: 'application/json', 
		            success:function(data){
						if(data.success){
							$datauseritemgrid.hdatagrid("reload");
						}else{
							$.messager.alert("警告",data.result);
						}
					}
			});
		}
	});
}

function delSelectedUser(){
	$.post('${AppContext.ctxPath}/action/portal/duty/delUserOfDuty',{
		preObjId:$datagrid.hdatagrid('getSelected').id,
		rearObjId:$datauseritemgrid.hdatagrid('getSelected').id
	},
	function(data){
		if(!data.success){
			$.messager.alert("警告",data.result);
		}
		$datauseritemgrid.hdatagrid('reload');
	});
}
</script>
</body>
</html>