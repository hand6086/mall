<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp"%>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
		<div border="false" style="width: 100%; height: 360px;">
			<table id="Seckill-table" fit="true">
				<thead>
					<tr>
						<th field="cityName" width="120px">城市</th>
						<th field="activityName" width="140px"
							editor="{type:'textbox',options:{required:true}}">秒杀名称</th>
						<th field="activityCode" width="100px">秒杀编码</th>
						<th field="startTime" width="140px"
							editor="{type:'datetimebox',options:{required:true}}">开始时间</th>
						<th field="endTime" width="140px"
							editor="{type:'datetimebox',options:{required:true}}">结束时间</th>
						<th field="approvalStatus" width="120px" lov="TB_O2O_APPROVAL_STATUS" >审批状态</th>
						<th field="status" width="100px" lov='TB_O2O_STATUS'>状态</th>
						<th field="type" width="100px" lov='TB_O2O_CAMPAIGN_TYPE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_CAMPAIGN_TYPE'),
											editable:true,
											disabled:true,
											required:true}}">类型</th>
						<th field="activityNotes" width="140px"
							editor="{type:'textbox',options:{required:false}}">说明</th>
					</tr>
				</thead>
			</table>
		</div>
		<div border="false" style="width: 100%; height: 370px;">
			<table id="Seckill-table-goods" fit="true">
				<thead>
					<tr>
						<th field="buyMerchName" width="140px"
							editor="{type:'picklistbox',options:{required:true,title:'选择商品',initParam:initPickGoodsParam,
					      completeFun:merchandisePicklistComplete,
					tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp'}}">商品名称</th>
						<th field="merchCode" width="140px">商品编码</th>
						<th field="promotionPrice" width="120px"
							editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">秒杀价</th>
						<th field="successRate" width="100px"
							editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">秒杀成功率%</th>
						<th field="payMode" width="100px" lov='TB_O2O_PAY_MODE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_PAY_MODE'),
											editable:true}}">支付方式</th>
						<th field="lmtAmt" width="100px"
							editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">每人限购数量</th>
						<th field="totalQty" width="100px"
							editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限购总量</th>
						<th field="purchasedQty" width="100px" editor="{options:{min:0,precision:0,required:true}}">已售数量</th>
						<th field="status" width="100px" lov='TB_O2O_STATUS'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_STATUS'),
											editable:true,
											required:true}}">状态</th>
						<th field="merchStartTime" width="140px" hidden="true" noSearch="true"
							editor="{type:'datetimebox'}">开始时间</th>
						<th field="merchEndTime" width="140px" hidden="true" noSearch="true"
							editor="{type:'datetimebox'}">结束时间</th>
						<th field="costProportionD" width="140px"
							editor="{type:'textbox',options:{required:true}}">经销商承担费用比例</th>
						<th field="costMaxProportionD" width="140px"
							editor="{type:'textbox',options:{required:true}}">经销商承担费用上限</th>
						<th field="costMinProportionD" width="140px"
							editor="{type:'textbox',options:{required:true}}">经销商承担费用下限</th>
						<th field="costProportionW" width="140px"
							editor="{type:'textbox',options:{required:true}}">二批商承担费用比例</th>
						<th field="costMaxProportionW" width="140px"
							editor="{type:'textbox',options:{required:true}}">二批商承担费用上限</th>
						<th field="costMinProportionW" width="140px"
							editor="{type:'textbox',options:{required:true}}">二批商承担费用下限</th>
						<th field="costProportionR" width="140px"
							editor="{type:'textbox',options:{required:true}}">终端承担费用比例</th>
						<th field="costMaxProportionR" width="140px"
							editor="{type:'textbox',options:{required:true}}">终端承担费用上限</th>
						<th field="costMinProportionR" width="140px"
							editor="{type:'textbox',options:{required:true}}">终端承担费用下限</th>

					</tr>
				</thead>
			</table>
		</div>
		<div border="false" style="height: 370px; width: 100%">

			<table id="Seckill-table-Consumer" fit="true">
				<thead>
					<tr>
						<th field="customerCode" width="200px"
							editor="{type:'textbox',options:{required:true}}">消费者编码</th>
						<th field="customerName" width="200px"
							editor="{type:'textbox',options:{required:true}}">消费者名称</th>
						<th field="customerPhone" width="200px"
							editor="{type:'textbox',options:{required:true}}">消费者电话</th>
						<th field="created" width="200px"
							editor="{type:'textbox',options:{required:true}}">参与时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		$dataseckill = $('#Seckill-table');
		$dataseckillgoods = $('#Seckill-table-goods');
		$dataseckillconsumer = $('#Seckill-table-Consumer');
		var initHeadId = getUrlParams("id");
		$dataseckill
				.hdatagrid({
					pagination : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonDelete : true,
					buttonNew : false,
					updateable : true,
					buttonBatchEdit : false,
					pageSize : 10,//每页显示的记录条数，默认为20 
					pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
					url : '${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
					subGridIds : [ 'Seckill-table-goods' ],
					onBeforeLoad:function(param){
						if(initHeadId != '' && typeof(initHeadId) != 'undefined'){
							param.id = initHeadId;
						}
			    		param.type = "Second Kill";
					},
					onSelect:function(index, row){
						if(row.status == 'Inactive' && (row.approvalStatus == 'New' || row.approvalStatus == 'Rejected' )){
							$('#btn_submit').attr("hidden", false);
						} else{
							$('#btn_submit').attr("hidden", true);
						}
						if(row.approvalStatus == 'Pending'){
							$('#btn_cancel').attr("hidden", false);
						} else{
							$('#btn_cancel').attr("hidden", true);
						}
						if(row.approvalStatus == 'New'){
							$('.easyui-linkbutton-delete-list-table',$dataseckill.datagrid('getPanel')).linkbutton('enable');
						} else{
							$('.easyui-linkbutton-delete-list-table',$dataseckill.datagrid('getPanel')).linkbutton('disable');
						}
					},
					onInitNewData : function(that) {
						return {
							status : 'Active',
							type : 'Second Kill',
						};
					},

					readOnlyCondition: function(row, that){//行不可编辑判断，true为只读
						if(row.approvalStatus != 'New' && row.approvalStatus != 'Rejected'){
				    		return true;
				    	}else{
				    		return false;
				    	}
					},
					
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
						var startTime= $dataseckill.hdatagrid('getCurrentRow').startTime;
						var  endTime= $dataseckill.hdatagrid('getCurrentRow').endTime;
						$.post("${AppContext.ctxPath}/action/portal/promotion/upsert",row, 
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
								row.deleteFlg = 'Y';
								row.status = 'Inactive';
								row.attr1 = 'salesPromotionSchemaApproval';
								$.post('${AppContext.ctxPath}/action/portal/promotion/update', row, function(data) {
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
						addButtonFun(99,'<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="submit()">提交</a>',that);
						addButtonFun(100,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="cancel()">撤销</a>',that);
					},

				});
		$dataseckillgoods
				.hdatagrid({
					pagination : true,
					toolbarShow : true,
					buttonDelete :true,
					buttonSearch : true,
					buttonNew : true,
					buttonCopy:true,
					nowrap:false,
					updateable : true,
					buttonBatchEdit : false,
					pageSize : 10,//每页显示的记录条数，默认为20 
					pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
					url : '${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
					subGridIds : [ 'Seckill-table-Consumer' ],
					parentGridId : 'Seckill-table',
					parentGridField : 'id',
					linkGridField : 'headId',
					onInitNewData : function(that) {
						var headRow = $dataseckill.hdatagrid('getCurrentRow');
						return {
							purchasedQty : 0,

							purchasedQty : '0',
							status : 'Active',
							costProportionD : '0',
							noCouponUse : 'Y',
							costProportionD : '0',
							costMaxProportionD : '9999',
							costMinProportionD : '0',
							costProportionW : '0',
							costMaxProportionW : '9999',
							costMinProportionW : '0',
							costProportionR : '0',
							costMaxProportionR : '9999',
							costMinProportionR : '0',
							merchStartTime:headRow.startTime,
							merchEndTime:headRow.endTime,
							payMode : 'Only Payonline',
							successRate : '100',
							lmtAmt : 1,
						};
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
								});
							}
						});
					},
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
						row.endTime=$dataseckill.hdatagrid('getCurrentRow').endTime;
						 row.startTime=$dataseckill.hdatagrid('getCurrentRow').startTime;
						 row.cityId=$dataseckill.hdatagrid('getCurrentRow').cityId;
						row.headId = $dataseckill.hdatagrid('getCurrentRow').id;
						$.post("${AppContext.ctxPath}/action/portal/promotionGoods/upsert",row, 
						function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					},

				});
		$dataseckillconsumer
				.hdatagrid({
					pagination : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonBatchEdit : true,
					oauthFlag:false,
					pageSize : 10,//每页显示的记录条数，默认为20 
					pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
					url : '${AppContext.ctxPath}/action/portal/promotionGoods/querySeckillManPage',
					parentGridId : 'Seckill-table-goods',
					parentGridField : 'id',
					linkGridField : 'campaignLineId',
				});

		function completePickCoupon(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').onCouponName = selectRow.onCouponName;
			return selectRow.onCouponName;
		}
		function merchandisePicklistComplete(selectRow){
			$dataseckillgoods.hdatagrid('getCurrentRow').buyMerchId = selectRow.id;
			$dataseckillgoods.hdatagrid('getCurrentRow').totalPrice = selectRow.totalPrice;
			return selectRow.o2oDisplayName;
		}
		//初始化城市
		function initPickCityParam() {
			/* var accntIdValue = $datagrid.hdatagrid('getCurrentRow').accntId;
			if(accntIdValue == null || accntIdValue == ''){
				return {attr1:'noMatchId'};
			}else{
				return {attr1:accntIdValue};
			} */
		}

		function initPickGoodsParam() {
			/* var suitProductFlg = 'N';
			return {suitProductFlg:suitProductFlg}; */
			var row = $dataseckill.hdatagrid('getCurrentRow');
			var attr1 = 'promotion';
			var districtId = row.cityId;
			var startTime = row.startTime;
			var endTime = row.endTime;
			return {attr1:attr1,
					districtId:districtId,
					startTime:startTime,
					endTime:endTime
				};
		}
		
		function submit(){
			var row = $dataseckill.hdatagrid('getCurrentRow');
			if(row.status == 'Inactive' && (row.approvalStatus == 'New' || row.approvalStatus == 'Rejected' )){
				if(row.approvalFlg == 'Y'){
					row.status = 'Active';
					row.approvalStatus = 'Approved';
				} else {
					row.approvalStatus='Pending';
				}
				row.merchStartTime=row.startTime;
				row.merchEndTime=row.startTime;
				$.post('${AppContext.ctxPath}/action/portal/promotion/submit', row, function(data) {
				   if (!data.success) {
					   $dataseckill.hdatagrid('reload');
					   window.parent.operationtip(data.result,'error');
					}else{
						$dataseckill.hdatagrid('reload');
						window.parent.operationtip('促销活动已提交，请等待审批！', 'info');
					}
				});
			}else{
				window.parent.operationtip("不可重复提交",'info');
			}
		}
		
		/**
		* 撤销按钮
		*/
		function cancel(){
			var row = $dataseckill.hdatagrid('getCurrentRow');
			if(row.approvalStatus == 'Pending'){
				row.approvalStatus='New';
				$.post('${AppContext.ctxPath}/action/portal/promotion/cancel', row, function(data) {
					   if (!data.success) {
						    window.parent.operationtip(data.result,'error');
						}else{
							$dataseckill.hdatagrid('reload');
							window.parent.operationtip('已撤回！', 'info');
						}
					});
			}else{
				window.parent.operationtip("对不起，撤回功能只能对已提交的活动生效",'info');
			}
		}
	</script>
</body>
</html>