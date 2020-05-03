<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<body>
	<div id="menu_layout" class="easyui-layout" fit="true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<table id="complaints-table" style="width:100%;height:100%;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="id" width="80px" noSearch="true" hidden="true">Id</th>
						<th field="userId" width="150px" editor="{type:'textbox'}">消费者ID或回复员工ID</th>
						<th field="phoneNumber" width="100px" editor="{type:'textbox'}">消费者联系电话</th>
						<th field="context" width="300px" editor="{type:'textbox'}">申或回复内容</th>
						<th field="type" width="200px" editor="{type:'textbox'}">申诉、回复</th>
						<th field="parentId" width="100px" editor="{type:'textbox'}">回复的对象ID</th>
						<th field="tAttr01" width="100px" editor="{type:'textbox'}">定位城市</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog" title="请填写回复内容" data-options="closed:true,buttons:'#dlg-buttons'" style="width:450px;height:300px">
		<form id="complaintsForm" method="post" style="width:100%;height:100%">
			<table style="width:100%;height:100%">
				<tr style="width:100%;height:100%">
					<td style="width:100%;height:100%">
						<textarea style="width:99%;height:98%" placeholder='请在此输入回复内容' class="easyui-validatebox"
						 name="context" type="text" id="context" required="true"></textarea>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
    <script type="text/javascript">
	    $dlg = $('#dlg');
		$complaintsForm = $('#complaintsForm');
		$datagrid = $('#complaints-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonMenu:true,
			oauthFlag:true,
			striped:true,
			border : false,
			url : '${AppContext.ctxPath}/action/portal/feedBack/queryByExamplePage',
			
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="context()" iconCls="icon-ok" plain="true">回复</a>',that);
			}
		});
		function context(){
		  var row = $datagrid.datagrid('getSelected');
		   if(row.type=="申诉"){
		   $dlg.dialog('open');
		   }else{
			   window.parent.operationtip('申诉、回复字段必须为申诉时才可回复！', 'error');
		   }
		}
		function save(){
			   var row = $datagrid.datagrid('getSelected');
			   var options = {
						url : '${AppContext.ctxPath}/action/portal/feedBack/insert',
						type : 'post',
						dataType :'json',
						data: {
							'parentId': row.id,
							'type': '申诉回复',
							'tAttr01': row.tAttr01,
			            },
						beforeSubmit: function() {
							var result = $complaintsForm.form('validate');
							return result;
						},  
						success : function(data) {
							if (data.success) {
								$dlg.dialog('close');
								window.parent.operationtip('回复成功！', 'info');
								$datagrid.datagrid('reload');
							} else {
								window.parent.operationtip(data.result, 'error');
							}
						}
					};
			   $complaintsForm.ajaxSubmit(options);
		   }
	</script>
</body>
</html>