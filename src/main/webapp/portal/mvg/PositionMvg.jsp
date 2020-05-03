<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<body style="margin:0 0 0 0">
    	<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'east',split:false" title="" style="width:47%;height:100%;border-top:0px;border-right:0px;border-bottom:0px;">
					<div id="selected-position-table-mvg-toolbar">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						搜索条件:
					    <input class="easyui-combobox" style="width:100px" url="/portal/json/marketScope.json" valueField="id" textField="text"/> 
					    <input style="width: 200px;" type="text" class="easyui-textbox" />
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#selected-model-table-mvg').datagrid('doSearch')">查询</a> 
					</div>
					
					<table id="selected-position-table-mvg" title="已选职位" 
						singleSelect="true" rownumbers="true" toolbar="#selected-position-table-mvg-toolbar">
						<thead>
							<tr>
								<th field="isMainBusiness" width="8%" formatter="isDefaultFormatter">主要职位</th>
								<th field="text" width="20%" >职位名称</th>
								<th field="positionType" width="20%">职位类型</th>
								<th field="deptName" width="20%">部门</th>
							<th field="orgName" width="20%">组织</th>
							</tr>
						</thead>
					</table>
			</div>
		
			<div data-options="region:'center',split:false" border="false" style="width:6%;height:100%;padding:0px;">
				 <br/><br/><br/><br/>
				 <div style="margin:0 auto;text-align:center;">
					<p><span id="add_position"><input type="button" id="addPostn" class="btn" value="&nbsp;>&nbsp;" onclick="addPostn()" title="移动选择项到右侧"/></span></p><br/>
					<p><span id="remove_position"><input type="button" id="removePostn" class="btn" value="&nbsp;<&nbsp;" onclick="removePostn()" title="移动选择项到左侧"/></span></p>
					<%-- <p><span id="remove_all_position"><input type="button" class="btn" value="<<" onclick="removeAllPostn()" title="全部移到左侧"/></span></p> --%>
				 </div>
			</div>
			
			<div data-options="region:'west',split:false" style="width:47%;height:100%;border-top:0px;border-left:0px;border-bottom:0px;">
				<div id="unselected-position-table-mvg-toolbar">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					搜索条件:
				    <input class="easyui-combobox" style="width:100px" url="/portal/json/marketScope.json" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#unselected-model-table-mvg').datagrid('doSearch')">查询</a> 
				</div>
				
				<table id="unselected-position-table-mvg" title="职位列表"
					singleSelect="true" rownumbers="true" toolbar="#unselected-position-table-mvg-toolbar">
					<thead>
						<tr>
							<th field="text" width="15%">职位名称</th>
							<th field="positionType" width="12%">职位类型</th>	
							<th field="username" width="17%">主要负责人用户名</th>	
							<th field="fstName" width="15%">主要负责人姓名</th>	
							<th field="deptName" width="15%">部门</th>
							<th field="orgName" width="15%">组织</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<script type="text/javascript">
		$mvgSelectedDatagrid = $('#selected-position-table-mvg');
		var pickSelectedIndex = undefined;
		var itemInsertFlag = false;
		$mvgSelectedDatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/position/selectedList',
			width:'100%',
			height:'100%',
			pagination: true, 
			border: false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.userId = '${id}';
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
							changeDefaultPostnUpdate(row);
						});
				$("#removePostn").removeAttr("disabled");
		   }
		});
		
		function changeDefaultPostnUpdate(row){
			$.post('${AppContext.ctxPath}/action/portal/user/defaultPostnUpdate', 
					{
						id 			: '${id}',
						postnId	: row.id
				    },
					function(data){
				    	if(!data.success){
							window.parent.operationtip(data.result, 'error');
						}
					});
		}
		
		function removePostn(){
			$("#removePostn").attr("disabled", "disabled");
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/position/delPostnByUser', 
			{
				id : row.id,
				userId : '${id}'
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
		
		function removeAllPostn(){
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/position/delAllPostnByUser', 
			{
				userId : '${id}'
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
		
		
		$mvgUnSelectedDatagrid = $('#unselected-position-table-mvg');
		$mvgUnSelectedDatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/position/unSelectedList',
			width:'100%',
			height:'100%',
			pagination: true,
			border:false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为10 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.userId = '${id}';
			},
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$mvgUnSelectedDatagrid.datagrid('selectRow', 0);
				}
				$("#addPostn").removeAttr("disabled");
		   }
		});
		function addPostn(){
			$("#addPostn").attr("disabled", "disabled");
			var row = $mvgUnSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/position/addPostnByUser', 
			{
				id : row.id,
				userId : '${id}'
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