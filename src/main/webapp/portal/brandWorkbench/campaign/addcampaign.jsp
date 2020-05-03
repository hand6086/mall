<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 1100px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 16px;
}
.table-block tr{
	height:40px;
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
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" border="false" style="width:100%;height:100%;">
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>基础信息</legend>
							<form id="campaignForm" method="post"> 
								<table class="table-block" >							
									<tr>
										<td class="td-label"><label>承接页类型： </label></td>
										<td class="td-content">
											<input  class="easyui-combobox" name="type" type="text" id="type"  data-options="required:true"></textarea>
										</td>
										
										<td class="td-label"><label>承接页名称： </label></td>
										<td class="td-content">
											<input id="name" name="name" class="easyui-validatebox"  data-options="required:true"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>承接页编码： </label></td>
										<td class="td-content">
											<input id="code" name="code" class="easyui-validatebox"  disabled="disabled"/>
										</td>
										
										<td class="td-label"><label>分享方式：</label></td>
										<td class="td-content">
											<input id="shareType" name="shareType" class="easyui-combobox"  data-options="required:true"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>状态： </label></td>
										<td class="td-content">
											<input id="status" name="status" class="easyui-combobox"  data-options="required:true"/>
										</td>
										
										<td class="td-label"><label>分享标题： </label></td>
										<td class="td-content">
											<input id="shareTheme" name="shareTheme" class="easyui-validatebox"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>URL： </label></td>
										<td class="td-content">
											<input id="url" name="url" class="easyui-validatebox"/>
										</td>
										
										<td class="td-label"><label>分享说明： </label></td>
										<td class="td-content">
											<input id="shareNotes" name="shareNotes" class="easyui-validatebox"/>
											<input id="classifyId" hidden="true" name="classifyId">
											<input id="charePicId" hidden="true" name="charePicId">
										</td>
									</tr>
								</table>
							</form>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset>
						<table class="table-block" >						
							<tr>
								<td class="td-label"><label>分享图片： </label></td>
								<td class="td-content">
										<section class="img-section" >
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="imageurl" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
									</div>
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
			</table>
			<div>
				<center>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton save" onclick="save()" iconCls="icon-redo" plain="true">下一步</a>
		    		&nbsp;&nbsp;&nbsp;
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" iconCls="icon-undo" plain="true">取消</a> 
				</center>
			</div>
		</div>
	</div>
	

	<script type="text/javascript">
	$campaignForm = $("#campaignForm");	
	
	$('#imageurl').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '150px',
	    height : '150px',
		myComplete : function (success, result, message){
			// 自定义操作
			$('#charePicId').val(result.id);
		},
		myRemove : function(){
			$('#charePicId').val('');
		}
	});
	
	//初始化类型下拉列表
	$('#type').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_SHEET_TYPE'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	//初始化 分享方式下拉列表
	$('#shareType').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_SHARE_TYPE'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false,
	    value: 'Screenshot',
	});
	
	//初始化 状态下拉列表
	$('#status').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_STATUS'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false,
	    value: 'Active',
	});
	
	function save() {
			$(".save").linkbutton('disable');
	 		var options = {
					url : '${AppContext.ctxPath}/action/portal/campaign/insert',
					type : 'post',
					dataType :'json',
					data:{brandInsert:'1'},
					beforeSubmit: function() {
						var result = $campaignForm.form('validate');
						if(!result){
							$(".save").linkbutton('enable');
						}
						return result;
					},  
					success : function(data) {
						if (data.success) {
							window.parent.closeAddWin("ok",data.newRow.id,data.newRow.type);
						} else {
							$(".save").linkbutton('enable');
							window.parent.operationtip(data.result, 'error');
						}
					}
				};
			$campaignForm.ajaxSubmit(options);
	}
	
	$(".cancel").click(function(){
		window.parent.closeAddWin("cancel", "");
	}); 
	</script>

</body>
</html>