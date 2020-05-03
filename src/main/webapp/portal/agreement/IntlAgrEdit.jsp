<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	width:300px;
}
.td-label {
	width:90px;
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
		<div data-options="region:'center'" title="合同审批表" fit="true">
			<div id="header" class="easyui-panel" style="height:250px;" data-options="border:false">
				<form id="headerForm" method="post">
					<table class="form-table">
						<tr>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>合同编号 :</label></td>
										<td class="td-content">
											<input class="easyui-textbox" id="agrNumber" name="agrNumber" required="true"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>合同类型 :</label></td>
										<td class="td-content">
											<input id="agrType" name="agrType" class="easyui-combobox" 
													data-options="method:'get',
																data:getLovArray('AGR_TYPE'),
																valueField:'name',
																textField:'name',
															    editable:false,
															    cache: false"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>合同版本 :</label></td>
										<td class="td-content">
											<input class="easyui-textbox" id="agrVersion" name="agrVersion" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>产品性质 :</label></td>
						         		<td class="td-content">
											<input id="prodProperties" name="prodProperties" class="easyui-combobox" 
													data-options="method:'get',
																data:getLovArray('AGR_PRODPRO'),
																valueField:'name',
																textField:'name',
															    editable:false,
															    cache: false"/>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>客户名称 :</label></td>
										<td class="td-content">
											<input id="acctName" name="acctName"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>商机名称 :</label></td>
										<td class="td-content">
											<input id="optyName" name="optyName" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>商机地址 :</label></td>
						         		<td class="td-content">
						         			<input id="optyAddr" name="optyAddr" class="easyui-textbox" disabled="disabled"/>
						         		</td>
									</tr>
									<tr><td class="td-label"><td class="td-content"></td></tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>所属区域 :</label></td>
										<td class="td-content">
											<input id="orgName" name="orgName"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>业务员姓名 :</label></td>
						         		<td class="td-content">
						         			<input id="fstName" name="fstName"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>业务员电话 :</label></td>
						         		<td class="td-content">
						         			<input id="empTel" name="empTel" class="easyui-textbox" disabled="disabled"/>
						         		</td>
									</tr>
									<tr><td class="td-label"><td class="td-content"></td></tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label" rowspan="4"><label>合同摘要 :</label></td>
										<td class="td-content" rowspan="4">
											<input id="agrAbstract" name="agrAbstract" class="easyui-textbox" data-options="multiline:true" 
												style="height:120px;"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<input type="hidden" name="id" id="argId"/>
					<input type="hidden" name="agrCategory" id="agrCategory"/>
					<input type="hidden" name="accntId" id="accntId"/>
					<input type="hidden" name="optyId" id="optyId"/>
					<input type="hidden" name="postnId" id="postnId"/>
					<input type="hidden" name="orgId" id="orgId"/>
				</form>
				<div style="width:100%;height:30px;padding:0px;margin-top:30px;">
					<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
						plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="goBack()">取消</a>
			    	<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
			    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="headerUpdate()">保存</a>
			    </div>
			</div>
		
			<div id="body-tabs" class="easyui-tabs" style="width:'$(window).width() - 18';height:400px;"
				data-options="border:false">
				<!-- tabs1 合同摘要明细 -->
				<div title="合同摘要明细">
					<div data-options="region:'center'" border="false" style="width:100%;height:100%;padding:0px;">
						<table id="agrDetail-table" fit="true">
							<thead>
								<tr>
									<th field="prodName" width="150px" editor="{type:'picklistbox',options:{title:'选择产品',
															required:true,
															completeFun:prodNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp'}}">产品名称或分类</th>
									<th field="totalPrice" width="150px" currency="CNY" editor="{type:'numberbox'}">总售价</th>
									<th field="estiMcost" width="150px" currency="CNY" editor="{type:'numberbox',options:{precision:2}}">预估材料成本</th>
									<th field="estiLcost" width="150px" currency="CNY" editor="{type:'numberbox',options:{precision:2}}">预估人工成本</th>
									<th field="estiMprofit" width="150px" currency="CNY" editor="{type:'numberbox',options:{precision:2}}">预估边际利润</th>
									<th field="comments" width="250px" formatter="tooltipFormatter" editor="{type:'validatebox'}">备注</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				
				<!-- tabs2 需求简要 -->
				<div title="需求简要">
					<div data-options="region:'center'" border="false" style="width:100%;height:100%;padding:0px;">
						<table id="agrDemand-table" fit="true">
							<thead>
								<tr>
									<th field="demandItem" width="30%" lov="AGR_DEMAND_ITEM" editor="{type:'combobox',options:{
																			valueField:'name',
																			textField:'name',
																			required:true,
																			method:'get',
																			data:getLovArray('AGR_DEMAND_ITEM'),
																			editable:false}}">需求项目</th>
									<th field="demandDesc" width="30%" formatter="tooltipFormatter" editor="{type:'validatebox'}">需求描述</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<!-- tabs3 审批记录 -->
				<div title="审批记录">
					<div data-options="region:'center'" border="false" style="width:100%;height:100%;padding:0px;">
						<table id="approval-record-table" fit="true">
							<thead>
								<tr>
									<th field="approvalNodeDesc" width="150px">审批节点描述</th>
									<th field="approvalUserName" width="100px">审批人</th>
								    <th field="approvalEnd" width="150px" >审批时间</th>
						    		<th field="approvalOpera" width="150px" >审批操作</th>
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
		$(document).ready(function() {
			/* headerFormTagInit();
			headerInfoInit(); */
		});
		getLovOfList("[AGR_DEMAND_ITEM]");
		getLovOfList("[AGR_BUSTYPE]");
		getLovOfList("[AGR_TYPE]");
		getLovOfList("[AGR_PRODPRO]");
		var headerIsEditing = true; //头表单信息是否为编辑状态 标志
		var initHeadId = getUrlParams("id");
		$headerForm = $("#headerForm");//头表单
		headerFormTagInit();
		headerInfoInit();
		$agrDetailDatagrid = $('#agrDetail-table');//合同摘要明细
		$agrDemandDatagrid = $('#agrDemand-table');//需求简要
		$approvalRecordDatagrid = $('#approval-record-table');//审批记录
		
		$('#body-tabs').tabs({
			onSelect : function(title, index) {
				if (index == 1) {
				} else if (index == 2) {
				} else if (index = 3) {
				}
			}
		});

		/***********************************************************************************************************/
		//合同摘要明细
		$agrDetailDatagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
		    url:'${AppContext.ctxPath}/action/portal/agrDetail/queryByExamplePage',
			onBeforeLoad:function(param){
				param.id=initHeadId;
			},
			onInitNewData : function(that){
				return {agrId : initHeadId};
			},
		    buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/agrDetail/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/agrDetail/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction : function(row, successFun, errFun, that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/agrDetail/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
									/* var index = $agrDetailDatagrid.hdatagrid('getRowIndex', row)
									$agrDetailDatagrid.hdatagrid("deleteRow", index); */
								}
						});
					}
				});
			}
		});
		function prodNamePicklistComplete(selectRow){
			$agrDetailDatagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
			return selectRow.prodName;
		}
		
		/***********************************************************************************************************/
		//需求简要
		$agrDemandDatagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
		    url:'${AppContext.ctxPath}/action/portal/agrDemand/queryByExamplePage',
			onBeforeLoad:function(param){
				param.id=initHeadId;
			},
			onInitNewData : function(that){
				return {agrId : initHeadId};
			},
		    buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/agrDemand/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/agrDemand/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction : function(row, successFun, errFun, that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/agrDemand/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
									/* var index = $agrDetailDatagrid.hdatagrid('getRowIndex', row)
									$agrDetailDatagrid.hdatagrid("deleteRow", index); */
								}
						});
					}
				});
			}
		});
		
		/***********************************************************************************************************/
		//审批记录
		$approvalRecordDatagrid.hdatagrid({
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
		    url:'',
			onBeforeLoad:function(param){
				param.id=initHeadId;
			}
		});
		
		/***********************************************************************************************************/
		//头信息明细
		/* *********** 定义变量并且绑定输入框   start **************** */
		$agrNumberObj			= $('input[name=agrNumber]',$('#headerForm'));//合同编号
		$agrVersionObj			= $('input[name=agrVersion]',$('#headerForm'));//合同版本
		$acctNameObj			= $('input[name=acctName]',$('#headerForm'));//客户名称 
		$optyNameObj			= $('input[name=optyName]',$('#headerForm'));//商机名称    
		$orgNameObj				= $('input[name=orgName]',$('#headerForm'));//所属区域
		$fstNameObj				= $('input[name=fstName]',$('#headerForm'));//业务员姓名
		$agrTypeObj				= $('input[name=agrType]',$('#headerForm'));//合同类型
		$prodPropertiesObj		= $('input[name=prodProperties]',$('#headerForm'));//产品性质
		$agrAbstractObj			= $('input[name=agrAbstract]',$('#headerForm'));//合同摘要
		//只读标签---
		$optyAddrObj			= $('input[name=optyAddr]',$('#headerForm'));//商机地址
		$empTelObj				= $('input[name=empTel]',$('#headerForm'));//业务员电话
		/* *********** 定义变量并且绑定输入框   end **************** */
		
		var headerUpdateFlag = false;//按钮锁标志，防止按钮被重复点击
		/**  更新头信息 */
		function headerUpdate(){
			if(headerUpdateFlag){
				return;
			}
			headerUpdateFlag = true;//按钮加锁
			$headerForm.form("submit",{
				success : function(data){
					var data = eval('(' + data + ')'); // change the JSON string to javascript object
					if (data.success) {
						window.parent.operationtip('保存成功！','info');
						goBack();
					} else {
						window.parent.operationtip(data.result,'error');
					}
					headerUpdateFlag = false;//按钮解锁
				}
			});
		}
		/**
		 * 返回
		 */
		function goBack(){
			gotoContentPage('${AppContext.ctxPath}/portal/agreement/IntlAgrList.jsp');
	    }
		$acctNameObj.picklist({
			title:'选择客户',
			required:true,
			completeFun:function(selectedRow){
				$('input[name=accntId]',$('#headerForm')).val(selectedRow.id);
				return selectedRow.acctName;
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'
		});
		$optyNameObj.picklist({
			title:'选择商机',
			completeFun:function(selectedRow){
				$('input[name=optyId]',$('#headerForm')).val(selectedRow.id);
				$optyAddrObj.textbox('setValue', selectedRow.optyAddr);
				return selectedRow.optyName;
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp'
		});
		$orgNameObj.picklist({
			title:'选择区域',
			completeFun:function(selectedRow){
				$('input[name=orgId]',$('#headerForm')).val(selectedRow.id);
				return selectedRow.text;
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'
		});
		$fstNameObj.picklist({
			title:'选择业务员',
			required:true,
			tableUrl:'${AppContext.ctxPath}/portal/picklist/PostnJoinByEmpPickList.jsp',
			completeFun:function(selectedRow){
				$('input[name=postnId]',$('#headerForm')).val(selectedRow.id);
				$empTelObj.textbox('setValue', selectedRow.empTel);
				return selectedRow.fstName;
			}
		});
		/**
		 * 初始化表单标签
		 */
		function headerFormTagInit(){
			var formUrl = '';
			if(initHeadId == null || initHeadId == 'noMatchId'){//判断是否为新建
				formUrl = '${AppContext.ctxPath}/action/portal/agreement/insert';
			} else {
				formUrl = '${AppContext.ctxPath}/action/portal/agreement/update';
			}
			$headerForm.form({
				url : formUrl,
				onSubmit : function(){
					return $headerForm.form('validate');
				}
			});
		}
		/**
		 * 初始化输入框的默认值 和 状态
		 */
		function headerInfoInit(){
			var url = '';
			if(initHeadId == null || initHeadId == 'noMatchId'){//判断是否为新建
				url = '${AppContext.ctxPath}/action/portal/agreement/intlNewInit';
			} else {
				url = '${AppContext.ctxPath}/action/portal/agreement/queryById';
			}
			$.post(url,{id:initHeadId},
				function(data){
					if(data){
						if(data.success){
							var entity = data.result;
							initHeadId = entity.id;
							$headerForm.form("load", entity);
						}
					}
				});
			//设置输入框默认为不可编辑
			//headFormDisable();
		}
		/**
		 * 设置客户头信息的输入框为 编辑 状态
		 */
		function headFormEnable(){
			if(!headerIsEditing){
				$agrNumberObj.textbox('enable');
				$agrVersionObj.textbox('enable');
				$acctNameObj.textbox('enable');
				$optyNameObj.textbox('enable');
				$orgNameObj.textbox('enable');
				$fstNameObj.textbox('enable');
				$agrTypeObj.combobox('enable');
				$prodPropertiesObj.combobox('enable');
				$agrAbstractObj.textbox('enable');
				headerIsEditing = true;
			}
		}
		/**
		 * 设置客户头信息的输入框为 不可编辑 状态
		 */
		function headFormDisable(){
			if(headerIsEditing){
				$agrNumberObj.textbox('disable');
				$agrVersionObj.textbox('disable');
				$acctNameObj.textbox('disable');
				$optyNameObj.textbox('disable');
				$orgNameObj.textbox('disable');
				$fstNameObj.textbox('disable');
				$agrTypeObj.combobox('disable');
				$prodPropertiesObj.combobox('disable');
				$agrAbstractObj.textbox('disable');
				headerIsEditing = false;
			}
		}
	</script>
</body>
</html>