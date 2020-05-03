\<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:400px;width:100%" title="拼团活动发布">
	<table id="group-activity-table" fit="true" >
		<thead>
				<tr>
					<th field="cityName" width="120px">城市</th>
					<th field="activityCode" width="100px" >活动编码</th>
					<th field="activityName" width="200px" editor="{type:'textbox',options:{required:true}}">促销活动名称</th>
					<th field="startTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>
					<th field="approvalStatus" width="120px" lov="TB_O2O_APPROVAL_STATUS" >审批状态</th>
					<th field="status" width="120px" lov="TB_O2O_STATUS" >活动状态</th>
					<th field="type" width="120px" lov="TB_O2O_CAMPAIGN_TYPE" editor="{type:'combobox',options:{valueField:'val',
																					  textField:'name',
																					  data:getLovArray('TB_O2O_CAMPAIGN_TYPE'),
																					  editable:false,
																					  required:true }}">促销形式</th>
					<th field="noCouponUse" width="120px" lov='TB_O2O_COUPON_USE' editor="{type:'combobox',options:{valueField:'val',
																						textField:'name',
																						method:'get',
																						data:getLovArray('TB_O2O_COUPON_USE'),  
																						editable:false,
																						required:true}}">是否可用优惠券</th>																  
					<th field="activityNotes" width="230px" editor="{type:'textarea',options:{required:true}}" >说明</th>																  
				</tr>
		</thead>
	</table>
 </div>
	<div border="false" style="width:100%;height:100%;" title="拼团商品维护">
		<table id="group-table" fit="true" >
			<thead>
				<tr>
					<th field="buyMerchName" width="100px" editor="{type:'picklistbox',options:{title:'选择商品',
															completeFun:merchandisePicklistComplete,
															initParam:initPickMerchandiseParam,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp',
															required:true}}">商品名称</th>
					<th field="merchCode" width="200px" >商品编码</th>
					<th field="promotionPrice" width="200px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">拼团价</th>
					<th field="groupsNumber" width="200px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">规定拼团人数</th>
					<th field="merchStartTime" width="140px" mark="DATE" hidden="true" noSearch="true" editor="{type:'datetimebox'}" >拼团开始时间</th>
					<th field="merchEndTime" width="140px" mark="DATE" hidden="true" noSearch="true" editor="{type:'datetimebox'}" >拼团结束时间</th>
					<th field="totalQty" width="230px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限购总量</th>																  
					<th field="purchasedQty" width="230px">已售数量</th>																  
					<th field="status" width="120px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																					  textField:'name',
																					  data:getLovArray('TB_O2O_STATUS'),
																					  editable:false,
																					  required:true}}">商品状态</th>
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
	   $datagrid = $('#group-activity-table');
	   $dataItemgrid=$('#group-table');
	   var initHeadId = getUrlParams("id");
	   
	   $datagrid.hdatagrid({
			buttonNew:false,
			buttonDelete:true,
			updateable:true,
			toolbarShow:true,
			buttonCopy:false,
			buttonSearch:true,
			buttonExport:true,
			title:"拼团活动发布",
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,20,50],//可以设置每页记录条数的列表 
		    newDefaultValue:true,
			subGridIds: ['group-table'],
			url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
			buttonBatchEdit : false,	
			onBeforeLoad:function(param){
				if(initHeadId != '' && typeof(initHeadId) != 'undefined'){
					param.id = initHeadId;
				}
				param.type = 'FightGroup';
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
					$('.easyui-linkbutton-delete-list-table',$datagrid.datagrid('getPanel')).linkbutton('enable');
				} else{
					$('.easyui-linkbutton-delete-list-table',$datagrid.datagrid('getPanel')).linkbutton('disable');
				}
			},
			readOnlyCondition: function(row, that){//行不可编辑判断，true为只读
				if(row.approvalStatus != 'New' && row.approvalStatus != 'Rejected'){
		    		return true;
		    	}else{
		    		return false;
		    	}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				
				var index = $datagrid.hdatagrid('getRowIndex', row);
				$.post('${AppContext.ctxPath}/action/portal/promotion/updateHead', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						$datagrid.hdatagrid("reload");
						successFun(that, data);
			            $datagrid.datagrid('selectRow',index);
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
						})
					}
				})
		    },
			onInitNewData : function(that){
				return{
					status:'Active',
					noCouponUse:'N',
					type:'FightGroup'
				}
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="submit()">提交</a>',that);
				addButtonFun(100,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="cancel()">撤销</a>',that);
			},
		});
		
		$dataItemgrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			updateable:true,
			buttonDelete:true,
			buttonBatchEdit : false,
			buttonCopy:true,
			buttonSearch:true,
			buttonExport:true,
			nowrap:false,
			newDefaultValue:true,
			title:"拼团商品维护",
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
			parentGridId : 'group-activity-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
			onInitNewData:function(that){
				var headRow = $datagrid.hdatagrid('getCurrentRow');
				return{
					status:'Active',
					merchStartTime:headRow.startTime,
					merchEndTime:headRow.endTime,
					purchasedQty : '0',
					
					costProportionD : '0',
					costMaxProportionD : '9999',
					costMinProportionD : '0',
					costProportionW : '0',
					costMaxProportionW : '9999',
					costMinProportionW : '0',
					costProportionR : '0',
					costMaxProportionR : '9999',
					costMinProportionR : '0'
	 			};
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				var headRow = $datagrid.hdatagrid('getCurrentRow');
				row.startTime=headRow.startTime;
				row.endTime=headRow.endTime;
				row.headId = headRow.id;
				row.cityId = headRow.cityId;
				row.attr1 = 'groupActivity';
				$.post('${AppContext.ctxPath}/action/portal/promotionGoods/upsert', row, function(data) {
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
		});
		
		/**
		 * 组合 商品名称 picklist 确定
		 */
		function merchandisePicklistComplete(selectRow){
			$dataItemgrid.hdatagrid('getCurrentRow').buyMerchId = selectRow.id;
			$dataItemgrid.hdatagrid('getCurrentRow').totalPrice = selectRow.totalPrice;
			return selectRow.o2oDisplayName;
		}
		
		function initPickMerchandiseParam() {
			/* var suitProductFlg = 'N';
			return {suitProductFlg:suitProductFlg}; */
			var row = $datagrid.hdatagrid('getCurrentRow');
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
			var row = $datagrid.hdatagrid('getCurrentRow');
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
					   $datagrid.hdatagrid('reload');
					   window.parent.operationtip(data.result,'error');
					}else{
						$datagrid.hdatagrid('reload');
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
			var row = $datagrid.hdatagrid('getCurrentRow');
			if(row.approvalStatus == 'Pending'){
				row.approvalStatus='New';
				$.post('${AppContext.ctxPath}/action/portal/promotion/cancel', row, function(data) {
					   if (!data.success) {
						    window.parent.operationtip(data.result,'error');
						}else{
							$datagrid.hdatagrid('reload');
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