<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<body>
		<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'center'" border="false" style="padding:0px;">
				<div id="order-acct-table-toolbar">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					搜索条件:
				    <input class="easyui-combobox" style="width:100px" url="/portal/json/OrderAcctPickList.json" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#order-acct-table').datagrid('doSearch')">查询</a> 
				</div>
				
				<table id="order-acct-table" style="height:100%;width:100%" title="" border="false"
					singleSelect="true" rownumbers="true" toolbar="#order-acct-table-toolbar">
				<thead>
					<tr>
					
						<th field="acctId" width="100px">客户编码</th>
						<th field="acctName" width="250px">客户名称</th>
						<th field="acctName" width="100px">法人联系人</th>
						<th field="marketChannel" width="80px">营销渠道</th>
						<th field="taxType" width="70px">税分类</th>
						
						<th field="created" width="150px">创建时间</th>
					</tr>
				</thead>
			</table>
			</div>
		</div>
	
	<script type="text/javascript">
		$picklistdatagrid = $('#order-acct-table');
		$picklistdatagrid.datagrid({
			url:'${AppContext.ctxPath}/action/portal/accnt/queryListPage',
			width:'100%',
			height:'100%',
			pagination: true, 
			striped:true,
			pageSize: 20,//每页显示的记录条数，默认为20 
			pageList: [20,30,50],//可以设置每页记录条数的列表 
			onBeforeLoad:function(param){
				param.attr1 = '${acctId}';
			},
			onDblClickCell:function(index,field,value){
				$('#picklistOK').click();
			},
			onLoadSuccess:function(data){
				if(data.success){
					if(data.rows.length > 0){
						$picklistdatagrid.datagrid('selectRow', 0);
					}
				}else
				{
					window.parent.operationtip(data.result, 'error');
				}
		   }
		});
		$.parser.parse('#order-acct-table');
	</script>
</body>
</html>