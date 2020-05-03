<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<body style="margin:0 0 0 0">
    	<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'east',split:false" title="" style="width:47%;height:100%;border-top:0px;border-right:0px;border-bottom:0px;">
					<div id="selected-duty-table-mvg-toolbar">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						搜索条件:
					    <input class="easyui-combobox" style="width:100px" url="/portal/json/duty.json" valueField="id" textField="text"/> 
					    <input style="width: 200px;" type="text" class="easyui-textbox" />
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#selected-duty-table-mvg').datagrid('doSearch')">查询</a> 
					</div>
					
					<table id="selected-duty-table-mvg" title="已选职责" 
						singleSelect="true" rownumbers="true" toolbar="#selected-duty-table-mvg-toolbar">
						<thead>
							<tr>
								<th field="isMainBusiness" width="8%" formatter="isDefaultFormatter">主要职位</th>
								<th field="name" width="40%">职责名称</th>
								<th field="comments" width="40%">说明</th>	
							</tr>
						</thead>
					</table>
			</div>
		
			<div data-options="region:'center',split:false" border="false" style="width:6%;height:100%;padding:0px;">
				 <br/><br/><br/><br/>
				 <div style="margin:0 auto;text-align:center;">
					<p><span id="add_position"><input type="button" id="addPostn" class="btn" value="&nbsp;>&nbsp;" onclick="addDuty()" title="移动选择项到右侧"/></span></p><br/>
					<p><span id="remove_position"><input type="button" id="removeDuty" class="btn" value="&nbsp;<&nbsp;" onclick="removeDuty()" title="移动选择项到左侧"/></span></p>
					<%-- <p><span id="remove_all_position"><input type="button" class="btn" value="<<" onclick="removeAllPostn()" title="全部移到左侧"/></span></p> --%>
				 </div>
			</div>
			
			<div data-options="region:'west',split:false" style="width:47%;height:100%;border-top:0px;border-left:0px;border-bottom:0px;">
				<div id="unselected-duty-table-mvg-toolbar">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					搜索条件:
				    <input class="easyui-combobox" style="width:100px" url="/portal/json/duty.json" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#unselected-duty-table-mvg').datagrid('doSearch')">查询</a> 
				</div>
				
				<table id="unselected-duty-table-mvg" title="职责列表"
					singleSelect="true" rownumbers="true" toolbar="#unselected-duty-table-mvg-toolbar">
					<thead>
						<tr>
							<th field="name" width="50%">职责名称</th>
							<th field="comments" width="50%">说明</th>	
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<script type="text/javascript">
		$mvgSelectedDatagrid = $('#selected-duty-table-mvg');
		$mvgSelectedDatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/duty/selectDutyList',
			width:'100%',
			height:'100%',
			pagination: true, 
			border: false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.id = '${id}';
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
			$.post('${AppContext.ctxPath}/action/portal/user/defaultDutyUpdate', 
					{
						preObjId : '${id}',
						rearObjId : row.id
				    },
					function(data){
				    	if(!data.success){
							window.parent.operationtip(data.result, 'error');
						}
					});
		}
		
		function removeDuty(){
			$("#removeDuty").attr("disabled", "disabled");
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/user/removeDutyOfUser', 
			{
				preObjId:'${id}',
				rearObjId:row.id
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
		
		
		$mvgUnSelectedDatagrid = $('#unselected-duty-table-mvg');
		$mvgUnSelectedDatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/duty/unSelectDutyList',
			width:'100%',
			height:'100%',
			pagination: true,
			border:false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为10 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.id = '${id}';
			},
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$mvgUnSelectedDatagrid.datagrid('selectRow', 0);
				}
				$("#addDuty").removeAttr("disabled");
		   }
		});
		function addDuty(){
			$("#addDuty").attr("disabled", "disabled");
			var row = $mvgUnSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/user/addDutyOfUser', 
			{
				preObjId:'${id}',
				rearObjId:row.id
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