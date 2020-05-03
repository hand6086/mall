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
			<table id="goods-table" fit="true">
				<thead>
					<tr>
						<th field="buyMerchName" width="280px">商品名称</th>
						<th field="merchCode" width="170px" hidden="true">商品编码</th>
						<th field="path" width="150px" formatter="pathFormatter">商品图片</th>
						<th field="originalPrice" width="120px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">一口价</th>
						<th field="brandDiscount" width="120px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">促销折扣(折)</th>
						<th field="promotionPrice" width="120px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">折后价</th>
						<th field="lmtAmt" width="120px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">每人限购数量</th>
						<th field="totalQty" width="110px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限购总量</th>
						<th field="purchasedQty" width="110px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">已售总量</th>
						<th field="status" width="120px" lov="TB_O2O_STATUS">商品状态</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
<script type="text/javascript">
	$buyMerchNamePicklist = $('#buyMerchName');
	$dataGoodsgrid = $('#goods-table');
	var headId = "${param.headId}";

	$dataGoodsgrid.hdatagrid({
		toolbarShow  : true,
		buttonSearch : true,
		nowrap       : false,
		title : "折扣商品管理",
		pageSize : 10,//每页显示的记录条数，默认为20 
		pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
		url : '${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
		onBeforeLoad:function(param){
	    	param.headId=headId;
		},
		onChangeSelectedItem:function(row,that){
			if(row.status == 'Active'){
				$("#btn_Invalid").linkbutton({text:'失效'});
			} else{
				$("#btn_Invalid").linkbutton({text:'有效'});
			}
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="productAdd()">新建</a>',that);
			addButtonFun(92,'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="productDel()">删除</a>',that);
			addButtonFun(93,'<a href="javascript:void(0)" id="btn_Invalid" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">无效</a>',that);
		},
	});
	
	function pathFormatter(val,row){   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A +row.path +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
	
	//新建商品
	function productAdd(){
		window.location.href="${AppContext.ctxPath}/portal/brandShop/brandDiscountProductEdit.jsp?headId=" + headId + "&startTime=" + "${param.startTime}" + "&endTime=" + "${param.endTime}" ;
	}
	
	//删除记录
	function productDel(){
		var row = $dataGoodsgrid.datagrid('getSelected');
		if(row != null && row != ''){
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					row.deleteFlg = 'Y';
					row.status = 'Inactive';
					row.attr1 = 'delete';
					$.post('${AppContext.ctxPath}/action/portal/promotionGoods/update', row, function(data) {
						if (!data.success) {
							$.messager.alert("错误", data.result, "error");
							 return false;
						} else {
							$.messager.alert("成功", "删除成功", "info");
							$dataGoodsgrid.hdatagrid("reload");
						}
					})
				}
			});
		}
	}
	
	//失效、有效
	function Invalid(){
		var row = $dataGoodsgrid.datagrid('getSelected');
		var warningMessage = '';
		if(row.status == 'Active'){
			row.status = 'Inactive';
			warningMessage = '该操作将使商品失效,确定要执行该操作？';
		} else{
			row.status = 'Active';
			warningMessage = '该操作将使商品生效,确定要执行该操作？';
		}
		$.messager.confirm("操作提示", warningMessage, function(data) {
			if(data){
				row.brandDiscountType = 'Discount';
				$.post('${AppContext.ctxPath}/action/portal/promotionGoods/update', row, function(data) {
					if (!data.success) {
						$.messager.alert("错误", data.result, "error");
						 return false;
					} else {
						$.messager.alert("成功", "操作成功", "info");
						var index = $dataGoodsgrid.hdatagrid('getRowIndex', row);
						$dataGoodsgrid.hdatagrid("refreshRow", index);
						$dataGoodsgrid.datagrid('selectRow', index);
					}
				});
			}
		});
	}
</script>
</body>
</html>