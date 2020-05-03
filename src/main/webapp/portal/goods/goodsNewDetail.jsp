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
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:50%" title="商品详情信息">
					<form id="goodsHeaderForm" method="post">
					<table class="form-table">
					    <tr>
						   <td>
						   		<fieldset>
									<legend>商品详情</legend>
									<table class="table-block">
										<tr>
											<td class="td-label"><label>商品名称:</label></td>
											<td class="td-input">
												<input  class="easyui-validatebox" name="o2oDisplayName" type="text" id="o2oDisplayName" size="25" />
											</td>
											
											<td class="td-label"><label>商品编码 :</label></td>
											<td class="td-input">
												<input  class="easyui-validatebox" name="o2oIntCode" type="text" id="o2oIntCode" size="25" />
											</td>
											
											<td class="td-label"><label>组织:</label></td>
											<td class="td-input">
												<input  class="easyui-validatebox" name="organization" type="text" id="organization" size="25" />
											</td>
										</tr>
									</table>
								</fieldset>
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

var initGoodsId = "";
var goodsId = "${param.goodsId}";
$('#goods-tabs').tabs();

/* *********** 定义变量并且绑定输入框   start **************** */
$o2oDisplayNameInput	 	 = $('#o2oDisplayName');
$o2oIntCodeInput  			 = $('#o2oIntCode');
$organizationInput	   	     = $('#organization');

var goods = {};

$goodsHeaderForm = $("#goodsHeaderForm");

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
	$.post("${AppContext.ctxPath}/action/portal/goods/queryById",{id:initGoodsId},
		function(data){
			if(data){
				if(data.success){
					goods = data.result;
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
		$("#btn_submit").hide();
		$("#btn_cancle").hide();
		$("#btn_edit").show();
	}
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
	
	function loadObject(object){
		$("#goodsHeaderForm").form("clear");
		$("#goodsHeaderForm").form("load", object);
		for (key in object) {
			value = object[key];
		} 
	}
	
	function submitForm(){
		var o2oDisplayName = $o2oDisplayNameInput.val();
		var o2oIntCode = $o2oIntCodeInput.val();
		var organization = $organizationInput.val();
		
		if (o2oDisplayName==null || o2oDisplayName == ''){
			alert('商品名称不能为空！');
			return;
		}else{
			goods.o2oDisplayName = o2oDisplayName;
		}
		if (o2oIntCode==null || o2oIntCode == ''){
			alert('商品编码不能为空！');
			return;
		}else{
			goods.o2oIntCode = o2oIntCode;
		}
		if (organization==null || organization == ''){
			alert('组织不能为空！');
			return;
		}else{
			goods.organization = organization;
		}
		goods.row_status = 'UPDATE';
		$.post('${AppContext.ctxPath}/action/portal/goods/upsert',goods,function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						goods = data.newRow;
						disableEdit();
						alert("保存成功");
					}
				});
	}
</script>
</body>
</html>