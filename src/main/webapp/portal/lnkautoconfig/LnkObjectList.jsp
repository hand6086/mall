<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
		<fieldset class="x-fieldset" id="autoconfigKeyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">快速筛选条件</span>
			</legend>
			<div class="row keyfilter-border">
				<ul id="autoconfig-keyfilter" data-toggle="keyfilter"
					data-title="项目" data-filter-filed="attr02"
					data-table-Id="autoconfig-table">
				</ul>
			</div>
		</fieldset>
		<table id="autoconfig-table" height="300px"
			keyFilterDiv="autoconfigKeyFilter" >
			<thead>
				<tr>
					<th field="id" width="60px" formatter="objFormatter">对象ID</th>
					<th field="attr02" lov="LNK_SRPRO_PROJECT" width="130px"
						editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_SRPRO_PROJECT'),
																		editable:false,
																		required:true}}">项目名称</th>
					<th field="attr03" width="100px" defaultSearch="true"
						editor="{type:'validatebox',options:{required:true, validType:'english' }}">文件夹名称</th>
					<th field="attr01" width="160px"
						editor="{type:'validatebox',options:{required:true}}" defaultSearch="true">显示名称</th>
					<th field="name" width="160px"
						editor="{type:'validatebox',options:{required:true, validType:'english' }}">对象名称(英文)</th>
					<th field="newflag" width="60px"
						editor="{type:'checkbox',options:{on:'Y',off:'N'}}">新建</th>
					<th field="updateflag" width="60px"
						editor="{type:'checkbox',options:{on:'Y',off:'N'}}">更新</th>
					<th field="deleteflag" width="60px"
						editor="{type:'checkbox',options:{on:'Y',off:'N'}}">删除</th>
					<th field="queryflag" width="60px"
						editor="{type:'checkbox',options:{on:'Y',off:'N'}}">查询</th>
					<th field="basetable" width="140px" defaultSearch="true"
						editor="{type:'validatebox',options:{required:true}}">基表</th>
					<th field="basetablealais" width="60px">基表别名</th>
					<th field="activeflag" width="60px"
						editor="{type:'checkbox',options:{on:'Y',off:'N'}}">有效</th>
					<th field="orderbyfield" width="100px"
						editor="{type:'validatebox',options:{required:false}}">排序字段</th>
					<th field="coms" width="160px"
						editor="{type:'validatebox',options:{required:false}}">说明</th>
					<th field="attr04" width="100px"
						editor="{type:'validatebox',options:{required:false}}">crm包名称</th>
					<th field="attr18" width="100px"
						editor="{type:'validatebox',options:{required:false}}">mobile包名称</th>

					<th field="attr09" width="100px"
						editor="{type:'validatebox',options:{required:false, validType:'english' }}">数据源名称</th>

					<!-- 
					<th field="attr05" width="100px"
					
						editor="{type:'validatebox',options:{required:false}}">model路径</th>
					<th field="attr06" width="100px"
						editor="{type:'validatebox',options:{required:false}}">jsp路径</th>
					<th field="attr07" width="100px"
						editor="{type:'validatebox',options:{required:false}}">xml路径</th>
					<th field="attr08" width="100px"
						editor="{type:'validatebox',options:{required:false}}">jsptable名称</th>
					
					<th field="attr10" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注10</th>



					<th field="attr11" width="100px"
						editor="{type:'validatebox',options:{required:false}}">sercice名称</th>

					<th field="attr12" width="100px"
						editor="{type:'validatebox',options:{required:false}}">service方法</th>

					<th field="attr13" width="100px"
						editor="{type:'validatebox',options:{required:false}}">service接口路径</th>

					<th field="attr14" width="100px"
						editor="{type:'validatebox',options:{required:false}}">mapper名称</th>

					<th field="attr15" width="100px"
						editor="{type:'validatebox',options:{required:false}}">mapperid</th>

					<th field="attr16" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注16</th>

					<th field="attr17" width="100px"
						editor="{type:'validatebox',options:{required:false}}">controllerpath备注attr17</th>

					

					<th field="attr19" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr19</th>

					<th field="attr20" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr20</th>

					<th field="attr21" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr21</th>

					<th field="attr22" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr22</th>

					<th field="attr23" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr23</th>

					<th field="attr24" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr24</th>

					<th field="attr25" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr25</th>

					<th field="attr26" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr26</th>

					<th field="attr27" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr27</th>

					<th field="attr28" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr28</th>

					<th field="attr29" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr29</th>

					<th field="attr30" width="100px"
						editor="{type:'validatebox',options:{required:false}}">备注attr30</th>

 -->




					<th field="createdByName" width="60px">创建人</th>
					<th field="created" width="130px" mark="DATE">创建时间</th>


				</tr>
			</thead>
		</table>
		<!-- fit="false" -->
		<div data-options="region:'center',split:true" border="false"
			style="height: 600px; width: 100%;">
			<div class="easyui-tabs" data-options="fit:true" border="false"
				style="height: 600px; width: 100%;">
				<div title="对象字段">
					<table id="autoconfig-table-Field" fit="true">
					<thead frozen="true">
						<tr>
							<th field="displayname" width="160px"
									editor="{type:'validatebox',options:{required:true}}">显示名称</th>
								<th field="name" width="160px"
									editor="{type:'validatebox',options:{required:true}}">字段名称</th>
						</tr>
					</thead>
						<thead>
							<tr>
								
								<th field="joinname" width="100px"
									editor="{type:'combobox',options:{valueField:'name',
																		textField:'name',
																		onBeforeLoad:onBeforeLoadCombox,
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/basic/getobjlink/get',
																		editable:true,
																		required:false}}">连接</th>



								<th field="table" width="120px">表</th>
								<th field="columnname" width="160px"
									editor="{type:'validatebox',options:{required:false}}">列名称</th>
								<th field="lovtype" width="160px"
									editor="{type:'validatebox',options:{required:false}}">值列表</th>
								<th field="queryflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">查询标记</th>
								<th field="orderflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">排序标记</th>
								<th field="activeflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">激活的</th>
								<th field="updateflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">可更新</th>
								<th field="insertflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">可插入</th>
								<th field="uireadonly" width="80px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">界面只读</th>
								<th field="uitype" lov="LNK_INNER_UITYPE" width="60px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_INNER_UITYPE'),
																		editable:false,
																		required:true}}">界面类型</th>
								<th field="attr04" lov="LNK_APP_UITYPE" width="80px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_APP_UITYPE'),
																		editable:false,
																		required:true}}">app界面类型</th>



								<th field="fieldtype" lov="LNK_INNER_FIELDTYPE" width="100px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_INNER_FIELDTYPE'),
																		editable:false,
																		required:true}}">字段类型</th>
								<th field="columntype" lov="LNK_INNER_COLTYPE" width="100px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_INNER_COLTYPE'),
																		editable:false,
																		required:true}}">列类型</th>
								<th field="columnlength" width="100px"
									editor="{type:'validatebox',options:{required:false}}">列长度</th>
								<th field="calcflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">计算字段</th>
								<th field="calc" width="100px"
									editor="{type:'validatebox',options:{required:false}}">计算逻辑</th>

								<th field="uirequired" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">界面必输</th>
								<th field="uiqueryflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">界面可查询</th>
								<th field="attr01" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">界面隐藏</th>
								<th field="attr03" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">界面快速筛选</th>
								<th field="attr08" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">多语言</th>
								<th field="attr09" width="160px"
									editor="{type:'validatebox',options:{required:false}}">多语言表达式</th>




								<th field="indextype" lov="LNK_INNER_INDEXTYPE" width="100px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_INNER_INDEXTYPE'),
																		editable:true,
																		required:false}}">索引类型</th>


								<th field="coms" width="100px"
									editor="{type:'validatebox',options:{required:false}}">说明</th>

								<th field="attr02" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">有效</th>




								<!-- 
								<th field="attr04" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注4</th>

								<th field="attr05" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注5</th>
								<th field="attr06" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注6</th>
								<th field="attr07" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注7</th>
								<th field="attr08" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注8</th>
								<th field="attr09" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注9</th>
								<th field="attr10" width="100px"
									editor="{type:'validatebox',options:{required:false}}">备注10</th>
									 -->
								<th field="created" width="130px" mark="DATE">创建时间</th>
							</tr>
						</thead>
					</table>
				</div>
				<div title="关联表">
					<table id="autoconfig-table-link" fit="true">
						<thead>
							<tr>

								<th field="name" width="160px" defaultSearch="true"
									editor="{type:'validatebox',options:{required:true}}">名称</th>
								<th field="tablename" width="160px"
									editor="{type:'validatebox',options:{required:true}}">表</th>
								<th field="attr01" width="60px"
									editor="{type:'validatebox',options:{required:true}}">表别名</th>
								<th field="outerflag" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">外连接</th>
								<th field="linkcoms" width="160px"
									editor="{type:'validatebox',options:{required:false}}">连接条件(主表在前)</th>
								<th field="coms" width="100px"
									editor="{type:'validatebox',options:{required:false}}">说明</th>

								<th field="attr02" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">有效</th>


								<!-- 
