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
			<form id="bannerForm" method="post"> 
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>基础信息</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>分类名称 ：</label></td>
									<td class="td-content">
										<input  class="easyui-mvgPick" name="classifyName" type="text" id="classifyName"  data-options="required:true"/>
									</td>
									
									<td class="td-label"><label>Banner名称： </label></td>
									<td class="td-content">
										<input id="name" name="name" class="easyui-validatebox"  data-options="required:true"/>
									</td>
									
									<td class="td-label"><label>Banner编码： </label></td>
									<td class="td-content">
										<input id="targetId" name="targetId" class="easyui-validatebox"  disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>是否显示： </label></td>
									<td class="td-content">
										<input id="isDisplay" name="isDisplay" class="easyui-combobox"  data-options="required:true"/>
									</td>
									
									<td class="td-label"><label>显示顺序： </label></td>
									<td class="td-content">
										<input id="sequence" name="sequence" class="easyui-numberbox"  data-options="min:0,
																					precision:0,required:true"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>开始时间： </label></td>
									<td class="td-content">
										<input id="startTime" name="startTime" class="easyui-datetimebox"  data-options="required:true"/>
									</td>
									
									<td class="td-label"><label>结束时间： </label></td>
									<td class="td-content">
										<input id="endTime" name="endTime" class="easyui-datetimebox"  data-options="required:true"/>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>	
					<td>
						<fieldset>
							<legend>明细信息</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>Banner类型： </label></td>
									<td class="td-content">
										<input  class="easyui-combobox" name="tAttr01" type="text" id="tAttr01"  data-options="required:true"></textarea>
										<input id="id" hidden="true"  name="id">
										<input id="classifyId" hidden="true" name="classifyId">
										<input id="image" hidden="true" name="image">
										<input id="campaignId" hidden="true" name="campaignId">
										<input id="merchandiseId" hidden="true" name="merchandiseId">
									</td>
								</tr>
								
								<tr class="Promotion" hidden="true">
									<td class="td-label"><label>活动名称 ：</label></td>
									<td class="td-content">
										<input  class="easyui-picklistbox" name="campaignName" type="text" id="campaignName" data-options="required:true"/>
									</td>
									
									<td class="td-label"><label>活动编码： </label></td>
									<td class="td-content">
										<input  name="campaignCode" id="campaignCode" disabled="disabled"></textarea>
									</td>
								</tr>
								<tr class="Product"  hidden="true">
									<td class="td-label"><label>商品名称： </label></td>
									<td class="td-content">
										<input id="merchandiseName" name="merchandiseName" class="easyui-picklistbox"/>
									</td>
									
									<td class="td-label"><label>商品编码： </label></td>
									<td class="td-content">
										<input id="merchandiseCode" name="merchandiseCode" disabled="disabled"/>
									</td>
								</tr>
								<tr class="URL"  hidden="true">
									<td class="td-label"><label>链接地址： </label></td>
									<td class="td-content">
										<input id="url" name="url" class="easyui-validatebox"/>
									</td>
								</tr>
								<tr class="Button"  hidden="true">
									<td class="td-label"><label>促销按钮： </label></td>
									<td class="td-content">
										<input id="buttonId" name="buttonId" class="easyui-combobox"/>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			</form>
			<table class="form-table">
				<tr>	
					<td>
						<fieldset>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>Banner图片： </label></td>
									<td class="td-content">
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
										<span style="padding-left:20px;">建议尺寸：宽1125×高300</span>
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
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" iconCls="icon-undo" plain="true">取消</a> 
				</center>
			</div>
		</div>
	</div>
	

	<script type="text/javascript">
	var bannerId = "${param.bannerId}";
	$bannerForm = $("#bannerForm");	
	
	function bannerInfoInit (bannerId, refreshDatagrid){
		if(!bannerId){
			$.messager.alert("错误","参数错误, 无法获取商品id", "error");
			return;
		}else if(bannerId == "current"){
			bannerId = initId;
		}
		initId = bannerId;
		var banner = {};
		$.post("${AppContext.ctxPath}/action/portal/banner/queryById",{id:initId},
			function(data){
				if(data){
					if(data.success){
						banner = data.result;
						$bannerForm.form("load", banner);
						$('#classifyName').mvgPick({
							title:'分类名称',
							completeFun:bannerMvgPickComplete,
							mvgMapperName:'classifyBanner',
							height: '450px',
							mvgParentId:bannerId,
							optionsLeft:{
								tableUrl:'${AppContext.ctxPath}/portal/brandWorkbench/mvgPick/BannerLeftMvgPick.jsp',
								initParam:bannerMvgPickParam
							}
						});
						$('#imageurl').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl : banner.imageUrl,
						    width : '140px',
						    height : '140px',
							myComplete : function (success, result, message){
								// 自定义操作
								$('#image').val(result.id);
							},
							myRemove : function(){
								$('#image').val('');
							}
						});
					}
				}
			});
		if(refreshDatagrid){
		}
	}
	
	
	
	/**
	 *  分类名称mvgPick 按【确定】后执行的方法
	 */
	function bannerMvgPickComplete(rightRowsMvg) {
		if(rightRowsMvg != null){
			$("#classifyId").val(rightRowsMvg.id);
			$("#classifyName").val(rightRowsMvg.name);
			return rightRowsMvg.name;
		}
	}
	/**
	 * 分类名称mvgPick 列表数据初始化参数
	 */
	function bannerMvgPickParam(){
		return {mvgParentId:bannerId};
	}
	
	//初始化 banner类型下拉列表
	$('#tAttr01').combobox({ 
		onChange: function (newVal,oldVal) {
			if(newVal=="Product"){
				$('.Product').attr("hidden",false);
				$('.Promotion').attr("hidden",true);
				$('.Button').attr("hidden",true);
				$('.URL').attr("hidden",true);
				$('#campaignName').textbox({required:false});
				$('#buttonId').combobox({required:false});
				$('#merchandiseName').textbox({required:true});
				$('#url').textbox({required:false});
			}
			else if(newVal=="Promotion"){
				$('.Promotion').attr("hidden",false);
				$('.Product').attr("hidden",true);
				$('.Button').attr("hidden",true);
				$('.URL').attr("hidden",true);
				$('#campaignName').textbox({required:true});
				$('#buttonId').combobox({required:false});
				$('#merchandiseName').textbox({required:false});
				$('#url').textbox({required:false});
			}
			else if(newVal=="Button"){
				$('.Promotion').attr("hidden",true);
				$('.Product').attr("hidden",true);
				$('.Button').attr("hidden",false);
				$('.URL').attr("hidden",true);
				$('#campaignName').textbox({required:false});
				$('#buttonId').combobox({required:true});
				$('#merchandiseName').textbox({required:false});
				$('#url').textbox({required:false});
			}
			else if(newVal=="URL"){
				$('.URL').attr("hidden",false);
				$('.Promotion').attr("hidden",true);
				$('.Button').attr("hidden",true);
				$('.Product').attr("hidden",true);
				$('#campaignName').textbox({required:false});
				$('#buttonId').combobox({required:false});
				$('#merchandiseName').textbox({required:false});
				$('#url').textbox({required:true});
			}
		},
		method:'get',
		data:getLovArray('BRAND_BANNER_TYPE'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	//初始化 是否显示下拉列表
	$('#isDisplay').combobox({ 
		method:'get',
		data:getLovArray('Is_Display'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$('#campaignName').picklist({
		title:'选择活动',
		completeFun:function(selectRow){
			$('#campaignId').val(selectRow.id);
			$('#campaignCode').val(selectRow.code);
			return selectRow.name;
		},
		initParam : function() {
			return {brandQuery : '1'};
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/BrandCampaignPickList.jsp'
	});
	
	$('#merchandiseName').picklist({
		title:'选择商品',
		completeFun:function(selectRow){
			$('#merchandiseId').val(selectRow.id);
			$('#merchandiseCode').val(selectRow.o2oIntCode);
			return selectRow.o2oDisplayName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/TbBrandMerchandisePickList.jsp'
	});
	
	//初始化 按钮下拉列表
	$('#buttonId').combobox({
		method:'get',
		url:'${AppContext.ctxPath}/action/portal/button/buttonList',
		valueField:'id',
		textField:'buttonName',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false,
	    onBeforeLoad : function(param) {
			param.source="brand";
		}
	});
	
	$(".save").click(function(){
		if($('#image').val() == '' || $('#image').val() == null){
			window.parent.operationtip('请完善图片', 'info');
			return;
		}
		if($('#startTime').datetimebox('getValue') >= $('#endTime').datetimebox('getValue')){
			window.parent.operationtip('结束时间必须大于开始时间', 'info');
			return;
		}
 		var options = {
				url : '${AppContext.ctxPath}/action/portal/banner/update',
				type : 'post',
				dataType :'json',
				data: {targetId : $('#targetId').val(),'brandUpdate': '1'},
				beforeSubmit: function() {
					var result = $bannerForm.form('validate');
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
		$bannerForm.ajaxSubmit(options); 
	});
	
	$(".cancel").click(function(){
		window.parent.closeDetailWin();
	}); 
	</script>

</body>
</html>