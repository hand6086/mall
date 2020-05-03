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
	height:20px;
	width:120px;
}
.td-input{
	width:160px;
/* 	height:30px; */
	padding-left: 10px;
}
/* -- td css end -- */

.td-input-input{
	width:150px;
}
</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false" style="width: 100%; height: 100%; padding: 0px;">
    <div data-options="region:'center'" collapsible="false" title="" border="false" style="width:100%;height:97%;padding:0px;">
	  <div  data-options="fit:true" style="width:100%;padding:1px;"> 
	    <fieldset>
			<legend>国内下单通知书</legend>
		<form id="internalOrderForm" method="post">
			<table style="width:100%;">
				<tr>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>合同编号：</label></td>
								<td class="td-input">
								    <input hidden="true" name="id" id="id"/>
									<input hidden="true" name="orderNoticeId" id="orderNoticeId"/>
									<input hidden="true" name="orderNoticeType" id="orderNoticeType"/>
									<input class="easyui-textbox td-input-input" name="contractCode" id="contractCode" data-options="required:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机编码：</label></td>
								<td class="td-input">
									<input name="optyId" id="optyId" hidden="true"/>
								    <input class="easyui-textbox td-input-input"  name="optyCode" id="optyCode" disabled="disabled"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机名称：</label></td>
								<td class="td-input">
								    <input class="easyui-textbox td-input-input" name="optyName" id="optyName"/> 
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机地点：</label></td>
								<td class="td-input">
									 <input class="easyui-textbox td-input-input" name="optyAddr" id="optyAddr" disabled="disabled"/>
								</td>
							</tr>
							
							<tr>
								<td class="td-label">
									<label>客户名称：</label> 
								</td>
								<td class="td-input">
									<input class="easyui-textbox td-input-input" name="acctName" id="acctName" /> 
									<input hidden="true" name="acctId" id="acctId"/>
								</td>
							</tr>
							
							<tr>
								<td class="td-label">
									<label>业务员：</label>
								</td>
								<td class="td-input">
								    <input  hidden="true" name="postnId" id="postnId"/>
									<input class="easyui-textbox td-input-input" name="salesmenName" id="salesmenName"/>
								</td>
							</tr>
							<tr>
								<td class="td-label">
									<label>业务员电话：</label>
								</td>
								<td class="td-input">
									<input class="easyui-textbox td-input-input" name="salesmenPhone" id="salesmenPhone" disabled="disabled"/>
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
									<td class="td-label">
										<label>业务类型：</label>
									</td>
									<td class="td-input">
										 <input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('BUSINESS_TYPE'),
																editable:false
																}"
										 class="easyui-combobox td-input-input" name="serviceType" id="serviceType"/> 
									</td>
							</tr>			
							<tr>
									<td class="td-label">
										<label>下单类型：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('PLACE_ORDER_TYPE'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="placeOrderType" id="placeOrderType"/>
									</td>
							</tr>
							<tr>
								<td class="td-label">
									<label>进场时间：</label>
								</td>
								<td class="td-input">
									<input class="easyui-datebox td-input-input" name="approachDt" id="approachDt"/>
								</td>
							</tr>
							<tr>
									<td class="td-label">
										<label>完工时间：</label>
									</td>
									<td class="td-input">
										<input class="easyui-datebox td-input-input" name="completedDt" id="completedDt"/>
									</td>
							</tr>	
								<tr>
									<td class="td-label">
										<label>所属区域：</label>
									</td>
									<td class="td-input">
										<input  hidden="true" name="orgId" id="orgId"/>
										<input class="easyui-textbox td-input-input" name="orgName" id="orgName"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">
										<label>现场负责人：</label>
									</td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="sceneChargeName" id="sceneChargeName"/>
									</td>
								</tr>	
								<tr>
									<td class="td-label">
										<label>现场负责人电话：</label>
									</td>
									<td class="td-input">
										<input class="easyui-numberbox td-input-input" name="sceneChargePhone" id="sceneChargePhone"/>
									</td>
								</tr>													
						</table>
					</td>
					<td>
						<table>
								<tr>
									<td class="td-label">
										<label>状态：</label> 
								    </td>
									<td class="td-input">
										 <input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('ORDER_STATUS'),
																editable:false
																}"
										 class="easyui-combobox td-input-input" name="status" id="status" disabled="true"/> 
									</td>
							    </tr>
							    
								<tr>
									<td class="td-label">
										<label>门：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('DOOR_COLOR'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="door" id="door"/>
									</td>
								</tr>		
								<tr>
									<td class="td-label">
										<label>门材质：</label>
									</td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="doorMaterial" id="doorMaterial"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">
										<label>窗户类型：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('WINDOW_TYPE'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="windowType" id="windowType"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">
										<label>窗户配件：</label>
									</td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="windowParts" id="windowParts"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">
										<label>屋面瓦：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('ROOF_TILE_TYPE'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="roofTile" id="roofTile"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">
										<label>外包项：</label>
									</td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="outsourceType" id="outsourceType"/>
									</td>
								</tr>
						</table>
					</td>
					<td>
						<table>
						
						       <tr>
									<td class="td-label">
										<label>板墙厚：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('WALL_THICKNESS_TYPE'),
																editable:false
																}"
										   class="easyui-combobox td-input-input" name="wallThickness" id="wallThickness"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label">
										<label>其他配件：</label>
									</td>
									<td class="td-input">
										<input class="easyui-textbox td-input-input" name="otherParts" id="otherParts"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label">
										<label>进场条件：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('APPROACH_CONDITION'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="approachCondition" id="approachCondition"/>
									</td>
								</tr>		
								<tr>
									<td class="td-label">
										<label>基础类型：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('BASE_TYPE'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="baseType" id="baseType"/>
									</td>
								</tr>	
								
								<tr>
									<td class="td-label">
										<label>用电情况：</label>
									</td>
									<td class="td-input">
										<input data-options="{	valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('ELECTRICITY_TYPE'),
																editable:false
																}"
										class="easyui-combobox td-input-input" name="electricityUsage" id="electricityUsage"/>
									</td>
								</tr>
									
								<tr>
									<td class="td-label" rowspan="2">
										<label>其他说明：</label>
									</td>
									<td class="td-input" rowspan="2">
										<input class="easyui-textbox td-input-input"  name="approachOther" id="approachOther" data-options="multiline:true"  style="height:60px;" />
									</td>
								</tr>								
						</table>
					</td>
				</tr>
			</table>
			 <div id="prodpickList" style="display:none;">
					<input name="pickListId" id="pickListId"/>
			 </div>
		</form>
		<div style="width:100%;height:30px;padding:0px;margin-top:10px;" margin-bottom:10px;">
				<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
					plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="goBack()">取消</a>
		    	<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
		    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="saveInnerNoticeInfo()">保存</a>
		</div>
		</fieldset>
		</div>
		<div data-options="region:'center',split:true" border="false" style="width:100%;height:70%">
			<div class="easyui-tabs" data-options="fit:true">
			
				<div title="产品型号及数量" style="height: 100%;width: 100%">
					<table id="prodInfo-table"  data-options="fit:true">
						<thead>
							<th field="prodName" width="200px"  editor="{type:'picklistbox',options:{title:'选择产品',
	   			   																		completeFun:prodPickListComplete,
	   			   																		tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp',
		   			   																		required:true}}">产品名称</th>
						    <th field="prodComments" width="200px"  editor="{type:'textbox'}">产品详细说明</th>
						    <th field="specs" width="200px"  editor="{type:'textbox'}">规格</th>
						    <th field="ridgepoleNum" width="200px"  editor="{type:'numberbox'}">栋数</th>
						    <th field="area" width="200px"  editor="{type:'numberbox',options:{min:0,precision:7}}">面积(平方米)</th>
						</thead>
					</table>
				</div>
				
				<div title="附件" style="height: 100%;width: 100%">
					<table id="attachment-table" data-options="fit:true">
						<thead>
							<tr>
								<th field="attachmentOriginal" width="160px" formatter="attachmentOriginalFormatter">附件</th>
								<th field="comments" editor="{type:'textbox'}" width="300px">备注信息</th>
							</tr>
						</thead>
					</table>
					<!--------------------------传附件弹出框：开始------------------------------>
					<div id="upload_attachment" >
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'center',border:false,fit:true" style="padding:10px;background:#fff;border:1px solid #ccc;">
						        <form method="post" class="uploadAttachmentForm" style="text-align:center;margin-top: 30px;" enctype="multipart/form-data" border:true>
	 								<table id="uploadAttachment-table" style="height: 100%;weight:100%;border-collapse:separate; border-spacing:10px;">
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
					<!--------------------------传附件弹出框：结束------------------------------>
				</div>
				
				<div title="审批记录" style="height: 100%;width: 100%">
					<table id="approvalRecord-table" data-options="fit:true">
						<thead>
							<tr>
								<th field="approvalNodeDesc"  width="150px">审批节点描述</th>
								<th field="approvalUserName" width="100px">审批人</th>
							    <th field="approvalEnd"  width="150px" >审批时间</th>
					    		<th field="approvalOpera" width="150px">审批操作</th>
							    <th field="approvalView" width="250px">审批意见</th>
							</tr>
						</thead>
					</table>
				</div>
				
			</div>
		</div>
	</div>
  </div>
	<script type="text/javascript">
		var existRecord  = false;
		var noticeId = getUrlParams("id");
		var agrId = "noMatchSelect";
		
		$headerForm = $("#internalOrderForm");   //头表单
		$dataProdgrid = $('#prodInfo-table');
		$dataApprovalgrid = $('#approvalRecord-table');
		$dataAttachmentgrid = $('#attachment-table');
		
		//变量输入框绑定
		$idInput = $('#id');                                    //下单通知书记录ID
		$orderNoticeTypeInput = $('#orderNoticeType');          //下单通知书类型
		$orderNoticeIdInput = $('#orderNoticeId');              //下单通知书ID
		$acctIdInput = $('#acctId');                            //客户ID
		$acctNameInput = $('#acctName');                        //客户名称
		$contractCodeInput = $('#contractCode');                //合同编码
		$serviceTypeCombobox = $('#serviceType');               //业务类型
		$placeOrderTypeCombobox = $('#placeOrderType');         //下单类型
		$approachDtDatebox = $('#approachDt');                  //进场时间
		$completedDtDatebox = $('#completedDt');                //完成时间
		$postnIdInput = $('#postnId');                          //业务员ID
		$salesmenNameInput = $('#salesmenName');                //业务员姓名
		$salesmenPhoneInput = $('#salesmenPhone');              //业务员姓名
		$sceneChargeNameInput = $('#sceneChargeName');          //现场负责人姓名
		$sceneChargePhoneInput = $('#sceneChargePhone');        //现场负责人电话
		$wallThicknessCombobox = $('#wallThickness');           //板墙厚度
		$doorCombobox = $('#door');                             //门
		$doorMaterialInput = $('#doorMaterial');                //门材料
		$windowTypeCombobox = $('#windowType');                 //窗子
		$windowPartsInput = $('#windowParts');                  //窗配件
		$roofTileCombobox = $('#roofTile');                     //房屋瓦
		$outsourceTypeInput = $('#outsourceType');              //外包项
		$otherPartsInput = $('#otherParts');                    //其他配件
		$approachConditionCombobox = $('#approachCondition');   //进场条件
		$baseTypeCombobox = $('#baseType');                     //基础类型
		$electricityUsageCombobox = $('#electricityUsage');     //用电情况
		$approachOtherInput = $('#approachOther');              //进场其他说明
		$optyIdInput = $('#optyId');                            //商机ID
		$optyCodeInput = $('#optyCode');                        //商机编码
		$optyNameInput = $('#optyName');                        //商机名称
		$optyAddrInput = $('#optyAddr');                        //商机地点
		$orgIdInput = $('#orgId');                              //组织ID
		$orgNameInput = $('#orgName');                          //所属区域
		
		//客户PickList
		$acctPickList = $("#acctName");
		$acctPickList.picklist({
			title:'客户列表',
			required:true,
			completeFun:function(selectRow){
				if(selectRow){
					$acctNameInput.textbox('setValue', selectRow.acctName);
					$acctIdInput.val(selectRow.id);
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'
		});
		//商机PickList
		$optyPickList = $("#optyName");
		$optyPickList.picklist({
			title:'商机列表',
			required:false,
			completeFun:function(selectRow){
				if(selectRow){
					$optyNameInput.textbox('setValue',selectRow.optyName);
					$optyIdInput.val(selectRow.id);
					$optyCodeInput.textbox('setValue',selectRow.id);
					$optyAddrInput.textbox('setValue',selectRow.optyAddr);
					//客户默认从商机带出,可进行修改
					/* var acctId = $acctIdInput.val();
					if(acctId == null ||acctId ==''){
						$acctIdInput.val(selectRow.accntId);
						$acctNameInput.textbox('setValue',selectRow.accnt);
					} */
					//直接带出商机的客户信息
					$acctIdInput.val(selectRow.accntId);
					$acctNameInput.textbox('setValue',selectRow.accnt);
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp'
		});
		//所属区域PickList
		$orgPickList = $("#orgName");
		$orgPickList.picklist({
			title:'组织列表',
			required:false,
			completeFun:function(selectRow){
				if(selectRow){
					$orgNameInput.textbox('setValue',selectRow.text);
					$orgIdInput.val(selectRow.id);
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'
		});
		//业务员PickList
		$salesmenPickList = $("#salesmenName");
		$salesmenPickList.picklist({
			title:'用户列表',
			required:true,
			completeFun:function(selectRow){
				if(selectRow){
					$postnIdInput.val(selectRow.id);
					$salesmenNameInput.textbox('setValue',selectRow.fstName);
					$salesmenPhoneInput.textbox('setValue',selectRow.empTel);
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/PostnJoinByEmpPickList.jsp'
		});
		
		//页面元素加载完成事件
		$(document).ready(function() { 
			noticeInfoInit();
		}); 
		
		/*
		 * 头表单及信息初始化
		 */
		function noticeInfoInit(){
			var formUrl = '';
			if(noticeId == null || noticeId =="noMatchSelect"){                      //新建国内下单通知书
				formUrl = '${AppContext.ctxPath}/action/portal/saleorder/insert';       //新建时头表单URL
				$.post("${AppContext.ctxPath}/action/portal/saleorder/newInnerNotice",{
				},function(data){
					if(data.success){
						var record = data.result;
						noticeId = record.id;
						$('#internalOrderForm').form("load", record);
					}
					else{
						$.messager.alert("警告", data.result);
					}
				});
			}
			else{                                                                    //编辑国内下单通知书
				formUrl = '${AppContext.ctxPath}/action/portal/saleorder/update';    //编辑时头表单URL
				existRecord = true;         
				$.post("${AppContext.ctxPath}/action/portal/saleorder/queryById", {
					id : noticeId
				}, function(data) {
					if (data.success) {
						var record = data.result;
						$('#internalOrderForm').form("load", record);
					} else {
						$.messager.alert("警告", data.result);
					}
				});
			}
			
			//初始化头表单
			$headerForm.form({
				url : formUrl,
				onSubmit : function(){
					return $headerForm.form('validate');
				}
			});
		};	

	 	/**
		 * 保存头信息
		 */		
	 	function saveInnerNoticeInfo(){
	 		if(!existRecord){
	 			$headerForm.form("submit",{
					success : function(data){
						var data = eval('(' + data + ')'); // change the JSON string to javascript object
						if (data.success) {
							existRecord = true; 
							var updateUrl = '${AppContext.ctxPath}/action/portal/saleorder/update';    //编辑时头表单URL
							$headerForm.form('options').url = updateUrl;                               
							window.parent.operationtip('保存成功！','info');
						} else {
							window.parent.operationtip(data.result,'error');
						}
					}
				});
	 		}
	 		else{
	 			$headerForm.form("submit",{
					success : function(data){
						var data = eval('(' + data + ')'); // change the JSON string to javascript object
						if (data.success) {
							existRecord = true;
							window.parent.operationtip('更新成功！','info');
						} else {
							window.parent.operationtip(data.result,'error');
						}
					}
				});
	 		}
		}; 

		//产品型号和数量hdatagrid
	 	$dataProdgrid.hdatagrid({
	 		updateable : true,
			toolbarShow:true,
			buttonNew:true,
			buttonSearch:true,
			buttonDelete:true,
			striped:true,
			border:false,
			rownumbers:true,	//默认显示行号
			pagination:true,	//默认分页功能
			pageSize: 5,//每页显示的记录条数，默认为20 
			pageList: [5,10,15],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/saleorderitem/queryByExamplePage',
			onBeforeLoad:function(param){
				param.headId = noticeId;
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(98,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-mini-add" plain="true" onclick="getProds()">获取产品</a>',that);
			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							headId       : noticeId,
							id           : row.id,
							prodId       : row.prodId,
							prodName     : row.prodName,
							prodComments : row.prodComments,
							specs        : row.specs,
							ridgepoleNum : row.ridgepoleNum,
							area         : row.area
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/saleorderitem/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/saleorderitem/upsert', {
					row_status   : row.row_status,
					headId       : noticeId,
					id           : row.id,
					prodId       : row.prodId,
					prodName     : row.prodName,
					prodComments : row.prodComments,
					specs        : row.specs,
					ridgepoleNum : row.ridgepoleNum,
					area         : row.area
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
						$.post('${AppContext.ctxPath}/action/portal/saleorderitem/deleteById', {
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
			}
			
	 	});
		
	 	/**
		 * 产品picklist回调事件
		 */
	 	function prodPickListComplete(selectRow){
	 		$dataProdgrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
			return selectRow.prodName;
	 	};
	 	
	 	//审批记录hdatagrid
	 	$dataApprovalgrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 5,//每页显示的记录条数，默认为20 
			pageList: [5,10,15],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/flowRecord/listApproRecord',
			onBeforeLoad:function(param){
				param.id = noticeId
			}
	 	});
	 	
	 	//附件上传hdatagrid
		$dataAttachmentgrid.hdatagrid({
			updateable : true,
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			striped:true,
			border:false,
			rownumbers:true,	//默认显示行号
			pagination:true,	//默认分页功能
			pageSize: 5,//每页显示的记录条数，默认为20 
			pageList: [5,10,15],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
			onBeforeLoad:function(param){
				if(noticeId != "noMatchSelect")
					param.id = noticeId
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(39,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment()">新建</a>',that);
			},
			onUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/attachment/update', {
					id			:row.id,
					comments	:row.comments
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
			}
		});
	 	
		/* --------------------附件列表：开始------------------------------ */ 
		$uploadAttachmentDiv = $('#upload_attachment');
		function openUploadAttachment(){
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
			if(!noticeId){
				$.messager.alert("警告","获取国内下单通知书Id失败,请刷新页面重试！");
				return;
			}
			$.messager.progress();
			var options = {
	   				url:'${AppContext.ctxPath}/action/portal/attachment/insert',
	   				type:'post',
					data : formatRequest({
								headId 		: noticeId,
								moduleType 	: "Domestic OrderNotice",
								headCode 	: noticeId
							}),
					dataType : 'json',
					contentType : "application/vnd.ms-excel;charset=utf-8",
					success : function(data) {
						if (data.success) {
							$.messager.progress('close');
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
			};
			
		/**
		 *附件下载
		 */
		function attachmentOriginalFormatter(val, row) {
			if (val != null) {
				var content = "点击下载";
				return "<a href='###' class='easyui-tooltip' title='"
				+ content + "' onclick='window.open(\"" + row.attachmentPath + "\")'>" + val + "</a>";
			}
		};
		
	 	/**
	 	 * 获取合同产品行
	 	 */
		function getProds(){
 			var sContractCode = $contractCodeInput.textbox('getValue');
	 		if(sContractCode == null || sContractCode == ""){
	 			window.parent.operationtip("请先输入合同编号,再获取产品行信息！", 'info');
	 		}
	 		else{
	 			if(agrId == "noMatchSelect" || agrId == null){
	 				$.post("${AppContext.ctxPath}/action/portal/saleorder/getContractId",{
		 				contractCode : sContractCode
					},function(data){
						if(data.success){
							var record = data.result;
							if(record){
								agrId = record.id;
								getContractProds();
							}
						}
						else{
							$.messager.alert("警告", data.result);
						}
					})
	 			}
	 			else{
	 				getContractProds();
	 			}
	 		}
		}; 
		
		/**
		 * 获取对应合同审批下产品行
		 */
		function getContractProds(){
			//选择合同审批产品行PickList
			$prodPickList = $("#pickListId");
		    $prodPickList.multiSelect({ 
				title:'合同产品行',
				completeFun:function(selectedRow){
				 	var visitRecords = [];
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						visitRecords.push({
							headId      : noticeId,
							prodId      : selectedRow[i].prodId,        //产品id
							prodName    : selectedRow[i].prodName,      //产品名称
							prodComments: selectedRow[i].prodDesc,       //产品详细说明
						    specs 		: selectedRow[i].spec,          //规格
							ridgepoleNum: selectedRow[i].buildNum,      //栋数个数
							area        : selectedRow[i].area            //面积
						});
					}
					$.ajax({	
							type: "POST",
				            url: "${AppContext.ctxPath}/action/portal/saleorderitem/batchInsert",
				            data: JSON.stringify(visitRecords),
				            dataType: "json",	
				            contentType: 'application/json', 
				            success:function(data){
								if(data.success){
									$dataProdgrid.hdatagrid("reload");
								}else{
									$.messager.alert("警告",data.result);
								}
							}
					}); 
				},
				initParam:function(){
					return {id : agrId};
				},
				tableUrl:'${AppContext.ctxPath}/portal/notice/picklist/DomesticAgrProds.jsp'
			}); 
		}
	</script>
</body>
</html>