<th field="attr02" width="100px" editor="{type:'validatebox',options:{required:false}}">备注2</th>
<th field="attr03" width="100px" editor="{type:'validatebox',options:{required:false}}">备注3</th>
<th field="attr04" width="100px" editor="{type:'validatebox',options:{required:false}}">备注4</th>
<th field="attr05" width="100px" editor="{type:'validatebox',options:{required:false}}">备注5</th>
<th field="attr06" width="100px" editor="{type:'validatebox',options:{required:false}}">备注6</th>
<th field="attr07" width="100px" editor="{type:'validatebox',options:{required:false}}">备注7</th>
<th field="attr08" width="100px" editor="{type:'validatebox',options:{required:false}}">备注8</th>
<th field="attr09" width="100px" editor="{type:'validatebox',options:{required:false}}">备注9</th>
<th field="attr10" width="100px" editor="{type:'validatebox',options:{required:false}}">备注10</th>
 -->
								<th field="created" width="130px" mark="DATE">创建时间</th>
							</tr>
						</thead>
					</table>
				</div>
				<div title="筛选条件">
					<table id="autoconfig-table-where" fit="true">
						<thead>
							<tr>
								<th field="name" width="100px" defaultSearch="true"
									editor="{type:'validatebox',options:{required:true}}">名称</th>
								<th field="linkcoms" width="160px"
									editor="{type:'validatebox',options:{required:true}}">连接条件</th>
								<th field="coms" width="100px"
									editor="{type:'validatebox',options:{required:false}}">说明</th>
								<th field="attr02" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">有效</th>
								<!-- 
