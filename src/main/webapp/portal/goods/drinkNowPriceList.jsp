<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
<div class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="goodsCity-table" width="100%" height="40%">
		<thead>
			<tr>
				<th field="cityName" width="20%">城市</th>
				<th field="cityNotes" width="76%">说明</th>
			</tr>
		</thead>
	</table>
	
	<table id="goodsPrice-table" width="98%" height="60%" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="prodDisplayName" width="180px">商品名称</th>
					<th field="prodIntCode" width="160px">商品编码</th>
					<th field="freightName" width="150px" >配送费模板</th>
					<th field="isRetailMerchandise" width="80px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否零售商品</th>
					<th field="retailPrice" width="80px">零售价</th>
					<th field="isGpMerchandise" width="80px" hidden="true" noSearch="true" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否团购商品</th>
					<th field="groupPurchaseMinQty" hidden="true" noSearch="true" width="100px">最低团购数量</th>
					<th field="groupPurchasePrice" hidden="true" noSearch="true" width="80px">团购价</th>
					<th field="payMode" width="120px" lov="TB_O2O_PAY_MODE">支付方式</th>
					<th field="dnDisplaySequence" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">显示顺序</th>
					<th field="status" width="80px" lov="TB_O2O_STATUS">状态</th>
					<th field="notes" width="80px">说明</th>
					
			   </tr>
			</thead>
		</table>
		
	</div>
  </div> 	
   	
	<script type="text/javascript">
	    $datagrid = $('#goodsCity-table');
	    $priceDatagrid = $('#goodsPrice-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			buttonExport:true,
			buttonMenu:true,
			menuButtonCount :true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
			subGridIds: ['goodsPrice-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
		});
		
		$priceDatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			/* buttonCopy:true, */
			buttonExport:true,
			/* buttonImport:true, */
			buttonMenu:true,
			menuButtonCount:false,
			newDefaultValue:true,
			oauthFlag:true,
			nowrap:false,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			subGridIds: ['goodsAdd-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsPrice/queryByExamplePage',
		    parentGridId : 'goodsCity-table',
		    parentGridField : 'cityId',
		    linkGridField : 'districtId',
		    onBeforeLoad:function(param){
		    	param.isDrinkNow = "Y";
			},
			
			onUpdateAction:function(row,successFun,errFun,that){
				row.attr1 = 'drinkNow';
				$.post("${AppContext.ctxPath}/action/portal/goodsPrice/update",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
		},
		});
		
	</script>
</body>
</html>