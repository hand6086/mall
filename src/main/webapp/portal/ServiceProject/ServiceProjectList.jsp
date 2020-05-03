<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">


</style>

<body>

  <div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false" fit="true">

		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">快速筛选</span>
			</legend>

			<div class="row keyfilter-border">
				<ul id="attr02Keyfilter" data-toggle="keyfilter" data-title="项目名称"
					data-filter-filed="projName" data-table-Id="ServiceProject-table"></ul>
			</div> 

			<div class="row keyfilter-border">
				<ul id="statusKeyfilter" data-toggle="keyfilter" data-title="状态"
					data-filter-filed="status" data-table-Id="ServiceProject-table"></ul>
			</div>
<!--  
			<div class="row keyfilter-border">
				<ul id="priorityLevelKeyfilter" data-toggle="keyfilter"
					data-title="优先级" data-filter-filed="priorityLevel"
					data-table-Id="ServiceProject-table"></ul>
			</div>
			-->
			<div class="row keyfilter-border">
				<ul id="attr06Keyfilter" data-toggle="keyfilter"
					data-title="任务类型" data-filter-filed="attr06"
					data-table-Id="ServiceProject-table"></ul>
			</div>




		</fieldset>
		
		<table id="ServiceProject-table" fit="true"
			keyFilterDiv="keyFilter">
			<thead>
				<tr>
				<!--  
					<th field="id" width="60px">编号</th>-->
					<th field="created" width="120px">创建时间</th>
					<!--<th field="createdByName" width="60px">创建人</th>-->
					<!-- <th field="attr02" width="140px" defaultSearch="true" lov="LNK_SRPRO_PROJECT"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('LNK_SRPRO_PROJECT'),editable:false,required:true}}">项目名称</th> -->
					<th field="projName" width="140px"  defaultSearch="true"
												   editor="{type:'picklistbox',options:{title:'项目名称',
												   			oauthFlag:false,
															initParam:initProjPicklistParam,
															completeFun:projPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/SrproProjectPickList.jsp',
															required:true}}">项目名称</th> 