<th field="attr01" width="100px" editor="{type:'validatebox',options:{required:false}}">备注1</th>
<th field="attr02" width="100px" editor="{type:'validatebox',options:{required:false}}">备注2</th>
<th field="attr03" width="100px" editor="{type:'validatebox',options:{required:false}}">备注3</th>
<th field="attr04" width="100px" editor="{type:'validatebox',options:{required:false}}">备注4</th>
<th field="attr05" width="100px" editor="{type:'validatebox',options:{required:false}}">备注5</th>
<th field="attr06" width="100px" editor="{type:'validatebox',options:{required:false}}">备注6</th>
<th field="attr07" width="100px" editor="{type:'validatebox',options:{required:false}}">备注7</th>
<th field="attr08" width="100px" editor="{type:'validatebox',options:{required:false}}">备注8</th>
<th field="attr09" width="100px" editor="{type:'validatebox',options:{required:false}}">备注9</th>
<th field="attr10" width="100px" editor="{type:'validatebox',options:{required:false}}">备注10</th>
 -->
								<th field="created" width="130px" mark="DATE">创建时间</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 弹出窗 -->
    <div id="editWin" class="crmWin" hidden>
    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="100%" frameborder="0" scrolling="no">
    </iframe>
    </div>
	<script type="text/javascript">
		$('.easyui-layout').layout();
		$datagrid = $('#autoconfig-table');
		getLovOfList("[LNK_INNER_UITYPE,LNK_SRPRO_PROJECT,LNK_INNER_FIELDTYPE,LNK_INNER_INDEXTYPE,LNK_INNER_COLTYPE]");
		$dataItemgrid = $('#autoconfig-table-Field');
		$dataItemgridlink = $('#autoconfig-table-link');
		$dataItemgridwhere = $('#autoconfig-table-where');

		$dataItemgrid
				.hdatagrid({
					pageSize : 200,//每页显示的记录条数，默认为20 
					pageList : [ 200, 300, 500 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : true,
					newDefaultValue : true,
					url : '${AppContext.ctxPath}/action/portal/LnkInnerField/queryByExamplePage',
					parentGridId : 'autoconfig-table',
					parentGridField : 'id',
					linkGridField : 'parentid',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						for(var i=0; i< rows.length; i++){
							var row = rows[i];
							if(row.name){
								row.name = toFirstLower(row.name);
							}
							if(row.columnname){
								row.columnname = toUpper(row.columnname);
							}
						}
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/LnkInnerField/batchUpdate",
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

						row.name = toFirstLower(row.name);
						row.columnname = toUpper(row.columnname);

						$.post(
										'${AppContext.ctxPath}/action/portal/LnkInnerField/upsert',
										row, function(data) {
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
																'${AppContext.ctxPath}/action/portal/LnkInnerField/deleteById',
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
							parentid : $datagrid.datagrid('getSelected').id,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName,
							queryflag : "Y",
							orderflag : 'Y',
							activeflag : 'Y',
							updateflag : 'Y',
							insertflag : 'Y',
							uireadonly : 'N',
							calcflag : 'N',
							uirequired : 'N',
							uiqueryflag : 'Y',
							attr01 : "N",
							attr02 : "Y",
							uitype : "validatebox",
							fieldtype : "String",
							columntype : "VARCHAR2",
							attr04 : "text",
							columnlength : "100",
							indextype : ""

						};
					},
					onAddMoreButton : function(that, addButtonFun) {

						addButtonFun(
								94,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFinish()" iconCls="icon-ok" plain="true">校验</a>',
								that);

					}
				});
		$dataItemgridlink
				.hdatagrid({
					pageSize : 200,//每页显示的记录条数，默认为20 
					pageList : [ 200, 300, 500 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : false,
					buttonImport : false,
					newDefaultValue : true,
					url : '${AppContext.ctxPath}/action/portal/LnkInnerLink/queryByExamplePage',

					parentGridId : 'autoconfig-table',
					parentGridField : 'id',
					linkGridField : 'parentid',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/LnkInnerLink/batchUpdate",
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
					onInsertOrUpdateAction : function(row, successFun, errFun,that) {
						$.post(
										'${AppContext.ctxPath}/action/portal/LnkInnerLink/upsert',
										row, function(data) {
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
																'${AppContext.ctxPath}/action/portal/LnkInnerLink/deleteById',
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
							parentid : $datagrid.datagrid('getSelected').id,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							attr02 : "Y",
							outerflag : "Y",
							postnName : appCtx.postnName
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(
								94,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFinish()" iconCls="icon-ok" plain="true">校验</a>',
								that);
					}
				});

		$dataItemgridwhere
				.hdatagrid({
					pageSize : 200,//每页显示的记录条数，默认为20 
					pageList : [ 200, 300, 500 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : false,
					buttonImport : false,
					newDefaultValue : true,
					striped : true,
					border : false,
					url : '${AppContext.ctxPath}/action/portal/LnkInnerWhere/queryByExamplePage',

					parentGridId : 'autoconfig-table',
					parentGridField : 'id',
					linkGridField : 'parentid',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/LnkInnerWhere/batchUpdate",
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
										'${AppContext.ctxPath}/action/portal/LnkInnerWhere/upsert',
										row, function(data) {
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
																'${AppContext.ctxPath}/action/portal/LnkInnerWhere/deleteById',
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
							parentid : $datagrid.hdatagrid("getSelected").id,
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							attr01 : "Y",
							postnName : appCtx.postnName

						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(
								94,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFinish()" iconCls="icon-ok" plain="true">校验</a>',
								that);

					}
				});

		$datagrid.hdatagrid({
					pageSize : 5,//每页显示的记录条数，默认为20 
					pageList : [ 5, 15, 30 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					//buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : false,
					newDefaultValue : true,
					oauthFlag : true,
					url : '${AppContext.ctxPath}/action/portal/autoconfig/queryByExamplePage',
					subGridIds : [ 'autoconfig-table-Field',
							'autoconfig-table-link', 'autoconfig-table-where' ],
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						for(var i=0; i< rows.length; i++){
							var row = rows[i];
							row.fieldList = [];
							row.linkList =[] ;
							row.whereList =[] ;
							if(row.attr03){
								row.attr03 = toLower(row.attr03);
							}
							if(row.attr18){
								row.attr18 = toLower(row.attr18);
							}
							if(row.attr04){
								row.attr04 = toLower(row.attr04);
							}
							if(row.basetable){
								row.basetable = toLower(row.basetable);
							}
						}
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/autoconfig/batchUpdate",
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
					onInsertOrUpdateAction : function(row, successFun, errFun, that) {
						row.fieldList = [];
						row.linkList =[] ;
						row.whereList = [];
						row.attr03 = toLower(row.attr03);
						row.attr18 = toLower(row.attr18);
						row.attr04 = toLower(row.attr04);
						row.basetable = toLower(row.basetable);

						$.post(
										'${AppContext.ctxPath}/action/portal/autoconfig/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
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
							$dataItemgridlink.hdatagrid(
									"changeParentItemAndParams", {
										parentid : parentId
									});
							$dataItemgridwhere.hdatagrid(
									"changeParentItemAndParams", {
										parentid : parentId
									});
						} else {
							$dataItemgrid.hdatagrid('loadData', {
								total : 0,
								success : true,
								rows : []
							});
							$dataItemgridlink.hdatagrid('loadData', {
								total : 0,
								success : true,
								rows : []
							});
							$dataItemgridwhere.hdatagrid('loadData', {
								total : 0,
								success : true,
								rows : []
							});
						}

					},
					onLoadSuccess : function(data) {
						if(data.success && data.rows.length){
							for(var i=0; i<data.rows.length; i++){
								var row = data.rows[i];
								row.fieldList = [];
								row.linkList =[] ;
								row.whereList = [];
							}
						}
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
																'${AppContext.ctxPath}/action/portal/autoconfig/deleteById',
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
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName,
							newflag : "Y",
							updateflag : "Y",
							deleteflag : "Y",
							queryflag : "Y",
							orderbyfield : "T1.CREATED DESC",
							basetablealais : "T1",
							attr04 : "com.hand.base",
							attr18 : "com.hand.mobile",
							activeflag : "Y"
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(
								10,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newObject()" iconCls="icon-add" plain="true">新建</a>',
								that);
						addButtonFun(
								91,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newTable()" iconCls="icon-newSQL" plain="true">生成建表语句</a>',
								that);
						
						addButtonFun(
								91,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newTable(\'MySql\')" iconCls="icon-newSQL" plain="true">生成建表语句(MySql)</a>',
								that);
						addButtonFun(
								92,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newQueryTable()" iconCls="icon-newSQL" plain="true">生成查询sql</a>',
								that);
						addButtonFun(
								92,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newQueryTable(\'MySql\')" iconCls="icon-newSQL" plain="true">生成查询sql(MySql)</a>',
								that);
						addButtonFun(
								93,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newObjectFile()" iconCls="icon-newFile" plain="true">生成对象文件</a>',
								that);/**/
						addButtonFun(
								94,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="Check()" iconCls="icon-ok" plain="true">校验</a>',
								that);
						addButtonFun(
								95,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="DeepCopy()" iconCls="icon-copy" plain="true">深度复制</a>',
								that);
						
						/*addButtonFun(
								96,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newAppFile()" iconCls="icon-generate" plain="true">生成APP对象</a>',
								that);
						
						addButtonFun(
								97,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="getmodelinfo()" iconCls="icon-generate" plain="true">获取model对象</a>',
								that);
						addButtonFun(
								98,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="updatemodelinfo()" iconCls="icon-generate" plain="true">更新model对象</a>',
								that);*/

					}
				});

		/*
		function toUpperFormatter(value, rowData, rowIndex) {
			if (value != undefined && value != '') {
				return value.toUpperCase();
			} else {
				return "";
			}

		}
		function toLowerFormatter(value, rowData, rowIndex) {
			if (value != undefined && value != '') {
				return value.toLowerCase();
			} else {
				return "";
			}

		}
		function toFirstLowerFormatter(value, rowData, rowIndex) {
			if (value != undefined && value != '') {
				if(value.length>1){
					return value.substring(0,1).toLowerCase()+value.substring(1,value.length);
					
				}else{
					return value.toLowerCase();
				}
				
			} else {
				return "";
			}

		}
		 */

		$('.fixed-keyfilter-ul').keyFilter();
		$('#autoconfig-keyfilter').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/LNK_SRPRO_PROJECT'
		});

		function newTable(dbType) {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/newTable', {
				id : row.id,
				attr1:dbType,
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');

				} else {
					window.open(data.url);
					//$datagrid.datagrid('reload');
				}
			});

		};
		
		function test(dbType) {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/test', {
				id : row.id,
				attr1:dbType,
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');

				} else {
					window.open(data.url);
					//$datagrid.datagrid('reload');
				}
			});

		};

		function newQueryTable(dbType) {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/newQueryTable', {
				id : row.id,
				attr1:dbType
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					//$datagrid.datagrid('reload');
					window.open(data.url);
				}
			});

		};

		function newObjectFile() {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/newObjectFile', {
				id : row.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					window.open(data.url);
					//$datagrid.datagrid('reload');
				}
			});

		};

		function newAppFile() {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/newAppFile', {
				id : row.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					window.open(data.url);
					//$datagrid.datagrid('reload');
				}
			});

		};
		function getmodelinfo() {
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/autoconfig/getmodelinfo', {
				id : row.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					//window.open(data.url); 
					//$datagrid.datagrid('reload');
				}
			});

		};
		function updatemodelinfo() {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/updatemodelinfo', {
				id : row.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					//window.open(data.url); 
					//$datagrid.datagrid('reload');
				}
			});

		};

		function Check() {
			alert("该功能还未开放");
			/*
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/Check', {
				id : row.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					window.open(data.url); 
					//$datagrid.datagrid('reload');
				}
			});*/

		};

		function DeepCopy() {
			var row = $datagrid.datagrid('getSelected');

			$.post('${AppContext.ctxPath}/action/portal/autoconfig/DeepCopy', {
				id : row.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				} else {
					$datagrid.datagrid('reload');
				}
			});

		};

		function onBeforeLoadCombox(param) {

			//var editRowId = $dataItemgrid.hdatagrid("getSelected").parentid;
			var editRowId = $datagrid.hdatagrid("getSelected").id;
			param.parentid = editRowId;
		}
		
		/**
		* 新建配置对象
		*/
		function newObject(){
			$("#editWinFram").attr("src", "${AppContext.ctxPath}/portal/lnkautoconfig/LnkObjectNew.jsp");
			$("#editWin").show();
		}
		/**
		* Form视图查看对象
		*/
		function updateObject(id){
			$("#editWinFram").attr("src", "${AppContext.ctxPath}/portal/lnkautoconfig/LnkObjectNew.jsp?op=UPDATE&id="+id);
			$("#editWin").show();
		}
		function editWinClose(op){
			if(op == "CANCEL"){//取消 
				
			}else if(op == "SUCCESS"){//保存成功
				$datagrid.datagrid('reload');
			}
			$("#editWin").hide();
		}
		
		function objFormatter(val, row){
			if(val){
				return "<a href='###' onClick='updateObject(\""+row.id+"\")'>"+val+"</a>";
			}
		}
	</script>
</body>
</html>