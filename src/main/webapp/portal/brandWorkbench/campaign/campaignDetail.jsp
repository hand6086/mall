<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>

<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 1100px;
	border-top: 1px solid #ccc;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
legend{
	padding-left:30px;
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
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:300px">
				<legend>基础信息</legend>
				<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<form id="campaignForm" method="post"> 
								<table class="table-block" >	
									<tr>
										<td class="td-label"><label>承接页名称： </label></td>
										<td class="td-content">
											<input id="name" name="name" class="easyui-validatebox"  data-options="required:true"/>
										</td>
									</tr>						
									<tr>
										<td class="td-label"><label>承接页类型： </label></td>
										<td class="td-content">
											<input  class="easyui-combobox" name="type" type="text" id="type"  disabled="disabled"></textarea>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>分享方式：</label></td>
										<td class="td-content">
											<input id="shareType" name="shareType" class="easyui-combobox"  data-options="required:true"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>状态： </label></td>
										<td class="td-content">
											<input id="status" name="status" class="easyui-combobox"  data-options="required:true"/>
											<input id="classifyId" hidden="true" name="classifyId">
											<input id="charePicId" hidden="true" name="charePicId">
										</td>
									</tr>
								</table>
							</form>
					</fieldset>
				</td>
					<td>
						<fieldset>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>承接页编码： </label></td>
									<td class="td-content">
										<input id="code" name="code" class="easyui-validatebox"  disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>URL： </label></td>
									<td class="td-content">
										<input id="url" name="url" class="easyui-validatebox"/>
										
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>分享标题： </label></td>
									<td class="td-content">
										<input id="shareTheme" name="shareTheme" class="easyui-validatebox"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>分享说明： </label></td>
									<td class="td-content">
										<input id="shareNotes" name="shareNotes" class="easyui-validatebox"/>
									</td>
								</tr>
							</table>
					</fieldset>
				</td>
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
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton back" plain="true">返回</a>
		    		&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton save" plain="true">保存</a>
		    		&nbsp;&nbsp;&nbsp;
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" plain="true">取消</a> 
				</center>
			</div>
			</div>
			<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:447px;padding:0px;" fit="true">
			   <table id="campPicLine-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
				<thead>
					<tr>
						<th field="lineType" width="100px" LOV="BRAND_CAM_LINE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			onSelect : onSelectType,
																			data: getdata(),
																			editable:false}}">类型</th>
						<th field="picUrl" width="160px" formatter="imageFormatter">图片</th>
						<th field="prodName" width="180px" editor="{type:'picklistbox',options:{title:'选择商品',
															completeFun:merchandisePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/TbBrandMerchandisePickList.jsp'}}">商品名称</th>
						<th field="couponName" width="180px" editor="{type:'picklistbox',options:{title:'选择优惠券',
																completeFun:consDrawPicklistComplete,
																initParam:initPickCouponParam,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oConsDrawPickList.jsp'}}">优惠券名称</th>
						<th field="promotionName" width="120px" editor="{type:'picklistbox',options:{title:'选择秒杀产品',
																completeFun:secKillPicklistComplete,
																initParam:initPicksecKillParam,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/BrandSecKillPickList.jsp'}}">秒杀名称</th>
						<th field="promotionStartTime" width="120px" mark="date" >秒杀开始时间</th>
						<th field="promotionEndTime" width="120px" mark="date">秒杀结束时间</th>
						<th field="displaySeq" width="100px" editor="{type:'numberbox',options:{
																					min:0,
																					precision:0}}">显示顺序</th>
						<th field="status" width="120px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_STATUS'),
																			editable:false}}">状态</th>
						
				   </tr>
				</thead>
			</table>
			<div id="bigImg" style="display: none;">
				<img id="popUpImg"/>
			</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var campaignId = "${param.campaignId}";
var type = "${param.type}";
$campaignForm = $("#campaignForm");	
var campaign = {};

