<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',collapsible:false,tools:[
							{
								iconCls:'icon-save',
								handler:function(){saveOptyInfo()}
							}]"title="商机基本信息" border="false" style="width: 90%; height: 200px; padding: 0px;">
		<form id="optyForm" method="post">
			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">商机编码：</label> 
					<input class="easyui-textbox form-control" disabled="true" name="id" id="id" value="${opty.id}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">商机名称：</label> 
					<input class="easyui-textbox form-control" name="optyName" id="optyName" value="${opty.optyName}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">客户名称：</label> 
					<input class="easyui-textbox form-control" name="accnt" id="accnt" value="${opty.accnt}"/> 
					<input hidden="true" name="accntId" id="accntId" value="${opty.accntId}"/>
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">联系人名称：</label> 
					<input class="easyui-textbox form-control" name="contact" id="contact" value="${opty.contact}"/> 
					<input hidden="true" name="contactId" id="contactId" value="${opty.contactId}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">商机阶段：</label> 
					<input lov="ACTIVATED" data-options="{ valueField:'name',
										textField:'name',
										url:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_STAGE',
										editable:false,
										required:true}",
						class="easyui-combobox form-control" name="stage" id="stage" value="${opty.stage}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">预计销售金额：</label> 
					<input class="easyui-textbox form-control" name="amount" id="amount" value="${opty.amount}"/>
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">预计签单时间：</label> 
					<input class="easyui-datebox form-control" name="startDt" id="startDt" value="${opty.startDt}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">商机收集时间：</label> 
					<input class="easyui-datebox form-control" name="optyDt" id="optyDt" value="${opty.optyDt}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">商机类型：</label> 
					<input data-options="{valueField:'name',
										textField:'name',
										method:'get',
										url:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_TYPE_CD',
										editable:false,
										required:true}"
						class="easyui-combobox form-control" name="typeCd" id="typeCd" value="${opty.typeCd}"/>
				</div>
			</div>

			<div class="row row-control">
				<div class="col-xs-3">
					<label class="input-label">商机来源：</label> 
					<input data-options="{	valueField:'name',
										textField:'name',
										method:'get',
										url:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_SOURCE',
										editable:false,
										required:true}"
						class="easyui-combobox form-control" name="source" id="source" value="${opty.source}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">成交概率：</label> 
					<input data-options="{	valueField:'name',
										textField:'name',
										method:'get',
										url:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_SUCCESS_RATE',
										editable:false,
										required:true}"
						class="easyui-combobox form-control" name="rate" id="rate" value="${opty.rate}"/>
				</div>
				<div class="col-xs-3">
					<label class="input-label">销售人员：</label> 
					<input class="easyui-textbox form-control" name="emp" id="emp" value="${opty.emp}"/> 
					<input hidden="true" name="empId" id="empId" value="${opty.empId}"/>
				</div>
			</div>
			<input type="hidden" id="rowid" name="id"/>
			<input type="hidden" id="rowstatus" name="row_status" />
			<div class="row row-control">
				<div class="col-xs-9">
					<label class="input-label-9">备注：</label> 
					<input class="easyui-textbox form-control-9" name="comments" id="comments" value="${opty.comments}"/>
					<input hidden="true" name="orgId" id="orgId" value="${opty.orgId}"/>
					<input hidden="true" name="postnId" id="postnId" value="${opty.postnId}"/>
				</div>
			</div>
		</form>
	</div>
	
	<div data-options="region:'center',fit:true,split:true,collapsible:false" border="false" style="width: 100%;">
		<div class="easyui-tabs" data-options="fit:true">
			<div title="产品信息列表" data-options="fit:true" border="false">
				<table id="opty-prod-table"  style="height: 340px;width: 100%">
					<thead>
						<th field="prodCode" width="20%">产品编码</th>
						<th field="prodName" width="30%">产品名称</th>
						<th field="price" currency="CNY" width="20%">单价</th>
						<th field="qty" width="10%" editor="{type:'numberspinner'}">数量</th>
						<th field="amount" currency="CNY" width="15%" >金额</th>
					</thead>
				</table>
			</div>
			<div title="活动信息列表" data-options="fit:true" border="false">
				<table id="opty-activity-table" style="height: 350px;">
					<thead>
						<th field="id" width="100px">活动编码</th>
						<th field="type" width="80px" lov="TUDO_CD" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('TUDO_CD'),
																		editable:false,
																		required:true}}"sortable="true">活动类型</th>
						<th field="important" width="50px"  sortable="true" lov="ACTIVITY_IMPORTANT" editor="{type:'combobox',options:{valueField:'val',
																				textField:'name',
																				method:'get',
																				data:getLovArray('ACTIVITY_IMPORTANT'),
																				editable:false,
																				required:true}}">重要性</th>
						<th field="status" width="80px" sortable="true" lov="EVT_STAT_CD" editor="{type:'combobox',options:{valueField:'val',
																				textField:'name',
																				method:'get',
																				data:getLovArray('EVT_STAT_CD'),
																				editable:false,
																				required:true}}">活动状态</th>
						<th field="description" width="230px" editor="{type:'validatebox'}">活动内容</th>
						<th field="planStartDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">计划开始时间</th>
						<th field="planEndDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">计划结束时间</th>
						<th field="actlStartDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">实际开始时间</th>
						<th field="actlEndDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">实际结束时间</th>
						<th field="accntName" width="120px"  editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'}}">客户名称</th>
		                <th field="contactsName" width="80px"  editor="{type:'picklistbox',options:{title:'选择联系人',initParam:initContactPicklistParam,completeFun:contactPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/contactPickList.jsp'}}">联系人</th>
					</thead>
				</table>
			</div>
			<div title="附件列表" data-options="fit:true" border="false">
				<table id="attachment-table" style="height: 350px;">
					<thead>
						<tr>
							<th field="attachmentOriginal" width="120px" formatter="attachmentOriginalFormatter">附件名称</th>
							<th field="attachmentSize" width="120px">大小（字节）</th>
							<th field="created" width="120px">上传时间</th>
							<th field="comments" width="120px">备注</th>
						</tr>
					</thead>
				</table>
				<!-- ------------------------上传附件弹出框：开始----------------------------  -->
				<div id="upload_attachment" >
					<div class="easyui-layout" data-options="fit:true">
						<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;">
							<form method="post" class="uploadAttachmentForm" style="text-align:center;margin-top: 30px;" enctype="multipart/form-data" >
								<input type='file' name='uploadAttachment' style="display: none;"/>
								文件：
								<input id="openFile" class="easyui-textbox" data-options="buttonText:'浏览',
												         							  buttonIcon:'icon-search',
												         							  prompt:'请选择文件...',
												         							  editable:false,
												         							  width:'200px',
												         							  height:'30px',
												         							  onClickButton: function(){
												         							  	$('#upload_attachment input[name=uploadAttachment]').click();
																					}"/>
								<br/><br/>类型：
								<input name="documentType" class="easyui-combobox" data-options="valueField:'name',
																						textField:'name',
																						width:'200px',
												         							  	height:'30px',
																						method:'get',
																						url:'${AppContext.ctxPath}/action/portal/basic/list/DOCUMENT_TYPE',
																						editable:false,
																						required:true"/>
								<br/><br/>备注：
								<input id="comments" name="comments" class="easyui-textbox" data-options="multiline:true,
												         							  prompt:'请填写附件备注...',
												         							  width:'200px',
												         							  height:'90px'"/>
							</form>
						</div>
						<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
							<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="uploadAttachment()">上传</a>
							<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadAttachmentDiv.window('close')">取消</a>
						</div>
					</div>
				</div>
				<!-- ------------------------上传附件弹出框：结束----------------------------  -->
			</div>
		</div>
	</div>
  </div>
	<script type="text/javascript">
	var optyId = '${opty.id}';
	$prodDatagrid = $('#opty-prod-table');
	$activityDatagrid = $('#opty-activity-table');
	$dataAttachmentgrid = $('#attachment-table');
	getLovOfList("[TUDO_CD,ACTIVITY_IMPORTANT,EVT_STAT_CD]");
	$optyForm = $("#optyForm");
	var row_status = "NEW";              //行记录操作状态：NEW
	$('#accnt').picklist({
		title:'选择客户',
		completeFun:function(selectRow){
			$('#accntId').val(selectRow.id)
			return selectRow.acctName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp'
	});
	
	$('#contact').picklist({
		title:'选择联系人',
		initParam:function(){
			var accntId = $('#accntId').val();
			if(accntId == null || accntId == ''){
				return {id:'noMatchId'};
			}else{
				return {id:accntId};
			}
		},
		completeFun:function(selectRow){
			$('#contactId').val(selectRow.id)
			return selectRow.contactsName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/contactPickList.jsp'
	});
	
	$('#emp').picklist({
		title:'选择销售人员',
		completeFun:function(selectRow){
			$('#empId').val(selectRow.id)
			return selectRow.firstName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/employeePickList.jsp'
	});
	
	var headerUpdateFlag = false;//按钮锁标志，防止按钮被重复点击
	function saveOptyInfo(){
		if($('optyName').val() == ""){
			$.messager.alert('警告','商机名称不能为空'); 
			return;
		}
		if($('#accnt').picklist('getValue') == ""){
			$.messager.alert('警告','客户不能为空'); 
			return;
		}
		if($('#contact').picklist('getValue') == ""){
			$.messager.alert('警告','联系人不能为空'); 
			return;
		}
		if($('#source').combobox('getValue') == ""){
			$.messager.alert('警告','商机来源不能为空'); 
			return;
		}
		/*   
		$("#optyForm").form("submit",{
			url:"${AppContext.ctxPath}/action/portal/opty/upsert",
		    onSubmit: function(param){
		    	param.id = '${opty.id}';
		    	param.row_status = '${opty.row_status}';
		    },
		    success:function(){
		    	var data = eval('(' + data + ')'); // change the JSON string to javascript object
		    	$.messager.alert("提示",'保存成功！');
			    gotoContentPage('${AppContext.ctxPath}/portal/opty/optyList.jsp');	    	
		    }
		});
		 */
		if(headerUpdateFlag){
			return;
		}
		 
		$("input[name='rowid']").attr("value",optyId);   //商机ID
		$("input[id='rowstatus']").attr("value",row_status);   //更新或新增操作
		headerUpdateFlag = true;
		if($optyForm.form('validate')){ 
			var options = {
					url : '${AppContext.ctxPath}/action/portal/opty/upsert',
					type : 'post',
					dataType :'json',
					success : function(data) {
						if (!data.success) {
							optyHeadEnable();
							window.parent.operationtip(data.result, 'error');
							errFun(data.result, that);
							headerUpdateFlag = false;
						} else {
							optyHeadDisable();
							window.parent.operationtip('保存成功！', 'info');
							headerUpdateFlag = false;
							goBack();
						} 
						
					}
				};
			$("#optyForm").ajaxSubmit(options);
		}
	}
	
	$prodDatagrid.hdatagrid({
		queryParams:{
			optyId:optyId
		},
		updateable:true,
		buttonDelete:true,
		toolbarShow : true,
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(91,'<a id="selectProdBtn" href="javascript:void(0)" class="easyui-linkbutton" onClick="selectProdWindow()" iconCls="icon-add" plain="true">选择产品</a>',that);
		},
		url : '${AppContext.ctxPath}/action/portal/optyItem/queryByExamplePage',
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			if(optyId == null){
				$.messager.alert('警告','获取商机Id失败,请刷新页面重试！');
			}
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id			:row.id,
						prodId		:row.prodId,
						optyId		:optyId,
						price		:row.price,
						qty			:row.qty
				}
				rows_2.push(row_2);
			}
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/optyItem/batchUpdate",
				type:"post",
				data:JSON.stringify(rows_2),
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
			if(optyId == null){
				$.messager.alert('警告','获取商机Id失败,请刷新页面重试！');
			}
			$.post('${AppContext.ctxPath}/action/portal/optyItem/upsert', {
				row_status  : row.row_status,
				id			:row.id,
				prodId		:row.prodId,
				optyId		:optyId,
				price		:row.price,
				qty			:row.qty
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/optyItem/deleteById', {
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
		onLoadSuccess:function(data) {
		}
	});
	$activityDatagrid.hdatagrid({
		queryParams:{
			optyId:optyId
		},
		updateable:true,
		toolbarShow:true,
		buttonSearch:false,
		buttonNew:true,
		buttonDelete:true,
		buttonCopy:true,
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/opty/queryActivityPage',
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			if(optyId == null){
				$.messager.alert('警告','获取商机Id失败,请刷新页面重试！');
			}
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id			:row.id,
						description	:row.description,
						important	:row.important,
						type		:row.type,
						status		:row.status,
						comments	:row.comments,
						actlEndDt	:row.actlEndDt,
						actlStartDt	:row.actlStartDt,
						planEndDt	:row.planEndDt,
						planStartDt	:row.planStartDt,
						optyId		:'${opty.id}',
						accntId		:row.accntId,
						empId		:row.empId,
						contactId	:row.contactId	
				}
				rows_2.push(row_2);
			}
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/opty/batchUpdate",
				type:"post",
				data:JSON.stringify(rows_2),
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
			if(optyId == null){
				$.messager.alert('警告','获取商机Id失败,请刷新页面重试！');
			}
			$.post('${AppContext.ctxPath}/action/portal/activity/activityInsertOrUpdate', {
				row_status  : row.row_status,
				id			:row.id,
				description	:row.description,
				important	:row.important,
				type		:row.type,
				status		:row.status,
				comments	:row.comments,
				actlEndDt	:row.actlEndDt,
				actlStartDt	:row.actlStartDt,
				planEndDt	:row.planEndDt,
				planStartDt	:row.planStartDt,
				optyId		:'${opty.id}',
				accntId		:row.accntId,
				empId		:row.empId,
				contactId	:row.contactId	
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					//successFun(that, data);
					optyId = '${opty.id}';
					$activityDatagrid.datagrid('reload', {'optyId':optyId});
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/activity/delActivityById', {
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
		onLoadSuccess:function(data) {
		}
	});
	
	function accntPicklistComplete(selectRow){
		$activityDatagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
		return selectRow.acctName;
	}
	
	function contactPicklistComplete(selectRow){
		$activityDatagrid.hdatagrid('getCurrentRow').contactId = selectRow.id;
		return selectRow.contactsName;
	}
	
	//初始化联系人客户Id
	function initContactPicklistParam(){
		var accntId = $activityDatagrid.hdatagrid('getCurrentRow').accntId;
		if(accntId == null || accntId == ''){
			return {id:'noMatchId'};
		}else{
			return {id:accntId};
		}
	}
	
	function selectProdWindow(){
		$('#selectProdBtn').multiSelect({
			title:'选择产品',
			completeFun:function(selectedRow){
				var prodRecords = [];
				for(var i =0; selectedRow != null && i<selectedRow.length;i++){
					prodRecords.push({
						prodId:selectedRow[i].id,
						optyId:'${opty.id}',
						price:selectedRow[i].price,
						qty:1
					});
				}
				$.ajax({	
						type: "POST",
			            url: "${AppContext.ctxPath}/action/portal/optyItem/batchInsert",
			            data: JSON.stringify(prodRecords),
			            dataType: "json",	
			            contentType: 'application/json', 
			            success:function(data){
							if(data.success){
								$prodDatagrid.datagrid('reload', {'optyId':optyId});
							}else{
								$.messager.alert("警告",data.result);
							}
						}
				});
			},
			initParam:function(){
				return {optyId:optyId};
			},
			tableUrl:'${AppContext.ctxPath}/portal/opty/dialog/productMultiSelect.jsp'
		});
	}
	/* --------------------附件列表：开始------------------------------ */
	$dataAttachmentgrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		buttonDelete:true,
		striped:true,
		border:false,
		url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		queryParams:{id : optyId},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(39,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment()">新建</a>',that);
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/attachment/deleteById', {
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
		onLoadSuccess:function(data) {	
		}
	});
	$uploadAttachmentDiv = $('#upload_attachment');
	function openUploadAttachment(){
		$uploadAttachmentDiv.dialog({
			title:'上传附件',
			iconCls:'icon-add',
		    width:'400px',
		    height:'400px',
		    closable:false,
		    minimizable:false,
		    collapsible:false,
		    modal:true,
		    closed:true
		});
		clearDiv();
		$uploadAttachmentDiv.window('open');
	}
	/**
	 * 清空弹出框内容
	 */
	function clearDiv(){
		$('input[name=uploadAttachment]',$uploadAttachmentDiv).val('');
		$('#comments',$uploadAttachmentDiv).textbox('setValue','');
		$('#openFile',$uploadAttachmentDiv).textbox('setValue', '');
	}
	$('input[name=uploadAttachment]',$uploadAttachmentDiv).change(function(){
		var fileName = $('input[name=uploadAttachment]',$uploadAttachmentDiv).val();
		$('#openFile').textbox('setValue', fileName);
	});
	function uploadAttachment(){
		if(!optyId){
			$.messager.alert("警告","获取商机Id失败,请刷新页面重试！");
			return;
		}
		$.messager.progress();
		var options = {
   				url:'${AppContext.ctxPath}/action/portal/attachment/insert',
   				type:'post',
				data : formatRequest({
							headId 		: optyId,
							moduleType 	: 'Opportunity',
							headCode 	: optyId,
							headName 	: $('#optyName').textbox('getValue')
						}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					if (data.success) {
						$.messager.progress('close');
						$.messager.alert("提示", "上传成功！");
						$dataAttachmentgrid.datagrid('reload');
						$uploadAttachmentDiv.window('close');
					} else {
						if (data.result == null) {
							data.result = "上传失败！";
						}
						$.messager.alert("警告", data.result);
					}
				}
		};
		$('.uploadAttachmentForm', $uploadAttachmentDiv).ajaxSubmit(options);
	}
		/**
		 * 格式化URL请求参数
		 */
		function formatRequest(data) {
			for ( var filed in data) {
				if (typeof (data[filed]) == "object") {
					data[filed] = JSON.stringify(data[filed]);
				} else if (typeof (data[filed]) == "Array") {
					data[filed] = JSON.stringify(data[filed]);
				}
			}
			return data;
		}
		function attachmentOriginalFormatter(val, row) {
			if (val != null) {
				var content = "点击下载";
				return "<a href='###' class='easyui-tooltip' title='"
				+ content + "' onclick='window.open(\"" + row.attachmentPath + "\")'>" + val + "</a>";
			}
		}
	/* --------------------附件列表：结束------------------------------ */
	</script>
</body>
</html>