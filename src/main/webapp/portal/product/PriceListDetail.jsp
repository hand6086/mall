<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
fieldset {
	margin: 10px 10px;
	border: 1px solid #acacac;
}

fieldset .textbox {
	border-color: #acacac;
	border-radius: 0px;
}

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
	padding-left: 10px;
}
/* -- td css end -- */
.td-input-input {
	width: 150px;
}

.easyui-linkbutton-copy-list-table {
	display: none;
}
</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false"
		style="width: 100%; height: 100%; padding: 0px;">
		<div data-options="region:'center'" collapsible="false" title=""
			border="false" style="width: 100%; height: 97%; padding: 0px;">
			<div data-options="fit:true" style="width: 100%; padding: 1px;">
				<fieldset>
					<legend>价格表信息</legend>
					<form id="priceListForm" method="post">
						<table style="width: 100%;">
							<tr>
								<td>
									<table>
										<tr>
											<td class="td-label"><label>名称：</label></td>
											<td class="td-input"><input hidden="true" name="id"
												id="id" display="none" /> <input
												class="easyui-textbox td-input-input" name="priceListName"
												id="priceListName" data-options="required:true" /></td>
										</tr>
										<tr>
											<td class="td-label"><label>是否激活:</label></td>
											<td class="td-input"><input id="activatedShow" disabled
												name="activatedShow"
												class="easyui-textbox td-input-input td_activated"
												data-options="editable:false" /> <input name="activated"
												type="hidden" /></td>
										</tr>
										<tr>
											<td class="td-label"><label>有效期开始时间：</label></td>
											<td class="td-input"><input
												class="easyui-datetimebox td-input-input"
												name="effStartDate" id="effStartDate"
												data-options="showSeconds:false,required:true" /></td>
										</tr>
										<tr>
											<td class="td-label"><label>有效期结束时间：</label></td>
											<td class="td-input"><input
												class="easyui-datetimebox td-input-input" name="effEndDate"
												id="effEndDate" data-options="showSeconds:false" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table>
										<tr>
											<td class="td-label"><label>组织：</label></td>
											<td class="td-input"><input name="orgId" id="orgId"
												hidden="true" /> <input
												class="easyui-textbox td-input-input" name="orgName"
												id="orgName" /></td>
										</tr>
										<tr>
											<td class="td-label"><label>说明：</label></td>
											<td class="td-input"><textarea rows="5" name="comments"
													id="comments" style="width: 150px;"></textarea></td>
										</tr>
										<tr></tr>
									</table>
								</td>
							</tr>
						</table>
					</form>
					<div
						style="width: 100%; height: 30px; padding: 0px; margin-top: 10px;"margin-bottom:10px;">
						<a href="javascript:void(0)" id="btn_cancel"
							class="easyui-linkbutton" iconCls="icon-undo" plain="false"
							style="margin-left: 100px; width: 100px; height: 30px;"
							onclick="goBack()">取消</a> <a href="javascript:void(0)"
							id="btn_submit" class="easyui-linkbutton" iconCls="icon-save"
							plain="false"
							style="margin-left: 70px; width: 100px; height: 30px;"
							onclick="savePriceListInfo()">保存</a>
					</div>
				</fieldset>
			</div>
			<div data-options="region:'center',split:true" border="false"
				style="width: 100%; height: 70%">
				<table id="priceListInfo-table" fit="true" fitColumns="true">
					<thead>
						<th field="prodName" width="200px"
							editor="{type:'picklistbox',options:{title:'选择产品',
	   			   																		     completeFun:prodPickListComplete,
	   			   																		     tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp',
		   			   																		 required:true}}">产品名称</th>
						<th field="prodCode" width="150px"
							editor="{type:'textbox',options:{disabled:true}}">产品编码</th>
						<th field="price" width="100px" currency="CNY"
							editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">原价</th>
						<th field="promoPrice" width="100px" currency="CNY"
							editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">促销价</th>
						<th field="effStartDate" width="150px" mark="DATE"
							editor="{type:'datetimebox',options:{showSeconds:false,required:true}}">有效开始时间</th>
						<th field="effEndDate" width="150px" mark="DATE"
							editor="{type:'datetimebox',options:{showSeconds:false}}">有效结束时间</th>
						<th field="comments" width="300px" editor="{type:'textbox'}">说明</th>
					</thead>
				</table>
			</div>
		</div>


		<script type="text/javascript">
			var existRecord = false;
			var priceListId = getUrlParams("id");
			var agrId = "noMatchSelect";
			var activated = "";

			$headerForm = $("#priceListForm"); //头表单
			$dataPriceListgrid = $("#priceListInfo-table"); //价格表行项目

			//变量输入框绑定

			//页面元素加载完成事件
			$(document).ready(function() {
				priceListInfoInit();
			});

			//头表单及信息初始化
			function priceListInfoInit() {
				var formUrl = '';
				if (priceListId == null || priceListId == "noMatchSelect") { //新建价格表
					formUrl = '${AppContext.ctxPath}/action/portal/priceList/insert'; //新建时头表单URL
					$
							.post(
									"${AppContext.ctxPath}/action/portal/priceList/preDefaultValue",
									{},
									function(data) {
										if (data.success) {
											var record = data.result;
											priceListId = record.id;
											$('#priceListForm').form("load",
													record);
											$('#activatedShow').textbox(
													'setValue',
													record.activated);
										} else {
											$.messager.alert("提示", data.result);
										}
									});
				} else {
					formUrl = '${AppContext.ctxPath}/action/portal/priceList/update'; //编辑时头表单URL
					existRecord = true;
					$
							.post(
									"${AppContext.ctxPath}/action/portal/priceList/queryById",
									{
										id : priceListId
									},
									function(data) {
										if (data.success) {
											var record = data.result;
											$('#priceListForm').form("load",
													record);
											$('#activatedShow').textbox(
													'setValue',
													record.activated);
										} else {
											$.messager.alert("提示", data.result);
										}
									});
				}

				//初始化头表单
				$headerForm.form({
					url : formUrl,
					onSubmit : function() {
						return $headerForm.form('validate');
					}
				});
			};

			/**
			 * 保存头信息
			 */
			function savePriceListInfo() {
				if (!existRecord) {
					$headerForm
							.form(
									"submit",
									{
										success : function(data) {
											var data = eval('(' + data + ')'); // change the JSON string to javascript object
											if (data.success) {
												existRecord = true;
												var updateUrl = '${AppContext.ctxPath}/action/portal/priceList/update'; //编辑时头表单URL
												$headerForm.form('options').url = updateUrl;
												window.parent.operationtip(
														'保存成功！', 'info');
												gotoContentPage("${AppContext.ctxPath}/portal/product/PriceList.jsp");
											} else {
												window.parent.operationtip(
														data.result, 'error');
											}
										}
									});
				} else {
					$headerForm
							.form(
									"submit",
									{
										success : function(data) {
											var data = eval('(' + data + ')'); // change the JSON string to javascript object
											if (data.success) {
												existRecord = true;
												window.parent.operationtip(
														'更新成功！', 'info');
												gotoContentPage("${AppContext.ctxPath}/portal/product/PriceList.jsp");
											} else {
												window.parent.operationtip(
														data.result, 'error');
											}
										}
									});
				}
			};
			function goBack() {
				gotoContentPage("${AppContext.ctxPath}/portal/product/PriceList.jsp");
			};

			//选择组织
			$organizationPickList = $('#orgName');
			$organizationIdInput = $('#orgId');
			$organizationPickList
					.picklist({
						title : '选择组织',
						completeFun : function(selectedRow) {
							$organizationIdInput.val(selectedRow.id);
							return selectedRow.text;
						},
						tableUrl : '${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'
					});
			/**
			 * 价格表行项目
			 */
			$dataPriceListgrid
					.hdatagrid({
						updateable : true,
						toolbarShow : true,
						buttonNew : true,
						buttonSearch : true,
						buttonDelete : true,
						buttonExport : true,
						newDefaultValue : true,
						selectFirstRow : false,
						buttonCopy : true,
						striped : true,
						border : false,
						title : '价格表行项目',
						url : '${AppContext.ctxPath}/action/portal/priceListItem/queryByExamplePage',
						onAddMoreButton : function(that, addButtonFun) {
							addButtonFun(
									20.5,
									'<a href="javascript:void(0)" id="btn_multiAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="multiAdd()">批量添加</a>',
									that);
							addButtonFun(
									21,
									'<a href="javascript:void(0)" id="btn_addEffDate" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addEffDate()">新建有效期</a>',
									that);
						},
						onBeforeLoad : function(param) {
							param.headId = priceListId;
						},
						onInitCopyData : function(that) {
							return {
								effStartDate : appCtx.sysdateNoSeconds,
								effEndDate : ''
							};
						},
						buttonBatchEdit : true,
						onBatchUpdateAction : function(rows, successFun,
								errFun, that) {
							var rows_2 = [];
							for (var i = 0; i < rows.length; i++) {
								var row = rows[i];
								var row_2 = {
									row_status : "UPDATE",
									id : row.id,
									headId : priceListId,
									prodId : row.prodId,
									prodName : row.prodName,
									prodCode : row.prodCode,
									price : row.price,
									promoPrice : row.promoPrice,
									effStartDate : row.effStartDate,
									effEndDate : row.effEndDate,
									comments : row.comments
								}
								rows_2.push(row_2);
							}
							$
									.ajax({
										url : "${AppContext.ctxPath}/action/portal/priceListItem/batchUpdate",
										type : "post",
										data : JSON.stringify(rows_2),
										dataType : "json",
										contentType : "application/json",
										success : function(data) {
											if (data.success) {
												successFun(that, data);
											} else {
												errFun(that, data);
											}
										},
										error : function(xhr, code, msg) {
											errFun(that, "msg");
										}
									});
						},
						onInsertOrUpdateAction : function(row, successFun,
								errFun, that) {
							$
									.post(
											'${AppContext.ctxPath}/action/portal/priceListItem/upsert',
											{
												row_status : row.row_status,
												id : row.id,
												headId : priceListId,
												prodId : row.prodId,
												prodName : row.prodName,
												prodCode : row.prodCode,
												price : row.price,
												promoPrice : row.promoPrice,
												effStartDate : row.effStartDate,
												effEndDate : row.effEndDate,
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
																	'${AppContext.ctxPath}/action/portal/priceListItem/deleteById',
																	{
																		id : row.id
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
											});
						},
					});

			/**
			 * 新建有效期
			 */
			function addEffDate() {
				var row = $dataPriceListgrid.hdatagrid('getSelected');
				if (!row) {
					$.messager.alert("提示", "请选中要复制的数据!");
					return;
				}
				row.effEndDate = appCtx.sysdateNoSeconds;
				row.headId = priceListId;
				var edIndex = $dataPriceListgrid.hdatagrid('getRowIndex', row);
				$
						.post(
								"${AppContext.ctxPath}/action/portal/priceListItem/update",
								row,
								function(data) {
									if (data.success) {
										$dataPriceListgrid.hdatagrid(
												'updateRow', {
													index : edIndex,
													row : data.newRow
												});
										$(
												'.easyui-linkbutton-copy-list-table',
												$($dataPriceListgrid
														.datagrid("getPanel")))
												.click();
									} else {
										$.messager.alert("提示", data.result);
										return;
									}
								});
			}
			/**
			 * 产品picklist回调事件
			 */
			function prodPickListComplete(selectRow) {
				$dataPriceListgrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
				$dataPriceListgrid.hdatagrid('getCurrentRow').prodCode = selectRow.prodCode;
				var editIndex = $dataPriceListgrid
						.hdatagrid('getCurrentRowIndex');
				$($dataPriceListgrid.hdatagrid('getEditor', {
					index : editIndex,
					field : 'prodCode'
				}).target).textbox('setValue', selectRow.prodCode);
				return selectRow.prodName;
			};

			/*
			 * 批量添加
			 */
			function multiAdd() {
                var priceListId = getUrlParams("id");
                console.log(priceListId);
                $.post(
                        "${AppContext.ctxPath}/action/portal/priceList/preDefaultValue",
                        {},
                        function(data) {
                            if (data.success) {
                                var record = data.result;
                                $('#btn_multiAdd')
                                    .multiSelect(
                                        {
                                            title : '批量添加',
                                            initParam : function() {
                                                return {
                                                    id : record.id,
                                                    headId : priceListId
                                                };
                                            },
                                            tableUrl : '${AppContext.ctxPath}/portal/product/ProductItemMultiSelect.jsp',
                                            completeFun : function(selectedRow) {
                                                var priceListItemList = [];
                                                for(var i =0; selectedRow != null && i<selectedRow.length;i++){
                                                    var priceListItem = {};
                                                    priceListItem.headId = priceListId;
                                                    priceListItem.prodId = selectedRow[i].id;
                                                    priceListItem.prodCode = selectedRow[i].prodCode;
                                                    priceListItem.prodName = selectedRow[i].prodName;
                                                    priceListItem.price = selectedRow[i].price;
                                                    priceListItemList.push(priceListItem);
                                                }
                                                $.ajax({
                                                    type: "POST",
                                                    url: "${AppContext.ctxPath}/action/portal/priceListItem/multiAddProdToPrice",
                                                    data: JSON.stringify(priceListItemList),
                                                    dataType: "json",
                                                    contentType: 'application/json',
                                                    success:function(data){
                                                        if(data.success){
                                                            $dataPriceListgrid.hdatagrid("reload");
                                                        }else{
                                                            $.messager.alert("警告",data.result);
                                                        }
                                                    }
                                                });
                                            }
                                        });
                            } else {
                                $.messager.alert("提示", data.result);
                            }
                        });
			}
		</script>
</body>