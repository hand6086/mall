<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file = "/portal/header.jsp" %>

<title>通知消息</title>
</head>
<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:50%;padding:0px;">
   <table id="message-table"  width="100%" height="100%" >
		<thead>
			<tr>
				<th field="id" width="80px" sortable="true">消息ID</th>
				<th field="msgType" width="100px" sortable="true">消息类型</th>
				<th field="msgReceiveType" width="230px" sortable="true" editor="{type:'textbox'}">消息接收对象类型</th>
				<th field="importance" lov="ACTIVITY_IMPORTANT" width="80px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('ACTIVITY_IMPORTANT'),
																		editable:false,
																		required:true}}" defaultSearch="true">重要性</th>
				<th field="isSend" width="100px"  noSearch="true">已发送</th>
				<th field="msgTitle" width="100px" editor="{type:'textbox'}">消息标题</th>
				<th field="msgContent" width="400px" editor="{type:'textarea'}">消息内容</th>
				<th field="sendBy" width="100px">发送人</th>
				<th field="sendTime" width="200px">发送时间</th>
			</tr>
		</thead>
	</table>
</div>

<div data-options="region:'center'" border="false" style="width:100%;height:50%;padding:0px;">
		<table id="receiver-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="userId" width="25%" sortable="true">用户ID</th>
					<th field="userName" defaultSearch="true"  width="100px">用户名</th>
					<th field="firstName" width="100px">姓名</th>
					<th field="isRead" width="100px" >已读标记</th>
					<th field="readTime" width="200px">阅读时间</th>
			   </tr>
			</thead>
		</table>
	</div>
<script type="text/javascript">
	$datagrid = $('#message-table');
	$receivergrid= $('#receiver-table');
	getLovOfList("[ACTIVITY_IMPORTANT]");
	$datagrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		oauthFlag:true,
		striped:true,
		border:false,
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/message/queryByExamplePage',
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(91,'<a href="javascript:void(0)" id="btn-removeMessage" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeMessage()">删除</a>',that);
			addButtonFun(92,'<a href="javascript:void(0)" id="btn-send" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="send()">发送</a>',that);
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/message/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
			$.post("${AppContext.ctxPath}/action/portal/message/upsert",row, 
			function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		//选中一条消息记录，刷新接收方列表
		onChangeSelectedItem:function(row){
			$receivergrid.hdatagrid("changeParentItemAndParams",{msgId:row.id});
			refreshMsgToolBar();
		},
		onLoadSuccess:function(data){
			if(data.rows.length > 0){
				$datagrid.hdatagrid('selectRow', 0);
				var row = $datagrid.hdatagrid('getSelected');
				$receivergrid.hdatagrid('options').url = "${AppContext.ctxPath}/action/portal/userMessage/queryByExamplePage";
				//$receivergrid.hdatagrid('load',{msgId:row.id});
				$receivergrid.hdatagrid("changeParentItemAndParams",{msgId:row.id});// 自扩展功能，参数会重新包装
			}
			else{
				//$receivergrid.hdatagrid('load',{msgId:'no_data_id'});
				$receivergrid.hdatagrid("changeParentItemAndParams",{msgId:'no_data_id'});
			}
			refreshMsgToolBar();
	    },
		onInitNewData : function(that){
		return {
			isSend : 'N',
			msgType : '消息'
		};
		}
	});
	
	function removeMessage(row,successFun,errFun,that){
		var row = $datagrid.hdatagrid('getSelected');
		if(row.isSend != 'Y'){
			$.messager.confirm("操作提示", "是否确定删除信息？", function(data){
				if(data){
					$.post("${AppContext.ctxPath}/action/portal/message/deleteById",{
						id : row.id
					}, function(data){
						if(!data.success){
							$.messager.alert(data.result, 'error');
						}
						$datagrid.hdatagrid('reload');
					});
				}
			});	
		}
	}
	function send(){
		var row = $datagrid.hdatagrid('getSelected');
		row.isSend = 'Y';
		$.post("${AppContext.ctxPath}/action/portal/message/upsert",row, 
				function(data){
			if(data.success){
				var index = $datagrid.hdatagrid('getRowIndex', row);
				row.isSend = 'Y';
				$datagrid.hdatagrid("refreshRow", index);
				refreshMsgToolBar();
				$receivergrid.hdatagrid("changeParentItemAndParams",{msgId:row.id});
				$datagrid.datagrid('reload');
			}else{
				alert("error");
			}
		});
	}
