<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<body style="margin:0 0 0 0;">
	<div class="easyui-layout" data-options="fit:true" border="false">
				<div data-options="region:'west',split:false" style="width:48%;height:100%;border-top:0px;border-left:0px;border-bottom:0px;">
					<table id="peopleForSelect"  rownumbers="true" >
						<thead>
							<tr>
								<th field="id" checkbox="true">参与人id</th>
								<th field="fatName" width="30%">参与人名字</th>
								<th field="empMail" width="30%">参与人邮件</th>
							</tr>
						</thead>
					</table>
				</div>
				
			    <div data-options="region:'center',split:false" border="false" style="width:3%;height:100%;">
					 <br/><br/><br/><br/>
					 <div style="margin:0 auto;text-align:center;">
						<p><input type="button" id="addPeople" class="btn" value="&nbsp;>&nbsp;" onclick="addPeople()" title="移动选择项到右侧"/></p><br/>
						<p><input type="button" id="removePeople" class="btn" value="&nbsp;<&nbsp;" onclick="removePeople()" title="移动选择项到左侧"/></p>
					 </div>
				</div>
				
				<div data-options="region:'east',split:false"  style="width:47%;height:100%;border-top:0px;border-right:0px;border-bottom:0px;">
						<table id="peopleSelected"  rownumbers="true" >
								<thead>
									<tr>
										<th field="id"  checkbox="true">参与人id</th>
										<th field="fatName" width="30%">参与人名字</th>
										<th field="empMail" width="30%">参与人邮件</th>
									</tr>
								</thead>
					    </table>
				</div>	
	</div>
	<script type="text/javascript">
	var leftTable = $('#peopleForSelect');
	var rightTable = $('#peopleSelected');
	var noteId = getUrlParams("id");
	leftTable.hdatagrid({
		height:'100%',
		title:'可选',
		singleSelect:false,
		checkOnSelect:true,
		selectOnCheck:true,
		selectFirstRow:false,
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		url:'${AppContext.ctxPath}/action/portal/forum/peopleList'
	});
	
	rightTable.hdatagrid({
		height:'100%',
		title:'已选',
		singleSelect:false,
		checkOnSelect:true,
		selectOnCheck:true,
		selectFirstRow:false,
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		url:'${AppContext.ctxPath}/action/portal/forum/peopleOfForumList/'+noteId,
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/forum/batchUpdate",
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
		},
		onAddMoreButton:function(that,addButtonFun){
		},
		onDeleteAction:function(row,successFun,errFun,that){
		},
		onInitNewData:function(that){
		}
	});
	function addPeople(){
		var rows = leftTable.datagrid('getSelections');
		if(rows!=null){
			for(var i = 0; i < rows.length; i++){
				var row = rows[i];
				delete row.endRow;
				delete row.startRow;
			}
			$.ajax({url:'${AppContext.ctxPath}/action/portal/forum/forumPeopleInsert',
					type : "POST", 
				    dataType:"json",
				    contentType:'application/json;charset=UTF-8',
					data:JSON.stringify({id:noteId,peopleList:rows}),
					success:function(data){
						if(data.success){
							rightTable.hdatagrid("reload");
						}else{
							$.messager.alert("操作提示", data.result,"error");
						}
						
					}
			});
		}
	}	
	function removePeople(){
		var rows = rightTable.datagrid('getSelections');
		if(rows!=null){
			for(var i = 0; i < rows.length; i++){
				var row = rows[i];
				delete row.endRow;
				delete row.startRow;
			}
			$.ajax({url:'${AppContext.ctxPath}/action/portal/forum/forumPeopleDelete',
					type : "POST", 
				    dataType:"json",
				    contentType:'application/json;charset=UTF-8',
					data:JSON.stringify({id:noteId,peopleList:rows}),
					success:function(data){
						if(data.success){
							rightTable.hdatagrid("reload");
						}else{
							$.messager.alert("操作提示", data.result,"error");
						}
						
					}
			});
		}
		
	}
</script>
</body>

</html>