<th field="attr06" width="80px" lov="LNK_SRPROJ_TYPE"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('LNK_SRPROJ_TYPE'),editable:false,required:true}}">类型</th>
					<th field="abstracts" width="600px"
						editor="{type:'textarea',options:{required:true}}">内容</th>
					<th field="status" width="60px" lov="SERVICE_STATUS"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('SERVICE_STATUS'),editable:false,required:true}}">状态</th>
					<th field="priorityLevel" width="60px" lov="SER_PRIORITY_LEVEL"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('SER_PRIORITY_LEVEL'),editable:false,required:true}}">优先级</th>
					<th field="severityLevel" width="60px" lov="SER_SEVERITY_LEVEL"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('SER_SEVERITY_LEVEL'),editable:false,required:true}}">严重性</th>
					<!-- <th field="attr01" width="100px" defaultSearch="true" lov="LNK_SRPRO_PERSON"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('LNK_SRPRO_PERSON'),editable:false,required:true}}">责任人</th>
					<th field="attr03" width="100px" defaultSearch="true" lov="LNK_SRPRO_PERSON"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('LNK_SRPRO_PERSON'),editable:false,required:true}}">提出人</th> -->
					 
					 <th field="pFirstName" width="80px" editor="{type:'picklistbox',options:{title:'提出人',
					 										oauthFlag:false,
			         										initParam:initRespPicklistParam,
															completeFun:srproPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/RespPersonPickList.jsp',
															required:true}}">提出人</th> 
															
					 <th field="rFirstName" width="80px" defaultSearch="true" editor="{type:'picklistbox',options:{title:'责任人',
					 										oauthFlag:false,
					 									 	initParam:initRespPicklistParam,
															completeFun:respPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/RespPersonPickList.jsp',
															required:true}}">责任人</th> 
					<th field="temp_onclick" width="60px" formatter="spFollower">项目跟进</th>
											 
					<th field="startdt" width="100px" 
						editor="{type:'datebox',options:{showSeconds:false}}">开始日期</th>
					<th field="enddt" width="100px" 
						editor="{type:'datebox',options:{showSeconds:false}}">结束日期</th>


					<th field="attr05" width="60px" 
						editor="{type:'textbox',options:{required:true}}">百分比</th>
					<th field="pubStatus" width="100px" lov="PUBLISH_STATUS" editor="{type:'combobox',
																					options:{valueField:'val',
																					textField:'name',
																					method:'get',
																					data:getLovArray('PUBLISH_STATUS'),
																					editable:false}}">发布状态</th>
					<th field="pubTime" width="100px"
						editor="{type:'datebox',options:{showSeconds:false}}">发布时间</th>
					<th field="relateObject" width="100px"
						editor="{type:'textbox',options:{required:false}}">相关对象</th>
					<th field="comments" width="200px"
						editor="{type:'textarea',options:{required:false}}">备注</th>
					

				</tr>
			</thead>
		</table>
	</div>
  </div>
    <!-- 弹出窗2 -->
    <div id="editWin" class="easyui-window" style="width:100%;height:100%"
    data-options="iconCls:'icon-save'">
    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="95%" frameborder="0" scrolling="no" >
    </iframe>
    </div>
	<script type="text/javascript">
		var oldRow;
		var loginName;
		$readOnlyWin = $("#readOnlyWin");
		$readOnlyWinFram = $("#readOnlyWinFram");
		$editWin = $("#editWin");
		$editWinFram = $("#editWinFram");
		$editWin.window({
			title: "跟进",
			top: 0,
			width:"60%",
			//height:"100%",
			closed:true,
			border:false,//边框
			shadow:false,
			draggable:false,//拖曳
			minimizable:false,//最小化按钮
			maximizable:false,
			resizable: false,//改变大小
			modal:true,//模态窗口
		
			onClose: function(){
			}
		});
		$datagrid = $('#ServiceProject-table');
		getLovOfList("[LNK_SRPRO_PROJECT,SERVICE_STATUS,SER_PRIORITY_LEVEL,SER_SEVERITY_LEVEL,LNK_SRPRO_PERSON,PUBLISH_STATUS]");
		$datagrid
				.hdatagrid({
					title : '',
					pageSize : 100,//每页显示的记录条数，默认为20 
					pageList : [ 100, 200, 500 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : false,
					//newDefaultValue : true,
					oauthFlag:true,
					striped : true,
					border : false,
					url : '${AppContext.ctxPath}/action/portal/ServiceProject/queryByExamplePage',
					onBeforeLoad:function(param){
						param.noTotal=true;
						/* param.attr4 = appCtx.userId; */
					},
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/ServiceProject/batchUpdate",
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
					onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {
						/* $datagrid.hdatagrid('getCurrentRow').attr4 = appCtx.userId;//更新记录后光标定位到当前行 */
						oldRow = $datagrid.data().datagrid.originalRows[$datagrid.datagrid('getRowIndex',$datagrid.datagrid('getSelected'))]
						$.post(
										'${AppContext.ctxPath}/action/portal/ServiceProject/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
						/* 
						$.post(  
								'${AppContext.ctxPath}/action/portal/ServiceProject/pushmsg',
								{'abstracts':row.abstracts,'oldAbstracts':oldRow.abstracts,
									 'rFirstName':row.rFirstName,'oldrFirstName':oldRow.rFirstName,
									 'pFirstName':row.pFirstName,'oldpFirstName':oldRow.pFirstName,
									 'attr01':row.attr01,'oldAttr01':oldRow.attr01,
									 'attr03':row.attr03,'oldAttr03':oldRow.attr03,
									 'status':row.status,'oldStatus':oldRow.status,
									 'priorityLevel':row.priorityLevel,'oldPriorityLevel':oldRow.priorityLevel,
									 'severityLevel':row.severityLevel,'oldSeverityLevel':oldRow.severityLevel,
									 'rowStatus':row.row_status,
									 'login':appCtx.userId,
									 'loginName':appCtx.firstName}, function(data) {
								});
 */
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager.confirm("操作提示",'是否确定删除信息？',function(data) {
							if (data) {
								$.post('${AppContext.ctxPath}/action/portal/ServiceProject/deleteById',
										{ id : row.id },
										function(data) {
											if (!data.success) {
												errFun(data.result,that);
											} else {
												successFun(that, data);
											}
										});
							}
						});
					},
					onChangeSelectedItem : function(row) {
						//$datagrid.hdatagrid("changeParentItemAndParams",{ServiceProjectId:row.id});
					},
					/**
					 * 初始化新建的数据
					 */
					onInitNewData : function(that) {
						return {
							created : appCtx.sysdate(),
							createdByName:appCtx.firstName,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							priorityLevel:'中',
							status:'新建',
							severityLevel:'中',
							attr10:'serviceProject',
							attr05:'0',
							attr06:'技术开发',
							postnName : appCtx.postnName,
						    pFirstName : appCtx.firstName,
						    attr03: appCtx.userId,
						    pubStatus:'NO PUBLISHED'
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="SetStatus(\'进行中\')" iconCls="icon-ok" plain="true">进行中</a>',that);
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="SetStatus(\'待测试\')" iconCls="icon-ok" plain="true">待测试</a>',that);
						addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="SetStatus(\'已完成\')" iconCls="icon-ok" plain="true">已完成</a>',that);
						//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editServiceProjectPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
						//addButtonFun(95,'<a id="mp" href="javascript:void(0)" class="easyui-linkbutton" onClick="manageProject()" iconCls="icon-generate" plain="true">项目管理</a>',that);
					}
				});

		/*$('#priorityLevelKeyfilter').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/SER_PRIORITY_LEVEL'
		});*/
		$('#statusKeyfilter').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/SERVICE_STATUS'
		});
		$('#attr02Keyfilter').keyFilter({
			remoteData : true,
			filterByValue : false,
			dataValue:'id',
			dataName:'projName',
			/*remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/LNK_SRPRO_PROJECT'*/
			remoteUrl : '${AppContext.ctxPath}/action/portal/project/projectlistvalbyuser'
		});
		$('#attr06Keyfilter').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/LNK_SRPROJ_TYPE'
		});
