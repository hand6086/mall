<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
  	<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">筛选条件</span>
			</legend>

			<div class="row keyfilter-border">
				<ul id="groupName-keyfilter" data-toggle="keyfilter"
					data-title="所在分组" data-filter-filed="groupName"
					data-table-Id="wxGroup-table">
				</ul>
			</div>
		</fieldset>
	
	<table id="wxGroup-table" style="height:100%;width:100%" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="130px" >创建时间</th>
				<th field="groupName" width="200px" defaultSearch="false" editor="{type:'validatebox',options:{required:false,validType:'length[1,30]'}}">分组名字</th>
				<th field="groupid" width="100px" defaultSearch="false">分组ID</th>
				<th field="count" width="100px" defaultSearch="false">分组内用户数量</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#wxGroup-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : false,
			buttonExport : true,
			buttonImport : false,
			newDefaultValue : true,
			striped : true,
			border : false,
			/* sortName : 'groupid',
			sortOrder : 'asc', */
			url:'${AppContext.ctxPath}/action/portal/wxGroup/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/wxGroup/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/wxGroup/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				if(row.groupid=="0"||row.groupid=="1"||row.groupid=="2"){
					$.messager.alert("操作提示", "系统分组，不允许删除修改","warning");
					return;
				}
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/wxGroup/deleteById', {
								id : row.id,
								groupid : row.groupid								
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{WxGroupId:row.id});
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
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="ansyGroup()" iconCls="icon-reload" plain="true">分组同步</a>',that);
				//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);
			
			},
			/**
			 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
			 */
			readOnlyCondition: function(row, that){
				if(row.groupid=="0"||row.groupid=="1"||row.groupid=="2"){
					$.messager.alert("操作提示", "系统分组，不允许删除修改","warning");
					return true;
				}else{
					return false;
				}
				
			},
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
		function WxGroupSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.WxGroupStatus == '新建'||row.WxGroupStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/WxGroup/WxGroupSubmit', 
				{
					id	: row.id,
					WxGroupStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.WxGroupStatus+'，无法提交！', 'error');
			}
		}
		function productPicklistComplete(selectRow){ 
			$datagrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			});
			return selectRow.prodName;
		}
		*/
		
		/**
			微信分组同步
		*/
		function ansyGroup(){
			operationprogress('进度提示', '正在同步...');
			$.get('${AppContext.ctxPath}/action/portal/wxGroup/ansyGroup',
					function(data) {
						/* console.log(data); */
						if (!data.success) {
							$.messager.alert("操作提示", data.result, "error");
						} else {
							$.messager.progress('close');
							$datagrid.datagrid('reload');
							$.messager.alert("操作提示","已同步" + data.total + "条记录", "info");
						}
					});
			
		}
	</script>
</body>
</html>
