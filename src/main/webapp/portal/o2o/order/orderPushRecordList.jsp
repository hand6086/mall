<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>	
	<table id="orderPushRecord-table" height="100%">
		<thead>
			<tr>
				<th field="tAttr01" width="100px" lov="TB_O2O_PUSH_TYPE" editor="{type:'combobox',options:{valueField:'val',textField:'name',
																						method:'get',data:getLovArray('TB_O2O_PUSH_TYPE'),editable:false,required:true}}">推送类型</th>
				<th field="orderNum" width="200px" editor="{type:'picklistbox',
				                                                   options:{title:'订单号',
			                                                       required:true,
                                                                   completeFun:orderNumberPicklistComplete,
                                                                   tableUrl:'${AppContext.ctxPath}/portal/picklist/orderNumPickList.jsp'}}">订单号</th>
				<th field="name" width="200px"  editor="{type:'picklistbox',options:{title:'客户名称',required:true,
															completeFun:customerNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/customerPickList.jsp'
															}}">客户名称</th>
				<th field="ouNum" width="200px" editor="{type:'textbox'}">客户编码</th>
				<th field="o2oStoreType" width="100px" editor="{type:'textbox'}" lov="TB_O2O_STORE_TYPE">商户类型</th>
				<th field="o2oAcctType" width="100px" editor="{type:'textbox'}" lov="TB_O2O_ACCT_TYPE">配送网点类型</th>
				<th field="tAttr09" width="100px" editor="{type:'numberbox'}">大约距离(米)</th>
				<th field="isForcedPickup" width="100px" lov="S_IF" editor="{type:'combobox',options:{valueField:'val',textField:'name',
																						method:'get',data:getLovArray('S_IF'),editable:false}}">是否兜底商户</th>
				<th field="tAttr13" width="140px" editor="{type:'datetimebox'}">开始时间</th>
				<th field="tAttr14" width="140px" editor="{type:'datetimebox'}">过期时间</th>
				<th field="pushFlg" width="100px" lov="S_IF" editor="{type:'combobox',options:{valueField:'val',textField:'name',
																						method:'get',data:getLovArray('S_IF'),editable:false}}">是否已推送</th>
				<th field="tAttr12" width="140px" editor="{type:'numberbox'}">兜底短信已发送次数</th>
				<th field="tAttr15" width="140px" editor="{type:'datetimebox'}">兜底短信最后发送时间</th>
				
				<th field="id" width="100px" hidden="true" noSearch="true">Id</th>
				<th field="userId" width="100px" hidden="true" noSearch="true">userId</th>
				<th field="objectId" width="100px" hidden="true" noSearch="true">objectId</th>
			</tr>
		</thead>
	</table>		
 <script type="text/javascript">
	 $datagrid = $('#orderPushRecord-table');
	 $datagrid.hdatagrid({
			updateable:true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/order/platformOrder/queryOrderPushRecord?orderNum=${param.orderNum}',
			onInsertAction : function(row,successFun,errFun,that){
				row = $datagrid.hdatagrid('getCurrentRow');
		    	$.post('${AppContext.ctxPath}/action/portal/order/platformOrder/insert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
		/* 				var index = $datagrid.hdatagrid('getRowIndex', row);
						row.cityName = data.newRow.cityName;//给被选中行的某个字段重新赋值(controller中updateSubDetail方法返回数据中的值)，再刷新
						$datagrid.hdatagrid("refreshRow", index); */
					};
					$datagrid.hdatagrid('reload');
				});
			},
			onInitNewData:function(that){
				return {
					isForcedPickup : 'N',
					pushFlg : 'N',
					orderNum:'${param.orderNum}',
					objectId:'${param.objectId}'
				};
			},
			onUpdateAction: function(row,successFun,errFun,that){
		    	$.post('${AppContext.ctxPath}/action/portal/order/platformOrder/update', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction : function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/order/platformOrder/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add_id" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="reloadRecord()">重新推送</a>',that);
			}
		});	
	 
	 function orderNumberPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orderNum = selectRow.orderNum;
			$datagrid.hdatagrid('getCurrentRow').objectId = selectRow.id;
			return selectRow.orderNum;
	 }
	 
	 function customerNamePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').name = selectRow.name;
			$datagrid.hdatagrid('getCurrentRow').ouNum = selectRow.ouNum;
			$datagrid.hdatagrid('getCurrentRow').o2oStoreType = selectRow.o2oStoreType;
			$datagrid.hdatagrid('getCurrentRow').o2oAcctType = selectRow.o2oAcctType;
			$datagrid.hdatagrid('getCurrentRow').userId = selectRow.accntId;
			return selectRow.name;
	 }
	 function reloadRecord(){
		 var row = $datagrid.hdatagrid('getSelected');
		 if(row == null){
			 $.messager.alert("错误", "请选择一条记录！", "error");
		 }
		 $.post("${AppContext.ctxPath}/action/portal/order/platformOrder/updateRecordById", {id: row.id}, function(data){
			if(data.success){
				$datagrid.datagrid('reload');
			}else{
				$.messager.alert("错误", "更新数据错误: "+data.result, "error");
			}
		});
	 }
 </script>
 </body>
 </html>