//
		var editFormatter = function(value, row, index) {
			return value;
		}
		
		function projPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').attr02 = selectRow.id;
			return selectRow.projName;
		}
		
		function srproPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').attr03 = selectRow.id;
			return selectRow.firstName;
		}
		
		function respPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').attr01 = selectRow.id;
			return selectRow.firstName;
		}
		
		function initRespPicklistParam(){
			var projIdValue = $datagrid.hdatagrid('getCurrentRow').attr02;
			if(projIdValue == null || projIdValue == ''){
				return {attr2:'noMatchId'};
			}else{
				return {attr2:projIdValue};
			}
		}
		function initProjPicklistParam(){
			return {userId:appCtx.userId}
		}
		function SetStatus(Status){
			var row = $datagrid.datagrid('getSelected');
			$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:Status});
		}
		function spFollower(val,row){
			val = '项目跟进';
			/* return "<a class='easyui-tooltip' title='"
			    		+"项目跟进："+row.abstracts+
			    		"' href='javascript:void(0)' onclick='windowShow(\""+row.id+"\")'>" + "项目跟进" + "</a>";  */
			//return "<a target='_blank' href='${AppContext.ctxPath}/portal/ServiceProject/ServiceProjectFollower.jsp?serviceId="+row.id+"'>" + '项目跟进' + "</a>";
			return "<a href='javascript:void(0)' onclick='windowShow(\""+row.id+"\")'>" + val + "</a>";
		} 
		function windowShow(id){
			$editWinFram.attr("src", "${AppContext.ctxPath}/portal/ServiceProject/ServiceProjectFollower.jsp?serviceId="+id);
			//$editWin.window("open");
			//'width='+(window.screen.availWidth-10)+',height='+(window.screen.availHeight-30);
			//var winheight=window.screen.availHeight-200;
			//var winwidth=window.screen.availWidth-200;
			//var loc='height='+winheight+',width='+winwidth+',top=80,left=100,alwaysRaised=yes,depended=yes,  toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no';
			window.open("${AppContext.ctxPath}/portal/ServiceProject/ServiceProjectFollower.jsp?serviceId="+id,'_blank');
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
		function ServiceProjectSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.ServiceProjectStatus == '新建'||row.ServiceProjectStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/ServiceProject/ServiceProjectSubmit', 
				{
					id	: row.id,
					ServiceProjectStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.ServiceProjectStatus+'，无法提交！', 'error');
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
