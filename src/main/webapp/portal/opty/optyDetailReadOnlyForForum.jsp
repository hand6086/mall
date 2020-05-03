<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">

/* -- td css start -- */
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
	width:120px;
}
.td-input{
	width:160px;
	height:30px;
	padding-left: 10px;
}
/* -- td css end -- */

.td-input-input{
	width:150px;
}
</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',collapsible:false,tools:[
							 {
								iconCls:'icon-undo',
								text:' 撤回',
								handler:function(){window.top.ForumOfModel.modelDetailGoBackToForum()}
							},
	                        {iconCls:'icon-reload',
								text:' 刷新',
								handler:function(){optyInfoInit()}
							}]"title="商机基本信息" border="false" style="width: 100%; height: 230px; padding: 0px;">
		<form id="optyForm" method="post">
			<table style="width:100%;">
				<tr>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>商机名称：</label></td>
								<td class="td-input">
									<input class="easyui-textbox td-input-input" name="optyName" id="optyName" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机阶段：</label></td>
								<td class="td-input">
				         			<input data-options="{ valueField:'name',
										textField:'name',
										data:getLovArray('OPTY_STAGE'),
										editable:false}"
										class="easyui-combobox td-input-input" name="stage" id="stage" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机状态：</label></td>
								<td class="td-input">
									<input data-options="{	valueField:'name',
															textField:'name',
															method:'get',
															data:getLovArray('OPTY_STATUS'),
															editable:false}"
						          		class="easyui-combobox td-input-input" name="status" id="status" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>交货地点：</label></td>
								<td class="td-input">
									 <input class="easyui-textbox td-input-input" name="deliverAddr" id="deliverAddr" />
								</td>
							</tr>
							<tr>
								<td class="td-label">
									<label>创建日期：</label>
								</td>
								<td class="td-input">
								    <input class="easyui-datebox td-input-input" disabled="disabled" name="created" id="created" />
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label">
									<label>客户名称：</label> 
								</td>
								<td class="td-input">
									<input class="easyui-textbox td-input-input" name="accnt" id="accnt" /> 
									<input hidden="true" name="accntId" id="accntId" />
								</td>
							</tr>
							<tr>
									<td class="td-label">
										<label>商机地点：</label>
									</td>
									<td class="td-input">
										 <input class="easyui-textbox td-input-input" name="optyAddr" id="optyAddr" /> 
									</td>
							</tr>			
							<tr>
									<td class="td-label">
										<label>商机来源：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'name',
														textField:'name',
														method:'get',
														data:getLovArray('OPTY_SOURCE'),
														editable:false
														}"
										class="easyui-combobox td-input-input" name="source" id="source" />
									</td>
							</tr>
							<tr>
								<td class="td-label">
									<label>预计销售金额：</label>
								</td>
								<td class="td-input">
									<input class="easyui-textbox td-input-input" name="amount" id="amount" />
								</td>
							</tr>							
							<tr>
								<td class="td-label">
									<label>跟进截止时间：</label>
								</td>
								<td class="td-input">
									<input class="easyui-datebox td-input-input"  name="deadline" id="deadline" />
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
								<tr>
									<td class="td-label">
										<label>产品需求：</label>
									</td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="prodRequire" id="prodRequire" />
									</td>
					
								</tr>
								
								<tr>
									<td class="td-label" rowspan="4">
										<label>商机说明：</label>
									</td>
									<td class="td-input" rowspan="4">
										<input class="easyui-textbox td-input-input" name="resultReason" id="resultReason" 
													data-options="multiline:true"  style="height:120px;" />
									</td>					
								</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div data-options="region:'center',split:true" border="false" style="width:100%;">
		<div class="easyui-tabs" data-options="fit:true" border="false" >
			<div title="商机简述" style="height: 100%;width: 100%">
				<table id="opty-brief-table" data-options="fit:true">
					<thead>
						<th field="description" width="200px"  editor="{type:'textbox'}">商机简要</th>
					    <th field="attachmentName" width="200px"  formatter="attachmentOriginalFormatter">附件</th>
					</thead>
				</table>
			</div>
			<div title="产品信息列表" style="height: 100%;width: 100%">
				<table id="opty-prod-table"  data-options="fit:true">
					<thead>
						<th field="prodCode" width="20%">产品编码</th>
						<th field="prodName" width="30%">产品名称</th>
						<th field="price" currency="CNY" width="20%">单价</th>
						<th field="qty" width="10%" editor="{type:'numberspinner'}">数量</th>
						<th field="amount" currency="CNY" width="15%" >金额</th>
					</thead>
				</table>
			</div>
			<!-- 
			   <div title="活动信息列表" >
				<table id="opty-activity-table" style="height: 100%;width: 100%">
					<thead>
						<th field="id" width="100px">活动编码</th>
						<th field="type" width="80px" editor="{type:'combobox',options:{valueField:'name',
																		textField:'name',
																		method:'get',
																		data:getLovArray('TUDO_CD'),
																		editable:false,
																		required:true}}"sortable="true">活动类型</th>
						<th field="important" width="50px" sortable="true" editor="{type:'combobox',options:{valueField:'name',
																				textField:'name',
																				method:'get',
																				data:getLovArray('ACTIVITY_IMPORTANT'),
																				editable:false,
																				required:true}}">重要性</th>
						<th field="status" width="80px" sortable="true" editor="{type:'combobox',options:{valueField:'name',
																				textField:'name',
																				method:'get',
																				data:getLovArray('EVT_STAT_CD'),
																				editable:false,
																				required:true}}">活动状态</th>
 						<th field="description" width="230px" editor="{type:'validatebox'}">活动内容</th>
 						<th field="planStartDt" width="100px" editor="{type:'datetimebox',options:{showSeconds:false}}">计划开始时间</th>
						<th field="planEndDt" width="100px" editor="{type:'datetimebox',options:{showSeconds:false}}">计划结束时间</th>
						<th field="actlStartDt" width="100px" editor="{type:'datetimebox',options:{showSeconds:false}}">实际开始时间</th>
						<th field="actlEndDt" width="100px" editor="{type:'datetimebox',options:{showSeconds:false}}">实际结束时间</th>                       
						<th field="accntName" width="120px" editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'}}">客户名称</th>
		                <th field="contactsName" width="80px"  editor="{type:'picklistbox',options:{title:'选择联系人',initParam:initContactPicklistParam,completeFun:contactPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/contactPickList.jsp'}}">联系人</th>
					</thead>
				</table>
			</div> -->
			 
			<div title="商机跟进" style="height: 100%;width: 100%">
				<table id="opty-flowUp-table" data-options="fit:true">
					<thead>
						<tr>
							<th field="dt" width="160px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">跟进时间</th>
							<th field="description" width="300px"  editor="{type:'textbox'}">跟进说明</th>						
						</tr>
 					</thead>
				</table>
			</div>
			<div title="方案报价" style="height: 100%;width: 100%">
				<table id="attachment-table" data-options="fit:true">
					<thead>
						<tr>
							<th field="attachmentOriginal" width="160px" formatter="attachmentOriginalFormatter">附件</th>
							<th field="comments" editor="{type:'textbox'}" width="300px">方案报价</th>
						</tr>
					</thead>
				</table>
				<!-- ------------------------方案报价上传附件弹出框：开始----------------------------  -->
				<div id="upload_attachment" >
					<div class="easyui-layout" data-options="fit:true">
						<div data-options="region:'center',border:false,fit:true" style="padding:10px;background:#fff;border:1px solid #ccc;">
					        <form method="post" class="uploadAttachmentForm" style="text-align:center;margin-top: 30px;" enctype="multipart/form-data" border:true>
