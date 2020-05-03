<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<style type="text/css">

/* -- td css start -- */
.td-label {
	font-size: 14px;
	font-weight: 200;
	text-align: right;
	height: 30px;
	width: 120px;
}

.td-input {
	width: 160px;
	height: 30px;
	padding-left: 10px;
}
/* -- td css end -- */
.td-input-input {
	width: 150px;
}

</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',collapsible:false" title="商机基本信息"
			border="false" style="width: 100%; height: 100%; padding: 0px;">
			<form id="optyForm" method="post" style="width: 100%; padding: 0px;">
				<table class="form-table" style="width: 100%;">
					<tr>
						<td>
							<table>
								<tr>
									<td class="td-label"><label>商机名称：</label></td>
									<td class="td-input"><input
										class="easyui-textbox td-input-input" name="optyName"
										id="optyName" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>商机阶段：</label></td>
									<td class="td-input"><input
										data-options="{ valueField:'val',
										textField:'name',
										data:getLovArray('OPTY_STAGE'),
										editable:false}"
										class="easyui-combobox td-input-input" name="stage" id="stage" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>商机状态：</label></td>
									<td class="td-input"><input
										data-options="{	valueField:'val',
															textField:'name',
															method:'get',
															data:getLovArray('OPTY_STATUS'),
															editable:false}"
										class="easyui-combobox td-input-input" name="status"
										id="status" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>交货地点：</label></td>
									<td class="td-input"><input
										class="easyui-textbox td-input-input" name="deliverAddr"
										id="deliverAddr" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>预计成单日期：</label></td>
									<td class="td-input">
										<input class="easyui-datebox td-input-input" name="startDt" id="startDt" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>创建日期：</label></td>
									<td class="td-input"><input
										class="easyui-datebox td-input-input" disabled="disabled"
										name="created" id="created" /></td>
								</tr>
							</table>
						</td>
						<td>
							<table>
								<tr>
									<td class="td-label"><label>客户名称：</label></td>
									<td class="td-input"><input
										class="easyui-textbox td-input-input" name="accnt" id="accnt" />
										<input hidden="true" name="accntId" id="accntId" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>所在地：</label></td>
									<td class="td-input"><input
										class="easyui-textbox td-input-input" name="optyAddr"
										id="optyAddr" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>商机来源：</label></td>
									<td class="td-input"><input
										data-options="{	valueField:'val',
														textField:'name',
														method:'get',
														data:getLovArray('OPTY_SOURCE'),
														editable:false
														}"
										class="easyui-combobox td-input-input" name="source"
										id="source" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>负责人：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="managerName" id="managerName" />
										<input type="hidden" name="managerId" id="managerId"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>所属组别：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" disabled="disabled" 
											name="managerOrgName" id="managerOrgName" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>预计销售金额（税后）：</label></td>
									<td class="td-input"><input
										class="easyui-numberbox td-input-input" data-options="min:0,precision:2"
										name="amount" id="amount" /></td>
								</tr>
								<tr>
									<td class="td-label"><label>跟进截止时间：</label></td>
									<td class="td-input"><input
										class="easyui-datebox td-input-input" name="deadline"
										id="deadline" /></td>
								</tr>
							</table>
						</td>
						<td>
							<table>
								<tr>
									<td class="td-label"><label>产品需求：</label></td>
									<td class="td-input"><input
										class="easyui-textbox td-input-input" name="prodRequire"
										id="prodRequire" /></td>

								</tr>
								<tr>
									<td class="td-label"><label>赢单率：</label></td>
									<td class="td-input">
										<input class="easyui-combobox td-input-input" name="rate" id="rate" 
											data-options="{valueField:'val',
															textField:'name',
															method:'get',
															data:getLovArray('OPTY_SUCCESS_RATE'),
															editable:false,
															required:true}"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>赢/丢单主要原因：</label></td>
									<td class="td-input">
										<input class="easyui-combobox td-input-input" name="resultFactor" id="resultFactor"
											data-options="{valueField:'val',
															textField:'name',
															method:'get',
															data:getLovArray('OPTY_RESULT_FACTOR'),
															editable:false,
															required:false}" />
									</td>
								</tr>
								<tr>
									<td class="td-label" rowspan="4"><label>赢/丢单说明：</label></td>
									<td class="td-input" rowspan="4"><input
										class="easyui-textbox td-input-input" name="resultReason"
										id="resultReason" data-options="multiline:true"
										style="height: 90px;" /></td>
								</tr>
							</table>
						</td>
						<td>
							<table>
								<tr>
									<td class="td-label"><label>销售人员：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="salesman" id="salesman" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>业务范围：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="businessScope" id="businessScope" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>主推产品：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="mainProd" id="mainProd" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>竞争对手及产品：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="competitor" id="competitor" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>备注：</label></td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" data-options="multiline:true"
										style="height: 90px;" name="comments" id="comments" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="id"/>
				<input type="hidden" id="rowstatus" name="row_status" />
			</form>
			<div style="width: 100%; height: 30px; padding: 0px; margin-top: 15px;margin-bottom: 15px;">
				<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" plain="false"
					style="margin-left: 100px; width: 100px; height: 30px;" onclick="goBack()">取消</a>
				<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save"
					plain="false" style="margin-left: 70px; width: 100px; height: 30px;"
					onclick="saveOptyInfo()">保存</a>
			</div>
			<div class="easyui-tabs" style="width: '$(window).width() - 18';height: 500px;" border="false">
				<div title="商机简述" style="height: 100%; width: 100%">
					<table id="opty-brief-table" data-options="fit:true">
						<thead>
							<th field="description" width="200px" editor="{type:'textbox'}">商机简要</th>
							<th field="attachmentName" width="200px"
								formatter="attachmentOriginalFormatter">附件</th>
						</thead>
					</table>
				</div>

				

				<div title="商机跟进" style="height: 100%; width: 100%">
					<%@ include file="optyFlowUpList.jsp"%>
				</div>
				
					<!-- ------------------------方案报价上传附件弹出框：结束----------------------------  -->
				</div>
				
									<!-- ------------------------商机简述上传附件弹出框：开始----------------------------  -->
					<div id="upload_briefattachment">
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'center',border:false"
								style="padding: 10px; background: #fff; border: 1px solid #ccc;">
								<form method="post" class="uploadBriefAttachmentForm"
									style="text-align: center; margin-top: 30px;"multipart/form-data" >
									<table id="uploadBriefAttachment-table"
										style="height: 100%; weight: 100%; border-collapse: separate; border-spacing: 10px;">
										<input type='file' name='uploadAttachment'
											style="display: none;" />
										<tr>
											<td class="td-label" style="weight: 30%" align="right"><label>商机简要
													:</label></td>
											<td class="td-input" style="weight: 70%" align="right">
												<input id="briefName" name="briefName"
												class="easyui-textbox"
												data-options="
												         							  prompt:'请填写商机简述',
												         							  width:'200px',
												         							  height:'30px'" />
											</td>
										</tr>

										<tr>
											<td class="td-label" style="weight: 40%" align="right"><label>文件
													:</label></td>
											<td class="td-input" style="weight: 60%" align="right">
												<input id="openFileBrief" class="easyui-textbox"
												data-options="buttonText:'浏览',
													         							  buttonIcon:'icon-search',
													         							  prompt:'请选择文件...',
													         							  editable:false,
													         							  width:'200px',
													         							  height:'30px',
													         							  onClickButton: function(){
													         							  	$('#upload_briefattachment input[name=uploadAttachment]').click();
																						}" />
											</td>
										</tr>
										<tr>
											<td class="td-label" style="weight: 40%" align="right"><label>附件说明
													:</label></td>
											<td class="td-input" style="weight: 60%" align="right">
												<input id="commentsBrief" name="comments"
												class="easyui-textbox"
												data-options="multiline:true,
												         							  prompt:'请填写附件备注...',
												         							  width:'200px',
												         							  height:'90px'" />
											</td>
										</tr>
									</table>
								</form>
							</div>
							<div data-options="region:'south',border:false"
								style="text-align: right; padding: 5px 0px;">
								<a id="btnOkBrief" class="easyui-linkbutton upload"
									style="width: 100px; margin-right: 30px;"
									data-options="iconCls:'icon-ok'" href="javascript:void(0)"
									onclick="uploadBriefAttachment()">确定</a> <a id="btnCancelBrief"
									class="easyui-linkbutton"
									style="width: 100px; margin-right: 50px;"
									data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
									onclick="$uploadBriefAttachmentDiv.window('close')">取消</a>
							</div>
						</div>
					</div>
					<!-- ------------------------商机简述上传附件弹出框：结束----------------------------  -->
			</div>
		</div>
	</div>
	<!-- 要放大显示的div -->
 	<div id="bigImg" style="display: none;">
		<img id="popUpImg" />
	</div> 
	<script type="text/javascript">
		var briefRecord = null; //商机简述记录
		var optyBriefId = null; //商机简述Id
		var optyHeadIsEditing = true;
		var flag = false; //是否商机简要附件更新
		var followUpFlag = false; //是否商机跟进
		var headId = "noMatchSelect"; //附件头ID
		var headName = "noMatchSelect"; //附件头名称
		var moduleType = "noMatchSelect"; //业务模块
		var followRecord = null; //商机跟进
		$optyForm = $("#optyForm");
		
		var optyId = "${param.optyId}";
		$dataAttachmentgrid = $('#attachment-table');
		$dataOptyFlowUpgrid = $('#opty-flowUp-table');
		$dataOptyBriefgrid = $('#opty-brief-table');
		$prodDatagrid = $('#opty-prod-table');
		$activityDatagrid = $('#opty-activity-table'); 
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

		//新增商机跟进弹窗
		/* $addOptyWin = $("#addOptyWin");
		$addOptyWinFram = $("#addOptyWinFram"); */

		//页面元素加载完成事件
		$(document).ready(function() {
			if(top.editFlag!="Y"){
				$("#btn_submit").hide();
			}
			optyInfoInit();
		});

		function optyInfoInit() {
			$.post("${AppContext.ctxPath}/action/portal/opty/queryById", {
				id : optyId
			},
					function(data) {
						if (data.success) {
							record = data.result;
							record.row_status = "UPDATE";               //行记录操作状态
							record.stage = getLovShowName('OPTY_STAGE',
									record.stage);
							record.status = getLovShowName('OPTY_STATUS',
									record.status);
							record.source = getLovShowName('OPTY_SOURCE',
									record.source);
							$('#optyForm').form("load", record);
							$optyNameInput.attr('disabled', 'disabled');
						} else {
							$.messager.alert("警告", data.result);
						}
					});
			//optyHeadDisable();
		}

		$('#accnt').picklist({
			title : '选择客户',
			completeFun : function(selectRow) {
				$('#accntId').val(selectRow.id)
				return selectRow.acctName;
			},
			tableUrl : '${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp'
		});
		
		$('#managerName').picklist({
			title : '选择负责人',
			oauthFlag : false,
			completeFun : function (selectRow){
				$('#managerId').val(selectRow.id);
				$('#managerOrgName').textbox('setValue',selectRow.orgName);
				return selectRow.firstName;
			},
			tableUrl : '${AppContext.ctxPath}/portal/picklist/employeePickList.jsp',
			required : true
		});

		/**
		 * 设置商机头信息的输入框为 编辑状态
		 */
		function optyHeadEnable() {
			if (!optyHeadIsEditing) {
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
		function optyHeadDisable() {
			if (optyHeadIsEditing) {
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
		
		var headerUpdateFlag = false;//按钮锁标志，防止按钮被重复点击
		function saveOptyInfo() {
			if(top.editFlag!="Y"){
				$.messager.alert("错误", "您没有修改此商机信息的权限");
			}
			if(headerUpdateFlag){
				return;
			}
			headerUpdateFlag = true;
			var options = {
					url : '${AppContext.ctxPath}/action/portal/opty/upsert',
					type : 'post',
					dataType :'json',
					beforeSubmit: function() {
						var result = $optyForm.form('validate');
						return result;
					},  
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
		
		/**
		 * 返回
		 */
		function goBack() {
			gotoContentPage('${AppContext.ctxPath}/portal/opty/hlyOptyList.jsp');
		}

		//商机简述和商机跟进共用后台,通过type字段进行区分
		$dataOptyBriefgrid
				.hdatagrid({
					updateable : true,
					buttonNew : false,
					toolbarShow : true,
					buttonSearch : true,
					buttonDelete : true,
					striped : true,
					border : false,
					rownumbers : true, //默认显示行号
					pagination : true, //默认分页功能
					oauthFlag:false,
					pageSize : 5,//每页显示的记录条数，默认为20 
					pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/flowUp/queryByExamplePage',
					onBeforeLoad : function(param) {
						param.optyId = optyId,
								param.type = 'TUDO_CD_OPTY_BRIEF'
					},
					onAddMoreButton : function(that, moreButtonList) {
						moreButtonList(1,'<a href="javascript:void(0)" id="btn-active" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newOptyBrief()">新建</a>',
								that);
						moreButtonList(91,'<a href="javascript:void(0)" id="btn-active" class="easyui-linkbutton" iconCls="icon-file-upload" plain="true" onclick="openUploadAttachment(\'Brief\')">上传附件</a>',
								that);
					},
					
					onUpdateAction : function(row, successFun, errFun, that) {
						if (optyId == null) {
							$.messager.alert('警告', '获取商机Id失败,请刷新页面重试！');
						}
						$
								.post(
										'${AppContext.ctxPath}/action/portal/flowUp/update',
										{
											id : row.id,
											description : row.description
										}, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												//删除附件
												if (row.attachmentId != ""
														&& row.attachmentId != null) {
													$
															.post(
																	'${AppContext.ctxPath}/action/portal/attachment/deleteById',
																	{
																		id : row.attachmentId
																	},
																	function(
																			data) {
																		if (!data.success) {
																			errFun(
																					data.result,
																					that);
																		} else {
																			successFun(
																					that,
																					data);
																		}
																	});
												}

												//删除商机简要
												$
														.post(
																'${AppContext.ctxPath}/action/portal/flowUp/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(
																				that,
																				data);
																	}
																});
											}
										});
					},
					onInitNewData : function(that) {
						var time = new Date(+new Date() + 8 * 3600 * 1000)
								.toISOString().replace(/T/g, ' ').replace(
										/\.[\d]{3}Z/, '');//获取当前日期与时间	
						return {
							type : 'TUDO_CD_OPTY_BRIEF',
							dt : time,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName,
							emp : appCtx.firstName
						};
					},
				});

		$prodDatagrid.hdatagrid({
				    queryParams : {
						optyId : optyId
					},  
					updateable   : true,
					buttonDelete : true,
					buttonSearch : true,
					toolbarShow  : true,
					rownumbers   : true, //默认显示行号
					pagination   : true, //默认分页功能
					pageSize     : 5,//每页显示的记录条数，默认为20 
					pageList     : [ 5, 10, 15 ],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/optyItem/queryListByOptyPage',
			 	    onBeforeLoad:function(param){
						if(optyId){
							param.optyId = optyId;
						}else{
							param.optyId ='noMatchId';
						}
					},  
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(91,'<a id="selectProdBtn" href="javascript:void(0)" class="easyui-linkbutton" onClick="selectProdWindow()" iconCls="icon-add" plain="true">选择产品</a>',that);
					},
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						if (optyId == null) {
							$.messager.alert('警告', '获取商机Id失败,请刷新页面重试！');
						}
						var rows_2 = [];
						for(var i=0; i< rows.length; i++){
							var row = rows[i];
							var row_2 = {
									row_status   	: "UPDATE",
									id : row.id,
									prodId : row.prodId,
									optyId : optyId,
									price : row.price,
									qty : row.qty
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
					onInsertOrUpdateAction : function(row, successFun, errFun,that) {
						if (optyId == null) {
							$.messager.alert('警告', '获取商机Id失败,请刷新页面重试！');
						}
						$.post('${AppContext.ctxPath}/action/portal/optyItem/upsert',{
								row_status : row.row_status,
								id : row.id,
								prodId : row.prodId,
								optyId : optyId,
								price : row.price,
								qty : row.qty
							}, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
								}
							});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager.confirm("操作提示",'是否确定删除信息？',
							function(data) {
								if (data) {
									$.post('${AppContext.ctxPath}/action/portal/optyItem/deleteById',
									{
										id : row.id
									},
									function(data) {
										if (!data.success) {
											errFun(data.result,that);
										} else {
											successFun(that,data);
										}
									});
								}
							});
					}
				});
		
		function selectProdWindow() {
			$('#selectProdBtn').multiSelect(
					{
						title : '选择产品',
						completeFun : function(selectedRow) {
							var prodRecords = [];
							for (var i = 0; selectedRow != null
									&& i < selectedRow.length; i++) {
								prodRecords.push({
									prodId : selectedRow[i].id,
									optyId : optyId,
									price : selectedRow[i].price,
									qty : 1
								});
							}
							$.ajax({
								type : "POST",
								url : "${AppContext.ctxPath}/action/portal/optyItem/batchInsert",
								data : JSON.stringify(prodRecords),
								dataType : "json",
								contentType : 'application/json',
								success : function(data) {
									if (data.success) {
										$prodDatagrid.hdatagrid("reload");
									} else {
										$.messager.alert("警告", data.result);
									}
								}
							});
						},
						initParam : function() {
							return {
								optyId : optyId
							};
						},
						tableUrl : '${AppContext.ctxPath}/portal/opty/dialog/productMultiSelect.jsp'
					});
		};
		//活动信息
		
		/* function accntPicklistComplete(selectRow){
			$activityDatagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
			return selectRow.acctName;
		}
		function contactPicklistComplete(selectRow){
			$activityDatagrid.hdatagrid('getCurrentRow').contactId = selectRow.id;
			return selectRow.contactsName;
		}  */
		//初始化联系人客户Id
		/* function initContactPicklistParam(){
		var accntId = $activityDatagrid.hdatagrid('getCurrentRow').accntId;
		if(accntId == null || accntId == ''){
			return {id:'noMatchId'};
		}else{
			return {id:accntId};
		}
		} */
		 
		//商机跟进
		$dataOptyFlowUpgrid
				.hdatagrid({
					updateable : true,
					buttonNew : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonDelete : true,
					striped : true,
					border : false,
					nowrap : false,
					rownumbers : true, //默认显示行号
					pagination : true, //默认分页功能
					pageSize : 5,//每页显示的记录条数，默认为20 
					pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/flowUp/queryByExamplePage',
					onBeforeLoad : function(param) {
						param.optyId = optyId
					},
					onInsertAction : function(row, successFun, errFun, that) {
						if (optyId == null) {
							$.messager.alert('警告', '获取商机Id失败,请刷新页面重试！');
						}
						$.post('${AppContext.ctxPath}/action/portal/flowUp/insert',
							{
								optyId : optyId,
								dt : row.dt,
								description : row.description,
								type : 'TUDO_CD_FLOW_UP',
								orgId : appCtx.orgId,
								postnId : appCtx.postnId,
								empId : appCtx.userId
							}, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
								}
							});
					},
					onUpdateAction : function(row, successFun, errFun, that) {
						if (optyId == null) {
							$.messager.alert('警告', '获取商机Id失败,请刷新页面重试！');
						}
						$.post('${AppContext.ctxPath}/action/portal/flowUp/update',
						{
							id : row.id,
							optyId : optyId,
							dt : row.dt,
							description : row.description,
							type : 'TUDO_CD_FLOW_UP',
							orgId : appCtx.orgId,
							postnId : appCtx.postnId,
							empId : appCtx.userId
						}, function(data) {
							if (!data.success) {
								errFun(data.result, that);
							} else {
								successFun(that, data);
							}
						});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager.confirm("操作提示",'是否确定删除信息？',
							function(data) {
								if (data) {
									/* 删除跟进 */
									$.post('${AppContext.ctxPath}/action/portal/flowUp/deleteById',
										{
											id : row.id
										},
										function(data) {
											if (!data.success) {
												errFun(data.result,that);
											} else {
												successFun(that,data);
											}
										});
									/* 删除跟进照片 */
								}
							});
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(71,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-file-upload" plain="true" onclick="openUploadAttachment(\'FollowUp\')">上传跟进照片</a>',
								that);
					},
					onInitNewData : function(that) {
						var time = new Date(+new Date() + 8 * 3600 * 1000)
								.toISOString().replace(/T/g, ' ').replace(
										/\.[\d]{3}Z/, '');//获取当前日期与时间	
						return {
							dt : time,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName,
							emp : appCtx.firstName
						};
					},
					onLoadSuccess : function(data) {
						//调用图片展示组件
						$('div.small_pic a').fancyZoom({
							scaleImg : true,
							closeOnClick : true
						});
					}
				});

		/**
			商机照片列
		 */
		function detailFormatter(value, row, index) {
			if (row.attachmentPath) {
				return "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src='"+row.attachmentPath+"' /></a></div>";
			} else {
				return "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src='${AppContext.ctxPath}/static/images/404.jpg' /></a></div>";
			}

		}

		//商机方案报价
		$dataAttachmentgrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonDelete : true,
					striped : true,
					border : false,
					oauthFlag:false,
					rownumbers : true, //默认显示行号
					pagination : true, //默认分页功能
					pageSize : 5,//每页显示的记录条数，默认为20 
					pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
					onBeforeLoad : function(param) {
						param.id = optyId
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(
								39,
								'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment(\'Attachment\')">新建</a>',
								that);
					},
					onUpdateAction : function(row, successFun, errFun, that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/attachment/update',
										{
											id : row.id,
											comments : row.comments
										}, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/attachment/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(
																				that,
																				data);
																	}
																});
											}
										});
					}
				});
		/* --------------------附件列表：开始------------------------------ */
		$uploadAttachmentDiv = $('#upload_attachment');
		function openUploadAttachment(obj) {
			if (obj == 'Attachment') { //方案报价"新增"按钮
				flag = false;
				moduleType = 'Opportunity';
				headId = optyId;
				headName = $('#optyName').textbox('getValue');
			}
			if (obj == 'Brief') { //商机简要"上传附件"按钮
				flag = true;
				moduleType = 'Opportunity-Brief';
				briefRecord = $dataOptyBriefgrid.datagrid("getSelected");
				if (briefRecord == null) {
					$.messager.alert("警告", "请选中商机简述记录后上传附件！");
					return;
				}
				headId = briefRecord.id;
				headName = briefRecord.description;
			}

			if (obj == 'FollowUp') { //商机跟进要"上传跟进照片"按钮
				flag = true;
				followUpFlag = true;
				moduleType = 'Opportunity-FollowUp';
				followRecord = $dataOptyFlowUpgrid.datagrid("getSelected");
				if (followRecord == null) {
					$.messager.alert("警告", "请选中商机跟进记录后上传附件！");
					return;
				}
				headId = followRecord.id;
				headName = followRecord.description;
			}

			$uploadAttachmentDiv.dialog({
				title : '上传附件',
				iconCls : 'icon-add',
				width : '450px',
				height : '320px',
				closable : false,
				minimizable : true,
				collapsible : false,
				modal : true,
				closed : true
			});
			clearDiv();
			$uploadAttachmentDiv.window('open');
		}

		/**
		 * 清空弹出框内容
		 */
		function clearDiv() {
			$('input[name=uploadAttachment]', $uploadAttachmentDiv).val('');
			$('#comments', $uploadAttachmentDiv).textbox('setValue', '');
			$('#openFile', $uploadAttachmentDiv).textbox('setValue', '');
		}
		$('input[name=uploadAttachment]', $uploadAttachmentDiv).change(
				function() {
					var fileName = $('input[name=uploadAttachment]',
							$uploadAttachmentDiv).val();
					$('#openFile').textbox('setValue', fileName);
				});

		/**
			上传按钮触发
		 */
		function uploadAttachment() {
			if (!optyId) {
				$.messager.alert("警告", "获取商机Id失败,请刷新页面重试！");
				return;
			}
			$.messager.progress();
			var options = {
				url : '${AppContext.ctxPath}/action/portal/attachment/insert',
				type : 'post',
				data : formatRequest({
					headId : headId,
					moduleType : moduleType,
					headCode : headId,
					headName : headName
				}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					if (data.success) {
						$.messager.progress('close');
						if (flag) {
							if (followUpFlag) {
								//更新商机跟进
								optyFollowUpAttachment(data.entity.id,
										followRecord.id);
								$dataOptyFlowUpgrid.datagrid("reload");
							} else {
								//更新商机简述的附件ID
								optyBriefAttachment(data.entity.id,
										briefRecord.id);
							}
						}
						$dataAttachmentgrid.datagrid('reload');
						$uploadAttachmentDiv.window('close');
						$dataOptyBriefgrid.datagrid("reload");
					} else {
						if (data.result == null) {
							data.result = "上传失败！";
						}
						$.messager.alert("警告", data.result);
						errFun(data.result, that);
					}
				}
			};
			$('.uploadAttachmentForm', $uploadAttachmentDiv)
					.ajaxSubmit(options);
		}

		/**
		商机跟进照片上传按钮触发
		 */
		function uploadAttachment_followUp() {
			if (!optyId) {
				$.messager.alert("警告", "获取商机Id失败,请刷新页面重试！");
				return;
			}
			var options = {
				url : '${AppContext.ctxPath}/action/portal/attachment/insert',
				type : 'post',
				data : formatRequest({
					headId : headId,
					moduleType : moduleType,
					headCode : headId,
					headName : headName
				}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					if (data.success) {
						optyBriefAttachment(data.entity.id, followRecord.id);
						$dataOptyFlowUpgrid.datagrid('reload');
						$uploadAttachmentDiv.window('close');
					} else {
						if (data.result == null) {
							data.result = "上传失败！";
						}
						$.messager.alert("警告", data.result);
						errFun(data.result, that);
					}
				}
			};
			$('.uploadAttachmentForm', $uploadAttachmentDiv)
					.ajaxSubmit(options);
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
				return "<a href='###' class='easyui-tooltip' title='" + content
						+ "' onclick='window.open(\"" + row.attachmentPath
						+ "\")'>" + val + "</a>";
			}
		}

		/* --------------------商机简要附件上传----------------------------- */
		$uploadBriefAttachmentDiv = $('#upload_briefattachment');
		function newOptyBrief() {
			$uploadBriefAttachmentDiv.dialog({
				title : '上传附件',
				iconCls : 'icon-add',
				width : '450px',
				height : '360px',
				closable : false,
				minimizable : true,
				collapsible : false,
				modal : true,
				closed : true
			});
			clearBriefDiv();
			$uploadBriefAttachmentDiv.window('open');
		}
		/**
		 * 清空商机简要附件上传弹出框内容
		 */
		function clearBriefDiv() {
			$('input[name=uploadAttachment]', $uploadBriefAttachmentDiv)
					.val('');
			$('#briefName', $uploadBriefAttachmentDiv).textbox('setValue', '');
			$('#commentsBrief', $uploadBriefAttachmentDiv).textbox('setValue',
					'');
			$('#openFileBrief', $uploadBriefAttachmentDiv).textbox('setValue',
					'');
		}
		$('input[name=uploadAttachment]', $uploadBriefAttachmentDiv).change(
				function() {
					var fileName = $('input[name=uploadAttachment]',
							$uploadBriefAttachmentDiv).val();
					$('#openFileBrief').textbox('setValue', fileName);
				});

		function uploadBriefAttachment() {
			if (!optyId) {
				$.messager.alert("警告", "获取商机Id失败,请刷新页面重试！");
				return;
			}
			//新建记录时"商机简要"不能为空
			var briefName = $('#briefName', $uploadBriefAttachmentDiv).textbox(
					'getValue');
			if (briefName.trim() == "") { //去掉前后空格
				$.messager.alert("", "商机简要为必填信息！");
			} else {
				$
						.post(
								'${AppContext.ctxPath}/action/portal/flowUp/insert',
								{
									optyId : optyId,
									description : briefName,
									type : 'TUDO_CD_OPTY_BRIEF',
									orgId : appCtx.orgId,
									postnId : appCtx.postnId,
									empId : appCtx.userId
								},
								function(data) {
									if (!data.success) {
										errFun(data.result, that);
									} else {
										optyBriefId = data.newRow.id;
										headId = optyBriefId;
										headName = data.newRow.description;
										moduleType = 'Opportunity-Brief';
										$dataOptyBriefgrid.datagrid("reload");
										var openFileBrief = $('#openFileBrief',
												$uploadBriefAttachmentDiv)
												.textbox('getValue');
										if (openFileBrief == "") {
											$dataOptyBriefgrid
													.datagrid("reload");
											$uploadBriefAttachmentDiv
													.window('close');
										}
										if (headName != ""
												&& openFileBrief != "") { //上传附件
											var options = {
												url : '${AppContext.ctxPath}/action/portal/attachment/insert',
												type : 'post',
												data : formatRequest({
													headId : headId,
													moduleType : moduleType,
													headCode : headId,
													headName : headName
												}),
												dataType : 'json',
												contentType : "application/vnd.ms-excel;charset=utf-8",
												success : function(data) {
													if (data.success) {
														//更新商机简述的附件ID
														optyBriefAttachment(
																data.entity.id,
																optyBriefId);
														$dataOptyBriefgrid
																.datagrid("reload");
														$uploadBriefAttachmentDiv
																.window('close');
													} else {
														if (data.result == null) {
															data.result = "上传失败！";
														}
														$.messager.alert("警告",
																data.result);
													}
												}
											};
											$('.uploadBriefAttachmentForm',
													$uploadBriefAttachmentDiv)
													.ajaxSubmit(options);

										}
									}
								});
			}

		}

		/**
		 * 更新商机简述的附件ID
		 */
		function optyBriefAttachment(attachmentId, optyBriefId) {
			if (!attachmentId || !optyBriefId) {
				$.messager.alert('警告', '获附件ID失败！');
				return;
			}
			$.post('${AppContext.ctxPath}/action/portal/flowUp/update', {
				id : optyBriefId,
				attachmentId : attachmentId
			}, function(data) {
				if (data.success) {
					$.messager.alert("提示", "上传成功！");
				} else {
					$.messager.alert('警告', data.result);
					errFun(data.result, that);
				}
			});
		}

		/**
		 * 更新商机跟进的附件ID
		 */
		function optyFollowUpAttachment(attachmentId, optyFollowId) {
			if (!attachmentId || !optyFollowId) {
				$.messager.alert('警告', '获附件ID失败！');
				return;
			}
			$.post('${AppContext.ctxPath}/action/portal/flowUp/update', {
				id : optyFollowId,
				dt : followRecord.dt,
				attachmentId : attachmentId
			}, function(data) {
				if (data.success) {
					$.messager.alert("提示", "上传成功！");
				} else {
					$.messager.alert('警告', data.result);
					errFun(data.result, that);
				}
			});
		}

		/* --------------------附件列表：结束------------------------------ */
	</script>
</body>
</html>