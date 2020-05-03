<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<body>
		<div class="easyui-panel" border="false" title="" style="width:100%;height:100%;" data-options="footer:'#ft'">
	    	<div id="org-table-picklist-toolbar">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				搜索条件:
			    <input class="easyui-combobox" style="width:100px" url="/portal/basic/orgnization.json" valueField="id" textField="text"/> 
			    <input style="width: 200px;" type="text" class="easyui-textbox" />
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#org-table').datagrid('doSearch')">查询</a> 
			</div>
			
			<table id="org-table-picklist" style="height:100%;" title="" border="false"
				singleSelect="true" rownumbers="true" toolbar="#org-table-picklist-toolbar">
				<thead>
					<tr>
						<th field="orgCode" width="20%">组织编码</th>
						<th field="text" width="20%" defaultSearch="true">名称</th>
						<th field="orgType" width="20%">组织类型</th>
						<th field="parentOrgName" width="20%">父组织</th>
						<th field="isEffective" width="18%">是否有效</th>
					</tr>
				</thead>
			</table>
	    </div>
	    <div id="ft" style="padding:5px;">
	        <div style="float: right;margin-right:10px;">
	        	<a href="###" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="getSelected()">确定</a>
	        	<a href="###" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="windowClose()">取消</a>
	        </div>
	    </div>
		
		<script type="text/javascript">
		
		$picklistdatagrid = $('#org-table-picklist');
		$picklistdatagrid.datagrid({
			fitColumns:false,
			fit:true,
		    pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/basic/orgList',
			pagination: true, 
			onLoadSuccess:function(data){
				$.parser.parse();
				if(data.rows.length > 0){
					$picklistdatagrid.datagrid('selectRow', 0);
				}
		   }
		});
		
		function getSelected()
		{
			var row = $picklistdatagrid.datagrid('getSelected');
			$('#piclistid').window("close");
			test(row.id);
		}
		function windowClose()
		{
			$('#piclistid').window("close");
		}
	</script>
</body>
</html>