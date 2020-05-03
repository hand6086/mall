<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
fieldset{
	margin: 0px auto;
	width:300px;
}
fieldset legend{
	font-size: 16px;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center',split:true" title="" border="false" style="width: 100%; height: 100%; padding: 0px;">

			<table id="userMsg-table" width="100%" height="100%" singleSelect="false" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="check" checkbox="true"></th>
					<th field="id" width="100px" sortable="true" hidden="true">id</th>
					<th field="msgId" width="100px" sortable="true" hidden="true">消息ID</th>
					<th field="msgType" width="100px" sortable="true">消息类型</th>
					<th field="msgTitle" width="100px" formatter="detailFormatter">标题</th>
					<th field="msgContent" width="200px" editor="{type:'textarea'}">内容</th>
					<th field="importance" width="80px" lov="ACTIVITY_IMPORTANT" editor="{type:'combobox',options:{valueField:'name',
																		textField:'name',
																		method:'get',
																		data:getLovArray('ACTIVITY_IMPORTANT'),
																		editable:false,
																		required:true}}" defaultSearch="true">重要性</th>
					<th field="isRead" width="100px" >已读</th>
					<th field="sendBy" width="100px">发送人</th>
					<th field="sendTime" width="100px">发送时间</th>
					<th field="readTime" width="100px">阅读时间</th>
			   </tr>
			</thead>
		</table>

		</div>
	
	</div>
	
<div id="msg-dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="reply('dlg-reply')">回复</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#msg-dlg').dialog('close')">取消</a>
</div>
<div id="msg-dlg" class="easyui-dialog" style="width:40%;height:80%;padding:10px 20px"
		closed="true" buttons="#msg-dlg-buttons">
		
	<div class="ftitle"></div>
	<form id="fm" method="post">	
	<input type="hidden" name="id" id="id">
	<table class="table-block" align="center">
		<tr>
			<td class="td-label">
				<label>标题：&nbsp;</label>
			</td>
			<td class="td-content">
				<input id="msgTitle" name="msgTitle" readonly="readonly" class="easyui-validatebox" style="width: 300px;font-size: 12px;">
			</td>
		</tr>			
		<tr>
			<td class="td-label">
				<label>内容：&nbsp;</label>
			</td>
			<td class="td-content">
				<textarea id="msgContent" name="msgContent" readonly="readonly" class="easyui-validatebox" style="width: 300px;height:300px;font-size: 12px;"></textarea>
			</td>
		</tr>		
	</table>
	</form>	
</div>

<div id="replyMsg-dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="send()">发送</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#replyMsg-dlg').dialog('close')">取消</a>
</div>
<div id="replyMsg-dlg" class="easyui-dialog" style="width:40%;height:80%;padding:10px 20px"
		closed="true" buttons="#replyMsg-dlg-buttons">
		
<div class="ftitle"></div>
	<form id="replyFm" method="post">
	<input type="hidden" name="id" id="id">
	<input type="hidden" name="isRead" id='isRead'>
	<input type="hidden" name="isSend" id='isSend'>
	<input type="hidden" name="readTime" id="readTime">
	<input type="hidden" name="msgType" id="msgType">
	<input type="hidden" name="row_status" id="row_status">	
	<input type="hidden" name="userId" id="userId">
	
	
	<table class="table-block" align="center">
		<tr>
			<td class="td-label">
				<label>标题：&nbsp;</label>
			</td>
			<td class="td-content">
				<input id="msgTitle" name="msgTitle" readonly="readonly" class="easyui-validatebox" style="width: 300px;font-size: 12px;">
			</td>
		</tr>
		<tr>
			<td class="td-label">
				<label>重要性：&nbsp;</label>
			</td>
			<td class="td-content">
				<input id="importance" name="importance" class="easyui-combobox td-input-input" 
       			    data-options="prompt:'请选重要性...',
       			    			data:getLovArray('ACTIVITY_IMPORTANT'),
								valueField:'name',
								textField: 'name',
								editable:false" style="width: 306px;font-size: 12px;">
			</td>
		</tr>				
		<tr>
			<td class="td-label">
				<label class="td-label">回复：&nbsp;</label>
			</td>
			<td class="td-content">
				<textarea id="msgContent" name="msgContent" class="easyui-validatebox" required="true" style="width: 300px; height: 250px; font-size: 12px;"></textarea>
			</td>
		</tr>
	</table>
	</form>
