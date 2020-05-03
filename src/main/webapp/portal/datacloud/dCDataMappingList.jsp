<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<table id="dCDataMapping-table" data-options="fit:true" style="height:100%;width:100%">
		<thead>
			<tr>
				<th field="vindaCode" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >维达编码</th>
				<th field="itemName" noSearch="false" defaultSearch="false"   width="200px" editor="{type:'validatebox',options:{required:false}}"  >名称</th>
				<th field="brand" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >品牌</th>
				<th field="source" noSearch="false" defaultSearch="false" lov="DC_DATA_SOURCE" width=80px" editor="{type:'combobox',options:{valueField:'val',
				textField:'name',data:getLovArray('DC_DATA_SOURCE'),editable:false,required:false}}"  >来源</th>
				<th field="type" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >类型</th>
				<th field="baijiaCode" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >百佳Code</th>
				<th field="huikangCode" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >惠康Code</th>
				<th field="hKTVCode" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >HKTV</th>
				<th field="attr01" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR01</th>
				<th field="attr02" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR02</th>
				<th field="attr03" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR03</th>
				<th field="attr04" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR04</th>
				<th field="attr05" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR05</th>
				<th field="attr06" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR06</th>
				<th field="attr07" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR07</th>
				<th field="attr08" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR08</th>
				<th field="attr09" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR09</th>
				<th field="attr10" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >ATTR10</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		$datagrid = $('#dCDataMapping-table');
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
			url:'${AppContext.ctxPath}/action/portal/dCDataMapping/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/dCDataMapping/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/dCDataMapping/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/dCDataMapping/deleteById', {
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{DCDataMappingId:row.id});
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
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editDCDataMappingPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
				//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);
			
			},
			/**
			 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
			 */
			//readOnlyCondition: function(row, that){
			//	return false;
			//},
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
		function DCDataMappingSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.DCDataMappingStatus == '新建'||row.DCDataMappingStatus == '已拒绝'){
				$.post('/action/portal/DCDataMapping/DCDataMappingSubmit', 
				{
					id	: row.id,
					DCDataMappingStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.DCDataMappingStatus+'，无法提交！', 'error');
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
