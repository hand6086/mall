<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp"%>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
		<div border="false" style="width: 100%; height: 100%;">
			<table id="activity-table" fit="true">
				<thead>
					<tr>
						<th field="cityName" width="120px">城市</th>
						<th field="activityName" width="120px"
							editor="{type:'textbox',options:{required:true}}">活动名称</th>
						<th field="activityCode" width="80px">活动编码</th>
						<th field="minOrdAmount" width="100px"
							editor="{type:'textbox',options:{required:true}}">订单满金额（元）</th>
						<th field="pmoType" width="100px" lov='TB_O2O_STORE_PMO_TYPE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_STORE_PMO_TYPE'),
											onSelect : function() {
												var editIndex = $dataItemgrid.hdatagrid('getCurrentRowIndex');
												var currentEditRow = $dataItemgrid.datagrid('selectRow', editIndex);
												if('Cash Deduction'==$(this).combobox('getValue')){
													$dataItemgrid.hdatagrid('getEditor', {
														index : editIndex,
														field : 'onCouponName'
													}).target.textbox('setValue', '').textbox('disable');
													
													$dataItemgrid.hdatagrid('getEditor', {
														index : editIndex,
														field : 'deducedCash'
													}).target.textbox('setValue', '0').textbox('enable');
												}
												
												if('Dispatch Coupon'==$(this).combobox('getValue')){
													$dataItemgrid.hdatagrid('getEditor', {
														index : editIndex,
														field : 'deducedCash'
													}).target.textbox('setValue', '').textbox('disable');
													
													$dataItemgrid.hdatagrid('getEditor', {
														index : editIndex,
														field : 'onCouponName'
													}).target.textbox('enable');
												}
												
											},
											editable:false,
											required:true}}">优惠方式</th>
						<th field="deducedCash" width="100px"
							editor="{type:'textbox',options:{required:false}}">优惠金额</th>
						<th field="onCouponName" width="150px"
							editor="{type:'picklistbox',options:{required:false,title:'选择优惠券',initParam:initPickCouponParam,
					completeFun:completePickCoupon,
					tableUrl:'${AppContext.ctxPath}/portal/picklist/couponPicklist.jsp'}}">优惠券名称</th>
						<%-- <th field="merchName" width="100px" 
					 editor="{type:'picklistbox',options:{required:false,title:'选择商品',initParam:initPickGoodsParam,
					      completeFun:completePickGoods,
					tableUrl:'${AppContext.ctxPath}/portal/picklist/GoodsPicklist.jsp'}}">满赠商品</th> --%>
						<th field="merchId" hidden='true'></th>
						<th field="startTime" width="140px"
							editor="{type:'datetimebox',options:{required:true}}">有效开始时间</th>
						<th field="endTime" width="140px"
							editor="{type:'datetimebox',options:{required:true}}">有效结束时间</th>
						<th field="status" width="100px" lov='TB_O2O_STATUS'>状态</th>
						<th field="approvalStatus" width="120px" lov="TB_O2O_APPROVAL_STATUS" >审批状态</th>
						<th field="type" width="100px" lov='TB_O2O_CAMPAIGN_TYPE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_CAMPAIGN_TYPE'),  
											editable:false,
											required:false,
											disabled:true}}">类型</th>
						<th field="doubleFlag" width="80px"
							editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否倍增</th>
						<th field="noCouponUse" width="80px" lov='TB_O2O_COUPON_USE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_COUPON_USE'),
											editable:false,
											required:true}}">是否可用优惠券</th>
						<th field="costProportionD" width="140px" editor="{type:'textbox'}">经销商承担费用比例</th>
						<th field="costMaxProportionD" width="140px" editor="{type:'textbox'}">经销商承担费用上限</th>
						<th field="costMinProportionD" width="140px" editor="{type:'textbox'}">经销商承担费用下限</th>
						<th field="costProportionW" width="140px" editor="{type:'textbox'}">二批商承担费用比例</th>
						<th field="costMaxProportionW" width="140px" editor="{type:'textbox'}">二批商承担费用上限</th>
						<th field="costMinProportionW" width="140px" editor="{type:'textbox'}">二批商承担费用下限</th>
						<th field="costProportionR" width="140px" editor="{type:'textbox'}">终端承担费用比例</th>
						<th field="costMaxProportionR" width="140px" editor="{type:'textbox'}">终端承担费用上限</th>
						<th field="costMinProportionR" width="140px" editor="{type:'textbox'}">终端承担费用下限</th>

					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	   $dataItemgrid=$('#activity-table');
	   var initHeadId = getUrlParams("id");
		$dataItemgrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			updateable:true,
			buttonBatchEdit : false,
			buttonSearch:true,
			oauthFlag:true,
			pageSize: 25,//每页显示的记录条数，默认为20 
		    pageList: [10,25,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/platformfavorable/queryActivityPage',
			onBeforeLoad:function(param){
				if(initHeadId != '' && typeof(initHeadId) != 'undefined'){
					param.id = initHeadId;
				}
			},
			onSelect:function(index, row){
				if(row.status == 'Inactive' && (row.approvalStatus == 'New' || row.approvalStatus == 'Rejected' )){
					$('#btn_submit').linkbutton('enable');
				} else{
					$('#btn_submit').linkbutton('disable');
				}
				
				if(row.approvalStatus == 'Pending'){
					$('#btn_cancel').linkbutton('enable');
				} else{
					$('#btn_cancel').linkbutton('disable');
				}
			},
		    onInsertAction : function(row, successFun, errFun, that) {
		       $.post('${AppContext.ctxPath}/action/portal/platformfavorable/couponInsert',
						row, function(data) {
							if (!data.success) {
								errFun(data.result, that);
							} else {
								successFun(that, data);
							}
						}
		       )
			},
			onUpdateAction : function(row, successFun, errFun, that) {
				$.post('${AppContext.ctxPath}/action/portal/platformfavorable/couponUpdate',
								row, function(data) {
									if (!data.success) {
										errFun(data.result, that);
									} else {
										successFun(that, data);
									}
								}
				)
			},
			readOnlyCondition: function(row, that){//行不可编辑判断，true为只读
				if(row.approvalStatus != 'New' && row.approvalStatus != 'Rejected'){
		    		return true;
		    	}else{
		    		return false;
		    	}
			},
			onDblClickRow: function(index, row){//行不可编辑判断，true为只读
				if('Cash Deduction'== row.pmoType){// 减现金:Cash Deduction
					$dataItemgrid.hdatagrid('getEditor', {
						index : index,
						field : 'onCouponName'
					}).target.textbox('disable');
					
					row.couponId = '';
					row.onCouponName = '';
					
					$dataItemgrid.hdatagrid('getEditor', {
						index : index,
						field : 'deducedCash'
					}).target.textbox('enable');
				}
				
				if('Dispatch Coupon'== row.pmoType){// Dispatch Coupon:赠优惠券
					$dataItemgrid.hdatagrid('getEditor', {
						index : index,
						field : 'deducedCash'
					}).target.textbox('disable');
				
					row.deducedCash = '';
					
					$dataItemgrid.hdatagrid('getEditor', {
						index : index,
						field : 'onCouponName'
					}).target.textbox('enable');
				}
				return false;
			},
			onInitNewData:function(that){
				return{
				status : 'Active',
				type : 'Platform Promotion',
				costProportionD : '0',
				noCouponUse : 'Y',
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
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="submit()">提交</a>',that);
				addButtonFun(100,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="cancel()">撤销</a>',that);
			},
		});
		
		function submit(){
			var row = $dataItemgrid.hdatagrid('getCurrentRow');
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
					   window.parent.operationtip(data.result,'error');
					}else{
						$dataItemgrid.hdatagrid('reload');
						window.parent.operationtip('促销活动已提交，请等待审批！', 'info');
						successFun(that, data);
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
			var row = $dataItemgrid.hdatagrid('getCurrentRow');
			if(row.approvalStatus == 'Pending'){
				row.approvalStatus='New';
				$.post('${AppContext.ctxPath}/action/portal/promotion/cancel', row, function(data) {
					   if (!data.success) {
						    window.parent.operationtip(data.result,'error');
						}else{
							$dataItemgrid.hdatagrid('reload');
							window.parent.operationtip('已撤回！', 'info');
							successFun(that, data);
						}
					});
			}else{
				window.parent.operationtip("对不起，撤回功能只能对已提交的活动生效",'info');
			}
		}
	
		function completePickCoupon(selectRow){
			$dataItemgrid.hdatagrid('getCurrentRow').couponId = selectRow.id;
			
			return selectRow.onCouponName;
		}
		function completePickGoods(selectRow){
			$dataItemgrid.hdatagrid('getCurrentRow').merchId = selectRow.merchId;
			return selectRow.merchName;
		}
	
		
		function initPickGoodsParam(){
		
		}
		function initPickCouponParam(){
		
		} 
	</script>
</body>
</html>