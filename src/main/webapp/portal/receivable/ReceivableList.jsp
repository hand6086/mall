<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" border="false" style="width: 100%; height: 100%; padding: 0px;">
			<table id="receivable-table">
				<thead>
					<tr>
						<th field="contractCode" width="150px">合同号</th>
						<th field="accntName" width="150px">客户</th>
						<th field="amount" currency="CNY" width="150px">金额</th>
						<th field="outputValue" currency="CNY" width="150px">产值</th>
						<th field="payClct" currency="CNY" width="150px">回款</th>
						<th field="balance" currency="CNY" width="150px">余额</th>
					</tr>
				</thead>
			</table>
			<div class="easyui-tabs" style="width:'$(window).width() - 18';height:80%;"
				data-options="border:false">
				<div title="回款计划" data-options="fit:true" border="false">
					<table id="payClct-plan-table">
						<thead>
							<th field="payDate" width="30%" mark="DATE" editor="{type:'datetimebox', options:{required:true}}">回款时间</th>
							<th field="payAmount" currency="CNY" width="30%" mark="DATE" editor="{type:'numberbox', options:{required:true}}">回款金额</th>
						</thead>
					</table>
				</div>
				<div title="回款过程" data-options="fit:true" border="false">
					<table id="payClct-actual-table">
						<thead>
							<th field="payDate" width="20%" mark="DATE" editor="{type:'datetimebox', options:{required:true}}">实际回款时间</th>
							<th field="payAmount" currency="CNY" width="20%" editor="{type:'numberbox', options:{required:true}}">实际回款金额</th>
							<th field="payType" width="20%" editor="{type:'validatebox', options:{required:true}}">付款方式</th>
							<th field="payer" width="20%" editor="{type:'validatebox', options:{required:true}}">回款人</th>
						</thead>
					</table>
					<table id="payClct-actual-attachment-table">
						<thead>
							<tr>
								<th field="attachmentOriginal" width="20%" formatter="attachmentOriginalFormatter">附件名称</th>
								<th field="attachmentSize" width="20%">大小（字节）</th>
								<th field="created" width="20%">上传时间</th>
								<th field="comments" width="30%">备注</th>
							</tr>
						</thead>
					</table>
				</div>
				<div title="五单" data-options="fit:true" border="false">
					<table id="attachment-table">
						<thead>
							<tr>
								<th field="attachmentOriginal" width="20%" formatter="attachmentOriginalFormatter">附件名称</th>
								<th field="attachmentSize" width="20%">大小（字节）</th>
								<th field="created" width="20%">上传时间</th>
								<th field="comments" width="30%">备注</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
  </div>
  <!-- ------------------------上传附件弹出框：开始----------------------------  -->
	<div id="upload_attachment" >
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<form method="post" class="uploadAttachmentForm" style="text-align:center;margin-top: 30px;" enctype="multipart/form-data" >
					<table class="table-block" style="text-align:center;margin: 0px auto;">
						<tr>
							<td class="td-label"><label>文件 : &nbsp;</label></td>
							<td class="td-content">
								<input type='file' name='uploadAttachment' style="display: none;"/>
								<input id="openFile" class="easyui-textbox" data-options="buttonText:'浏览',
									         							  buttonIcon:'icon-search',
									         							  prompt:'请选择文件...',
									         							  editable:false,
									         							  required:true,
									         							  width:'200px',
									         							  height:'30px',
									         							  onClickButton: function(){
									         							  	$('#upload_attachment input[name=uploadAttachment]').click();
																		}"/>
							</td>
						</tr>
						<tr name="tr_documentType">
							<td class="td-label"><label>类型 : &nbsp;</label></td>
							<td class="td-content">
								<input name="documentType" class="easyui-combobox" data-options="valueField:'name',
																			textField:'name',
																			width:'200px',
									         							  	height:'30px',
																			method:'get',
																			data:getLovArray('DOCUMENT_TYPE'),
																			editable:false"/>
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>备注 : &nbsp;</label></td>
							<td class="td-content">
								<input id="comments" name="comments" class="easyui-textbox" data-options="multiline:true,
									         							  prompt:'请填写附件备注...',
									         							  width:'200px',
									         							  height:'90px'"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
				<a class="easyui-linkbutton upload" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="">上传</a>
				<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadAttachmentDiv.window('close')">取消</a>
			</div>
		</div>
	</div>
	<!-- ------------------------上传附件弹出框：结束----------------------------  -->
	<script type="text/javascript">
	$receivableDatagrid = $('#receivable-table');
	$payClctPlanDatagrid = $('#payClct-plan-table');
	$payClctActualDatagrid = $('#payClct-actual-table');
	$payClctActualAttachmentDatagrid = $('#payClct-actual-attachment-table');
	$attachmentDatagrid = $('#attachment-table');
	
	/* --------------------应收账款：开始------------------------------ */
	$receivableDatagrid.hdatagrid({
		toolbarShow:true,	//显示工具栏
		buttonSearch:true,	//搜索框功能
		oauthFlag:true,
		width:'$(window).width() - 18',
		height:'50%',
		title:'应收账款',
		url : '${AppContext.ctxPath}/action/portal/receivable/queryByExamplePage',
		onChangeSelectedItem:function(row){
			$payClctPlanDatagrid.hdatagrid("changeParentItemAndParams",{receivableId:row.id});
			$payClctActualDatagrid.hdatagrid("changeParentItemAndParams",{receivableId:row.id});
			$attachmentDatagrid.hdatagrid("changeParentItemAndParams",{headId:row.id});
		}
	});
	
	/* --------------------回款计划列表：开始------------------------------ */
	$payClctPlanDatagrid.hdatagrid({
		updateable : true,    
		toolbarShow:true,	//显示工具栏
		buttonSearch:true,	//搜索框功能
		buttonNew:true,
		buttonDelete:true,
		width:'100%',
		height:'100%',
		//url : '${AppContext.ctxPath}/action/portal/payClct/queryPlanListPage',
		url : '${AppContext.ctxPath}/action/portal/payClct/queryByExamplePage',
		queryParams:{
			dataType:"PLAN",
			noPage:true
		},
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var receivableId = $payClctPlanDatagrid.hdatagrid("getParentParams").receivableId;
			if(receivableId == null){
				$.messager.alert('警告','获取应收账款Id失败,请刷新页面重试！');
			}
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id				: row.id,
						receivableId	: receivableId,
						payDate			: row.payDate,
						payAmount		: row.payAmount,
						dataType		: 'PLAN'
				}
				rows_2.push(row_2);
			}
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/payClct/batchUpdate",
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
			var receivableId = $payClctPlanDatagrid.hdatagrid("getParentParams").receivableId;
			if(receivableId == null){
				$.messager.alert('警告','获取应收账款Id失败,请刷新页面重试！');
			}
			$.post('${AppContext.ctxPath}/action/portal/payClct/upsert', {
				row_status  	: row.row_status,
				id				: row.id,
				receivableId	: receivableId,
				payDate			: row.payDate,
				payAmount		: row.payAmount,
				dataType		: 'PLAN'
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that,data);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/payClct/deleteById', {
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
	
	/* --------------------回款过程列表：开始------------------------------ */
	$payClctActualDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		width:$(window.width) - 18,
		height:'50%',
		//url:'${AppContext.ctxPath}/action/portal/payClct/queryActualListPage',
		url:'${AppContext.ctxPath}/action/portal/payClct/queryByExamplePage',
		queryParams:{
			dataType:"ACTUAL",
			noPage:true
		},
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var receivableId = $payClctActualDatagrid.hdatagrid("getParentParams").receivableId;
			if(receivableId == null){
				$.messager.alert('警告','获取应收账款ID失败,请刷新页面重试！');
			}
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id			     : row.id,
						receivableId	: receivableId,
						payDate			: row.payDate,
						payAmount		: row.payAmount,
						payType			: row.payType,
						payer			: row.payer,
						dataType		: 'ACTUAL'
				}
				rows_2.push(row_2);
			}
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/payClct/batchUpdate",
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
			var receivableId = $payClctActualDatagrid.hdatagrid("getParentParams").receivableId;
			if(receivableId == null){
				$.messager.alert('警告','获取应收账款ID失败,请刷新页面重试！');
			}
			$.post('${AppContext.ctxPath}/action/portal/payClct/upsert', {
				row_status  	: row.row_status,
				id				: row.id,
				receivableId	: receivableId,
				payDate			: row.payDate,
				payAmount		: row.payAmount,
				payType			: row.payType,
				payer			: row.payer,
				dataType		: 'ACTUAL'
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that,data);
				}
			});
		},
		onChangeSelectedItem:function(row){
			$payClctActualAttachmentDatagrid.hdatagrid("changeParentItemAndParams",{headId:row.id});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/payClct/deleteById', {
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
	
	$payClctActualAttachmentDatagrid.hdatagrid({
		toolbarShow:true,
		buttonDelete:true,
		title:'附件',
		width:$(window.width) - 18,
		height:'50%',
		//url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(39,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment(\'payClctActual\')">新建</a>',that);
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
	$attachmentDatagrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		buttonDelete:true,
		width:'100%',
		height:'100%',
		/* url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage', */
		url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(39,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment()">新建</a>',that);
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
	$uploadAttachmentDiv = $('#upload_attachment');
	function openUploadAttachment(flag){
		$uploadAttachmentDiv.dialog({
			title:'上传附件',
			iconCls:'icon-add',
		    width:'400px',
		    height:'400px',
		    closable:false,
		    minimizable:false,
		    collapsible:false,
		    modal:true,
		    closed:true
		});
		clearDiv();
		$uploadAttachmentDiv.window('open');
		if(flag){
			$('.upload', $uploadAttachmentDiv).linkbutton('options').onClick = function(){uploadAttachment(flag)};
			$('tr[name=tr_documentType]', $uploadAttachmentDiv).css("display", "none");
		} else {
			$('.upload', $uploadAttachmentDiv).linkbutton('options').onClick = function(){uploadAttachment()};
			$('tr[name=tr_documentType]', $uploadAttachmentDiv).css("display", "");
		}
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
	/**
	 * 上传附件
	 * @param flag 操作标记,区分不同情况调用而触发不同的操作
	 */
	function uploadAttachment(flag){
		var datagridObj;//datagrid对象
		var moduleType = '';//附件类型
		if(flag == 'payClctActual'){
			datagridObj = $payClctActualAttachmentDatagrid;
			moduleType = 'Receivable Actual';
		} else {
			datagridObj = $attachmentDatagrid;
			moduleType = 'Receivable Five Document';
		}
		var headId = $(datagridObj).hdatagrid("getParentParams").headId;
		if(!headId){
			$.messager.alert("警告","获取应收账款ID失败,请刷新页面重试！");
			return;
		}
		$.messager.progress();
		var options = {
   				url:'${AppContext.ctxPath}/action/portal/attachment/insert',
   				type:'post',
				data : formatRequest({
							headId 		: headId,
							moduleType 	: moduleType
						}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					if (data.success) {
						$.messager.progress('close');
						$.messager.alert("提示", "上传成功！");
						$(datagridObj).datagrid('reload');
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
		function attachmentOriginalFormatter(val, row) {
			if (val != null) {
				var content = "点击下载";
				return "<a href='###' class='easyui-tooltip' title='"
				+ content + "' onclick='window.open(\"" + row.attachmentPath + "\")'>" + val + "</a>";
			}
		}
	/* --------------------附件列表：结束------------------------------ */
	</script>
</body>
</html>