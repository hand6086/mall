<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
					<table id="autoconfig-table-Field" fit="true">
						<thead>
							<tr>
								<th field="displayname" width="160px"
									editor="{type:'validatebox',options:{required:true}}">显示名称</th>
								<th field="name" width="160px"
									editor="{type:'validatebox',options:{required:true}}">字段名称</th>
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
								<!-- <th field="uitype" lov="LNK_INNER_UITYPE" width="60px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_INNER_UITYPE'),
																		editable:false,
																		required:true}}">界面类型</th> -->
								<th field="attr04" lov="LNK_APP_UITYPE" width="80px"
									editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('LNK_APP_UITYPE'),
																		editable:false,
																		required:true}}">app界面类型</th>
								<th field="attr05" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">页面提示</th>
							<th field="attr06" width="60px"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">文本清除</th>
									
							<th field="attr07" width="120px"
									editor="{type:'textarea',}">条件只读表达式</th>
								
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
								<th field="created" width="130px">创建时间</th>
							</tr>
						</thead>
					</table>
	</table>
	
	<script type="text/javascript">
	getLovOfList("[LNK_INNER_UITYPE,LNK_SRPRO_PROJECT,LNK_INNER_FIELDTYPE,LNK_INNER_INDEXTYPE,LNK_INNER_COLTYPE]");
	$dataItemgrid = $('#autoconfig-table-Field');
	$dataItemgrid.hdatagrid({
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
		parentParams : {parentid:objId},//导入时引用参数
		url : '${AppContext.ctxPath}/action/portal/LnkInnerField/queryByExamplePage',
		onBeforeLoad:function(param){
			if(objStatus == "NEW"){ //对象头未保存
				return false;
			}
			var parentid = objId ? objId : "noMatchId";
			param.filtersRaw = '[{"id":"parentid","property":"parentid","value":"'+parentid+'"}]';
		},
		onBeforeAdd: function(row, that){
			if(objStatus == "NEW"){ //对象头未保存
				$.messager.alert("警告", "请先保存配置对象", "info");
				return false;
			}
		},
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
		onInsertOrUpdateAction : function(row, successFun, errFun,that) {

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
									$.post(
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
				parentid : objId,
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
			addButtonFun(94, '<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFinish()" iconCls="icon-ok" plain="true">校验</a>',
					that);

		},

	});
	
	function onBeforeLoadCombox(param) {
		param.parentid = objId;
	}
	</script>
</body>
</html>