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
			<div id="header" class="easyui-panel" style="height:300px" data-options="border:false">
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
										<td class="td-label"><label>业务类型 :</label></td>
										<td class="td-content">
											<input id="busType" name="busType" class="easyui-combobox" 
													data-options="method:'get',
																data:getLovArray('AGR_BUSTYPE'),
																valueField:'name',
																textField:'name',
															    editable:false,
															    cache: false,
															    onChange:function(newValue, oldValue){
															    	leaseDateBoxSwitch(newValue);
																},
																onLoadSuccess: function (data) {
																	leaseDateBoxSwitch($busTypeObj.combobox('getValue'));
																}"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>租赁开始日期 :</label></td>
						         		<td class="td-content">
						         			<input id="leaseStrdate" name="leaseStrdate" class="easyui-datebox" data-options="editable:false" />
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>租赁结束日期 :</label></td>
						         		<td class="td-content">
						         			<input id="leaseEnddate" name="leaseEnddate" class="easyui-datebox" data-options="editable:false" />
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>合同版本 :</label></td>
										<td class="td-content">
											<input class="easyui-textbox" id="agrVersion" name="agrVersion" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>所属区域 :</label></td>
										<td class="td-content">
											<input id="orgName" name="orgName"/>
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
										<td class="td-label"><label>客户评级 :</label></td>
										<td class="td-content">
											<input id="acctLevel" name="acctLevel" class="easyui-textbox" disabled="disabled"/>
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
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>基础 :</label></td>
						         		<td class="td-content">
						         			<input id="base" name="base" class="easyui-numberbox" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>地坪 :</label></td>
										<td class="td-content">
						         			<input id="floor" name="floor" class="easyui-numberbox" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>吊顶 :</label></td>
										<td class="td-content">
						         			<input id="ceiling" name="ceiling" class="easyui-numberbox" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>水电 :</label></td>
										<td class="td-content">
											<input id="hydropower" name="hydropower" class="easyui-numberbox" data-options="precision:2"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>其它 :</label></td>
										<td class="td-content">
						         			<input id="other" name="other" class="easyui-numberbox" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr><td class="td-label"><td class="td-content"></td></tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>吊装运输金额 :</label></td>
										<td class="td-content">
						         			<input id="transAmount" name="transAmount" class="easyui-numberbox" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>配套材料金额 :</label></td>
										<td class="td-content">
						         			<input id="materialsAmount" name="materialsAmount" class="easyui-numberbox" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>外包金额合计 :</label></td>
										<td class="td-content">
						         			<input id="outseTlAmount" name="outseTlAmount" class="easyui-textbox" disabled="disabled" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>总金额合计 :</label></td>
										<td class="td-content">
						         			<input id="totalAmount" name="totalAmount" class="easyui-textbox" disabled="disabled" data-options="precision:2"/>
						         		</td>
									</tr>
									<tr><td class="td-label"><td class="td-content"></td></tr>
									<tr><td class="td-label"><td class="td-content"></td></tr>
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
				<!-- tabs1 产品数量及价格 -->
				<div title="产品数量及价格">
					<div data-options="region:'center'" border="false" style="width:100%;height:100%;padding:0px;">
						<table id="agrDetail-table" fit="true">
							<thead>
								<tr>
									<th field="prodName" width="150px" editor="{type:'picklistbox',options:{title:'选择产品',
															required:true,
															completeFun:prodNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp'}}">产品名称/型号</th>
									<th field="prodDesc" width="150px" editor="{type:'validatebox'}">产品详细说明</th>
									<th field="spec" width="150px" editor="{type:'validatebox'}">规格</th>
									<th field="buildNum" width="150px" editor="{type:'numberbox',options:{precision:2}}">栋数个数</th>
									<th field="area" width="150px" editor="{type:'numberbox',options:{precision:2}}">面积(平方米)</th>
									<th field="price" width="150px" currency="CNY" editor="{type:'numberbox',options:{precision:2}}">单价</th>
									<th field="amount" width="150px" currency="CNY">金额</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				
				<!-- tabs2 付款方式 -->
				<div title="付款方式">
					<div data-options="region:'center'" border="false" style="width:100%;height:100%;padding:0px;">
						<table id="agrDemand-table" fit="true">
							<thead>
								<tr>
									<th field="paymentType" width="30%" lov="AGR_PAYTYPE" editor="{type:'combobox',options:{
																			valueField:'name',
																			textField:'name',
																			required:true,
																			method:'get',
																			data:getLovArray('AGR_PAYTYPE'),
																			editable:false}}">付款类型</th>
									<th field="paymentInstr" width="30%" editor="{type:'validatebox'}">付款说明</th>
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
			totalInit();
		});
		getLovOfList("[AGR_PAYTYPE]");
		getLovOfList("[AGR_BUSTYPE]");
		getLovOfList("[AGR_TYPE]");
		getLovOfList("[AGR_PRODPRO]");
		var headerIsEditing = true; //头表单信息是否为编辑状态 标志
		var initHeadId = getUrlParams("id");
		$headerForm = $("#headerForm");//头表单
		headerFormTagInit();
		headerInfoInit();
		$agrDetailDatagrid = $('#agrDetail-table');//产品数量及价格
		$agrDemandDatagrid = $('#agrDemand-table');//付款方式
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
		//产品数量及价格
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
		//付款方式
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
		$busTypeObj				= $('input[name=busType]',$('#headerForm'));//业务类型
		$agrVersionObj			= $('input[name=agrVersion]',$('#headerForm'));//合同版本
		$acctNameObj			= $('input[name=acctName]',$('#headerForm'));//客户名称 
		$optyNameObj			= $('input[name=optyName]',$('#headerForm'));//商机名称    
		$orgNameObj				= $('input[name=orgName]',$('#headerForm'));//所属区域
		$fstNameObj				= $('input[name=fstName]',$('#headerForm'));//业务员姓名
		$leaseStrdateObj		= $('input[name=leaseStrdate]',$('#headerForm'));//租赁开始日期
		$leaseEnddateObj		= $('input[name=leaseEnddate]',$('#headerForm'));//租赁结束日期
		$baseObj				= $('input[name=base]',$('#headerForm'));//基础
		$floorObj				= $('input[name=floor]',$('#headerForm'));//地坪
		$ceilingObj				= $('input[name=ceiling]',$('#headerForm'));//吊顶
		$hydropowerObj			= $('input[name=hydropower]',$('#headerForm'));//水电
		$otherObj				= $('input[name=other]',$('#headerForm'));//其它
		$transAmountObj			= $('input[name=transAmount]',$('#headerForm'));//吊装运输金额
		$materialsAmountObj		= $('input[name=materialsAmount]',$('#headerForm'));//配套材料金额
		//只读标签---
		$acctLevelObj			= $('input[name=acctLevel]',$('#headerForm'));//客户评级
		$optyAddrObj			= $('input[name=optyAddr]',$('#headerForm'));//商机地址
		$empTelObj				= $('input[name=empTel]',$('#headerForm'));//业务员电话
		$outseTlAmountObj		= $('input[name=outseTlAmount]',$('#headerForm'));//外包金额合计
		$totalAmountObj			= $('input[name=totalAmount]',$('#headerForm'));//总金额合计
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
			gotoContentPage('${AppContext.ctxPath}/portal/agreement/DomesticAgrList.jsp');
	    }
		$acctNameObj.picklist({
			title:'选择客户',
			required:true,
			completeFun:function(selectedRow){
				$('input[name=accntId]',$('#headerForm')).val(selectedRow.id);
				$acctLevelObj.textbox('setValue', selectedRow.acctLevel);
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
				url = '${AppContext.ctxPath}/action/portal/agreement/domesticNewInit';
			} else {
				url = '${AppContext.ctxPath}/action/portal/agreement/queryById';
			}
			$.post(url,
				{
				id:initHeadId
				},
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
				$busTypeObj.combobox('enable');
				$agrVersionObj.textbox('enable');
				$acctNameObj.textbox('enable');
				$optyNameObj.textbox('enable');
				$orgNameObj.textbox('enable');
				$fstNameObj.textbox('enable');
				$leaseStrdateObj.datebox('enable');
				$leaseEnddateObj.datebox('enable');
				$baseObj.numberbox('enable');
				$floorObj.numberbox('enable');
				$ceilingObj.numberbox('enable');
				$hydropowerObj.numberbox('enable');
				$otherObj.numberbox('enable');
				$transAmountObj.numberbox('enable');
				$materialsAmountObj.numberbox('enable');
				headerIsEditing = true;
			}
		}
		/**
		 * 设置客户头信息的输入框为 不可编辑 状态
		 */
		function headFormDisable(){
			if(headerIsEditing){
				$agrNumberObj.textbox('disable');
				$busTypeObj.combobox('disable');
				$agrVersionObj.textbox('disable');
				$acctNameObj.textbox('disable');
				$optyNameObj.textbox('disable');
				$orgNameObj.textbox('disable');
				$fstNameObj.textbox('disable');
				$leaseStrdateObj.datebox('disable');
				$leaseEnddateObj.datebox('disable');
				$baseObj.numberbox('disable');
				$floorObj.numberbox('disable');
				$ceilingObj.numberbox('disable');
				$hydropowerObj.numberbox('disable');
				$otherObj.numberbox('disable');
				$transAmountObj.numberbox('disable');
				$materialsAmountObj.numberbox('disable');
				headerIsEditing = false;
			}
		}
		/**
		 * 设置【租赁开始日期】和【租赁结束日期】控件开启或关闭
		 * @param busType 业务类型
		 */
		function leaseDateBoxSwitch(busType){
			var leaseName = getLovShowName('AGR_BUSTYPE', 'Lease');
			var busTypeName = getLovShowName('AGR_BUSTYPE', busType);
			if(leaseName == busType || leaseName == busTypeName){
				$leaseStrdateObj.datebox('enable');
				$leaseEnddateObj.datebox('enable');
			} else {
				$leaseStrdateObj.datebox('disable');
				$leaseEnddateObj.datebox('disable');
				$leaseStrdateObj.datebox('setValue','');
				$leaseEnddateObj.datebox('setValue','');
			}
		}
		/**
		 * 为数字输入框设置事件
		 */
		function totalInit(){
			$baseObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($baseObj)}}});
			$floorObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($floorObj)}}});
			$ceilingObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($ceilingObj)}}});
			$hydropowerObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($hydropowerObj)}}});
			$otherObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($otherObj)}}});
			$transAmountObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($transAmountObj)}}});
			$materialsAmountObj.numberbox({onChange: setTotal,events:{"focus":function(){numFocus($materialsAmountObj)}}});
		} 
		/**
		 * 如果输入框的值为0，则清空输入框
		 */
		function numFocus(obj){
			var value = parseFloat(obj.numberbox('getValue'));
			if(value == 0){
				obj.numberbox('clear');
			}
		}
		/**
		 * 统计数值，并且设置显示
		 */
		function setTotal(newValue,oldValue){
			var base = parseFloat($baseObj.numberbox('getValue'));
			var floor = parseFloat($floorObj.numberbox('getValue'));
			var ceiling = parseFloat($ceilingObj.numberbox('getValue'));
			var hydropower = parseFloat($hydropowerObj.numberbox('getValue'));
			var other = parseFloat($otherObj.numberbox('getValue'));
			var transAmount = parseFloat($transAmountObj.numberbox('getValue'));
			var materialsAmount = parseFloat($materialsAmountObj.numberbox('getValue'));
			var outseTlAmount = (isNaN(base) == true ? 0 : base)
							  + (isNaN(floor) == true ? 0 : floor)
							  + (isNaN(ceiling) == true ? 0 : ceiling)
							  + (isNaN(hydropower) == true ? 0 : hydropower)
							  + (isNaN(other) == true ? 0 : other);
			var totalAmount = outseTlAmount 
							+ (isNaN(transAmount) == true ? 0 : transAmount)
							+ (isNaN(materialsAmount) == true ? 0 : materialsAmount);
			$outseTlAmountObj.textbox('setValue', outseTlAmount);
			$totalAmountObj.textbox('setValue', totalAmount);
		}
	</script>
</body>
</html>