<!-- 							<form method="post" class="uploadAttachmentForm" style="text-align:center;  enctype="multipart/form-data" >
 -->							<table id="uploadAttachment-table" style="height: 100%;weight:100%;border-collapse:separate; border-spacing:10px;">
									<input type='file' name='uploadAttachment' style="display: none;"/>
									<tr>
										<td class="td-label" ><label>文件 :</label></td>
										<td class="td-input" >
											<input id="openFile" class="easyui-textbox" data-options="buttonText:'浏览',
													         							  buttonIcon:'icon-search',
													         							  prompt:'请选择文件...',
													         							  editable:false,
													         							  width:'200px',
													         							  height:'30px',
													         							  onClickButton: function(){
													         							  	$('#upload_attachment input[name=uploadAttachment]').click();
																						}"/>										
										</td>
									</tr>
									<tr>
										<td class="td-label" ><label>附件说明 :</label></td>
										<td class="td-input" >
											<input id="comments" name="comments" class="easyui-textbox" data-options="multiline:true,
												         							  prompt:'请填写附件备注...',
												         							  width:'200px',
												         							  height:'90px'"/>
										</td>
									</tr>
								</table>				         							  
							</form>
						</div>
						<div data-options="region:'south',border:false" style="text-align:right;padding:5px 5px;margin-bottom : 15px"">
							<a id="btnOk" class="easyui-linkbutton upload" style="width:100px;margin-right: 30px; data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="uploadAttachment()">上传</a>
							<a id="btnCancel" class="easyui-linkbutton" style="width:100px;margin-right: 50px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadAttachmentDiv.window('close')">取消</a>
						</div>
					</div>
				</div>
				<!-- ------------------------方案报价上传附件弹出框：结束----------------------------  -->
	            
	            
	            <!-- ------------------------商机简述上传附件弹出框：开始----------------------------  -->
				<div id="upload_briefattachment" >
					<div class="easyui-layout" data-options="fit:true">
						<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;" >
							<form method="post" class="uploadBriefAttachmentForm" style="text-align:center;margin-top: 30px;  enctype="multipart/form-data" >
								<table id="uploadBriefAttachment-table" style="height: 100%;weight:100%;border-collapse:separate; border-spacing:10px;">
									<input type='file' name='uploadAttachment' style="display: none;"/>
									<tr>
										<td class="td-label"  style="weight:30%" align="right"><label>商机简要 :</label></td>
										<td class="td-input"  style="weight:70%" align="right">
											<input id="briefName" name="briefName" class="easyui-textbox" data-options="
												         							  prompt:'请填写商机简述',
												         							  width:'200px',
												         							  height:'30px'"/>
										</td>
									</tr>
									
									<tr>
										<td class="td-label" style="weight:40%" align="right"><label>文件 :</label></td>
										<td class="td-input" style="weight:60%" align="right">
											<input id="openFileBrief" class="easyui-textbox" data-options="buttonText:'浏览',
													         							  buttonIcon:'icon-search',
													         							  prompt:'请选择文件...',
													         							  editable:false,
													         							  width:'200px',
													         							  height:'30px',
													         							  onClickButton: function(){
													         							  	$('#upload_briefattachment input[name=uploadAttachment]').click();
																						}"/>										
										</td>
									</tr>
									<tr>
										<td class="td-label"  style="weight:40%" align="right"><label>附件说明 :</label></td>
										<td class="td-input"  style="weight:60%" align="right">
											<input id="commentsBrief" name="comments" class="easyui-textbox" data-options="multiline:true,
												         							  prompt:'请填写附件备注...',
												         							  width:'200px',
												         							  height:'90px'"/>
										</td>
									</tr>
								</table>				         							  
							</form>
						</div>
						<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
							<a id="btnOkBrief" class="easyui-linkbutton upload" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="uploadBriefAttachment()">确定</a>
							<a id="btnCancelBrief" class="easyui-linkbutton" style="width:100px;margin-right: 50px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadBriefAttachmentDiv.window('close')">取消</a>
						</div>
					</div>
				</div>
		     <!-- ------------------------商机简述上传附件弹出框：结束----------------------------  -->
			</div>
		</div>
	</div>
  </div>
	<script type="text/javascript">
	var briefRecord = null;            //商机简述记录
	var optyBriefId = null;                //商机简述Id
	var optyHeadIsEditing = true;
	var flag = false;                  //是否商机简要附件更新
    var headId = "noMatchSelect";      //附件头ID
    var headName = "noMatchSelect";    //附件头名称
    var moduleType = "noMatchSelect";  //业务模块
    
    var optyId = "${param.optyId}";   
	$dataAttachmentgrid = $('#attachment-table');
	$dataOptyFlowUpgrid = $('#opty-flowUp-table');
	$dataOptyBriefgrid = $('#opty-brief-table');
	$prodDatagrid = $('#opty-prod-table');
 	//$activityDatagrid = $('#opty-activity-table'); 
	//变量输入框绑定
 	$optyNameInput = $('#optyName');   
	$accntInput = $('#accnt');
	$optyAddrInput = $('#optyAddr');
	$stageCombobox = $('#stage');
	$amountInput = $('#amount');
	$sourceCombobox = $('#source');
	$statusCombobox = $('#status');
	$deadlineDatebox = $('#deadline');
	$prodRequireInput = $('#prodRequire');
	$deliverAddrInput = $('#deliverAddr');
	$resultReasonInput = $('#resultReason');
	
	//页面元素加载完成事件
	$(document).ready(function() { 
		optyInfoInit();
	}); 
	
	function optyInfoInit(){
		$.post("${AppContext.ctxPath}/action/portal/opty/queryOne", {
			id : optyId
		}, function(data) {
			if (data.success) {
				record = data.result;
				$('#optyForm').form("load", record);
				$optyNameInput.attr('disabled','disabled');
			} else {
				$.messager.alert("警告", data.result);
			}
		});
		optyHeadDisable();
	}
	
	$('#accnt').picklist({
		title:'选择客户',
		completeFun:function(selectRow){
			$('#accntId').val(selectRow.id)
			return selectRow.acctName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp'
	});
	/**
	 * 设置商机头信息的输入框为 编辑状态
	 */
	function optyHeadEnable(){
		if(!optyHeadIsEditing){
			$optyNameInput.textbox('enable');
		    $accntInput.textbox('enable');
			$optyAddrInput.textbox('enable');
			$stageCombobox.combobox('enable');
			$amountInput.textbox('enable');
			$sourceCombobox.combobox('enable');
			$statusCombobox.combobox('enable');
			$deadlineDatebox.datebox('enable');
			$prodRequireInput.textbox('enable');
			$deliverAddrInput.textbox('enable');
			$resultReasonInput.textbox('enable');  
			optyHeadIsEditing = true;
		}
	}
	/**
	 * 设置商机头信息的输入框为 不可编辑状态
	 */
	function optyHeadDisable(){
		if(optyHeadIsEditing){
		    $optyNameInput.textbox('disable');
	 	    $accntInput.textbox('disable');
			$optyAddrInput.textbox('disable');
			$stageCombobox.combobox('disable');
		 	$amountInput.textbox('disable');
			$sourceCombobox.combobox('disable');
			$statusCombobox.combobox('disable');
			$deadlineDatebox.datebox('disable');
			$prodRequireInput.textbox('disable');
			$deliverAddrInput.textbox('disable');
			$resultReasonInput.textbox('disable');    
			optyHeadIsEditing = false;
		}
	}
	
 	function saveOptyInfo(){
		 $("#optyForm").form("submit",{
			url:"${AppContext.ctxPath}/action/portal/opty/optyInsertOrUpdate",
		    onSubmit: function(param){
		    	param.id = optyId;
		    	param.row_status = "UPDATE";
		    },
		    success : function(data){
				var data = eval('(' + data + ')'); // change the JSON string to javascript object
				if(!data.success){
					acctHeadEnable();
					window.parent.operationtip(data.result,'error');
					errFun(data.result,that);
				}
				else{
					optyHeadDisable();
					window.parent.operationtip('保存成功！','info');
					successFun(that, data);
				}	
					
			}
		}); 
	} 
       //商机简述和商机跟进共用后台,通过type字段进行区分
        $dataOptyBriefgrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		rownumbers:true,	//默认显示行号
		pagination:true,	//默认分页功能
		pageSize: 5,//每页显示的记录条数，默认为20 
		pageList: [5,5,15],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/flowUp/queryByExamplePage',
		onBeforeLoad:function(param){
			param.optyId = optyId,
			param.type = 'TUDO_CD_OPTY_BRIEF'   
		},
		onAddMoreButton : function(that, moreButtonList){
		},
		onInitNewData:function(that){
			var time = new Date(+new Date() + 8 * 3600 * 1000)
			.toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/,
					'');//获取当前日期与时间	
			return {
			    type    : 'TUDO_CD_OPTY_BRIEF',
				dt      : time,
				orgId   : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName,
				emp : appCtx.firstName
			};
		},
    });
	$prodDatagrid.hdatagrid({
		queryParams:{
			optyId:optyId
		},
		toolbarShow : true,
		rownumbers:true,	//默认显示行号
		pagination:true,	//默认分页功能
		pageSize: 5,//每页显示的记录条数，默认为20 
		pageList: [5,5,15],//可以设置每页记录条数的列表 
		url : '${AppContext.ctxPath}/action/portal/optyItem/queryListByOptyPage',
		onBeforeLoad:function(param){
				if(optyId){
					param.optyId = optyId;
				}else{
					param.optyId ='noMatchId';
				}
		},
		onAddMoreButton:function(that,addButtonFun){
		}
	}); 
	function selectProdWindow(){
		$('#selectProdBtn').multiSelect({
			title:'选择产品',
			completeFun:function(selectedRow){
				var prodRecords = [];
				for(var i =0; selectedRow != null && i<selectedRow.length;i++){
					prodRecords.push({
						prodId:selectedRow[i].id,
						optyId:optyId,
						price:selectedRow[i].price,
						qty:1
					});
				}
				$.ajax({	
						type: "POST",
			            url: "${AppContext.ctxPath}/action/portal/optyItem/batchNew",
			            data: JSON.stringify(prodRecords),
			            dataType: "json",	
			            contentType: 'application/json', 
			            success:function(data){
							if(data.success){
								$prodDatagrid.hdatagrid("reload");
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
	};
 	
    //商机跟进
	$dataOptyFlowUpgrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		rownumbers:true,	//默认显示行号
		pagination:true,	//默认分页功能
		pageSize: 5,//每页显示的记录条数，默认为20 
		pageList: [5,5,15],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/flowUp/queryByExamplePage',
		onBeforeLoad:function(param){
			param.optyId = optyId
		},
		onInsertAction:function(row,successFun,errFun,that){
			if(optyId == null){
				$.messager.alert('警告','获取商机Id失败,请刷新页面重试！');
			}
			$.post('${AppContext.ctxPath}/action/portal/flowUp/insert',{
				optyId      : optyId,
				dt			: row.dt,
				description	: row.description,	
				type        : 'TUDO_CD_FLOW_UP',
				orgId       : appCtx.orgId,
				postnId     : appCtx.postnId,
				empId		: appCtx.userId
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		onUpdateAction:function(row,successFun,errFun,that){
			if(optyId == null){
				$.messager.alert('警告','获取商机Id失败,请刷新页面重试！');
			}
			$.post('${AppContext.ctxPath}/action/portal/flowUp/update',{
				id          : row.id,
				optyId      : optyId,
				dt			: row.dt,
				description	: row.description,	
				type        : 'TUDO_CD_FLOW_UP',
				orgId       : appCtx.orgId,
				postnId     : appCtx.postnId,
				empId		: appCtx.userId
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
					$.post('${AppContext.ctxPath}/action/portal/flowUp/deleteById', {
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
		onInitNewData:function(that){
			var time = new Date(+new Date() + 8 * 3600 * 1000)
			.toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/,
					'');//获取当前日期与时间	
			return {
				dt      : time,
				orgId   : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName,
				emp : appCtx.firstName
			};
		}
	});
	
	//商机方案报价
	$dataAttachmentgrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		rownumbers:true,	//默认显示行号
		pagination:true,	//默认分页功能
		pageSize: 5,//每页显示的记录条数，默认为20 
		pageList: [5,5,15],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		onBeforeLoad:function(param){
			param.id = optyId
		},
		onAddMoreButton:function(that,addButtonFun){
		}
	});
    /* --------------------附件列表：开始------------------------------ */ 
	$uploadAttachmentDiv = $('#upload_attachment');
	function openUploadAttachment(obj){
		if(obj=='Attachment'){  //方案报价"新增"按钮
	 		flag = false;
	 		moduleType = 'Opportunity';
			headId = optyId;
		    headName = $('#optyName').textbox('getValue');
		}    
		if(obj=='Brief'){       //商机简要"上传附件"按钮
			flag = true;
			moduleType = 'Opportunity-Brief';
			briefRecord = $dataOptyBriefgrid.datagrid("getSelected"); 
		    if(briefRecord == null){
		    	$.messager.alert("警告", "请选中商机简述记录后上传附件！");
		    	return;
		    }
			headId = briefRecord.id;
		    headName = briefRecord.description;
		} 
	    
		$uploadAttachmentDiv.dialog({
			title:'上传附件',
			iconCls:'icon-add',
		    width:'450px',
		    height:'320px',
		    closable:false,
		    minimizable:true,
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
							headId 		: headId,
							moduleType 	: moduleType,
							headCode 	: headId,
							headName 	: headName
						}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					
					if (data.success) {
						$.messager.progress('close');
					 	if(flag){    //更新商机简述的附件ID
							optyBriefAttachment(data.entity.id,briefRecord.id);
						} 
						$dataAttachmentgrid.datagrid('reload');
						$uploadAttachmentDiv.window('close');
						$dataOptyBriefgrid.datagrid("reload");
					} else {
						if (data.result == null) {
							data.result = "上传失败！";
						}
						$.messager.alert("警告", data.result);
						errFun(data.result,that);
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
		
		//商机方案报价附件下载
		function attachmentOriginalFormatter(val, row) {
			if (val != null) {
				var content = "点击下载";
				return "<a href='###' class='easyui-tooltip' title='"
				+ content + "' onclick='window.open(\"" + row.attachmentPath + "\")'>" + val + "</a>";
			}
		}
	
	/* --------------------商机简要附件上传----------------------------- */
	$uploadBriefAttachmentDiv = $('#upload_briefattachment');
	function newOptyBrief(){
		$uploadBriefAttachmentDiv.dialog({
			title:'上传附件',
			iconCls:'icon-add',
			width:'450px',
			height:'360px',
			closable:false,
			minimizable:true,
			collapsible:false,
			modal:true,
			closed:true
		});
		clearBriefDiv();
		$uploadBriefAttachmentDiv.window('open');
	}
	 /**
	 * 清空商机简要附件上传弹出框内容
	 */
	function clearBriefDiv(){
		$('input[name=uploadAttachment]',$uploadBriefAttachmentDiv).val('');
		$('#briefName',$uploadBriefAttachmentDiv).textbox('setValue','');
		$('#commentsBrief',$uploadBriefAttachmentDiv).textbox('setValue','');
		$('#openFileBrief',$uploadBriefAttachmentDiv).textbox('setValue', '');
	}
	$('input[name=uploadAttachment]',$uploadBriefAttachmentDiv).change(function(){
		var fileName = $('input[name=uploadAttachment]',$uploadBriefAttachmentDiv).val();
		$('#openFileBrief').textbox('setValue', fileName);
	});
	
	function uploadBriefAttachment(){
		if(!optyId){
			$.messager.alert("警告","获取商机Id失败,请刷新页面重试！");
			return;
		}
		//新建记录时"商机简要"不能为空
		var briefName = $('#briefName',$uploadBriefAttachmentDiv).textbox('getValue');
		if(briefName.trim() == ""){      //去掉前后空格
			$.messager.alert("", "商机简要为必填信息！");
		}else{
			$.post('${AppContext.ctxPath}/action/portal/flowUp/insert',{
				optyId      : optyId,
				description	: briefName,
				type        : 'TUDO_CD_OPTY_BRIEF',
				orgId       : appCtx.orgId,
				postnId     : appCtx.postnId,
				empId		: appCtx.userId
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					optyBriefId = data.record.id;
					headId = optyBriefId;
					headName = data.record.description;
					moduleType = 'Opportunity-Brief';
					$dataOptyBriefgrid.datagrid("reload");
				 	var openFileBrief = $('#openFileBrief',$uploadBriefAttachmentDiv).textbox('getValue');
					if(openFileBrief == ""){   
						$dataOptyBriefgrid.datagrid("reload");
						$uploadBriefAttachmentDiv.window('close');
					}
					if(headName!="" && openFileBrief != ""){ //上传附件
						  var options = {
					   				url:'${AppContext.ctxPath}/action/portal/attachment/insert',
					   				type:'post',
									data : formatRequest({
												headId 		: headId,
												moduleType 	: moduleType,
												headCode 	: headId,
												headName 	: headName
											}),
									dataType : 'json',
									contentType : "application/vnd.ms-excel;charset=utf-8",
									success : function(data) {
										if (data.success) {
											//更新商机简述的附件ID
											optyBriefAttachment(data.entity.id,optyBriefId);
											$dataOptyBriefgrid.datagrid("reload");
											$uploadBriefAttachmentDiv.window('close');
										} else {
											if (data.result == null) {
												data.result = "上传失败！";
											}
											$.messager.alert("警告", data.result);
										}
									}
								};
								$('.uploadBriefAttachmentForm', $uploadBriefAttachmentDiv).ajaxSubmit(options); 
					
					}
				}
			});
		}
		
	}
	
	/**
	 * 更新商机简述的附件ID
	 */
	function optyBriefAttachment(attachmentId,optyBriefId){
     if(!attachmentId || !optyBriefId){
			$.messager.alert('警告','获附件ID失败！');
			return;
		}
		$.post('${AppContext.ctxPath}/action/portal/flowUp/update', {
			id				: optyBriefId,
			attachmentId  	: attachmentId
		}, function(data) {
			if (data.success) {
				$.messager.alert("提示", "上传成功！");
			}else{
				$.messager.alert('警告',data.result);
				errFun(data.result,that);
			}
		});
	}
	
	/* --------------------附件列表：结束------------------------------ */
	</script>
</body>
</html>