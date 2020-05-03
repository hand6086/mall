<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<body style="margin:0 0 0 0">
    	<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'east',split:false" title="" style="width:47%;height:100%;border-top:0px;border-right:0px;border-bottom:0px;">
					<div id="selected-org-table-mvg-toolbar">
						搜索条件:
					    <input class="easyui-combobox" style="width:80px" url="/portal/json/" valueField="id" textField="text"/> 
					    <input style="width: 200px;" type="text" class="easyui-textbox" />
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#selected-org-table-mvg').datagrid('doSearch')">查询</a> 
					</div>
					
					<table id="selected-org-table-mvg" 
						singleSelect="true" rownumbers="true" toolbar="#selected-org-table-mvg-toolbar">
						<thead>
							<tr>
								<th field="orgCode" width="35%" sortable="true">组织编码</th>
								<th field="text" width="30%">组织名称</th>
								<th field="parentOrgName" width="30%">父组织名称</th>
							</tr>
						</thead>
					</table>
			</div>
		
			<div data-options="region:'center',split:false" border="false" style="width:6%;height:100%;">
				 <br/><br/><br/><br/>
				 <div style="margin:0 auto;text-align:center;">
					<p><input type="button" id="addPostn" class="btn" value="&nbsp;>&nbsp;" onclick="" title="移动选择项到右侧"/></p><br/>
					<p><input type="button" id="removePostn" class="btn" value="&nbsp;<&nbsp;" onclick="" title="移动选择项到左侧"/></p>
				</div>
			</div>
			<div data-options="region:'west',split:false" style="width:47%;height:100%;border-top:0px;border-left:0px;border-bottom:0px;">
				<div id="unselected-org-table-mvg-toolbar">
					搜索条件:
				    <input class="easyui-combobox" style="width:80px" url="/portal/json/" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#unselected-org-table-mvg').datagrid('doSearch')">查询</a> 
				</div>
				
				<table id="unselected-org-table-mvg"
					singleSelect="true" rownumbers="true" toolbar="#unselected-org-table-mvg-toolbar">
					<thead>
						<tr>
							<th field="orgCode" width="35%" sortable="true">组织编码</th>
							<th field="text" width="30%">组织名称</th>
							<th field="parentOrgName" width="30%">父组织名称</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<script type="text/javascript">
		$mvgSelectedDatagrid = $('#selected-org-table-mvg');
		$mvgSelectedDatagrid.datagrid({
			url:"${AppContext.ctxPath}/action/portal/announce/selectedOrgList",
			onBeforeLoad:function(param){
				param.id = '${id}';
			},
			width:'100%',
			height:'100%',
			title: '已选',
			pagination: true, 
			border:false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$mvgSelectedDatagrid.datagrid('selectRow', 0);
				}
		   }
		});
		
		
		$mvgUnSelectedDatagrid = $('#unselected-org-table-mvg');
		$mvgUnSelectedDatagrid.datagrid({
			url:"${AppContext.ctxPath}/action/portal/announce/unSelectedOrgList",
			onBeforeLoad:function(param){
				param.id = '${id}';
			},
			width:'100%',
			height:'100%',
			title: '未选',
			pagination: true,
			border:false,
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为10 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$mvgUnSelectedDatagrid.datagrid('selectRow', 0);
				}
		   }
		});
		
		function addOrg(){
			var row = $mvgUnSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/announce/orgOfAnnounceInsert',{
				preObjId:'${id}',
				rearObjId:row.id
			},
			function(data){
				if(data.success){
					$mvgUnSelectedDatagrid.datagrid('reload');
					$mvgSelectedDatagrid.datagrid('reload');
			  	 }
			});
		}
		function removeOrg(){
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/announce/orgOfAnnounceDel',{
				id:row.id
			},function(data){
				if(data.success){
					$mvgUnSelectedDatagrid.datagrid('reload');
					$mvgSelectedDatagrid.datagrid('reload');
				}
			});
		}
		
	</script>
	
</body>
</html>