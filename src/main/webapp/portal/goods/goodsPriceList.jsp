<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
<div class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="goodsCity-table" width="98%" height="250px">
		<thead>
			<tr>
				<th field="cityName" width=20% editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
				<th field="cityNotes" width=76% editor="{type:'textbox'}">说明</th>
			</tr>
		</thead>
	</table>
	
	<table id="goodsPrice-table" width="98%" height="430px" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
				
				
					<th field="prodDisplayName" width="180px" editor="{type:'picklistbox',options:{title:'选择商品',
															completeFun:merchandisePicklistComplete,
															initParam:initPickMerchandiseParam,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp',
															required:true}}">商品名称</th>
					<th field="prodIntCode" width="160px">商品编码</th>
					
					<th field="isDrinkNow" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否马上喝商品</th>
					<th field="freightName" width="150px" editor="{type:'picklistbox',options:{title:'选择模板',
															initParam:freightNamePicklistParam,
															completeFun:freightNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oFreightPickList.jsp'}}">配送费模板</th>
					<th field="isSendRestaurant" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否送餐厅商品</th>
					<th field="isNewProduct" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否爱新品商品</th>
					
					<th field="isRetailMerchandise" width="80px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否零售商品</th>
					<th field="retailPrice" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">零售价</th>
					<th field="isGpMerchandise" width="80px" hidden="true" noSearch="true" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否团购商品</th>
					<th field="groupPurchaseMinQty" width="100px" hidden="true" noSearch="true" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">最低团购数量</th>
					<th field="groupPurchasePrice" width="80px" hidden="true" noSearch="true" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">团购价</th>
					<th field="payMode" width="120px" lov="TB_O2O_PAY_MODE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_PAY_MODE'),
																		editable:false}}">支付方式</th>
					<th field="displaySequence" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">显示顺序</th>
					<th field="sellingPoint" width="280px" editor="{type:'textbox'}">商品卖点描述</th>
					<th field="sellingPointColor" width="140px" editor="{type:'textbox'}">卖点显示颜色（代码）</th>
					<th field="status" width="80px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_STATUS'),
																		editable:false}}">状态</th>
					<th field="notes" width="80px" editor="{type:'textbox'}">说明</th>
					<th field="partialMerchantSellFlag" width="110px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否特定商户接单</th>
					
			   </tr>
			</thead>
		</table>
		
		<table id="goodsAdd-table" width="98%" height="347px" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="merchantCode" width="20%">商户编号</th>
					<th field="merchantName" width="20%" editor="{type:'picklistbox',options:{title:'选择商户',
															completeFun:accountPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oAccountPickList.jsp'}}">商户名称</th>
					<th field="o2oForcedStore" width="20%" lov="TB_O2O_JUDGE_TYPE">是否兜底商户</th>
					<th field="o2oDistrict" width="30%">区/县</th>
					
			   </tr>
			</thead>
		</table>
		
	</div>
  </div> 	
   	<!-- 弹出窗 -->
    <div id="detailWin" class="crmWin" style="width:100%;height:100%">
    	<iframe src=""  id="detailWinFram" name="detailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>	
   	</div>
	<script type="text/javascript">
		$detailWin = $("#detailWin");
		$detailWinFram = $("#detailWinFram");
	    $datagrid = $('#goodsCity-table');
	    $priceDatagrid = $('#goodsPrice-table');
		$addDatagrid = $('#goodsAdd-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonExport:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,15,30],//可以设置每页记录条数的列表 
			subGridIds: ['goodsPrice-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goodsCity/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/goodsCity/deleteById', {
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
			
 			onAddMoreButton:function(that,addButtonFun){
			}, 
			
		});
		
		$priceDatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			/* buttonCopy:true, */
			buttonExport:true,
			/* buttonImport:true, */
			buttonMenu:true,
			menuButtonCount : true,
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
		    
		    onSelect:function(index, row){
				if(row.isNewProduct == 'Y'){
					$('#btn_edit').linkbutton('enable');
				} else{
					$('#btn_edit').linkbutton('disable');
				}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				/* if(row.isRetailMerchandise=='N'&&(row.retailPrice==''||row.retailPrice==null)){
					if(row.isGpMerchandise=='N'&&(row.groupPurchasePrice==''||row.groupPurchasePrice==null)){
						alert("请在是否零售和是否团购中任选一种");
						var ind = $priceDatagrid.datagrid('getRowIndex',row);
						$priceDatagrid.datagrid('beginEdit', ind);
						return;
					}
				}
			 	if(row.isRetailMerchandise=='Y'&&(row.retailPrice==''||row.retailPrice==null)){
					alert("请选择零售价格")
					var ind = $priceDatagrid.datagrid('getRowIndex',row);
					$priceDatagrid.datagrid('beginEdit', ind);
					return;
				}
			 	
			 	if(row.isDrinkNow=='Y'&&(row.freightName==''||row.freightName==null)){
					alert("请选择配送费模板")
					var ind = $priceDatagrid.datagrid('getRowIndex',row);
					$priceDatagrid.datagrid('beginEdit', ind);
					return;
				}
				
				if(row.isGpMerchandise=='Y'&&(row.groupPurchasePrice==''||row.groupPurchasePrice==null)){
					alert("请选择团购价格");
					var ind = $priceDatagrid.datagrid('getRowIndex',row);
					$priceDatagrid.datagrid('beginEdit', ind);
					return;
				}  */
				row.attr1 = 'goodsPrice';
				row.districtId = $datagrid.datagrid('getSelected').cityId;
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
			
			onChangeSelectedItem:function(row,that){
				if(row.status == 'Active'){
					$("#btn_add").linkbutton({text:'无效'});
				} else{
					$("#btn_add").linkbutton({text:'有效'});
				}
			},

 			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_edit" onClick="edit()" iconCls="icon-edit" plain="true">爱新品信息维护</a>',that);
			}, 
			onInitNewData:function(that){
				return{
					status:'Active',
					payMode:'Only Payonline',
					isRetailMerchandise:'Y'
				};
			},
			
		});
		
		$addDatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			/* buttonCopy:true, */
			buttonExport:true,
			/* buttonImport:true, */
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:false,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/goodsMerchants/queryByExamplePage',
		    parentGridId : 'goodsPrice-table',
		    parentGridField : 'id',
		    linkGridField : 'prodPriceId',
			
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
 				row.prodPriceId=$priceDatagrid.datagrid('getSelected').id;
				$.post("${AppContext.ctxPath}/action/portal/goodsMerchants/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/goodsMerchants/deleteById', {
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

 			onAddMoreButton:function(that,addButtonFun){
			}, 
			
		});
		
		//失效
 		function Invalid(){
			var row = $priceDatagrid.datagrid('getSelected');
			if(row.status == 'Inactive'){
			$priceDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
			}else {
			$priceDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
			}
			var index = $priceDatagrid.hdatagrid('getRowIndex', row);
            $priceDatagrid.datagrid('selectRow',index);
		} 
		
		
		function merchandisePicklistComplete(selectRow){
			$priceDatagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
			if(selectRow.suitProductFlg == 'Y'){
				$priceDatagrid.hdatagrid('getEditor', {
					index : $priceDatagrid.hdatagrid('getCurrentRowIndex'),
					field : 'retailPrice'
				}).target.textbox('setValue', selectRow.retailPrice).textbox('enable');
			}else{
				$priceDatagrid.hdatagrid('getEditor', {
					index : $priceDatagrid.hdatagrid('getCurrentRowIndex'),
					field : 'retailPrice'
				}).target.textbox('setValue', '').textbox('enable');
			}
			return selectRow.o2oDisplayName;
		}
		
		function accountPicklistComplete(selectRow){
			$addDatagrid.hdatagrid('getCurrentRow').merchantId = selectRow.merchantId;
			return selectRow.name;
		}
		
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		function freightNamePicklistParam(){
			var row = $datagrid.hdatagrid('getCurrentRow');
			return {cityId:row.cityId};
		}
		
		function freightNamePicklistComplete(selectRow){
			$priceDatagrid.hdatagrid('getCurrentRow').freightId = selectRow.id;
			return selectRow.name;
		}
		
		function initPickMerchandiseParam() {
			var districtId = $datagrid.hdatagrid('getCurrentRow').cityId;
			return {districtId:districtId,attr1:'price'};
		}
		
		function edit(){
			var row = $priceDatagrid.hdatagrid('getCurrentRow');
			window.top.quickEnter('爱新品商品列表','爱新品商品列表','O2O_GOODS_MANAGE','');
			openDetailWin(row.id);
		}
		
	 function openDetailWin(prodId){
			if(!prodId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			if( !$detailWinFram.attr("src") ){
				$detailWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/newProductPriceDatail.jsp?prodId="+prodId);
				$detailWinFram[0].onload = function() {
					$detailWinFram[0].contentWindow.infoInit(prodId, "reload");//等待窗口加载完毕
				}
			}else{
				$detailWinFram[0].contentWindow.infoInit(prodId, "reload");
			}
			$detailWin.css("display", "block");
		}
	   function closeDetailWin(operate){
		   window.top.quickEnter('商品价格管理','商品价格管理','O2O_GOODS_MANAGE','');
		   $detailWin.css("display", "none");
		   $detailWinFram.attr("src","");
			var row = $priceDatagrid.datagrid('getSelected');
			var index = $priceDatagrid.datagrid('getRowIndex', row);

			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/goodsPrice/queryById", {id: row.id}, function(data){
					if(data.success){
						$priceDatagrid.datagrid('updateRow', {index : index, row:data.result})
						$priceDatagrid.datagrid('acceptChanges');
					}else{
						$.messager.show("错误", "更新数据错误: "+data.result, "error");
					}
				});
			}
		}
		
	</script>
</body>
</html>