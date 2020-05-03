<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style>
.datagrid-cell-c2-amount {
	padding-right: 10px;
}

.datagrid-cell {
	padding-right: 2px;
	padding-left: 2px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false"
			fit="true">
			<fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">商机筛选条件</span>
				</legend>

				<div class="row keyfilter-border">
					<ul id="opty-stage-keyfilter" data-toggle="keyfilter"
						data-title="商机阶段" data-filter-filed="stage"
						data-table-Id="opty-table">
					</ul>
				</div>
				<div class="row keyfilter-border">
					<ul id="opty-status-keyfilter" data-toggle="keyfilter"
						data-title="商机状态" data-filter-filed="status"
						data-table-Id="opty-table">
					</ul>
				</div>
				<div class="row keyfilter-border">
					<ul id="opty-managerOrgName-keyfilter" data-toggle="keyfilter"
						data-title="所属部门" data-filter-filed="managerOrgName"
						data-table-Id="opty-table">
					</ul>
				</div>
				<div class="row keyfilter-border">
					<ul id="opty-rate-keyfilter" data-toggle="keyfilter"
						data-title="成交概率" data-filter-filed="rate"
						data-table-Id="opty-table">
					</ul>
				</div>

			</fieldset>

			<table id="opty-table" keyFilterDiv="keyFilter" singleSelect="true"
				rownumbers="true" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="id" width="80px" formatter="idFormatter">商机编码</th>
						<!-- <th field="optyCode" width="80px" sortable="true" formatter="idFormatter">商机编码</th> -->
						<th field="optyName" width="230px" defaultSearch="true"
							editor="{type:'textbox',options:{required:true}}">商机名称</th>
						<th field="optyAddr" width="200px" editor="{type:'textbox'}">所在地</th>
						<th field="accnt" width="120px"
							editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
																						required:true}}">客户名称</th>
						<!--   
	                <th field="contact" width="80px"  editor="{type:'picklistbox',options:{title:'选择联系人',initParam:initContactPicklistParam,
	                																	   completeFun:contactPicklistComplete,
	                																	   tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/contactPickList.jsp',
	                																	   required:true}}">联系人</th> 
	               -->

						<th field="stage" width="80px" lov="OPTY_STAGE"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_STAGE'),
																			editable:false,
																			required:true}}">商机阶段</th>
						<th field="status" width="80px" lov="OPTY_STATUS"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_STATUS'),
																			editable:false,
																			required:true}}">商机状态</th>
						<th field="optyGrade" width="100px" lov="OPTY_GRADE"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_GRADE'),
																			editable:false,
																			required:false}}">商机等级</th>
						<th field="managerName" width="120px"
							editor="{type:'picklistbox',options:{title:'选择负责人',
																						oauthFlag:false,
																						completeFun:managerPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/picklist/employeePickList.jsp',
																						required:true}}">负责人</th>
						<th field="managerOrgName" width="100px">所属组别</th>
						<th field="prodRequire" width="200px" editor="{type:'textbox'}">产品需求</th>
						<th field="deliverAddr" width="200px" editor="{type:'textbox'}">交货地点</th>
						<th field="deadline" width="100px" mark="DATE"
							editor="{type:'datetimebox',options:{showSeconds:false}}">跟进截至日期</th>
						<th field="created" width="100px" mark="DATE">创建日期</th>
						<th field="amount" width="140px" currency="CNY"
							editor="{type:'numberbox',options:{
																				min:0,
																				precision:2,
																				required:true}}">预计销售金额（税后）</th>
						<th field="optyDt" width="100px" mark="DATE"
							editor="{type:'datetimebox',options:{showSeconds:false,required:true}}">商机收集时间</th>
						<th field="source" width="80px" lov="OPTY_SOURCE"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_SOURCE'),
																			editable:false,
																			required:true}}">商机来源</th>
						<th field="salesman" width="100px" editor="{type:'textbox'}">销售人员</th>
						<th field="businessScope" width="100px" editor="{type:'textbox'}">业务范围</th>
						<th field="salesArea" width="100px" lov="SALES_AREA"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('SALES_AREA'),
																			editable:false,
																			required:false}}">销售区域</th>
						<th field="mainProd" width="100px" editor="{type:'textbox'}">主推产品</th>
						<th field="competitor" width="100px" editor="{type:'textbox'}">竞争对手及产品</th>
						<th field="resultFactor" width="100px" lov="OPTY_RESULT_FACTOR"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_RESULT_FACTOR'),
																			editable:false,
																			required:false}}">赢/丢单主要原因</th>
						<th field="resultReason" width="200px" editor="{type:'textarea'}">赢/丢单说明</th>

						<!-- <th field="typeCd" width="80px" lov="OPTY_TYPE_CD" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_TYPE_CD'),
																			editable:false,
																			required:true}}">商机类型</th> -->
						<th field="startDt" width="100px"
							editor="{type:'datebox',options:{showSeconds:false}}">预计成单日期</th>
						<th field="rate" width="80px" lov="OPTY_SUCCESS_RATE"
							editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_SUCCESS_RATE'),
																			editable:false,
																			required:true}}">赢单率</th>
						<!-- <th field="orgName" width="130px" editor="{type:'picklistbox',options:{title:'选择组织',
																completeFun:orgPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
					<th field="postnName" width="130px" editor="{type:'picklistbox',options:{title:'选择职位',
																completeFun:postnPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'}}">职位</th> -->
						<!-- <th field="emp" width="120px" editor="{type:'picklistbox',options:{title:'选择销售人员',completeFun:employeePicklistComplete,
	                										tableUrl:'${AppContext.ctxPath}/portal/picklist/employeePickList.jsp'}}">销售人员</th> -->
						<th field="comments" width="180px" editor="{type:'textarea'}">备注</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$datagrid = $('#opty-table');
		getLovOfList("[OPTY_STAGE,OPTY_STATUS,OPTY_SOURCE,OPTY_TYPE_CD,OPTY_SUCCESS_RATE,OPTY_RESULT_FACTOR,CRM_BU,OPTY_GRADE,SALES_AREA]");
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonCopy : true,
					buttonDelete : true,
					buttonExport : true,
					oauthFlag : true,
					striped : true,
					border : false,
					url : '${AppContext.ctxPath}/action/portal/opty/queryByExamplePage',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/opty/batchUpdate",
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
						$
								.ajax({
									type : 'POST',
									url : '${AppContext.ctxPath}/action/portal/opty/upsert',
									data : {
										row_status : row.row_status,
										id : row.id,
										optyName : row.optyName,
										accntId : row.accntId,
										optyAddr : row.optyAddr,
										source : row.source,
										prodRequire : row.prodRequire,
										amount : row.amount,
										deliverAddr : row.deliverAddr,
										stage : row.stage,
										deadline : row.deadline,
										optyDt : row.optyDt,
										created : row.created,
										resultReason : row.resultReason,
										status : row.status,
										rate : row.rate,
										startDt : row.startDt,
										comments : row.comments,
										managerId : row.managerId,
										salesman : row.salesman,
										businessScope : row.businessScope,
										mainProd : row.mainProd,
										competitor : row.competitor,
										resultFactor : row.resultFactor,
										optyGrade : row.optyGrade,
										salesArea : row.salesArea
									},
									success : function(data) {
										if (!data.success) {
											errFun(data.result, that);
										} else {
											successFun(that, data);
										}
									},
									dataType : 'json'
								});
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(
								91,
								'<a href="javascript:void(0)" id="btn_initiateForum" class="easyui-linkbutton" iconCls="icon-discussAdd" plain="true" onclick="initiateForum()">发起讨论</a>',
								that);
						//addButtonFun(21,'<a href="javascript:void(0)" id="btn_copy" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copyOpty()">复制</a>',that);
						//addButtonFun(61,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="optyGenerateOrder()" iconCls="icon-newOrder" plain="true">生成订单</a>',that);
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
																'${AppContext.ctxPath}/action/portal/opty/deleteById',
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
						return {
							optyDt : getCurrentDHM(),
							stage : 'NEW',
							status : 'New'
						};
					}
				});

		function idFormatter(val, row) {
			if (val != null) {
				return "<a href='${AppContext.ctxPath}/portal/opty/crmOptyDetail.jsp?optyId="
						+ row.id + "'>" + val + "</a>";
			}
		};

		$('#opty-stage-keyfilter')
				.keyFilter(
						{
							remoteData : true,
							filterByValue : true,
							remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/OPTY_STAGE'
						});

		$('#opty-status-keyfilter')
				.keyFilter(
						{
							remoteData : true,
							filterByValue : true,
							remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/OPTY_STATUS'
						});

		$('#opty-managerOrgName-keyfilter').keyFilter({
			remoteData : true,
			filterByValue : false,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/CRM_BU'
		});

		$('#opty-rate-keyfilter')
				.keyFilter(
						{
							remoteData : true,
							filterByValue : true,
							remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/OPTY_SUCCESS_RATE'
						});

		function accntPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
			return selectRow.acctName;
		}

		function managerPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').managerId = selectRow.id;
			return selectRow.firstName;
		}

		function contactPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').contactId = selectRow.id;
			return selectRow.contactsName;
		}

		function productPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
			return selectRow.prodName;
		}

		function employeePicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').empId = selectRow.id;
			return selectRow.firstName;

		}
		/* 
		 function idFormatter(val,row){
		 return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/opty/crmOptyDetail.jsp?optyId=" + row.id +"\")'>" + row.optyName + "</a>";
		 } */
		//深度复制头和行
		function copyOpty() {
			var row = $datagrid.datagrid('getSelected');
			window.location.href = '${AppContext.ctxPath}/action/portal/opty/deepCopy/'
					+ row.id;
		}
		//初始化联系人客户Id
		function initContactPicklistParam() {
			var accntId = $datagrid.hdatagrid('getCurrentRow').accntId;
			if (accntId == null || accntId == '') {
				return {
					id : 'noMatchId'
				};
			} else {
				return {
					id : accntId
				};
			}
		}

		/**
		 * 商机转订单
		 */
		function optyGenerateOrder() {
			var row = $datagrid.datagrid('getSelected');
			//if(row.stage == '成交'){
			delete row.prodList;
			$
					.post(
							'${AppContext.ctxPath}/action/portal/opty/optyGenerateOrder',
							row,
							function(data) {
								if (!data.success) {
									$.messager.alert("操作提示", data.result,
											"error");
								} else {
									//window.location.href='${AppContext.ctxPath}/portal/order/SaleOrderList.jsp';
									$.messager.alert("操作提示", "订单生成成功!");
									window.parent
											.quickEnter('订单', '销售订单',
													'ORDER_MANAGE',
													'${AppContext.ctxPath}/portal/order/SaleOrderList.jsp');
								}
							});
			/* }else{
				$.messager.alert('提示','该商机未成交，不能转换为订单！');
			} */
		};

		function orgPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}

		function initiateForum() {
			var row = $datagrid.datagrid('getSelected');
			if (row == null) {
				return;
			}
			if (row.length > 1) {
				$.messager.alert('提示', '请选择一条信息发起讨论');
				return;
			}
			window.top.gotoNewForum(row.id, 'opty', row.optyName);
		}
	</script>
</body>
</html>