<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north'" border="false" style="width: 100%; height: 50%; padding: 0px;">
			<table id="acceptance-table">
				<thead>
					<tr>
						<th field="contractCode" width="150px" editor="{type:'validatebox', options:{required:true}}">合同号</th>
						<th field="acctName" width="150px" editor="{type:'picklistbox',options:{title:'选择客户',
															completeFun:accntPicklistComplete,
															required:true,
															tableUrl:'${AppContext.ctxPath}/portal/serviceRequest/picklist/AccntPicklist.jsp'}}">客户名称</th>
						<th field="acctCode" width="150px" >客户识别码</th>
						<th field="acctType" width="150px" lov="ACCT_TYPE" >客户分类</th>
						<th field="acctLevel" lov="ACCT_LEVEL" width="150px">客户评级</th>
						<th field="legalContName" width="150px">法人联系人</th>
						<th field="acctOrgName" width="150px">办事处</th>
						<th field="currency" lov="CURRENCY" width="150px">货币</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div data-options="region:'center',fit:true,split:true,collapsible:false" border="false" style="width: 100%;height:50%;">
			<div class="easyui-tabs" style="width:'$(window).width() - 18';height:50%"
				data-options="border:false">
				<div title="附件" data-options="fit:true" border="false">
					<table id="attachment-table">
						<thead>
							<tr>
								<th field="attachmentOriginal" width="20%" formatter="attachmentOriginalFormatter">附件名称</th>
								<th field="attachmentSize" width="20%">大小（字节）</th>
								<th field="documentType" lov="DOCUMENT_TYPE" width="15%">类型</th>
								<th field="created" width="20%" mark="DATE">上传时间</th>
								<th field="comments" formatter="tooltipFormatter" width="20%">备注</th>
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
					<input type='file' name='uploadAttachment' style="display: none;"/>
					文件：
					<input id="openFile" class="easyui-textbox" data-options="buttonText:'浏览',
									         							  buttonIcon:'icon-search',
									         							  prompt:'请选择文件...',
									         							  editable:false,
									         							  width:'200px',
									         							  height:'30px',
									         							  onClickButton: function(){
									         							  	$('#upload_attachment input[name=uploadAttachment]').click();
																		}"/>
					<br/><br/>类型：
					<input name="documentType" class="easyui-combobox" data-options="valueField:'name',
																			textField:'name',
																			width:'200px',
									         							  	height:'30px',
																			method:'get',
																			data:getLovArray('DOCUMENT_TYPE'),
																			editable:false"/>
					<br/><br/>备注：
					<input id="comments" name="comments" class="easyui-textbox" data-options="multiline:true,
									         							  prompt:'请填写附件备注...',
									         							  width:'200px',
									         							  height:'90px'"/>
				</form>
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
				<a class="easyui-linkbutton upload" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="uploadAttachment()">上传</a>
				<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadAttachmentDiv.window('close')">取消</a>
			</div>
		</div>
	</div>
	<!-- ------------------------上传附件弹出框：结束----------------------------  -->
	<script type="text/javascript">
	getLovOfList("[ACCT_TYPE,ACCT_LEVEL,CURRENCY]");
	$acceptanceDatagrid = $('#acceptance-table');
	$attachmentDatagrid = $('#attachment-table');
	
	/* --------------------验收及交付单：开始------------------------------ */
	$acceptanceDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		oauthFlag:true,
		width:'100%',
		height:'100%',
		title:'验收及交付单',
		url : '${AppContext.ctxPath}/action/portal/acceptance/queryByExamplePage',
		onChangeSelectedItem:function(row){
			$attachmentDatagrid.hdatagrid("changeParentItemAndParams",{headId:row.id});
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/acceptance/batchUpdate",
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
			$.post('${AppContext.ctxPath}/action/portal/acceptance/upsert',row , function(data) {
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
					$.post('${AppContext.ctxPath}/action/portal/service/deleteById', {
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
	 * 客户picklist回调方法
	 */
	function accntPicklistComplete(selectRow){
		var currentRow = $acceptanceDatagrid.hdatagrid('getCurrentRow');
		currentRow.acctName = selectRow.acctName;
		currentRow.acctId = selectRow.id;
		return selectRow.acctName;
	}
	
	/* --------------------附件列表：开始------------------------------ */
	$attachmentDatagrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		buttonDelete:true,
		width:'100%',
		height:'100%',
		//url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
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
	function openUploadAttachment(){
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
	 */
	function uploadAttachment(){
		var headId = $attachmentDatagrid.hdatagrid("getParentParams").headId;;
		if(!headId){
			$.messager.alert("警告","获取头表ID失败,请刷新页面重试！");
			return;
		}
		$.messager.progress();
		var options = {
   				url:'${AppContext.ctxPath}/action/portal/attachment/insert',
   				type:'post',
				data : formatRequest({
							headId 		: headId,
							moduleType 	: 'Service Acceptance'
						}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					if (data.success) {
						$.messager.progress('close');
						$.messager.alert("提示", "上传成功！");
						$attachmentDatagrid.datagrid('reload');
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