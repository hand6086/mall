<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
.left{
	float: left;
	width: 360px;
}
.center{
	float: left;
	width: 90%;
	margin-left:10px;
	
	/* position:absolute; */
}
.right{
	float: left;
	width: 360px;
	margin-left:10px;
}

.form-table{
	margin: 5px auto; 
	width: 1100px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}
.table-block1 {
	margin: 5px auto;
	width:100%;
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
	width:160px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input,select{
	width:180px;
}
.td-content textarea{
	width:300px;
}
.selected{
	background: #fee1c4;
}
.selectedreg,.selectedreg2{
	color: #f40;
}
.pic{
	overflow: hidden;
	width: 975px;
}
.pic > section {
	width: 160px;
	float: left;
	margin-right: 15%;
	height: 160px;
	margin-bottom:2%;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" title="" border="false" style="width:100%;height:100%;">
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>基本信息</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>商品名称 ：</label></td>
									<td class="td-content">
										<input id="prodDisplayName" name="prodDisplayName" class="easyui-picklistbox td-input-input" editable="true" />
										<input id="prodId" hidden="true" name="prodId" class="easyui-mvgPick td-input-input">
									</td>
									
									<td class="td-label"><label>商品编码： </label></td>
									<td class="td-content">
										<input class="easyui-textbox" name="prodIntCode" disabled id="prodIntCode"></input>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>有效开始时间： </label></td>
									<td class="td-content">
										<input name="startTime" id="startTime" class="easyui-datetimebox td-input-input" data-options="showSeconds:true,required:true" />
									</td>
									
									
									<td class="td-label"><label>有效结束时间： </label></td>
									<td class="td-content">
										<input name="endTime" id="endTime" class="easyui-datetimebox td-input-input" data-options="showSeconds:true,required:true" />
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>商品海报图URL： </label></td>
									<td class="td-content">
										 <input class="easyui-textbox td-input-input" name="prodUrl" id="prodUrl" disabled="disabled"/></td>
									</td>
									
									<td class="td-label"><label>是否展示： </label></td>
									<td class="td-content">
										<input id="isDisplay" name="isDisplay" data-options="required:true"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>爱新品频道展示顺序： </label></td>
									<td class="td-content">
										<input class="easyui-numberbox td-input-input" name="displaySequence" id="displaySequence" /></td>
									</td>
									
									<td class="td-label"><label> </label></td>
									<td class="td-content">
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>	
					<td>
						<fieldset>
							<legend>商品图片</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>APP首页展示图片：</td>
									<td class="td-content">
										<section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="appPic" class="file" multiple />
												  	</form>
												 </section>
												 
											 </div>
										 </section>
									</td>
									<td class="td-label"><label>一级页面轮播图片：</td>
									<td class="td-content">
										<section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="onePic" class="file" multiple />
												  	</form>
												 </section>
												 
											 </div>
										 </section>
									</td> 
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>	
					<td>
						<fieldset>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>商品海报图片：</td>
									<td class="pic">
										<section class="img-section file1">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file1" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										<section class="img-section file2" hidden="true">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file2" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										<section class="img-section file3" hidden="true">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file3" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										<section class="img-section file4" hidden="true">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file4" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										<section class="img-section file5" hidden="true">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file5" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										<section class="img-section file6" hidden="true">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file6" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
									</td>
								</tr> 
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			
			<div>
				<center>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton save" iconCls="icon-save" plain="true">保存</a>
		    		&nbsp;&nbsp;&nbsp;
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" iconCls="icon-redo" plain="true">取消</a> 
				</center>
			</div>
			<br/>
			<br/>
		</div>
	</div>
	<input type="text" id="fileId"/>
	<script type="text/javascript">
	$isDisplay = $('#isDisplay');
	var districtId = "${param.districtId}";
	var onePic = null;
	var appPic = null;
	var pic = new Array();
	;
	$('#appPic').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			// 自定义操作
			appPic = result.id;
		},
		myRemove : function(){
			appPic = '';
		}
	});
	
	$('#onePic').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			onePic = result.id;
		},
		myRemove : function(){
			onePic = '';
		}
	});
	$('#file1').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			pic[0]= result.id;
			$('#prodUrl').textbox('setValue', result.thumbUrl);
			$('.file2').show();
		},
		myRemove : function(){
			pic[0] = null;
		}
	});
	
	$('#file2').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			pic[1]= result.id;
			$('.file3').show();
		},
		myRemove : function(){
			pic[1] = null;
		}
	});
	$('#file3').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			pic[2]= result.id;
			$('.file4').show();
		},
		myRemove : function(){
			pic[2] = null;
		}
	});
	$('#file4').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			pic[3]= result.id;
			$('.file5').show();
		},
		myRemove : function(){
			pic[3] = null;
		}
	});
	$('#file5').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			pic[4]= result.id;
			$('.file6').show();
		},
		myRemove : function(){
			pic[4] = null;
		}
	});
	$('#file6').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '160px',
	    height : '160px',
		myComplete : function (success, result, message){
			pic[5]= result.id;
		},
		myRemove : function(){
			pic[5] = null;
		}
	});
	
	$('#prodDisplayName').picklist({
		title:'选择商品',
		completeFun:function(selectRow){
			$('#prodId').val(selectRow.id);
			$('#prodIntCode').textbox('setValue', selectRow.o2oIntCode);
			return selectRow.o2oDisplayName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp'
	});
	
	
	$(".save").click(function(){
		$(".save").attr("disabled", true); 
		var prodIdVal = $('#prodId').val();
		var startTimeVal = $('#startTime').textbox('getValue');
		var endTimeVal = $('#endTime').textbox('getValue');
		var prodUrlVal = $('#prodUrl').textbox('getValue');
		var isDisplayVal = $('#isDisplay').combobox('getValue');
		var displaySequenceVal = $('#displaySequence').val();
		var picSet = (pic.filter(t => t!=undefined && t!==null)).toString(); 
		$.post("${AppContext.ctxPath}/action/portal/goodsPrice/insert",{
			prodId : prodIdVal,
			startTime : startTimeVal,
			endTime : endTimeVal,
			prodUrl : prodUrlVal,
			isDisplay : isDisplayVal,
			displaySequence : displaySequenceVal,
			isSendRestaurant : isDisplayVal,
			isNewProduct : 'Y',
			districtId : districtId,
			onePic : onePic,
			appPic : appPic,
			attr5 : picSet
		},function(data){
			if (data.success) {
				$(".save").attr("disabled", false);
				window.parent.operationtip('保存成功！', 'info');
				window.parent.closeAddWin("ok", data.newRow.id);
			} else {
				$(".save").attr("disabled", false);
				window.parent.operationtip(data.result, 'error');
			}
		});
	});
	
	$(".cancel").click(function(){
		window.parent.closeAddWin("cancel", "");
	}); 
	
	
	//初始化 客户分类  下拉列表
	$isDisplay.combobox({ 
		method:'get',
		data:getLovArray('Is_Display'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	
	</script>

</body>
</html>