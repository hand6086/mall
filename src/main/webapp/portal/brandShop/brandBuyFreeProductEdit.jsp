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
  <div class="easyui-layout" data-options="fit:true" border="false" style="width: 100%; height: 100%; ">
	<div data-options="region:'center'" title="" style="width: 90%; height: 100%; padding: 0px;">
		<form id="goodsHeaderForm" method="post">
			<table class="form-table">
			    <tr>
				   <td>
				   		<fieldset>
							<legend>买赠商品选择</legend>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>购买商品名称:</label></td>
									<td class="td-input">
										<input class="easyui-validatebox" name="buyMerchName" type="text" id="buyMerchName" size="25" />
									</td>
									<td class="td-label"><label>购买数量 :</label></td>
									<td class="td-input">
										<input class="easyui-numberbox" name="buyAmt" type="text" id="buyAmt" size="25" data-options="min:0,precision:0" required="required"/>
									</td>
									<td class="td-input">
										<input type="hidden" name="o2oGoodsId" id="o2oGoodsId">
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>赠送商品名称:</label></td>
									<td class="td-input">
										<input class="easyui-validatebox" name="freeMerchName" type="text" id="freeMerchName" size="25" />
									</td>
									<td class="td-label"><label>赠送数量 :</label></td>
									<td class="td-input">
										<input class="easyui-numberbox" name="freeAmt" type="text" id="freeAmt" size="25" data-options="min:0,precision:0" required="required"/>
									</td>
									<td class="td-input">
										<input type="hidden" name="freeMerchId" id="freeMerchId">
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>每人限赠数量  :</label></td>
									<td class="td-input">
										<input class="easyui-numberbox" name="lmtAmt" type="text" id="lmtAmt" size="25" data-options="min:0,precision:0" required="required"/>
									</td>
									<td class="td-label"><label>限赠总量 :</label></td>
									<td class="td-input">
										<input class="easyui-numberbox" name="totalQty" type="text" id="totalQty" size="25" data-options="min:0,precision:0" required="required"/>
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
				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 120px;" class="easyui-linkbutton" iconCls="icon-save" plain="true"  id="btn_submit" onclick="saveGoods()">保存并继续添加</a>
				&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="goBack()">返回</a>
			</center>
		</div>
				
		<div class="form-group form-group-sm">
			<div class="col-md-12">
				<label>&nbsp;</label>
			</div>
		</div>
		<div border="false" style="width: 100%; height: 70%;">
			<table id="goods-table" fit="true">
				<thead>
					<tr>
					<th field="buyMerchName" width="280px">购买商品名称</th>
					<th field="merchCode" width="170px" hidden="true">购买商品编码</th>
					<th field="buyAmt" width="110px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">购买数量</th>
					<th field="freeMerchName" width="230px">赠送商品名称</th>
					<th field="freeAmt" width="110px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">赠送数量</th>
					<th field="totalQty" width="110px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限赠总量</th>
					<th field="lmtAmt" width="120px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">每人限购数量</th>
					<th field="originalPrice" width="120px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">零售价</th>
					<th field="purchasedQty" width="110px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">已赠总量</th>
					<th field="status" width="120px" lov="TB_O2O_STATUS">商品状态</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
  </div>