$receivergrid.hdatagrid({
	//updateable:true,
	toolbarShow:true,
	buttonSearch:true,
	//buttonNew:true,
	//buttonDelete:true,
	striped:true,
	title:'消息接收用户列表',
	border:false,
	pageSize: 10, 
    pageList: [5,10,15],
   	onDeleteAction: function(row, successFun, errFun, that){
   		$.messager.confirm("操作提示", "是否确定删除信息？", function(data){
   			if(data){
   				$.post("${AppContext.ctxPath}/action/portal/userMessage/deleteById",{
   					id : row.id
   				}, function(data){
   					if(!data.success){
   						errFun(data.result, that);
   					}else{
   						successFun(that, data);
   					}
   				});//post
   			}
   		})
   		},
   		
   		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(91,'<a href="javascript:void(0)" id="btn-selectUser" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectUserWindow()">新建</a>',that);
			addButtonFun(92,'<a href="javascript:void(0)" id="btn-removeUser" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">删除</a>',that);
		},
		onChangeSelectedItem:function(row){
			refreshReceiverToolBar();
		}
    });
    
function selectUserWindow()
{
	var msgRecord = $datagrid.hdatagrid('getSelected');
	$('#btn-selectUser').multiSelect({
		title:'添加用户',
		initParam:function(){
			return {attr1 : msgRecord.id};
		},
		tableUrl:'${AppContext.ctxPath}/portal/message/dialog/userMultiSelect.jsp',
		completeFun:function(selectedRow){
			var msgRow = $datagrid.hdatagrid('getSelected');
			var records = [];
			for(var i =0; selectedRow != null && i<selectedRow.length;i++){
				records.push({
					rearObjId:selectedRow[i].id,
					preObjId:msgRow.id
				});
			}
			$.ajax({	
					type: "POST",
		            url: "${AppContext.ctxPath}/action/portal/userMessage/addUserOfMessage",
		            data: JSON.stringify(records),
		            dataType: "json",	
		            contentType: 'application/json', 
		            success:function(data){
						if(data.success){
							$receivergrid.hdatagrid("reload");
							//$receivergrid.hdatagrid("changeParentItemAndParams",{msgId : msgRow.id});
						}else{
							$.messager.alert(data.result, "警告");
						}
					}
			});
		}
	});
}
//删除消息接收用户
function removeUser(){
	var row  = $receivergrid.hdatagrid('getSelected');
	$.post("${AppContext.ctxPath}/action/portal/userMessage/deleteById",{
			id : row.id
		}, function(data){
			if(!data.success){
				$.messager.alert(data.result, "error");
			}else{
				$receivergrid.hdatagrid("reload");
			}
		});//post
}
//刷新子列表工具栏按钮
function refreshReceiverToolBar(){
	var row  = $receivergrid.hdatagrid('getSelected');
	if(row.isRead == 'Y'){
		$("#btn-removeUser").css("display", "none");
	}
	else{
		$("#btn-removeUser").css("display", "inline");
	}
}

function refreshMsgToolBar(){
	var row = $datagrid.hdatagrid('getSelected');
	if(row.isSend == 'Y'){
		$("#btn-send").css("display", "none");
		$("#btn-removeMessage").css("display", "none");
	}
	else{
		$("#btn-send").css("display", "inline");
		$("#btn-removeMessage").css("display", "inline");
	}
}
</script>
</body>
</html>