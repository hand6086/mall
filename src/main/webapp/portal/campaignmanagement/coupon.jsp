<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<!--给body指定class属性指定easy的easyui-layout样式，这样就可以 使用body创建easyui的layout -->
 <body>
<div class="easyui-layout" data-options="fit:true" >  
      <div data-options="region:'north'" style="height:100%">
             <div data-options="region:'north',split:true" style="height:360px;">
             <div  border="false" style="width:100%;height:100%;">
		<table id="activity-table" split="true"fit="true" >
			<thead>
				<tr>
					<th field="cityName" width="120px" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
					<th field="couponName" width="140px"editor="{type:'textbox',options:{required:true}}">优惠券名称</th>
					<th field="couponCode" width="120px" >编码</th>
					<th field="faceValue" width="100px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}" >面额</th>
					<th field="startTime" width="140px" editor="{type:'datetimebox',options:{required:true}}" >有效开始日期</th>
					<th field="endTime" width="140px" editor="{type:'datetimebox',options:{required:true}}" >有效结束日期</th>
					<th field="restriction" width="100px" lov='TB_O2O_COUPON_USE_CONSTRAIN' editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											onSelect : function() {
												var editIndex = $dataItemgrid.hdatagrid('getCurrentRowIndex');
												if('No Constrain'==$(this).combobox('getValue')){
													$dataItemgrid.hdatagrid('getEditor', {
														index : editIndex,
														field : 'minOrdPrice'
													}).target.textbox('setValue', '0').textbox('disable');
												}else{
													$dataItemgrid.hdatagrid('getEditor', {
														index : editIndex,
														field : 'minOrdPrice'
													}).target.textbox('enable');
												}
											},
											data:getLovArray('TB_O2O_COUPON_USE_CONSTRAIN'),
											editable:true,
											required:true}}" >使用金额限制</th>
					<th field="minOrdPrice" width="100px"  editor="{type:'textbox',options:{required:true}}">订单满金额（元）</th>
					<th field="limitreceived" width="100px" editor="{type:'textbox',options:{required:false}}" >已领取金额限制</th>
					<th field="limitStarted" width="140px" editor="{type:'datetimebox',options:{required:false}}" >限制开始时间</th>
					<th field="limitFinish" width="140px" editor="{type:'datetimebox',options:{required:false}}" >限制结束时间</th>
					<th field="releaseAmt" width="100px"  editor="{type:'textbox',options:{required:true}}">发放数量</th>
					<th field="amtPerConsumer" width="100px" editor="{type:'textbox',options:{required:true}}" >每人限领张数</th>
					<th field="drawType" width="100px" lov='TB_O2O_COUPON_DRAW_TYPE'   editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_COUPON_DRAW_TYPE'),
											editable:true,
											required:true}}">领取方式</th>
					<th field="couponStatus" width="100px" lov='TB_O2O_STATUS' editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_STATUS'),
											editable:true,
											required:true}}"  >状态</th>
					<th field="type" width="100px"  lov='TB_O2O_CAMPAIGN_TYPE' editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_CAMPAIGN_TYPE'),
											editable:false,
											required:false,
											disabled:true
											}}" >类型</th>
					<th field="couponType" width="100px"  lov='CAMPAIGN_TYPE' editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('CAMPAIGN_TYPE'),
											editable:false,
											}}" >优惠券类型</th>
					<th field="goodsAvailable" width="100px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" >指定商品可用</th>
					<th field="receivedQuantity" width="100px" editor="{type:'textbox',options:{required:false}}" >已领取数量</th>
					<th field="costProportionD" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}">经销商承担费用比例</th>
					<th field="costMaxProportionD" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}">经销商承担费用上限</th>
					<th field="costMinProportionD" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}" >经销商承担费用下限</th>
					<th field="costProportionW" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}">二批商承担费用比例</th>
					<th field="costMaxProportionW" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}">二批商承担费用上限</th>
					<th field="costMinProportionW" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}" >二批商承担费用下限</th>
					<th field="costProportionR" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}">终端承担费用比例</th>
					<th field="costMaxProportionR" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}">终端承担费用上限</th>
					<th field="costMinProportionR" width="140px" noSearch="true" editor="{type:'textbox',options:{required:true}}" >终端承担费用下限</th>
				</tr>
			</thead>
		</table>
	</div>
	 </div> 
     <div id="coupon-tabs" class="easyui-tabs" style="width: 100%;height:80%;" data-options="border:false">
		<div title="选择商品" href="${AppContext.ctxPath}/portal/campaignmanagement/goodsTabList.jsp"></div>
		<div title="选择消费者" href="${AppContext.ctxPath}/portal/campaignmanagement/customerTabList.jsp" ></div>
	</div>
