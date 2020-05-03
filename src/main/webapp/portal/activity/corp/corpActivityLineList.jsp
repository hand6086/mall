<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
  
	
	<table id="corpActivityLine-table" style="height:50%;width:100%" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="100px" >创建时间</th>
				<th field="username" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">姓名</th>
				<th field="tel" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">手机号</th>
				<th field="corp" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">公司</th>
				<th field="postn" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">职位</th>
				<th field="products" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">关注产品</th>
				<th field="service" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">近期实施</th>
				<th field="headId" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">公司活动头ID</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#corpActivityLine-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/corpActivityLine/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/corpActivityLine/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				
				$.post('${AppContext.ctxPath}/action/portal/corpActivityLine/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/corpActivityLine/deleteById', {
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
			},
			onChangeSelectedItem:function(row){
				//$datagrid.hdatagrid("changeParentItemAndParams",{CorpActivityLineId:row.id});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editCorpActivityLinePrice()" iconCls="icon-edit" plain="true">修订</a>',that);
			}
		});

	   
		
		
		var editFormatter = function(value,row,index){
			return value;
		}
		
		/*以下为部分参考函数*/
		/*
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				accntId : selectRow.id
			});
			return selectRow.acctName;
		}
		function contactPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				contactId : selectRow.id
			});
			return selectRow.contactsName;
		}
		function CorpActivityLineSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.CorpActivityLineStatus == '新建'||row.CorpActivityLineStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/CorpActivityLine/CorpActivityLineSubmit', 
				{
					id	: row.id,
					CorpActivityLineStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.CorpActivityLineStatus+'，无法提交！', 'error');
			}
		}
		function productPicklistComplete(selectRow){ 
			$datagrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			});
			return selectRow.prodName;
		}
		*/
	</script>
</body>
</html>
