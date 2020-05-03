<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <table id="prict-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="districtName" width="100px" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp',
															required:true}}">城市</th>
				<th field="isDrinkNow" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否马上喝商品</th>
				<th field="freightName" width="150px" editor="{type:'picklistbox',options:{title:'选择模板',
														onBeforeOpenDialog:freightOnBeforeOpenDialog,
														initParam:freightNamePicklistParam,
														completeFun:freightNamePicklistComplete,
														tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oFreightPickList.jsp'}}">配送费模板</th>
				<th field="isSendRestaurant" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否送餐厅商品</th>
				<th field="isNewProduct" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否爱新品商品</th>
														
				<th field="isRetailMerchandise" width="100px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否零售商品</th>
				<th field="retailPrice" width="100px"  editor="{type:'textbox'}" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">零售价</th>
				<th field="isGpMerchandise" width="100px" hidden="true" noSearch="true" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否团购商品</th>
				<th field="groupPurchaseMinQty" width="100px" hidden="true" noSearch="true" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">最低团购数量</th>
				<th field="groupPurchasePrice" width="100px" hidden="true" noSearch="true" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">团购价</th>
				<th field="payMode" width="100px" lov="TB_O2O_PAY_MODE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_PAY_MODE'),
																		editable:false}}">支付方式</th>
				<th field="displaySequence" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">显示顺序</th>
				<th field="sellingPoint" width="180px"  editor="{type:'textbox'}">商品卖点描述</th>
				<th field="sellingPointColor" width="140px" editor="{type:'textbox'}">卖点显示颜色(代码)</th>
				<th field="status" width="100px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_STATUS'),
																		editable:false}}">状态</th>
				<th field="notes" width="100px"  editor="{type:'textbox'}">说明</th>
				<th field="partialMerchantSellFlag" width="110px" editor="{type:'textbox'}">是否特定商户接单</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	    $datagrid = $('#prict-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			oauthFlag:false,
			updateable:true,
			buttonNew:true,
			buttonDelete:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/goodsPrice/queryByExamplePage',
			onBeforeLoad:function(param){
				if(!goodsId){
		    		param.prodId = "noMatchId";
		    		param.attr5="detail";
		    	}else{
		    		param.prodId=goodsId;
		    		param.attr5="detail";
		    	}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				row.attr1 = 'goodsPrice';
				row.prodId=goodsId;
				$.post("${AppContext.ctxPath}/action/portal/goodsPrice/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsPrice/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			onInitNewData:function(that){
				return {
					sellingPointColor:'#FF0000',
					status:'Active',
					payMode:'Both',
					isRetailMerchandise:'Y'
				};
			},
		});
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').districtId = selectRow.id;
			return selectRow.name;
		}
		
		function freightOnBeforeOpenDialog(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(currentRow.districtId == '' || currentRow.districtId == null){
				$.messager.alert("错误", "请先选择城市", "error");
				return null;
			}else{
				return true;
				
			}
		}
		
		function freightNamePicklistParam(){
			var row = $datagrid.hdatagrid('getCurrentRow');
			return {cityId:row.districtId};
		}
		
		function freightNamePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').freightId = selectRow.id;
			return selectRow.name;
		}
		
	</script>
</body>
</html>