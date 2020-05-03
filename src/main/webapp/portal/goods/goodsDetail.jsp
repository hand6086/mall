<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	width:100%;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 16px;
}
.td-label {
	width:120px;
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
.btn-blue{
	background-color:#2277da;
	border:1px solid #0064b6;
	color:#fff!important;
	width:100px;
	height:30px;
	font-size:12px;
	margin-left:20px;
	border-radius:2px;
}
.btn-blue:hover{
	background-color:#006ba2;
}
.btn-red{
	background-color:#cc2424;
	border:1px solid #a91e1e;
	color:#fff!important;
	width:100px;
	margin-left:20px;
	height:30px;
	font-size:12px;
}
.btn-red:hover{
	background-color:#a91e1e;
}
.btn-green{
	background-color:#00a651;
	border:1px solid #007d3d;
	color:#fff!important;
	width:100px;
	margin-left:20px;
	height:30px;
	font-size:12px;
}
.btn-green:hover{
	background-color:#007d3d;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:50%" title="商品详情信息">
					<form id="goodsHeaderForm" method="post">
					<table class="form-table">
					    <tr>
						   <td>
								<table class="table-block">
									<tr>
										<td class="td-label"><label>产品 :</label></td>
										<td class="td-input">
											<input  class="easyui-validatebox" name="name" type="text" id="name" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>说明:</label></td>
										<td class="td-input">
											<input  class="easyui-validatebox" name="description" type="text" id="description" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>类型:</label></td>
										<td class="td-input">
											<input  class="easyui-combobox" name="type" type="text" id="type" disabled="disabled" size="25" />
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block">
									 <tr>
										<td class="td-label"><label>产品编码:</label></td>
										<td class="td-input">
											<input  class="easyui-validatebox" name="part" type="text" id="part" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>单位:</label></td>
										<td class="td-input">
											<input  class="easyui-combobox" name="unitOfMeasure" type="text" id="unitOfMeasure" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>检查资格:</label></td>
										<td class="td-input">
											<input  class="easyui-checkbox" style="width:30px" name="prePickCD" type="checkbox" 
											data-options=" on:'Y',off:'N' " id="prePickCD"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>包含资格:</label></td>
										<td class="td-input">
											<input  class="easyui-validatebox" style="width:30px" name="inclEligFlag" data-options=" on:'Y',off:'N' " type="checkbox" id="inclEligFlag" />
										</td>
									</tr>
									<tr hidden="true">
										<td class="td-label"><label>单位ID:</label></td>
										<td class="td-input">
											<input  class="easyui-validatebox" name="unitId" type="text" id="unitId" hidden="true" />
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block">
									<tr>
										<td class="td-label"><label>价格类型:</label></td>
										<td class="td-input">
												<input  class="easyui-combobox" name="priceType" type="text" id="priceType" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>状态:</label></td>
										<td class="td-content">
											<input  class="easyui-combobox" name="versionStatus" id="versionStatus" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>可订购:</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" style="width:30px" name="orderable" type="checkbox" id="orderable"/>
									</td>
									</tr>
									<tr>
										<td class="td-label"><label>作为资产追踪:</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox"  style="width:30px" name="trackAsAssetFlag" type="checkbox" id="trackAsAssetFlag"/>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block">
									<tr>
										<td class="td-label"><label>组织:</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="organization" type="text" id="organization" disabled="disabled" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>结构类型:</label></td>
										<td class="td-content">
											<input  class="easyui-combobox" name="productDefTypeCode" type="text" id="productDefTypeCode" size="25" />
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>销售产品:</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="salesProductFlag" style="width:30px" type="checkbox" id="salesProductFlag"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>服务产品:</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="salesServiceFlag" style="width:30px" type="checkbox" id="salesServiceFlag"/>
										</td>
									</tr>
								</table>
					 		</td>
					 	</tr>
					</table>
					</form>
				
				<div>
					<center>
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:window.parent.closeGoodsDetailWin()">返回</a>
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-save" plain="true"  id="btn_submit" onclick="submitForm()">保存</a>
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-edit" plain="true"  id="btn_edit" onclick="enableEdit()">编辑</a>
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  id="btn_cancle" onclick="disableEdit()">取消编辑</a>
					</center>
				</div>

			</div>
			<div id="goods-tabs" class="easyui-tabs" style="width: 98%;height: 500px;" data-options="border:false">
				<div title="商品销售价格" href="${AppContext.ctxPath}/portal/goods/product/prodPricList.jsp">
				</div>
				<div title="套装单品" href="${AppContext.ctxPath}/portal/goods/product/prodSkuList.jsp">
				</div>
				<div title="商品评价" href="${AppContext.ctxPath}/portal/goods/product/prodMessList.jsp">
				</div>
				<div title="商品图片" href="${AppContext.ctxPath}/portal/goods/product/prodPictList.jsp">
				</div>
				
			</div>
		</div>
	</div>
<script type="text/javascript">
getLovOfList("[PRODUCT_TYPE,IMPL_PHASE,PROD_TYPE_CD]");

var initGoodsId = "";
var goodsId = "${param.goodsId}";
$('#goods-tabs').tabs();

/* *********** 定义变量并且绑定输入框   start **************** */
$nameInput		 	 = $('#name');
$descriptionInput  	 = $('#description');
$typeCombobox	     = $('#type');

$partInput 			 = $('#part');
$unitOfMeasureCombobox= $('#unitOfMeasure');
$unitIdCombobox      = $('#unitId');
$prePickCD	   	     = $('#prePickCD');
$inclEligFlag		 = $('#inclEligFlag');

$priceTypeCombobox   = $('#priceType');
$versionStatusCombobox= $('#versionStatus');
$orderable	   	     = $('#orderable');
$trackAsAssetFlag	 = $('#trackAsAssetFlag');

$organization        = $('#organization');
$productDefTypeCodeCombobox  = $('#productDefTypeCode');
$salesProductFlag	 = $('#salesProductFlag');
$salesServiceFlag	 = $('#salesServiceFlag');

$goodsHeaderForm	 = $("#goodsHeaderForm");
$goodsFollowUp  	 = $("#goodsFollowUp");
var goods = {};


/* *********** 定义变量并且绑定输入框   end **************** */

	/**
	 * 更新客户的头信息
	 */
	function goodsHeadUpdate(){
		if(goodsHeadIsEditing){
			//acctHeadDisable();
			$goodsHeaderForm.form({
				success : function(data){
					var data = eval('(' + data + ')'); // change the JSON string to javascript object
					if (data.success) {
						goodsHeadDisable();
						window.parent.operationtip('保存成功！','info');
					} else {
						goodsHeadEnable();
						window.parent.operationtip(data.result,'error');
					}
				}
			});
			$goodsHeaderForm.submit();
		} 
	}
	
	$goodsHeaderForm = $("#goodsHeaderForm");
	$goodsHeaderForm.form({
		url : "${AppContext.ctxPath}/action/portal/goods/update",
		onSubmit : function(){
			return $goodsHeaderForm.form('validate');
		}
	});
	function goodsInfoInit(goodsId, refreshDatagrid){
		$("#btn_submit").hide();
		$("#btn_cancle").hide();
		if(!goodsId){
			$.messager.alert("错误","参数错误, 无法获取商品id", "error");
			return;
		}else if(goodsId == "current"){
			goodsId = initGoodsId;
		}
		initGoodsId = goodsId;
		$.post("${AppContext.ctxPath}/action/portal/goods/queryDetailById",{id:initGoodsId},
			function(data){
				if(data){
					if(data.success){
						goods = data.result;
						//$goodsHeaderForm.form("load", goods);
						disableEdit();
					}
				}
			});
		if(refreshDatagrid){

			
		}
	}
	/**
	 * 使表单能编辑修改
	 */
	function enableEdit(){
		$(":disabled", $("#goodsHeaderForm")).removeAttr("disabled");
		$("#organization").attr("disabled", "disabled");
		$("#type").combobox('disable');
		$unitOfMeasureCombobox.combobox('enable');
		$priceTypeCombobox.combobox('enable');
		$versionStatusCombobox.combobox('enable');
		$productDefTypeCodeCombobox.combobox('enable');
		$("#btn_submit").show();
		$("#btn_cancle").show();
		$("#btn_edit").hide();
	}

	/**
	 * 禁止表单修改
	 */
	function disableEdit(){
		loadObject(goods);
		$(":enabled", $("#goodsHeaderForm")).attr("disabled", "disabled");
		//使下拉列表不会显示列表值  禁用状态
		$unitOfMeasureCombobox.combobox('disable');
		$typeCombobox.combobox('disable');
		$priceTypeCombobox.combobox('disable');
		$versionStatusCombobox.combobox('disable');
		$productDefTypeCodeCombobox.combobox('disable');
		$("#btn_submit").hide();
		$("#btn_cancle").hide();
		$("#btn_edit").show();
	}
	//初始化 类型下拉列表
	$typeCombobox.combobox({ 
	    method:'get',
		data:getLovArray('PRODUCT_TYPE'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	//初始化 单位下拉列表
	$unitOfMeasureCombobox.combobox({ 
		url:'/action/portal/goods/queryUnit',
		method:'get',
		cache : false,
		valueField:'unitOfMeasure',
		textField:'unitOfMeasure',
		onSelect:function(unitRecord){
			return $unitIdCombobox.val(unitRecord.id);
		}
	});
	//初始化 价格类型下拉列表
	$priceTypeCombobox.combobox({ 
		valueField:'val',
		textField:'name',
		url:'/action/portal/basic/list/UNIT_OF_MEASURE',
		panelHeight: 'auto',//自动高度适合
		onBeforeLoad : function(param) {
			param.parentVal="Price Type";
		}
	});
	//初始化 状态下拉列表
	$versionStatusCombobox.combobox({ 
		method:'get',
		data:getLovArray('IMPL_PHASE'),
		valueField:'val',
		textField:'name',
	    cache: false
	});
	//初始化 结构类型下拉列表
	$productDefTypeCodeCombobox.combobox({ 
		method:'get',
		data:getLovArray('PROD_TYPE_CD'),
		valueField:'val',
		textField:'name',
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	}); 
	
	/**
	 * 把对象数据填充到表单上
	 */
	function loadObject(object){
		$("#goodsHeaderForm").form("clear");
		$("#goodsHeaderForm").form("load", object);
		for (key in object) {
			value = object[key];
			$("[name='" + key + "'][type='checkbox']", $("#goodsHeaderForm"))
					.each(
							function() {
								$(this).prop("checked", value=="Y" ? true : false);
							});
		} 
	}
	
	function submitForm(){
		var name = $nameInput.val();
		var part = $partInput.val();
		var unitOfMeasure = $unitOfMeasureCombobox.combobox('getValue');
		var priceType = $priceTypeCombobox.combobox('getValue');
		//检查资格 赋值 Y/N
		if($('#prePickCD').is(":checked")==true){
			$('#prePickCD').val('Y');
		} else {
			$('#prePickCD').val('N');
		}
		//包含资格 赋值 Y/N
		if($('#inclEligFlag').is(":checked")==true){
			$('#inclEligFlag').val('Y');
		} else {
			$('#inclEligFlag').val('N');
		}
		//可订购 赋值 Y/N
		if($('#orderable').is(":checked")==true){
			$('#orderable').val('Y');
		} else {
			$('#orderable').val('N');
		}
		//作为资产追踪 赋值 Y/N
		if($('#trackAsAssetFlag').is(":checked")==true){
			$('#trackAsAssetFlag').val('Y');
		} else {
			$('#trackAsAssetFlag').val('N');
		}
		//销售产品 赋值 Y/N
		if($('#salesProductFlag').is(":checked")==true){
			$('#salesProductFlag').val('Y');
		} else {
			$('#salesProductFlag').val('N');
		}
		//服务产品 赋值 Y/N
		if($('#salesServiceFlag').is(":checked")==true){
			$('#salesServiceFlag').val('Y');
		} else {
			$('#salesServiceFlag').val('N');
		}
/* 		if (name==null){
			alert('产品不能为空！');
		}
		if (part==null){
			alert('产品编码不能为空！');
		}
 */		if (unitOfMeasure==null || unitOfMeasure == ''){
			alert('单位不能为空！');
			return;
		}
		if (priceType==null || priceType == ''){
			alert('价格类型不能为空！');
			return;
		}
		$.post('${AppContext.ctxPath}/action/portal/goods/detailUpdate',
		{
			id					: goodsId,
			
			name				: $('#name').val(),
			description			: $('#description').val(),
			type			    : $('#type').combobox('getValue'),	
			part                : $('#part').val(),
			unitOfMeasure		: $('#unitOfMeasure').combobox('getValue'),
			prePickCD			: $('#prePickCD').val(),
			inclEligFlag		: $('#inclEligFlag').val(),
			unitId	            : $('#unitId').val(),
			priceType           : $('#priceType').combobox('getValue'),
			versionStatus       : $('#versionStatus').combobox('getValue'),
			orderable           : $('#orderable').val(),
			trackAsAssetFlag    : $('#trackAsAssetFlag').val(),
			organization        : $('#organization').val(),
			productDefTypeCode  : $('#productDefTypeCode').combobox('getValue'),
			salesProductFlag    : $('#salesProductFlag').val(),
			salesServiceFlag    : $('#salesServiceFlag').val()
	    },function(data){
	    	if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				goods = data.newRow;
				disableEdit();
				alert("保存成功");
				//window.parent.editWinClose($("#row_status").val(), data.newRow);
			}
		});
	}
</script>
</body>
</html>