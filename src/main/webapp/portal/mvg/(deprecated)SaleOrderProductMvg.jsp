<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<body style="margin:0 0 0 0">
    	<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'east',split:false" title="" style="width:47%;height:100%;border-top:0px;border-right:0px;border-bottom:0px;">
					<table id="selected-prod-table-mvg" fit="true">
						<thead>
							<tr>
								<th field="prodCode" width="120px">产品编码</th>
								<th field="prodName" width="120px">产品名称</th>
								<th field="qty" width="120px" editor="{type:'numberspinner',options:{
																		min:0,
																		validType:'integer',
																		required:true}}">数量</th>
							</tr>
						</thead>
					</table>
			</div>
		
			<div data-options="region:'center',split:false" border="false" style="width:6%;height:100%;padding:0px;">
				 <div style="margin:0 auto;text-align:center;">
					<p style="margin-top: 100px;"><input type="button" id="add" class="mvg_btn" value="&nbsp;>&nbsp;" onclick="addProd()" title="移动选择项到右侧"/></p></br>
					<p style="margin-top: 100px;"><input type="button" id="remove" class="mvg_btn" value="&nbsp;<&nbsp;" onclick="removeProd()" title="移动选择项到左侧"/></p>
				</div>
			</div>
			<div data-options="region:'west',split:false" style="width:47%;height:100%;border-top:0px;border-left:0px;border-bottom:0px;">
				<table id="unselected-prod-table-mvg" fit="true">
					<thead>
						<tr>
							<th field="prodCode" width="100px">产品编码</th>
							<th field="prodName" width="120px">产品名称</th>
							<th field="currency" width="100px">货币</th>
							<th field="price" currency="CNY" width="100px">原价</th>
							<th field="promoPrice" currency="CNY" width="100px">促销价</th>
							<th field="prodModelName" width="120px">产品型号</th>
							<th field="prodGroup" width="120px">产品品牌</th>
							<th field="prodSeries" width="120px">产品系列</th>
							<th field="comments" width="200px">产品描述</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<style type="text/css">
		.mvg_btn{
			font-size:20px !important;
			font-weight:100;
			height:50px;
			width:50px;
		}
		</style>
		<script type="text/javascript">
		var headId = '${saleOrderId}';//订单头ID
		$mvgSelectedDatagrid = $('#selected-prod-table-mvg');
		$mvgSelectedDatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			title:'已选产品',
		    url:"${AppContext.ctxPath}/action/portal/saleorderitem/queryByExamplePage",
			onBeforeLoad:function(param){
				param.headId = headId;
			},
			onUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/saleorderitem/qtyUpdate',{
					id		: row.id,
					qty		: row.qty
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onLoadSuccess:function(data){
				$("#remove").removeAttr("disabled");
		   }
		});
		
		
		$mvgUnSelectedDatagrid = $('#unselected-prod-table-mvg');
		$mvgUnSelectedDatagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			title:'未选产品',
		    url:"${AppContext.ctxPath}/action/portal/product/unSelectOrderlist",
			onBeforeLoad:function(param){
				param.attr1 = headId;
			},
			onLoadSuccess:function(data){
				$("#add").removeAttr("disabled");
		   }
		});
		
		function addProd(){
			$("#add").attr("disabled", "disabled");
			var row = $mvgUnSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/saleorderitem/insert',{
				headId		: headId,
				qty			: '1.0',
				prodId		: row.id,
				promoPrice		: row.promoPrice
			},
			function(data){
				if(data.success){
					$mvgUnSelectedDatagrid.datagrid('reload');
					$mvgSelectedDatagrid.datagrid('reload');
			  	 }
			});
		}
		function removeProd(){
			$("#remove").attr("disabled", "disabled");
			var row = $mvgSelectedDatagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/saleorderitem/deleteById',{
					id	: row.id
			},function(data){
				if(data.success){
					$mvgUnSelectedDatagrid.datagrid('reload');
					$mvgSelectedDatagrid.datagrid('reload');
				}
			});
		}
		$.extend($.fn.validatebox.defaults.rules, {
			integer: {
				validator: function(value, param){
					return /^[+]?[1-9]+\d*$/i.test(value);
				},
				message: '请输入正整数'
		    }
		});
		/**
		 *	设置 '>' 和 '<' 按钮是否可点击
		 */
		function btnEnable(bool){
			if(bool){
				$('#add').removeAttr('disabled');
				$('#remove').removeAttr('disabled');
			} else {
				$('#add').attr('disabled','disabled');
				$('#remove').attr('disabled','disabled');
			}
		}
	</script>
	
</body>
</html>