function campaignInfoInit (campaignId, refreshDatagrid){
	if(!campaignId){
		$.messager.alert("错误","参数错误, 无法获取商品id", "error");
		return;
	}else if(campaignId == "current"){
		campaignId = initId;
	}
	initId = campaignId;
	$.post("${AppContext.ctxPath}/action/portal/campaign/queryById",{id:initId},
		function(data){
			if(data){
				if(data.success){
					campaign = data.result;
					$campaignForm.form("load", campaign);
					$("#code").val(campaign.code);
					$("#url").val(campaign.url);
					$("#shareTheme").val(campaign.shareTheme);
					$("#shareNotes").val(campaign.shareNotes);
					$('#imageurl').BobImage({
						upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
					    initImgUrl : campaign.shareUrl,
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
				}
			}
		});
	if(refreshDatagrid){
	}
}

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
});

//初始化 状态下拉列表
$('#status').combobox({ 
	method:'get',
	data:getLovArray('TB_O2O_STATUS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

$(".save").click(function(){
	$(".save").attr("disabled", true); 
	var options = {
		url : '${AppContext.ctxPath}/action/portal/campaign/update',
		type : 'post',
		dataType :'json',
		data: {id:campaignId,	
			   type:$('#type').combobox('getValue'),
			   code:$('#code').val(),
			   url :$('#url').val(),
			   shareTheme :$('#shareTheme ').val(),
			   shareNotes :$('#shareNotes ').val(),
			   brandUpdate:'1'
			   },
		beforeSubmit: function() {
			var result = $campaignForm.form('validate');
			return result;
		},  
		success : function(data) {
			if (data.success) {
				campaign = data.newRow;
				window.parent.operationtip('保存成功！', 'info');
			} else {
				$(".save").attr("disabled", false);
				window.parent.operationtip(data.result, 'error');
			}
		}
	};
	$campaignForm.ajaxSubmit(options); 
});

$(".back").click(function(){
	window.parent.closeDetailWin();
}); 
$(".cancel").click(function(){
	$campaignForm.form("load", campaign);
	$("#code").val(campaign.code);
	$("#url").val(campaign.url);
	$("#shareTheme").val(campaign.shareTheme);
	$("#shareNotes").val(campaign.shareNotes);
}); 


$linDatagrid = $('#campPicLine-table');
$linDatagrid.hdatagrid({
	updateable:true,
	toolbarShow:true,
	buttonSearch:true,
	buttonNew:true,
	buttonDelete:true,
	buttonExport:true,
	buttonMenu:true,
	menuButtonCount : true,
	newDefaultValue:true,
	striped:true,
	border:false,
	pageSize: 10,//每页显示的记录条数，默认为20 
    pageList: [10,30,50],//可以设置每页记录条数的列表 
	url:'${AppContext.ctxPath}/action/portal/campaignLine/queryByExamplePage',
	onBeforeLoad:function(param){
		if(!campaignId){
    		param.camId = "noMatchId";
    		param.attr6="datail";
    		param. brandQuery="1";
    	}else{
    		param.camId = campaignId;
    		param.attr6 = "datail";
    		param. brandQuery="1";
    	}
	},
	
	onLoadSuccess: function (data) {
        //调用图片展示组件
        $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
    },
	
    onInsertOrUpdateAction:function(row,successFun,errFun,that){
    	row.camId = campaignId;
    	row.brandUpsert = '1';
		$.post("${AppContext.ctxPath}/action/portal/campaignLine/upsert",row, 
		function(data) {
			if (!data.success) {
				errFun(data.result,that);
			}else{
				successFun(that, data);
			}
		});
	},
	
	onDeleteAction : function(row,successFun,errFun,that){
		$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
			if(data){
				$.post('${AppContext.ctxPath}/action/portal/campaignLine/deleteById', {
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
	},

	onChangeSelectedItem:function(row,that){
		if(row.status == 'Active'){
			$("#btn_linadd").linkbutton({text:'无效'});
		} else{
			$("#btn_linadd").linkbutton({text:'有效'});
		}
	},
	
	onAddMoreButton:function(that,addButtonFun){
		addButtonFun(92,'<a href="javascript:void(0)" id="btn_linadd" class="easyui-linkbutton" onClick="linInvalid()" iconCls="icon-undo" plain="true">失效</a>',that);
		addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form2" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileLineImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="lineId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
	}, 
	
	onInitNewData:function(that){
		return {
			status : 'Active',
			displaySeq : '1',
		};
	},
});

$(".fileLineImg").change(function(){
	var row = $linDatagrid.datagrid('getSelected');
	if(row == null || row.id == null){
		$.messager.alter("没有选中任何产品信息！");
		return;
	};
	/* 判断产品上传图片大小
	var files = document.getElementById("file").files; 
	var size = files[0].size;
	if (size >= 2 * 1024 *1024){
		$.messager.alert('注意','上传图片大小不要超过2M');
		return;
	}
	 */
	$('#lineId').val(row.id);
	var options = {
			url:'${AppContext.ctxPath}/action/portal/campaign/uploadImg2',
			type:'post',
			dataType:'json',
			contentType:"application/x-www-form-urlencoded;charset=utf-8",
			success : function(data) {
					if(data.success){
						$linDatagrid.datagrid('reload');
						window.parent.operationtip('图片上传成功！', 'info');
				  	}
			}
		};
		$('#form2').ajaxSubmit(options);
});

//失效
	function imageFormatter(val,row){   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A +row.picUrl +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
	function linInvalid(){
		var row = $linDatagrid.datagrid('getSelected');
		if(row.status=="Inactive"){
			$linDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
		}else{
			$linDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
		}
		var index = $linDatagrid.hdatagrid('getRowIndex', row);
	    $linDatagrid.datagrid('selectRow',index);
	}
	
	function getdata(){
		var data = getLovArray('BRAND_CAM_LINE_TYPE');
		if(type == 'List Type'){
			for (var i = data.length - 1; i >=0; i--) {
				if (data[i].val == 'Second Kill') {
					data.splice(i,1);
				}
			}
			return data;
    	}else if(type == 'Single Pic Type'){
    		for (var i = data.length - 1; i >=0; i--) {
				if (data[i].val == 'Coupon') {
					data.splice(i,1);
				}
			}
			return data;
    	}else if(type == 'Stack Type'){
    		for (var i = data.length - 1; i >=0; i--) {
				if (data[i].val != 'Product') {
					data.splice(i,1);
				}
			}
			return data;
    	}else if(type == 'Coupon Type'){
    		for (var i = data.length - 1; i >=0; i--) {
				if (data[i].val != 'Coupon') {
					data.splice(i,1);
				}
			}
			return data;
    	}
	}
	
	function onSelectType(){
		var editIndex = $linDatagrid.hdatagrid('getCurrentRowIndex');
		var currentEditRow = $linDatagrid.datagrid('selectRow', editIndex);
		if('Picture'==$(this).combobox('getValue')){
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'prodName'
			}).target.textbox({required:false});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'couponName'
			}).target.textbox({required:false});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'promotionName'
			}).target.textbox({required:false});
		}
		if('Product'==$(this).combobox('getValue')){
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'prodName'
			}).target.textbox({required:true});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'couponName'
			}).target.textbox({required:false});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'promotionName'
			}).target.textbox({required:false});
		}
		if('Coupon'==$(this).combobox('getValue')){
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'prodName'
			}).target.textbox({required:false});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'couponName'
			}).target.textbox({required:true});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'promotionName'
			}).target.textbox({required:false});
		}
		if('Second Kill'==$(this).combobox('getValue')){
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'prodName'
			}).target.textbox({required:false});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'couponName'
			}).target.textbox({required:false});
			$linDatagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'promotionName'
			}).target.textbox({required:true});
		}
		
	}
	
	function merchandisePicklistComplete(selectRow){
		$linDatagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
		return selectRow.o2oDisplayName;
	}
	
	function consDrawPicklistComplete(selectRow){
		$linDatagrid.hdatagrid('getCurrentRow').couponId = selectRow.id;
		return selectRow.name;
	}
	
	function secKillPicklistComplete(selectRow){
		$linDatagrid.hdatagrid('getCurrentRow').promotionId = selectRow.id;
		return selectRow.name;
	}
	function initPickCouponParam() {
		return {source:'brand',type:'Coupon'};
	}
	function initPicksecKillParam() {
		return {source:'brand',type:'Second Kill'};
	}
</script>
</body>
</html>