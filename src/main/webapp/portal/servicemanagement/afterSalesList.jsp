<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<style type="text/css" >
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:180px;
}
</style>

<body>
	<div id="menu_layout" class="easyui-layout" fit="true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			
			<fieldset class="x-fieldset" id="aftermarketKeyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速查询</span>
				</legend>
				<div class="row keyfilter-border">
			   		<table class="form-table">
					    <tr>
			   				<td class="td-label"><label>服务编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="id" type="text" id="id" size="25" />
							</td>
							
							<td class="td-label"><label>售后类型：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="aftermarketType" type="text" id="aftermarketType" size="25" />
							</td>
							
							<td class="td-label"><label>订单编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="orderNumber" type="text" id="orderNumber" size="25" />
							</td>
			   			</tr>
					    <tr>
							<td class="td-label"><label>消费者名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="fstName" type="text" id="fstName" size="25" />
							</td>
							
							<td class="td-label"><label>消费者联系电话：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="phonenumber" type="text" id="phonenumber" size="25" />
							</td>
							
							<td class="td-label"><label>处理状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="processingStatus" type="text" id="processingStatus" size="25" />
							</td>
			   			</tr>
					    <tr>
							<td class="td-label"><label>退款结果：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="refundResult" type="text" id="refundResult" size="25" />
							</td>
			   			</tr>
			   		</table>
			   	</div>
			</fieldset>
			<table id="aftermarket-table" style="width:98%;height:100%;" singleSelect="true" rownumbers="true" pagination="true" keyFilterDiv="aftermarketKeyFilter">
				<thead>
					<tr>
						<th field="id" width="150px" formatter="idFormatter">服务编号</th>
						<th field="aftermarketType" width="150px" lov="AFTERMARKET_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('AFTERMARKET_TYPE'),
																		editable:false}}">售后类型</th>
						<th field="orderNumber" width="150px">订单编号</th>
						<th field="payType" width="150px">支付方式</th>
						<th field="created" width="150px">创建时间</th>
						<th field="fstName" width="150px">消费者</th>
						<th field="phonenumber" width="150px">联系电话</th>
						<th field="afterSalesAmount" width="150px">售后金额</th>
						<th field="reason" width="150px" lov="SALE_RETURNORREFUND_REASON">原因</th>
						<th field="instructionManual" width="150px">备注说明</th>
						<th field="documentInformation" width="150px">凭证信息</th>
						<th field="processingStatus" width="150px" lov="AFTER_SALES_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('AFTER_SALES_STATUS'),
																		editable:false}}">处理状态</th>
						<th field="refundResult" width="150px">退款结果</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 弹出窗1 -->
    <div id="saleDetailWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="saleDetailWinFram" name="saleDetailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
    <script type="text/javascript">
		var id = null;
		var aftermarketType = null;
		var orderNumber = null;
		var fstName = null;
		var phonenumber = null;
		var processingStatus = null;
		var refundResult = null;
	
	    $saleDetailWin = $("#saleDetailWin");
		$saleDetailWinFram = $("#saleDetailWinFram");
		$datagrid = $('#aftermarket-table');
		
		var initId = getUrlParams("id");
		
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:false,
			buttonMenu:true,
			buttonExport:true,
			buttonNew:true,
			oauthFlag:true,
			striped:true,
			newDefaultValue:true,
			border : false,
			url : '${AppContext.ctxPath}/action/portal/afterSale/queryByExamplePage',
			onBeforeLoad:function(param){
				if(id != null && id != ''){
		    		param.id = id;
				}
				if(aftermarketType != null && aftermarketType != ''){
		    		param.aftermarketType = aftermarketType;
				}
				if(orderNumber != null && orderNumber != ''){
		    		param.orderNumber = orderNumber;
				}
				if(fstName != null && fstName != ''){
		    		param.fstName = fstName;
				}
				if(phonenumber != null && phonenumber != ''){
		    		param.phonenumber = phonenumber;
				}
				if(processingStatus != null && processingStatus != ''){
		    		param.processingStatus = processingStatus;
				}
				if(refundResult != null && refundResult != ''){
		    		param.refundResult = refundResult;
				}
				
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					param.id = initId;
				}
			},
			
			onLoadSuccess: function (data) {
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					initId = '';
				}
	        },
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/afterSale/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="afterSaleSearch()" iconCls="icon-search" plain="true">查询</a>',that);
				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="afterSaleClean()" iconCls="icon-reload" plain="true">重置</a>',that);
			}
		});
		
	   	function idFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openSaleDetailWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
	   	
	   	function openSaleDetailWin(saleId){
			if(!saleId){
				$.messager.show("错误", "参数错误，无法获取线索id", "error");
				return;
			}
			if( !$saleDetailWinFram.attr("src") ){
				$saleDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/servicemanagement/saleDetail.jsp?saleId="+saleId);
				$saleDetailWinFram[0].onload = function() {
					$saleDetailWinFram[0].contentWindow.infoInit(saleId, "reload");//等待窗口加载完毕
				}
			}else{
				$saleDetailWinFram[0].contentWindow.infoInit(saleId, "reload");
			}
			$saleDetailWin.css("display", "block");
		}
	   	function closeSaleDetailWin(operate){
			$saleDetailWin.css("display", "none");
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);

			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/afterSale/queryById", {id: row.id}, function(data){
					if(data.success){
						$datagrid.datagrid('updateRow', {index : index, row:data.result})
						$datagrid.datagrid('acceptChanges');
					}else{
						$.messager.show("错误", "更新数据错误: "+data.result, "error");
					}
				});
			}
			$saleDetailWinFram.attr("src","");
		}
	   	
	   	$('#aftermarketType').combobox({ 
		    method:'get',
			data:getLovArray('AFTERMARKET_TYPE'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
	   	$('#processingStatus').combobox({ 
		    method:'get',
			data:getLovArray('AFTER_SALES_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
		function afterSaleSearch(){
		   id = $('#id').val();
		   aftermarketType = $('#aftermarketType').combobox('getValue');
		   orderNumber = $('#orderNumber').val();
		   fstName = $('#fstName').val();
		   phonenumber = $('#phonenumber').val();
		   processingStatus = $('#processingStatus').combobox('getValue');
		   refundResult = $('#refundResult').val();
		   $datagrid.datagrid('reload');
	    }
	   
	    function afterSaleClean(){
		   $('#id').val('');
		   $('#aftermarketType').combobox('setValue',''); 
		   $('#orderNumber').val('');
		   $('#fstName').val('');
		   $('#phonenumber').val('');
		   $('#processingStatus').combobox('setValue',''); 
		   $('#refundResult').val('');
		   id = null;
		   aftermarketType = null;
		   orderNumber = null;
		   fstName = null;
		   phonenumber = null;
		   processingStatus = null;
		   refundResult = null;
		   $datagrid.datagrid('reload');
	    }
	</script>
</body>
</html>