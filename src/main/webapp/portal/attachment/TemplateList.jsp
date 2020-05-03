<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
		<table id="attachment-table"  fit="true">
			<thead>
				<tr>
					<th field="attachmentOriginal" width="120px" formatter="attachmentOriginalFormatter">名称</th>
					<th field="moduleType" width="120px">类型</th>
					<th field="attachmentSize" width="80px">大小（字节）</th>
					<th field="created" width="120px">上传时间</th>
					<th field="comments" width="300px" formatter="titleFormatter">备注</th>
				</tr>
			</thead>
		</table>
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
								<br/><br/>备注：
								<input id="comments" name="comments" class="easyui-textbox" data-options="multiline:true,
												         							  prompt:'请填写附件备注...',
												         							  width:'200px',
												         							  height:'90px'"/>
							</form>
						</div>
						<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
							<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="uploadAttachment()">上传</a>
							<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadAttachmentDiv.window('close')">取消</a>
						</div>
					</div>
				</div>
				<!-- ------------------------上传附件弹出框：结束----------------------------  -->
				
	<script type="text/javascript">
	getLovOfList("[ATTACHMENT_MODULE_TYPE]");
	$dataAttachmentgrid = $('#attachment-table');
	$dataAttachmentgrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		onBeforeLoad:function(param){
			var documentType = 'Template';
			//documentType = getLovShowName("ATTACHMENT_MODULE_TYPE", "Template");
			param.filtersRaw = '[{"id":"moduleType","property":"moduleType","value":"'+documentType+'"}]';
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(39,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment()">添加附件</a>',that);
		}
	});
	
	function titleFormatter(val, row) {
		if (val != null) {
			return '<span class="easyui-tooltip" title="'+ val + '">' + val + '</span>';
		} else {
			return val;
		}
	}
	function attachmentOriginalFormatter(val, row) {
		if (val != null) {
			var content = "点击下载";
			return "<a href='###' class='easyui-tooltip' title='"
			+ content + "' onclick='window.open(\"" + row.attachmentPath + "\")'>" + val + "</a>";
		}
	}
	
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
	function uploadAttachment(){
		var options = {
   				url:'${AppContext.ctxPath}/action/portal/attachment/insert',
   				type:'post',
				data : formatRequest({
					    headId      : 'noMatchId',
						moduleType 	: 'Template'
						}),
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					if (data.success) {
						$.messager.alert("提示", "上传成功！");
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

	</script>
</body>
</html>