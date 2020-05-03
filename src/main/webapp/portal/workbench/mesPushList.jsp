<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
	<table id="MegPushRed-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="city" width="120px" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp',
															required:true}}">城市</th>
					<th field="pushType" width="100px" lov="TB_O2O_PUSH_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_PUSH_TYPE'),
																		editable:false}}">推送类型</th>
					<th field="messagePushType" width="120px" lov="TB_O2O_MSG_PUSH_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_MSG_PUSH_TYPE'),
																		editable:false}}">消息类型</th>
					<th field="objectType" width="100px" lov="TB_O2O_PUSH_OBJ_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_PUSH_OBJ_TYPE'),
																		editable:false}}">推送对象</th>
					<th field="pushText" width="120px" editor="{type:'textbox'}">推送内容</th>
					<th field="startTime" width="120px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:true}}">开始时间</th>
					<th field="expireTime" width="120px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:true}}">过期时间</th>
					<th field="isPushed" width="80px"  lov="S_IF" >是否已推送</th>
					<th field="activeFlag" width="80px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否有效</th>
					<th field="created" width="120px" >创建时间</th>

			   </tr>
			</thead>
		</table>
		
	</div>
   	
	<script type="text/javascript">
		$subdatagrid = $('#MegPushRed-table');
		$subdatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			title:'消息推送',
			border:false,
			pageSize: 25, 
		    pageList: [10,25,50],
		    url:'${AppContext.ctxPath}/action/portal/mesPush/queryByExamplePage',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/mesPush/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/mesPush/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			
			onDblClickRow: function(index, row){//行不可编辑判断，true为只读
				$subdatagrid.hdatagrid('getEditor', {
					index : index,
					field : 'city'
				}).target.textbox('disable');
				return false;
			},

 			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
			}, 
  onInitNewData:function(that){
	  return{
		  created:appCtx.sysdate(),
		  isPushed : 'N',
		  activeFlag:'Y',
		  pushType: 'Message Push'
	  };
		  
	  },
  
		});
		
		function cityPicklistComplete(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		//失效
		function Invalid(){
			var row = $subdatagrid.datagrid('getSelected');
			$subdatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,activeFlag:"N"});
		}
	</script>
</body>
</html>