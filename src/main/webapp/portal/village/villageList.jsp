<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
	<table id="village-table" style="height:100%;width:100%">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="150px" editor="{type:'datetimebox',options:{required:false,showSeconds:false}}">创建时间</th>
				<th field="attr02" noSearch="true" defaultSearch="false"   width="60px" editor="{type:'validatebox',options:{required:false}}"  >省份</th>
				<th field="city" noSearch="false" defaultSearch="false"   width="60px" editor="{type:'validatebox',options:{required:false}}"  >城市</th>
				<th field="attr03" noSearch="true" defaultSearch="false"   width="60px" editor="{type:'validatebox',options:{required:false}}"  >区县</th>
				<th field="name" noSearch="false" defaultSearch="false"   width="200px" editor="{type:'validatebox',options:{required:false}}"  >小区名称</th>
				<th field="addr" noSearch="false" defaultSearch="false"   width="300px" editor="{type:'validatebox',options:{required:false}}"  >地址</th>
				<th field="price" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >房屋均价</th>
				<th field="lng" noSearch="false" defaultSearch="false"   width="50px" editor="{type:'validatebox',options:{required:false}}"  >经度</th>
				<th field="lat" noSearch="false" defaultSearch="false"   width="50px" editor="{type:'validatebox',options:{required:false}}"  >纬度</th>
<!-- 			<th field="attr04" noSearch="true" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >预留字段04</th>
				<th field="attr01" noSearch="true" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >预留字段01</th>
				<th field="attr05" noSearch="true" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >预留字段05</th>
				<th field="attr06" noSearch="true" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >预留字段06</th> -->

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#village-table');
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
			url:'${AppContext.ctxPath}/action/portal/village/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			   buttonBatchEdit : true,
				onBatchUpdateAction : function(rows, successFun, errFun, that){
					$.ajax({
						url: "${AppContext.ctxPath}/action/portal/village/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/village/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/village/deleteById', {
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{VillageId:row.id});
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
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editVillagePrice()" iconCls="icon-edit" plain="true">修订</a>',that);
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
		function VillageSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.VillageStatus == '新建'||row.VillageStatus == '已拒绝'){
				$.post('/action/portal/Village/VillageSubmit', 
				{
					id	: row.id,
					VillageStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.VillageStatus+'，无法提交！', 'error');
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