<script type="text/javascript">
	$buyMerchNamePicklist = $('#buyMerchName');
	$freeMerchNamePicklist = $('#freeMerchName');
	$dataGoodsgrid = $('#goods-table');
	var headId = "${param.headId}";
	var startTime = "${param.startTime}";
	var endTime = "${param.endTime}";

	$dataGoodsgrid.hdatagrid({
		toolbarShow : true,
		buttonSearch : true,
		buttonDelete : true,
		nowrap : false,
		title : "买赠商品管理",
		pageSize : 10,//每页显示的记录条数，默认为20 
		pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
		url : '${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
		onBeforeLoad:function(param){
	    	param.headId=headId;
		},
		onDeleteAction : function(row,successFun,errFun,that){
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					row.deleteFlg = 'Y';
					row.status = 'Inactive';
					row.attr1 = 'delete';
					$.post('${AppContext.ctxPath}/action/portal/promotionGoods/update', row, function(data) {
						if (!data.success) {
							errFun(data.result,that);
						} else {
							successFun(that, data);
						}
					})
				}
			})
	    },
		onChangeSelectedItem:function(row,that){
			if(row.status == 'Active'){
				$("#btn_Invalid").linkbutton({text:'失效'});
			} else{
				$("#btn_Invalid").linkbutton({text:'有效'});
			}
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(91,'<a href="javascript:void(0)" id="btn_Invalid" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">无效</a>',that);
		},
	});
	
	$buyMerchNamePicklist.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		initParam : function(){
			var attr1 = 'promotion';
			return {
				attr1:attr1,
				startTime:startTime,
				endTime:endTime
			};
		},
		required : true,
		completeFun : function(selectRow) {
			$('#o2oGoodsId').val(selectRow.id);
			return selectRow.o2oDisplayName;
		}
	});
	
	$freeMerchNamePicklist.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		required : true,
		completeFun : function(selectRow) {
			$('#freeMerchId').val(selectRow.id);
			return selectRow.o2oDisplayName;
		}
	});
	//保存并继续添加
	function saveGoods(){
		buyMerchName = $('#buyMerchName').val();
		buyMerchId = $('#o2oGoodsId').val();
		buyAmt = $('#buyAmt').val();
		freeMerchName = $('#freeMerchName').val();
		freeMerchId = $('#freeMerchId').val();
		freeAmt = $('#freeAmt').val();
		lmtAmt = $('#lmtAmt').val();
		totalQty = $('#totalQty').val();
		
		if(buyMerchId =='' || buyMerchId == null){
			 $.messager.alert("错误", "商品不能为空", "error");
			 return false;
		}
		if(buyAmt =='' || buyAmt == null){
			 $.messager.alert("错误", "购买数量不能为空", "error");
			 return false;
		}
		if(freeMerchId =='' || freeMerchId == null){
			 $.messager.alert("错误", "赠送商品不能为空", "error");
			 return false;
		}
		if(freeAmt =='' || freeAmt == null){
			 $.messager.alert("错误", "赠送数量不能为空", "error");
			 return false;
		}
		if(lmtAmt =='' || lmtAmt == null){
			 $.messager.alert("错误", "每人限购数量不能为空", "error");
			 return false;
		}
		if(totalQty =='' || totalQty == null){
			 $.messager.alert("错误", "限购总量不能为空", "error");
			 return false;
		}
		$.post("${AppContext.ctxPath}/action/portal/promotionGoods/insert",{
			headId         :   headId,
			merchStartTime :   startTime,
			merchEndTime   :   endTime,
			buyMerchId     :   buyMerchId,
			freeMerchId    :   freeMerchId,
			buyAmt         :   buyAmt,
			freeAmt        :   freeAmt,
			lmtAmt         :   lmtAmt,
			totalQty       :   totalQty,
			status		   :   'Inactive',
			purchasedQty   :   '0',
			brandDiscountType  : 'BOFO'
		},function(data){
			if(data.success){
				window.parent.operationtip('保存成功！', 'info');
				//重置输入框
				$('#buyMerchName').textbox('setValue','');
				$('#o2oGoodsId').val('');
				$('#buyAmt').numberbox('setValue','');
				$('#freeMerchName').textbox('setValue','');
				$('#freeMerchId').val('');
				$('#freeAmt').numberbox('setValue','');
				$('#lmtAmt').numberbox('setValue','');
				$('#totalQty').numberbox('setValue','');
				$dataGoodsgrid.datagrid('reload');
			}
		});
	}
	
	//返回按钮
	function goBack(){
		window.location.href = '${AppContext.ctxPath}/portal/brandShop/brandBuyFreeProductList.jsp?headId=' + headId + "&startTime=" + startTime + "&endTime=" + endTime;
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
				row.brandDiscountType = 'BOFO';
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