<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">

		<table id="projectmanagement-table" height="300px"
			width="$(window).width() - 18">
			<thead>
				<tr>

					<th field="id" width="60px">项目编码</th>
					<th field="created" width="120px"
						editor="{type:'datebox',options:{showSeconds:false}}">创建时间</th>
					<th field="createdByName" width="80px">创建者</th>
					<th field="projName" width="160px" defaultSearch="true"
						editor="{type:'textbox',options:{required:true}}">项目名称</th>
					<th field="firstName" width="140px"
						editor="{type:'picklistbox',options:{title:'项目经理',
															oauthFlag:false,
															completeFun:managerPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/SrproPersonPickList.jsp',
															required:true}}">项目经理</th>
					<th field="comments" width="300px"
						editor="{type:'textbox',options:{required:false}}">项目描述</th>
					<th field="projStartDate" width="140px"
						editor="{type:'datebox',options:{required:true,showSeconds:false}}">项目起始时间</th>
					<th field="projEndDate" width="140px"
						editor="{type:'datebox',options:{required:true,showSeconds:false}}">项目结束时间</th>

				</tr>
			</thead>
		</table>
		<!-- fit="false" -->
		<div data-options="region:'center',split:true" border="false"
			style="height: 400px; width: 100%;">
			<div class="easyui-tabs" data-options="fit:true" border="false"
				style="height: 600px; width: 100%;">
				<div title="项目成员">
					<table id="projectmanagement-table-Field" fit="true">
						<thead>
							<tr>
								<th id="username" field="username" width="140px">用户名</th>

								<th id="firstName" field="firstName" width="100px"
									defaultSearch="true"
									editor="{type:'picklistbox',options:{title:'员工',
															oauthFlag:false,
															completeFun:teamPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/SrproPersonPickList.jsp',
															required:true
															}}">姓名</th>
								<th id="unitname" field="empUnitName" width="180px">部门</th>
								<th id="posistionname" field="empPositionName" width="100px">职位</th>
								<th id="workdate" field="empWorkdate" width="140px">入职时间</th>
								<th id="joblevel" field="empJoblevel" width="30px">级别</th>
								<th id="contactPhone" field="empPhone" width="100px">电话</th>
								<th id="email" field="empEmail" width="200px">邮箱</th>
							</tr>
						</thead>
					</table>
				</div>

			</div>
		</div>
	</div>
	<script type="text/javascript">
		var pId = '';
		var pCode = '';
		$datagrid = $('#projectmanagement-table');
		$dataItemgrid = $('#projectmanagement-table-Field');
		$datagrid
				.hdatagrid({
					pageSize : 10,//每页显示的记录条数，默认为20 
					pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : true,
					newDefaultValue : true,
					oauthFlag : true,
					url : '${AppContext.ctxPath}/action/portal/project/queryByExamplePage',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/project/batchUpdate",
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
						$.post(
										'${AppContext.ctxPath}/action/portal/project/upsert',
										row,
										function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {

												pId = data.newRow.id;
												var pPmId = data.newRow.projManagerId;

												if( row.row_status == 'NEW'){
												$.post(
																'${AppContext.ctxPath}/action/portal/projectTeam/upsert',
																{
																	projId : pId,
																	userId : appCtx.userId,
																	row_status : 'NEW'
																},
																function(data1) {
																	if (!data1.success) {
																		//errFun(data.result, that);
																	} else {
																		//successFun(that, data);
																		if (appCtx.userId == pPmId && row.row_status == 'NEW') {
																			successFun(
																					that,
																					data);
																			$dataItemgrid
																					.hdatagrid(
																							"changeParentItemAndParams",
																							{
																								parentid : pId
																							});

																		}else{
																			successFun(
																					that,
																					data);
																		}

																	}
																});
												}else{
													successFun(
															that,
															data);
												}
												if (appCtx.userId != pPmId && row.row_status == 'NEW') {
													$
															.post(
																	'${AppContext.ctxPath}/action/portal/projectTeam/upsert',
																	{
																		projId : pId,
																		userId : pPmId,
																		row_status : 'NEW'
																	},
																	function(
																			data2) {
																		if (!data2.success) {
																			//errFun(data.result, that);
																		} else {
																			//successFun(that, data);
																			successFun(
																					that,
																					data);
																			$dataItemgrid
																					.hdatagrid(
																							"changeParentItemAndParams",
																							{
																								parentid : pId
																							});

																		}
																	});
												}

											}
										});

					},

					onChangeSelectedItem : function(row) {
						var parentId = row.id ? row.id : "";
						if (parentId != '' && row.row_status != 'NEW') {
							$dataItemgrid.hdatagrid(
									"changeParentItemAndParams", {
										parentid : parentId
									});
						} else {
							$dataItemgrid.hdatagrid('loadData', {
								total : 0,
								success : true,
								rows : []
							});
						}

					},

					onDeleteAction : function(row, successFun, errFun, that) {
						//row.createdBy
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/project/deleteById',
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
							created : appCtx.sysdate(),
							createdBy : appCtx.userId,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName,
							projManagerId : appCtx.userId,
							firstName : appCtx.firstName,
							createdByName : appCtx.firstName,
							lastUpdated : appCtx.sysdate()
						};
					},
					onLoadSuccess : function(data) {
						if (!$dataItemgrid.hdatagrid("options").url) {
							$dataItemgrid.hdatagrid("options").url = "${AppContext.ctxPath}/action/portal/projectTeam/queryByExamplePage";
							if (data.rows.length > 0) {
								$datagrid.hdatagrid('selectRow', 0);
								var row = $datagrid.hdatagrid('getSelected');
								var parentId = row.id ? row.id : "";
								$dataItemgrid.hdatagrid(
										"changeParentItemAndParams", {
											parentid : parentId
										});// 自扩展功能，参数会重新包装
							} else {
								$dataItemgrid.hdatagrid('loadData', {
									total : 0,
									success : true,
									rows : []
								});

							}
						}

					},
					onAddMoreButton : function(that, addButtonFun) {

					}
				});

		$dataItemgrid
				.hdatagrid({
					pageSize : 10,//每页显示的记录条数，默认为20 
					pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : false,
					newDefaultValue : true,
					oauthFlag:false,
					url : '',
					onBeforeLoad : function(param) {
						param.projId = pId;
					},

					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/projectTeam/batchUpdate",
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
						$.post('${AppContext.ctxPath}/action/portal/projectTeam/upsert',
								row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												//$dataItemgrid.hdatagrid('reload');

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
																'${AppContext.ctxPath}/action/portal/projectTeam/deleteById',
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
							projId : $datagrid.hdatagrid("getSelected").id
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
                        addButtonFun(
                            25,
                            '<a href="javascript:void(0)" id="btn_multiAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="multiAdd()">批量添加</a>',
                            that);
					}
				});
		function teamPicklistComplete(selectRow) {
			var rows = $dataItemgrid.hdatagrid('getRows');
			var selectRowUserId = selectRow.id;
			var hasFlag = 'N';
			for (var i = 0; i < rows.length; i++) {
				if (selectRowUserId == rows[i].userId) {
					hasFlag = 'Y';
				}
			}
			if (hasFlag == 'Y') {
				$.messager.alert('消息', '项目团队中已有此成员。');
			} else {
				$dataItemgrid.hdatagrid('getCurrentRow').userId = selectRowUserId;
				return (selectRow.firstName);
			}
		}

		function managerPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').projManagerId = selectRow.id;
			return (selectRow.firstName);
		}
		
		function multiAdd() {
            var projectId = $datagrid.hdatagrid('getSelected');
            $('#btn_multiAdd').multiSelect({
				oauthFlag:false,
                title:'批量添加项目成员',
                initParam:function(){
                    return {id:projectId.id};
                },
                tableUrl:'${AppContext.ctxPath}/portal/ServiceProject/dialog/ProjectTeamMultiSelect.jsp',
                completeFun:function(selectedRow){
                    var projectId = $datagrid.hdatagrid('getSelected');
                    var records = [];
                    for(var i =0; selectedRow != null && i<selectedRow.length;i++){
                        records.push({
                            userId:selectedRow[i].id,
                            projId:projectId.id
                        });
                    }
                    $.ajax({
                        type: "POST",
                        url: "${AppContext.ctxPath}/action/portal/projectTeam/multiAddProjectTeam",
                        data: JSON.stringify(records),
                        dataType: "json",
                        contentType: 'application/json',
                        success:function(data){
                            if(data.success){
                                $dataItemgrid.hdatagrid("reload");
                            }else{
                                $.messager.alert("警告",data.result);
                            }
                        }
                    });
					console.log("multi select team member");
                }
            });
        }
		
	</script>
</body>
</html>