</div>

	<script type="text/javascript">
		var userInsertFlag = false;
		$datagrid = $("#userMsg-table");
		$fm = $('#fm');
		$replyFm = $('#replyFm');
		$msgDlg = $('#msg-dlg');
		$replyMsg = $('#replyMsg-dlg');
		
		
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			selectFirstRow:false,
			striped : true,
			border : false,
			pagination : true,
			pageSize : 20,//每页显示的记录条数，默认为20 
			pageList : [ 20, 30, 50 ],//可以设置每页记录条数的列表
			url : '${AppContext.ctxPath}/action/portal/userMessage/queryMyMessagePage',
			onAddMoreButton: function(that, addButtonFun){
				addButtonFun(90,'<a href="javascript:void(0)" id="btn_reply" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="reply()">回复</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_remark" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="readSelections()">标记已读</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_remarkAll" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="readAll()">标记全部已读</a>',that);
			},
			
			rowStyler : function(index,row){    
				if (row.isRead != 'Y'){      
				 	return 'font-weight:blod';//文字样式不生效
					}    
		   		},
	   		onDblClickRow : function(index, row){
	   			//alert("ss");
	   			msgDetail(index,row);
			}
		});
		
		function detailFormatter(val, row){
			if(val == null){
				val = '';
			}
			return "<a href='###' onClick='msgDetail(\""+row.id+"\")'>"+val+"</a>";
		}
		
		function readSelections(){
			var selectRows = $datagrid.hdatagrid('getSelections');
			var ids = '';
			var ids1 = '';
			for(var i=0; i<selectRows.length; i++){
				var row = selectRows[i];
				if(row.sendById == appCtx.userId){
					ids1 += row.id;					
				}else if(row.isRead !='Y'){					
					ids +=row.id+',';
				}								
			}
			if(ids1.length > 0){
				$.messager.alert("操作提示", "不能标记发送人为当前用户已读！","warning");
			}else if(ids.length >0){
				setReadFlag(ids);
			}
			if(selectRows.length < 1){
				$.messager.alert("操作提示", "请至少选择一条数据进行标记！","warning");
			}
		}
		function readAll(){
			var allRows = $datagrid.hdatagrid('getRows');
			var ids = '';
			for(var i=0; i<allRows.length; i++){
				var row = allRows[i];
				if(row.isRead !='Y' && row.sendById != appCtx.userId)
					ids +=row.id+',';
			}
			if(ids.length >0){
				setReadFlag(ids);
			}
		}
		function setReadFlag(ids){
			/* $.ajax({
				async : false,
				data : {ids : ids},
				
			}) */
			
			$.post('${AppContext.ctxPath}/action/portal/userMessage/updateReadFlag',
					{ids : ids},
					function(data){
						if(data.success){
							$datagrid.hdatagrid("reload");
						}
						else{
							alert(data.result);
						}
					});
		}
		
		function msgDetail(id){
			//$.messager.confirm("msgId",val);
			var allRows = $datagrid.hdatagrid('getRows');
			var row;
			for(var i=0; i<allRows.length; i++){
				if(allRows[i].id == id){
					row = allRows[i];
					break;
				}
			}
			$fm.form('clear');
			$msgDlg.dialog('open').dialog('setTitle','消息明细');
		    //var row = $datagrid.hdatagrid("getSelected");
		    if(row.sendById != appCtx.userId){
		    	if(row.isRead != 'Y'){
			    	setReadFlag(row.id);
			    }
		    }
		    
			$fm.form('load',row);
		}
		
		function replyMsg(id){
			var allRows = $datagrid.hdatagrid('getRows');
			var row;
			for(var i=0; i<allRows.length; i++){
				if(allRows[i].id == id){
					row = allRows[i];
					break;
				}
			}
			$replyFm.form('clear');
			$replyMsg.dialog('open').dialog('setTitle','回复消息');
		    if(row.isRead != 'Y'){
		    	setReadFlag(row.id);
		    }
		    $replyFm.form('load',{
		    	msgTitle:'回复：'+row.msgTitle,
		    	userId : row.sendById,
		    	row_status : 'NEW',
		    	msgType :'回复消息',
		    	isRead : 'N',
		    	isSend: 'Y'
		    });
		}
		
		function reply(str){
			if(str == 'dlg-reply'){
				var id = $('#fm [name=id]').val(); 
				if(id){
					replyMsg(id);
					return;
				}
			}
			var row = $datagrid.hdatagrid('getChecked');		
			var row_msg = $datagrid.datagrid('getSelected');
			if(row.length != 1){
				$.messager.alert("操作提示", "请选择一条数据回复！","warning");
			}else if(row_msg.sendById == appCtx.userId){
				$.messager.alert("操作提示", "不能对自己发出的消息进行回复！","warning");
			}else{
				replyMsg(row_msg.id);
			}		
		}
		
		function send(){
			if(!$replyFm.form('validate')){
				return;
			}
			$replyFm.form('submit',{
				url: '${AppContext.ctxPath}/action/portal/message/messageReplyInsert',
			    onSubmit: function(param){},
			    success:function(){
			        $replyMsg.dialog("close");
			    }
			});
			$datagrid.datagrid("reload");
		}
	</script>
</body>
</html>