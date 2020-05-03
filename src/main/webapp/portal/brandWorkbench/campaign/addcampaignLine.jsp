<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.table-block {
	margin: 5px auto;
	width: 100%;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
legend{
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
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" border="false" style="width:100%;height:100%;">
			<legend>明细信息</legend>
			<table class="form-table">
				<tr>
					<td>
						<form id="campaignLineForm" method="post"> 
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>类型 ：</label></td>
									<td class="td-content">
										<input  class="easyui-combobox" name="lineType" type="text" id="lineType"  data-options="required:true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>状态： </label></td>
									<td class="td-content">
										<input id="status" name="status" class="easyui-combobox"  data-options="required:true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>显示顺序：</label></td>
									<td class="td-content">
										<input id="displaySeq" name="displaySeq" class="easyui-numberbox" value=1  data-options="min:0,
																					precision:0,required:true"/>
										<input id="prodId"  hidden="true" name="prodId">
										<input id="couponId"  hidden="true" name="couponId">
										<input id="promotionId"  hidden="true" name="promotionId">
										<input id="picId"  hidden="true" name="picId">
									</td>
								</tr>
								<tr class="Product" hidden="true">
									<td class="td-label"><label>商品名称： </label></td>
									<td class="td-content">
										<input id="prodName" name="prodName" class="easyui-picklistbox"/>
									</td>
								</tr>
								<tr class="Coupon" hidden="true">
									<td class="td-label"><label>优惠卷名称： </label></td>
									<td class="td-content">
										<input id="couponName" name="couponName" class="easyui-picklistbox"/>
									</td>
								</tr>
								<tr class="SecondKill" hidden="true">
									<td class="td-label"><label>秒杀名称： </label></td>
									<td class="td-content">
										<input id="promotionName" name="promotionName" class="easyui-picklistbox"/>
									</td>
								</tr>
								<tr class="SecondKill" hidden="true">
									<td class="td-label"><label>开始时间： </label></td>
									<td class="td-content">
										<input id="promotionStartTime" name="promotionStartTime" class="easyui-datetimebox"  disabled="disabled"/>
									</td>
								</tr>
								<tr class="SecondKill" hidden="true">
									<td class="td-label"><label>结束时间： </label></td>
									<td class="td-content">
										<input id="promotionEndTime" name="promotionEndTime" class="easyui-datetimebox"  disabled="disabled"/>
									</td>
								</tr>
								<tr class="Url" hidden="true">
									<td class="td-label"><label>链接地址： </label></td>
									<td class="td-content">
										<input id="url" name="url" class="easyui-validatebox"/>
									</td>
								</tr>
							</table>
						</form>
				</td>
				<td>
					<span style="padding-left:16px;font-weight:bold;" class="ListType" hidden="true">您正在维护纵向列表承接页，请尽量维护三张及以上的图片</span>
					<span style="padding-left:16px;font-weight:bold;" class="SinglePicType" hidden="true">您正在维护单张图片承接页，只需维护一张图片即可</span>
					<span style="padding-left:16px;font-weight:bold;" class="StackType" hidden="true">您正在维护品字形承接页，请至少维护三张图片</span>
					<span style="padding-left:16px;font-weight:bold;" class="CouponType" hidden="true">您正在维护优惠券承接页，只需维护一张图片即可</span>
					<fieldset>
						<table class="table-block" >						
							<tr>
								<td class="td-label"><label>示意图片： </label></td>
								<td class="td-content">
										<section class="img-section" >
											<div class="z_photo upimg-div clear" >
												 <section class="z_file fl">
												 	<form>
														<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
														<input type="file" name="file" id="image" class="file" multiple />
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
			<tr>
				<td>
					<fieldset>
						<table class="table-block" >						
							<tr>
								<td class="td-label"><label>承接页图片： </label></td>
								<td>
									<div>
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
									 <span style="padding-left:20px;" class="ListType" hidden="true">建议尺寸：宽750×高495</span>
									 <span style="padding-left:20px;" class="SinglePicType" hidden="true">建议尺寸：宽1125×高1809</span>
									 <span style="padding-left:20px;" class="StackType" hidden="true">建议尺寸：宽750×高495</span>
									 <span style="padding-left:20px;" class="CouponType" hidden="true">建议尺寸：宽1125×高1809</span>
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
			</table>
			<div>
				<center>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton next" onclick="next()" plain="true">继续添加</a>
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton save" onclick="save()" plain="true">完成</a>
		    		&nbsp;&nbsp;&nbsp;
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" plain="true">取消</a> 
				</center>
			</div>
		</div>
	</div>
	

	<script type="text/javascript">
	var campaignId = "${param.campaignId}";
	var type = "${param.type}";
	var i = "${param.i}";
	var image = '';
	
	if(type == 'List Type'){
		$('.ListType').attr("hidden",false);
		$('.SinglePicType').attr("hidden",true);
		$('.StackType').attr("hidden",true);
		$('.CouponType').attr("hidden",true);
		image = '${AppContext.ctxPath}/static/css/img/listType.png';
	}else if(type == 'Single Pic Type'){
		$('.ListType').attr("hidden",true);
		$('.SinglePicType').attr("hidden",false);
		$('.StackType').attr("hidden",true);
		$('.CouponType').attr("hidden",true);
		$(".next").attr("hidden", true);
		image = '${AppContext.ctxPath}/static/css/img/singlePicType.png';
	}else if(type == 'Stack Type'){
		$('.ListType').attr("hidden",true);
		$('.SinglePicType').attr("hidden",true);
		$('.StackType').attr("hidden",false);
		$('.CouponType').attr("hidden",true);
		image = '${AppContext.ctxPath}/static/css/img/stackType.png';
	}else if(type == 'Coupon Type'){
		$('.ListType').attr("hidden",true);
		$('.SinglePicType').attr("hidden",true);
		$('.StackType').attr("hidden",true);
		$('.CouponType').attr("hidden",false);
		$(".next").attr("hidden", true);
		image = '${AppContext.ctxPath}/static/css/img/couponType.png';
	}
	
	$('#image').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : image,
	    readOnly : true,
	    width : '150px',
	    height : '150px',
		myComplete : function (success, result, message){
			// 自定义操作
		},
		myRemove : function(){
		}
	});
	
	
	$campaignLineForm = $("#campaignLineForm");	
	$('#imageurl').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : '',
	    width : '150px',
	    height : '150px',
		myComplete : function (success, result, message){
			// 自定义操作
			$('#picId').val(result.id);
		},
		myRemove : function(){
			$('#picId').val('');
		}
	});
	
	//初始化 banner类型下拉列表
	$('#lineType').combobox({ 
		onChange: function (newVal,oldVal) {
			if(newVal=='Product'){
				$('.Product').attr("hidden",false);
				$('.Coupon').attr("hidden",true);
				$('.Url').attr("hidden",true);
				$('.SecondKill').attr("hidden",true);
				$('#prodName').textbox({required:true});
				$('#couponName').textbox({required:false});
				$('#url').validatebox({required:false});
				$('#promotionName').textbox({required:false});
			}
			else if(newVal=='Coupon'){
				$('.Coupon').attr("hidden",false);
				$('.Product').attr("hidden",true);
				$('.Url').attr("hidden",true);
				$('.SecondKill').attr("hidden",true);
				$('#prodName').textbox({required:false});
				$('#couponName').textbox({required:true});
				$('#url').validatebox({required:false});
				$('#promotionName').textbox({required:false});
			}
			else if(newVal=='Second Kill'){
				$('.Product').attr("hidden",true);
				$('.Coupon').attr("hidden",true);
				$('.Url').attr("hidden",true);
				$('.SecondKill').attr("hidden",false);
				$('#prodName').textbox({required:false});
				$('#couponName').textbox({required:false});
				$('#url').validatebox({required:false});
				$('#promotionName').textbox({required:true});
			}
			else if(newVal=='Url'){
				$('.Product').attr("hidden",true);
				$('.Coupon').attr("hidden",true);
				$('.Url').attr("hidden",false);
				$('.SecondKill').attr("hidden",true);
				$('#prodName').textbox({required:false});
				$('#couponName').textbox({required:false});
				$('#url').validatebox({required:true});
				$('#promotionName').textbox({required:false});
			}
			else{
				$('.SecondKill').attr("hidden",true);
				$('.Product').attr("hidden",true);
				$('.Url').attr("hidden",true);
				$('.SecondKill').attr("hidden",true);
				$('#prodName').textbox({required:false});
				$('#couponName').textbox({required:false});
				$('#url').validatebox({required:false});
				$('#promotionName').textbox({required:false});
			}
		},
		method:'get',
		data:getdata(),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
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
	
	$('#prodName').picklist({
		title:'选择商品',
		completeFun:function(selectRow){
			$('#prodId').val(selectRow.id);
			return selectRow.o2oDisplayName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/TbBrandMerchandisePickList.jsp'
	});
	
	$('#couponName').picklist({
		title:'选择优惠券',
		completeFun:function(selectRow){
			$('#couponId').val(selectRow.id);
			return selectRow.name;
		},
		initParam:function(selectRow){
			return {source:'brand',type:'Coupon'}
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oConsDrawPickList.jsp'
	});
	
	$('#promotionName').picklist({
		title:'选择秒杀活动',
		completeFun:function(selectRow){
			$('#promotionId').val(selectRow.id);
			$('#promotionStartTime').datetimebox('setValue', selectRow.startTime);
			$('#promotionEndTime').datetimebox('setValue', selectRow.endTime);
			return selectRow.name;
		},
		initParam:function(selectRow){
			return {source:'brand',type:'Second Kill'};
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/BrandSecKillPickList.jsp'
	});
	
	function save(){
		$(".save").linkbutton('disable');
		if($('#picId').val() == '' || $('#picId').val() == null){
			window.parent.operationtip('请完善图片', 'info');
			$(".save").linkbutton('enable');
			return;
		}
		$campaignLineForm.ajaxSubmit({
			url : '${AppContext.ctxPath}/action/portal/campaignLine/insert',
			type : 'post',
			dataType :'json',
			data: {camId:campaignId, brandInsert : '1'},
			beforeSubmit: function() {
				var result = $campaignLineForm.form('validate');
				if(!result){
					$(".save").linkbutton('enable');
				}
				return result;
			},  
			success : function(data) {
				if (data.success) {
					window.parent.operationtip('保存成功！', 'info');
					window.parent.closeAddLineWin("ok",campaignId);
				} else {
					$(".save").linkbutton('enable');
					window.parent.operationtip(data.result, 'error');
				}
			}
		}); 
	}
	
	function next(){
		$(".next").linkbutton('disable');
		if($('#picId').val() == '' || $('#picId').val() == null){
			window.parent.operationtip('请完善图片', 'info');
			$(".next").linkbutton('enable');
			return;
		}
		$campaignLineForm.ajaxSubmit({
			url : '${AppContext.ctxPath}/action/portal/campaignLine/insert',
			type : 'post',
			dataType :'json',
			data: {camId:campaignId , brandInsert : '1'},
			beforeSubmit: function() {
				var result = $campaignLineForm.form('validate');
				if(!result){
					$(".next").linkbutton('enable');
				}
				return result;
			},  
			success : function(data) {
				if (data.success) {
					window.parent.closeAddLineWin("next", campaignId, type, i);
				} else {
					$(".next").linkbutton('enable');
					window.parent.operationtip(data.result, 'error');
				}
			}
		}); 
	}
	
	$(".cancel").click(function(){
		window.parent.closeAddLineWin("ok",campaignId, type);
	}); 
	</script>

</body>
</html>