</div>
</div>
	<script type="text/javascript">
		var flag = '';
	    $dataItemgrid=$('#activity-table');
	    
		var initHeadId = getUrlParams("id");
		$dataItemgrid.hdatagrid({
			updateable:true,
			pagination:true,
			buttonNew:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonBatchEdit : false,
			subGridIds: ['activity-table-goods','activity-table-coupon'],
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    url:'${AppContext.ctxPath}/action/portal/coupon/querycouponinformation',
		    onBeforeLoad:function(param){
				if(initHeadId != '' && typeof(initHeadId) != 'undefined'){
					param.id = initHeadId;
				}
			},
			onInsertAction : function(row, successFun, errFun, that) {
			       $.post('${AppContext.ctxPath}/action/portal/coupon/couponinformationInsert',
							row, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
								}
							});
			},
			/**
			 * 选择数据后，触发事件
			 */
/* 			onSelect:function(index, row){
				var headRow = $dataItemgrid.hdatagrid('getSelected');
				if (headRow.goodsAvailable != 'Y') {
					$('.easyui-linkbutton-delete-list-table',$('#activity-table-goods').datagrid('getPanel')).linkbutton('disable');
					$('.easyui-linkbutton-add-list-table',$('#activity-table-goods').datagrid('getPanel')).linkbutton('disable');
				} else{
					$('.easyui-linkbutton-delete-list-table',$('#activity-table-goods').datagrid('getPanel')).linkbutton('enable');
					$('.easyui-linkbutton-add-list-table',$('#activity-table-goods').datagrid('getPanel')).linkbutton('enable');
				}
				$('#activity-table-goods').datagrid('reload');
			}, */
			onUpdateAction : function(row, successFun, errFun, that) {
				
			$.post('${AppContext.ctxPath}/action/portal/coupon/couponUpdate',
							row, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
									//重新选择已选中行,使更新完成后可以触发onSelect事件
									index = $dataItemgrid.datagrid("getRowIndex", row);
									$dataItemgrid.datagrid('selectRow',index);  
								}
							});
			},
			onDblClickRow: function(index, row){//行不可编辑判断，true为只读
				
				if('No Constrain' == row.restriction){
					$dataItemgrid.hdatagrid('getEditor', {
						index : index,
						field : 'minOrdPrice'
					}).target.textbox('setValue', '0').textbox('disable');
				}else{
					$dataItemgrid.hdatagrid('getEditor', {
						index : index,
						field : 'minOrdPrice'
					}).target.textbox('enable');
				}
				$dataItemgrid.hdatagrid('getEditor', {
					index : index,
					field : 'cityName'
				}).target.textbox('disable');
				return false;
			},
			onInitNewData:function(that){
				return{
					couponStatus : 'Active',
					type : 'Coupon',
					receivedQuantity:'0',
					costProportionD :'0',
					costMaxProportionD :'9999',
				    costMinProportionD:'0',
					costProportionW:'0',
					costMaxProportionW:'9999',
					costMinProportionW:'0',
					costProportionR:'0',
					costMaxProportionR:'9999',
					costMinProportionR:'0', };
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_check" class="easyui-linkbutton" iconCls="icon-sum" plain="true" onclick="count()">计算</a>',that);
			},
		});
		
		function cityPicklistComplete(selectRow){
			$dataItemgrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		function initPickGoodsParam(){
			/* var accntIdValue = $datagrid.hdatagrid('getCurrentRow').accntId;
			if(accntIdValue == null || accntIdValue == ''){
				return {attr1:'noMatchId'};
			}else{
				return {attr1:accntIdValue};
			} */
		}
		
		function initPickCustomerParam(){
			/* var accntIdValue = $datagrid.hdatagrid('getCurrentRow').accntId;
			if(accntIdValue == null || accntIdValue == ''){
				return {attr1:'noMatchId'};
			}else{
				return {attr1:accntIdValue};
			} */
		}
		
		function completeCustomerPick(selectRow){
			$datagrid.hdatagrid('getCurrentRow').customerName = selectRow.customerName;
			return selectRow.customerName;
		}
		
		function count(){
			var row = $dataItemgrid.hdatagrid('getSelected');
			$.messager.confirm("操作提示", '是否确定计算已领取数量？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/coupon/count', {id:row.id},
						function(data){
					    	if(data.success){
					    		var index = $dataItemgrid.datagrid('getRowIndex', row);
					    		$dataItemgrid.datagrid('updateRow', {index : index, row:data.result})
								$dataItemgrid.datagrid('acceptChanges');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
	</script>
</body>
</html>