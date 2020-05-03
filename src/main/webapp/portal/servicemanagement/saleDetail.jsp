<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
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
.td-label {
	width:125px;
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
.apply{
	overflow: hidden;
	width: 1020px;
}
.return{
	overflow: hidden;
	width: 975px;
}
.apply > section , .return > section{
	width: 100px;
	float: left;
	margin-right: 2%;
	height: 100px;
	margin-bottom:2%;
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
.td-content input{
	width:180px;
}
.td-content textarea{
	width:180px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:415px" title="售后服务">
				<form id="saleForm" method="post"> 
					<table class="form-table">
					    <tr>
							<td>
								<fieldset>
									<legend>售后信息</legend>
									<table class="table-block">							
										<tr>
											<td class="td-label"><label>服务编号 ：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="id" type="text" id="id" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>售后类型： </label></td>
											<td class="td-content">
												<input  class="easyui-combobox" name="aftermarketType" type="text" id="aftermarketType" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>订单编号： </label></td>
											<td class="td-content">
												<input  class="easyui-combobox" name="orderNumber" type="text" id="orderNumber" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>创建时间： </label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="created" type="text" id="created" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>消费者 ：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="fstName" type="text" id="fstName" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>售后金额： </label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="afterSalesAmount" type="text" id="afterSalesAmount" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>原因： </label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="reason" type="text" id="reason" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>备注说明： </label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="instructionManual" type="text" id="instructionManual" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>联系电话 ：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="phonenumber" type="text" id="phonenumber" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>处理状态： </label></td>
											<td class="td-content">
												<input  class="easyui-combobox" name="processingStatus" type="text" id="processingStatus" disabled="disabled"/>
											</td>
											
											<td class="td-label"><label>审批意见： </label></td>
											<td class="td-content">
												<textarea  class="easyui-validatebox" name="notes" type="text" id="notes" required="true"></textarea>
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
						</tr>
					    <tr>
							<td>
								<fieldset>
									<legend>申请照片</legend>
									<table class="table-block">							
										<tr>
											<td class="td-label"><label></label></td>
											<td >
												<div class="apply picture1">
												
												</div>
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
						</tr>
					</table>
				</form>
				<div style="text-align: center;">
					<button class="btn btn-blue refund" style="margin-left: 0" hidden="true">确认退款</button>
					<button class="btn btn-green refunds" hidden="true">确认退货</button>
		    		<button class="btn btn-red cancel">返回</button> 
				</div>
			</div>
			<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:347px;padding:0px;" fit="true">
			   <table id="orderDetail-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
					<thead>
						<tr>
							<th field="merchName" width="160px">商品名称</th>
							<th field="merchCode" width="160px">商品编码</th>
							<th field="price" width="100px">报价</th>
							<th field="qty" width="120px">数量</th>
							<th field="qtyAftersale" width="120px">售后数量</th>
							<th field="attrib17" width="120px">报价总金额</th>
							<th field="pmoPrice" width="120px">成交价</th>
							<th field="tAttr19" width="100px">成交金额</th>
							<th field="attrib11" width="120px" lov="S_IF">是否赠品</th>
							<th field="campId" width="120px">促销活动编码</th>
							<th field="activityName" width="120px">促销活动名称</th>
							<th field="merchantOfferSum" width="120px">优惠总金额</th>
							<th field="couponId" width="120px">优惠券ID</th>
							<th field="freight" width="120px">运费</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="easyui-panel" id="returnPanel" style="height:290px">
				<form id="saleForm1" method="post"> 
					<table class="form-table">
					    <tr>
							<td>
								<fieldset>
									<legend>退货信息</legend>
									<table class="table-block" >							
										<tr>
											<td class="td-label"><label>退货地址 ：</label></td>
											<td class="td-content">
												<input  style="width:728px" class="easyui-picklistbox" name="address" type="text" id="address" disabled="disabled"/>
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
						</tr>
					    <tr>
							<td>
								<table class="table-block" >							
									<tr>
										<td class="td-label"><label>退货验收人 ：</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="contact" type="text" id="contact" disabled="disabled"/>
										</td>
										
										<td class="td-label"><label>退货收货人联系电话 ：</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="contPhone" type="text" id="contPhone" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>退货快递单号 ：</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="logisticsOddNumber" type="text" id="logisticsOddNumber" disabled="disabled"/>
										</td>
										
										<td class="td-label"><label>快递公司：</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="logisticsCompany" type="text" id="logisticsCompany" disabled="disabled"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					    <tr>
							<td>
								<fieldset>
									<table class="table-block">							
										<tr>
											<td class="td-label"><label>照片：</label></td>
											<td >
												<div class="return picture2">
												
												</div>
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
$saleForm = $("#saleForm");	
$saleForm1 = $("#saleForm1");	
$returnPanel = $("#returnPanel");	
$orderDetailgrid = $('#orderDetail-table');
$aftermarketType = $("#aftermarketType");
$reason = $("#reason");
$processingStatus = $("#processingStatus");
$logisticsCompany = $("#logisticsCompany");
var saleId = "${param.saleId}";
$returnPanel.css("display", "none");
var orderId = null;
var userRefundUrl = null;
//初始化 客户分类  下拉列表
$aftermarketType.combobox({ 
	method:'get',
	data:getLovArray('AFTERMARKET_TYPE'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

$reason.combobox({ 
	method:'get',
	data:getLovArray('SALE_RETURNORREFUND_REASON'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

$processingStatus.combobox({ 
	method:'get',
	data:getLovArray('AFTER_SALES_STATUS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

$logisticsCompany.combobox({ 
	method:'get',
	data:getLovArray('LOGISTICS_COMPANY'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

function infoInit(saleId, refreshDatagrid){
	if(!saleId){
		$.messager.alert("错误","参数错误, 无法获取商品id", "error");
		return;
	}else if(saleId == "current"){
		saleId = initId;
	}
	saleId = saleId;
	var sale = {};
	var apply = [];
	var returns = [];
	$.post("${AppContext.ctxPath}/action/portal/afterSale/queryByDetailId",{id:saleId},
		function(data){
			if(data){
				if(data.success){
					sale = data.result;
					orderId = sale.orderId;
					apply = data.apply;
					returns = data.returns;
					$saleForm.form("load", sale);
					$saleForm1.form("load", sale);
					userRefundUrl = sale.attr5;
					$orderDetailgrid.datagrid("reload");
					
					$('#address').picklist({
						title:'选择退货地址',
						completeFun:function(selectRow){
							$('#contact').val(selectRow.contact);
							$('#contPhone').val(selectRow.contPhone);
							return selectRow.province+selectRow.city+selectRow.district+selectRow.address;
						},
						initParam:function(selectRow){
							return {attr1:'afterSale',corpid:sale.corpid,brandQuery:'1'}
						},
						tableUrl:'${AppContext.ctxPath}/portal/picklist/addressPickList.jsp'
					});
					
					if(sale.aftermarketType=="only_refund" && sale.processingStatus=="APPLYING"){
						$('.refund').attr("hidden",false);
					}else if(sale.aftermarketType=="refunds" && sale.processingStatus=="APPLYING"){
						$('.refunds').attr("hidden",false);
						$('#address').textbox('enable');
						$('#address').textbox({required:true});
						$returnPanel.panel({title: "退货信息"});
						$returnPanel.css("display", "block");
					}else if(sale.aftermarketType=="refunds" && sale.processingStatus=="TO_M_RECEIVE"){
						$('.refund').attr("hidden",false);
						$returnPanel.panel({title: "退货信息"});
						$returnPanel.css("display", "block");
					}else if((sale.aftermarketType=="refunds" && sale.processingStatus=="CUS_RE_GOODS") || 
							(sale.aftermarketType=="refunds" && sale.processingStatus=="REFUNDING") || 
							(sale.aftermarketType=="refunds" && sale.processingStatus=="COMPLETED")){
						$returnPanel.panel({title: "退货信息"});
						$returnPanel.css("display", "block");
					}
					var a = '<section class="img-section">'
					var b = '<div class="z_photo upimg-div clear" >'
					var c = '<section class="z_file fl">'
					var d = '<form>'
					var e =	'<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">'
					var f = '</form>'
					var g = '</section>'
					var h = '</div>'
					var i = '</section>'
					for(var i=0;i<apply.length;i++){
						$('.picture1').append(a+b+c+d+e+'<input type="file" name="'+apply[i].id+'" id="'+apply[i].id+'" class="file" multiple />'+f+g+h+i);
						$('#'+apply[i].id).BobImage({
							//upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl : apply[i].path,
						    readOnly : true,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
							}
						});
					}
					for(var i=0;i<returns.length;i++){
						$('.picture2').append(a+b+c+d+e+'<input type="file" name="'+returns[i].id+'" id="'+returns[i].id+'" class="file" multiple />'+f+g+h+i);
						$('#'+returns[i].id).BobImage({
							//upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl : returns[i].path,
						    readOnly : true,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
							}
						});
					}
				}
			}
		});
	if(refreshDatagrid){
	}
}

$orderDetailgrid.hdatagrid({
	updateable:false,
	toolbarShow:true,
	buttonSearch:true,
	buttonNew:false,
	buttonDelete:false,
	oauthFlag:false,
	striped:true,
	border:false,
	title:'订单信息',
	pageSize: 10, 
    pageList: [10,20,50], 
	url : '${AppContext.ctxPath}/action/portal/orderItem/queryByExamplePage',

	onBeforeLoad:function(param){
		if(!saleId){
    		param.aftersaleId = "noMatchId";
    	}else{
    		param.aftersaleId = saleId;
    	}
	},
});

$(".refund").click(function(){
	var reason;
	var myDate = new Date();
	if($("#notes").val()==""){
		$("#notes").val("通过");
	}
	if($("#reason").val()==""){
		reason = "无";
	}else{
		reason = $("#reason").val();
	}
	var options = {
			url : '${AppContext.ctxPath}/action/portal/afterSale/update',
			type : 'post',
			dataType :'json',
			data: {
				'id': saleId,
				'processingStatus':'REFUNDING',
				'approvalTime':myDate,
				/* 'attr1':'push',
				'attr2':'Brand Refunding' */
			},
			beforeSubmit: function() {
				var result = $saleForm.form('validate');
				return result;
			},  
			success : function(data) {
				if (data.success) {
					window.open(userRefundUrl+"?reason="+encodeURI(reason)+"&id="+orderId);
					window.parent.closeSaleDetailWin("ok");
				} else {
					window.parent.operationtip(data.result, 'error');
				}
			}
		};
	$saleForm.ajaxSubmit(options);
});
$(".refunds").click(function(){
	if($("#notes").val()==""){
		$("#notes").val("通过")
	}
	var myDate = new Date();
	var options = {
			url : '${AppContext.ctxPath}/action/portal/afterSale/update',
			type : 'post',
			dataType :'json',
			data: {
				'id': saleId,
				'processingStatus':'CUS_RE_GOODS',
				'confirmationTime':myDate,
				'address': $('#address').textbox('getValue'),
				'contact': $('#contact').val(),
				'contPhone': $('#contPhone').val(),
				'attr1':'push',
				'attr2':'Brand Re Goods'
			},
			beforeSubmit: function() {
				var result = $saleForm.form('validate');
				var result1 = $saleForm1.form('validate');
				return result && result1;
			},  
			success : function(data) {
				if (data.success) {
					window.parent.operationtip('保存成功！', 'info');
					window.parent.closeSaleDetailWin("ok");
				} else {
					window.parent.operationtip(data.result, 'error');
				}
			}
		};
	$saleForm.ajaxSubmit(options); 
});





$(".cancel").click(function(){
	window.parent.closeSaleDetailWin();
}); 
</script>
</body>
</html>