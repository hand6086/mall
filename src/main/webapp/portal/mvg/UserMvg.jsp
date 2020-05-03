<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<body style="margin:0 0 0 0">
    	<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'east',split:false" title="" style="width:47%;height:100%;border-top:0px;border-right:0px;border-bottom:0px;">
					<div id="selected-user-table-mvg-toolbar">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						搜索条件:
					    <input class="easyui-combobox" style="width:100px" url="/portal/json/user.json" valueField="id" textField="text"/> 
					    <input style="width: 200px;" type="text" class="easyui-textbox" />
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#selected-user-table-mvg').datagrid('doSearch')">查询</a> 
					</div>
					
					<table id="selected-user-table-mvg" title="责任人" 
						singleSelect="true" rownumbers="true" toolbar="#selected-user-table-mvg-toolbar">
						<thead>
							<tr>
								<th field="isMainBusiness" width="10%" formatter="isDefaultFormatter">主要责任人</th>
								<th field="username" width="30%" >用户名</th>
								<th field="firstName" width="25%">姓名</th>
								<th field="status" width="25%">状态</th>
							</tr>
						</thead>
					</table>
			</div>
		
			<div data-options="region:'center',split:false" border="false" style="width:6%;height:100%;">
				 <br/><br/><br/><br/>
				 <div style="margin:0 auto;text-align:center;">
					<p><span id="add_user"><input type="button" id="addUser" class="btn" value="&nbsp;>&nbsp;" onclick="addUser()" title="移动选择项到右侧"/></span></p><br/>
					<p><span id="remove_user"><input type="button" id="removeUser" class="btn" value="&nbsp;<&nbsp;" onclick="removeUser()" title="移动选择项到左侧"/></span></p>
					<%-- <p><span id="remove_all_user"><input type="button" class="btn" value="<<" onclick="removeAllUser()" title="全部移到左侧"/></span></p> --%>
				</div>
			</div>
			<div data-options="region:'west',split:false" style="width:47%;height:100%;border-top:0px;border-left:0px;border-bottom:0px;">
				<div id="unselected-user-table-mvg-toolbar">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					搜索条件:
				    <input class="easyui-combobox" style="width:100px" url="/portal/json/user.json" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#unselected-user-table-mvg').datagrid('doSearch')">查询</a> 
				</div>
				
				<table id="unselected-user-table-mvg" title="用户列表"
					singleSelect="true" rownumbers="true" toolbar="#unselected-user-table-mvg-toolbar">
					<thead>
						<tr>
							<th field="username" width="15%">用户名</th>
							<th field="firstName" width="13%">姓名</th>
							<th field="status" width="10%">状态</th>
							<th field="empType" width="10%" >类型</th>
							<th field="role" width="10%" >角色</th>
							<th field="contact" width="12%" >联系人</th>
							<th field="contactPhone" width="15%">联系电话</th>
							
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<script type="text/javascript">
		$mvgSelectedDatagrid = $('#selected-user-table-mvg');
		var pickSelectedIndex = undefined;
		var itemInsertFlag = false;
		$mvgSelectedDatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/user/selectedList',
			width:'100%',
			height:'100%',
			pagination: true, 
			border:false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.postnId = '${id}';
			},
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$mvgSelectedDatagrid.datagrid('selectRow', 0);
				}
				//(是否默认型号)单选按钮点击事件
				$("input[name='isDefaultRadio']").click(
						function() {
							var row = $mvgSelectedDatagrid
									.datagrid('getData').rows[$(this)
									.val()];
							changeDefaultUserUpdate(row);
						});
				$("#removeUser").removeAttr("disabled");
		   }
		});
		
		function changeDefaultUserUpdate(row){
			$.post('${AppContext.ctxPath}/action/portal/position/defaultUserUpdate', 
					{
						id 			: '${id}',
						userId	: row.id
				    },
					function(data){
				    	if(!data.success){
							window.parent.operationtip(data.result, 'error');
						}
					});
		}
		
		function removeUser(){
			$("#removeUser").attr("disabled", "disabled");
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/user/delUserByPostn', 
			{
				id : row.id,
				postnId : '${id}'
		    },
			function(data){
		    	if(!data.success){
					window.parent.operationtip(data.result, 'error');
				} else {
					$mvgUnSelectedDatagrid.datagrid('reload');
			    	$mvgSelectedDatagrid.datagrid('reload');
				}
			});
		}
		
		function removeAllUser(){
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/user/delAllUserByPostn', 
			{
				postnId : '${id}'
		    },
			function(data){
		    	if(!data.success){
					window.parent.operationtip(data.result, 'error');
				} else {
					$mvgUnSelectedDatagrid.datagrid('reload');
			    	$mvgSelectedDatagrid.datagrid('reload');
				}
			});
		}
		
		
		$mvgUnSelectedDatagrid = $('#unselected-user-table-mvg');
		$mvgUnSelectedDatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/user/unSelectedList',
			width:'100%',
			height:'100%',
			pagination: true,
			border:false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.postnId = '${id}';
			},
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$mvgUnSelectedDatagrid.datagrid('selectRow', 0);
				}
				$("#addUser").removeAttr("disabled");
		   }
		});
		function addUser(){
			$("#addUser").attr("disabled", "disabled");
			var row = $mvgUnSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/user/addUserByPostn', 
			{
				id : row.id,
				postnId : '${id}'
		    },
			function(data){
		    	if(!data.success){
					window.parent.operationtip(data.result, 'error');
				} else {
					$mvgUnSelectedDatagrid.datagrid('reload');
			    	$mvgSelectedDatagrid.datagrid('reload');
				}
			});
		}
		
		
		function isDefaultFormatter(value, rowData, rowIndex) {
			var radio_A = '<input type="radio" name="isDefaultRadio" id="isDefaultRadio' + rowIndex + '"    value="' + rowIndex + '" ';
				var radio_B = ' />';
			var radio = '';
			//判断该行是否为主营业务
			if (rowData.isDefault == 'Y') {
				//设置为选中状态
				radio = radio + ' checked ';
			}
			return radio_A + radio + radio_B; //拼接成完整html标签后返回
		}
		
		
		
	</script>
	
</body>
</html>