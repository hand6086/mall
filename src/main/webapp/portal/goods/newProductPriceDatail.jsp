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
	width: 190px;
	float: left;
	margin-right: 8%;
	height: 180px;
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
							<form id="ProdPiceForm" method="post">
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>商品名称 ：</label></td>
									<td class="td-content">
										<input id="prodDisplayName" name="prodDisplayName" class="easyui-picklistbox td-input-input" disabled="disabled" />
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
									<td class="td-label"><label>是否展示： </label></td>
									<td class="td-content">
										<input id="isDisplay" name="isDisplay" data-options="required:true"/>
									</td>
									<td class="td-label"><label>爱新品频道展示顺序： </label></td>
									<td class="td-content">
										<input class="easyui-numberbox td-input-input" name="npDisplaySequence" id="npDisplaySequence" data-options="required:true" /></td>
									</td>
								</tr>
								
								<tr hidden = "true">
									<td class="td-label"><label>商品海报图URL： </label></td>
									<td class="td-content">
										 <input class="easyui-textbox td-input-input" name="prodUrl" id="prodUrl" disabled="disabled"/></td>
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
									<td class="td-label"><label>二级页面海报图片：</td>
									<td class="pic">
										<section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file1" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										 <section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file2" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										 <section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file3" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										 <section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file4" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										 <section class="img-section">
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="file5" class="file" multiple />
												  	</form>
												 </section>
											 </div>
										 </section>
										 <section class="img-section">
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
	$ProdPiceForm = $("#ProdPiceForm");
	$isDisplay = $('#isDisplay');
	var prodPricId = "${param.prodId}";
	var olds = new Set(); 
	var onePic = null;
	var appPic = null;
	var appPicUrl = '';
	var onePicUrl = '';
	var pic = new Array();
	
	$('#prodDisplayName').picklist({
		title:'选择商品',
		completeFun:function(selectRow){
			$('#prodId').val(selectRow.id);
			$('#prodIntCode').textbox('setValue', selectRow.o2oIntCode);
			return selectRow.o2oDisplayName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp'
	});
	
	function infoInit(prodId, refreshDatagrid){
		
		
		if(!prodId){
			$.messager.alert("错误","参数错误, 无法获取商品id", "error");
			return;
		}else if(prodId == "current"){
			prodId = initId;
		}
		initId = prodId;
		var prodpice = {};
		$.post("${AppContext.ctxPath}/action/portal/goodsPrice/queryByDetailId",{id:initId},
			function(data){
				if(data){
					if(data.success){
						
						prodpice = data.result;
						var poster = data.poster;
						$ProdPiceForm.form("load", prodpice);
						appPic = prodpice.appPic;
						onePic = prodpice.onePic;
						$('#appPic').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl : prodpice.appPicUrl,
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
						    initImgUrl : prodpice.onePicUrl,
							myComplete : function (success, result, message){
								// 自定义操作
								onePic = result.id;
							},
							myRemove : function(){
								onePic = '';
							}
						});
						var fileUrl0 = '';
						var fileUrl = new Array(fileUrl0,fileUrl0,fileUrl0,fileUrl0,fileUrl0,fileUrl0); 
						for(var j = 0 ; j <poster.length; j ++){
							fileUrl[j] = poster[j].path;
							pic[j]= poster[j].picId;
							olds.add(poster[j].picId);
						}
						
						$('#file1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl : fileUrl[0],
							myComplete : function (success, result, message){
								// 自定义操作
								pic[0] = result.id;
								$('#prodUrl').textbox('setValue', result.thumbUrl);
							},
							myRemove : function(){
								pic[0] = '';
								$('#prodUrl').textbox('setValue', '');
							}
						});
						
						$('#file2').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :  fileUrl[1],
							myComplete : function (success, result, message){
								// 自定义操作
								pic[1]= result.id;
							},
							myRemove : function(){
								pic[1] = '';
							}
						});
						
						$('#file3').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :  fileUrl[2],
							myComplete : function (success, result, message){
								// 自定义操作
								pic[2]= result.id;
							},
							myRemove : function(){
								pic[2] = '';
							}
						});
						
						$('#file4').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :  fileUrl[3],
							myComplete : function (success, result, message){
								// 自定义操作
								pic[3]= result.id;
							},
							myRemove : function(){
								pic[3] = '';
							}
						});
						
						$('#file5').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :  fileUrl[4],
							myComplete : function (success, result, message){
								// 自定义操作
								pic[4]= result.id;
							},
							myRemove : function(){
								pic[4] = '';
							}
						});
						
						$('#file6').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :  fileUrl[5],
						    myComplete : function (success, result, message){
								// 自定义操作
								pic[5]= result.id;
							},
							myRemove : function(){
								pic[5] = '';
							}
						});
						
					}
				}
			});
		if(refreshDatagrid){
		}
	}
	
	
	$(".save").click(function(){
		
		var news = new Set(); 

		for(var i = 0; i < pic.length ; i++){
			if(pic[i] != ''){
				news.add(pic[i]);
			}
		}
		if(appPic == ''){
			window.parent.operationtip('APP首页图片不能为空', 'error');
		}else if(onePic == ''){
			window.parent.operationtip('一级页面轮播图片不能为空', 'error');
		}else if((Array.from(news)).toString() == ''){
			window.parent.operationtip('二级页面海报图片不能为空', 'error');
		}else{
		
		var prodUrlVal = $('#prodUrl').textbox('getValue');
		var picdel = (Array.from(difference(olds,news))).toString();  
		var picadd = (Array.from(difference(news,olds))).toString(); 
		var options = {
				url : '${AppContext.ctxPath}/action/portal/goodsPrice/update',
				type : 'post',
				dataType :'json',
				data: {
					'id' : prodPricId,
					'onePic' : onePic,
					'appPic' : appPic,
					'attr5' : picadd,
					'attr6' : picdel,
					'prodUrl':prodUrlVal
				},
				beforeSubmit: function() {
					var result = $ProdPiceForm.form('validate');
					return result;
				},  
				success : function(data) {
					if (data.success) {
						window.parent.operationtip('保存成功！', 'info');
						window.parent.closeDetailWin("ok");
					} else {
						window.parent.operationtip(data.result, 'error');
					}
				}
			};
		$ProdPiceForm.ajaxSubmit(options);}
	});
	
	$(".cancel").click(function(){
		window.parent.closeDetailWin("cancel");
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
	
	function difference(thisSet, otherSet) {  
		 //初始化一个新集合，用于表示差集。  
		 var differenceSet = new Set();
		 //将当前集合转换为数组  
		 var values = Array.from(thisSet);  
		 //遍历数组，如果另外一个集合没有该元素，则differenceSet加入该元素。  
		 for (var i = 0; i < values.length; i++) {  
		   
		  if (!otherSet.has(values[i])) {  
		   differenceSet.add(values[i])  
		  }  
		 }  
		   
		 return differenceSet;  
	};
	</script>

</body>
</html>