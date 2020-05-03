<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:50%;width:100%" title="促销方案发布">
  
	<table id="schema-table" fit="true" >
		<thead>
			<tr>
				<th field="id" width="140px" hidden="">促销方案编码</th>
				<th field="schemaName" width="280px" editor="{type:'textbox',options:{required:true}}" >促销方案名称</th>
				<th field="startDate" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >开始时间</th>
				<th field="endDate" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >结束时间</th>
				<th field="city" width="100px" editor="{
							type:'mvgPickbox',
							options:{
								title:'所有O2O大区',completeFun:salesCityMvgPickComplete,
								mvgMapperName:'salesCity',
								tableId:'schema-table',
								optionsLeft:{
									tableUrl:'${AppContext.ctxPath}/portal/campaignmanagement/mvgPick/salesPromotionLeftMvgPick.jsp',
									initParam:salesCityMvgPickParam
								},
								optionsRight:{
									tableUrl:'${AppContext.ctxPath}/portal/campaignmanagement/mvgPick/salesPromotionRightMvgPick.jsp'
								},
								required:true
							}
						}">大区</th>							
				<%-- <th field="defaultProduct" width="230px" editor="{
							type:'mvgPickbox',
							options:{
								title:'所有商品',completeFun:salesGoodsMvgPickComplete,
								mvgMapperName:'salesGoods',
								tableId:'schema-table',
								optionsLeft:{
									tableUrl:'${AppContext.ctxPath}/portal/campaignmanagement/mvgPick/salesGoodsLeftMvgPick.jsp',
									initParam:salesGoodsMvgPickParam
								},
								optionsRight:{
									tableUrl:'${AppContext.ctxPath}/portal/campaignmanagement/mvgPick/salesGoodsRightMvgPick.jsp'
								}
							}
						}">默认商品</th> --%>
				<th field="status" width="100px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																										textField:'name',
																										data:getLovArray('TB_O2O_STATUS'),
																										editable:false,
																										required:true}}">是否有效</th>
				<th field="type" width="130px" lov="TB_O2O_CAMPAIGN_TYPE" editor="{
							type:'mvgPickbox',
							options:{
								required:true,
								title:'所有促销形式',completeFun:salesTypeMvgPickComplete,
								mvgMapperName:'salesType',
								tableId:'schema-table',
								optionsLeft:{
									tableUrl:'${AppContext.ctxPath}/portal/campaignmanagement/mvgPick/salesTypeLeftMvgPick.jsp',
									initParam:salesTypeMvgPickParam
								},
								optionsRight:{
									tableUrl:'${AppContext.ctxPath}/portal/campaignmanagement/mvgPick/salesTypeRightMvgPick.jsp'
								},
								deleteOptions:false,
								deleteAllOptions:false
							}
						}">促销形式</th>
				<th field="approvalFlg" width="120px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">活动自动审批</th>
				<th field="createdName" width="120px">创建人</th>
				<th field="created" width="120px">创建时间</th>
				<th field="comments" width="300px" editor="{type:'textarea',options:{required:true}}" >方案说明</th>
			</tr>
		</thead>
	</table>
 </div>
	<div border="false" style="width:100%;height:50%;" title="促销活动报名">
		<table id="activity-table" fit="true" >
			<thead>
				<tr>
					<th field="ck" checkbox="true"></th>
					<th field="cityName" width="140px" >大区</th>
					<th field="activityCode" width="100px" >促销活动编码</th>
					<th field="activityName" formatter="activityNameFormatter" width="200px" >促销活动名称</th>
					<th field="startTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>
				<!--<th field="status" width="120px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																					  textField:'name',
																					  data:getLovArray('TB_O2O_STATUS'),
																					  editable:false }}">活动状态</th>
				-->
					<th field="type" width="120px" lov="TB_O2O_CAMPAIGN_TYPE" >促销形式</th>
					<th field="approvalStatus" width="120px" lov="TB_O2O_APPROVAL_STATUS" >审批状态</th>
					<th field="createdName" width="120px">创建人</th>
					<th field="created" width="120px">创建时间</th>
					<th field="approvalSuggest" width="240px" >审批意见</th>
					<th field="activityNotes" width="230px" >说明</th>
				</tr>
			</thead>
		</table>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog" title="请填写审批意见" data-options="closed:true,buttons:'#dlg-buttons'" style="width:450px;height:300px">
		<form id="activityForm" method="post" style="width:100%;height:100%">
			<table style="width:100%;height:100%">
				<tr style="width:100%;height:100%">
					<td style="width:100%;height:100%">
						<textarea style="width:99%;height:98%" placeholder='请在此输入审批意见' class="easyui-validatebox"
						 name="approvalSuggest" type="text" id="approvalSuggestId" required="true"></textarea>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	<script type="text/javascript">
	   $dlg = $('#dlg');
	   $activityForm = $('#activityForm');
	   $datagrid = $('#schema-table');
	   $dataItemgrid=$('#activity-table');
	   $datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			title:"促销方案发布",
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,30,50],//可以设置每页记录条数的列表 
		    newDefaultValue:true,
		    striped:true,
			subGridIds: ['activity-table'],
			url:'${AppContext.ctxPath}/action/portal/salesPromotionSchema/queryByExamplePage',
			buttonBatchEdit : false,		
			onBeforeLoad:function(param){
				param.isApproved = 'Approved'
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/salesPromotionSchema/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						$datagrid.hdatagrid("load");
						successFun(that, data);
					}
				});
			},
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/salesPromotionSchema/deleteById', row, function(data) {
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
					status:'Active'
				}
			},
		});
	   var enable = false;
	   if(appCtx.systemRole =='super_administrator'){
		   enable = true;
	   }
		$dataItemgrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonBatchEdit:false,
			updateable:enable,
			buttonSearch:true,
			buttonExport:true,
			newDefaultValue:true,
			selectFirstRow:false,
			singleSelect:false,
			striped:true,
			title:"促销活动报名",
			pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
			parentGridId : 'schema-table',
		    parentGridField : 'id',
		    linkGridField : 'schemaId',
			onBeforeLoad:function(param){
				param.isApproved = 'Approved'
			},
			readOnlyCondition: function(row, that){
				//先清除所有选择行,在选择当前编辑行
				$dataItemgrid.hdatagrid('clearSelections');
				var index = $dataItemgrid.hdatagrid('getRowIndex', row);
				$dataItemgrid.datagrid('selectRow',index)
				return false;
			},
			onUnselect: function(index, row){
				var selectRows = $dataItemgrid.datagrid('getSelections');
				var ifenable = 'enable';
				for(var i=0; i<selectRows.length; i++){
					if(selectRows[i].approvalStatus == 'Approved' || selectRows[i].approvalStatus == 'Rejected'){
						ifenable = 'disable';
					}
				}
				$('#btn_ok').linkbutton(ifenable);
				$('#btn_cancel').linkbutton(ifenable);
			},
			onSelect:function(index, row){
				var selectRows = $dataItemgrid.datagrid('getSelections');
				var ifenable = 'enable';
				for(var i=0; i<selectRows.length; i++){
					if(selectRows[i].approvalStatus == 'Approved' || selectRows[i].approvalStatus == 'Rejected'){
						ifenable = 'disable';
					}
				}
				$('#btn_ok').linkbutton(ifenable);
				$('#btn_cancel').linkbutton(ifenable);
				
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				var headRow = $datagrid.hdatagrid('getCurrentRow');
				row.schemaId = headRow.id;
				row.merchStartTime=headRow.startDate;
				row.merchEndTime=headRow.endDate;
				$.post('${AppContext.ctxPath}/action/portal/promotion/upsert', row, function(data) {
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
						var headRow = $datagrid.hdatagrid('getCurrentRow');
						row.merchStartTime=headRow.startDate;
						row.merchEndTime=headRow.endDate;
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
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true" disabled onclick="approved(' + '\'Approved\'' + ')">审批通过</a>',that);
				addButtonFun(100,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" disabled onclick="approved(' + '\'Rejected\'' + ')">审批拒绝</a>',that);
			}
		});
	
		/**
		 * 大区mvgPick 按【确定】后执行的方法
		 */
		function salesCityMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null ){
				currentRow.city = rightRowsMvg.cityName;
			}
			return currentRow.city;
		}
		/**
		 * 大区mvgPick 列表数据初始化参数
		 */
		function salesCityMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};

		}
		
		/**
		 * 默认商品mvgPick 按【确定】后执行的方法
		 */
		function salesGoodsMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null ){
				currentRow.defaultProduct = rightRowsMvg.o2oDisplayName;
			}
			return currentRow.defaultProduct;
		}
		/**
		 * 默认商品mvgPick 列表数据初始化参数
		 */
		function salesGoodsMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
		}
		
		/**
		 * 促销形式mvgPick 按【确定】后执行的方法
		 */
		function salesTypeMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null ){
				currentRow.type = rightRowsMvg.name;
			}
			return currentRow.type;
		}
		/**
		 * 促销形式mvgPick 列表数据初始化参数
		 */
		function salesTypeMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
		}
		
		/**
		 * 促销活动  城市picklist 初始化参数
		 */
		function initPickCityParam() {
			var schemaId = $datagrid.hdatagrid('getCurrentRow').id;
			return {schemaId:schemaId};
		}
		
		
		function cityPicklistComplete(selectRow){
			$dataItemgrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.cityName;
		}

		/**
		* 审批拒绝、审批通过 按钮执行方式
		* @param 值为Approved Rejected
		*/
		function approved(param){
			var rows = $dataItemgrid.datagrid('getSelections');
			if(rows.length <= 0){
				$.messager.alert("操作提示", "未选中行,不能进行该操作!","error");
				return true;
			}
			for(var i=0; i<rows.length; i++){
				if(param == 'Rejected'){
					$dlg.dialog('open');
					return true;
				} else{
					rows[i].approvalStatus = param;
					rows[i].status = 'Active';
					rows[i].attr1 = 'salesPromotionSchemaApproval';
				} 
			}
			
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/promotion/batchUpdate",
				type:"post",
				data:JSON.stringify(rows),
				dataType:"json",
				contentType: "application/json",
				success: function(data){
					if(data.success){
						var rows = $dataItemgrid.datagrid('getSelections');
						for(var i=0; i<rows.length; i++){
							var index = $dataItemgrid.hdatagrid('getRowIndex', rows[i]);
							$dataItemgrid.hdatagrid("refreshRow", index);
						}
						$('#btn_ok').linkbutton('disable');
						$('#btn_cancel').linkbutton('disable');
						window.parent.operationtip('审批通过！', 'info');
						successFun(that, data);
					}else{
						errFun(that, data);
					}
				},
				error: function(xhr, code, msg){
					errFun(that, "msg");
				}
			});
		}
		
		 function save(){
				var rows = $dataItemgrid.datagrid('getSelections');
				var approvalSuggest = $("#approvalSuggestId").val();
				if(approvalSuggest != null && approvalSuggest != ''){
					for(var i=0; i<rows.length; i++){
						rows[i].approvalSuggest = approvalSuggest;
						rows[i].approvalStatus = 'Rejected';
						rows[i].attr1 = 'salesPromotionSchemaApproval';
					}
				   
					$.ajax({
						url: "${AppContext.ctxPath}/action/portal/promotion/batchUpdate",
						type:"post",
						data:JSON.stringify(rows),
						dataType:"json",
						contentType: "application/json",
						success: function(data){
							if(data.success){
								$('#dlg').dialog('close');
								var rows = $dataItemgrid.datagrid('getSelections');
								for(var i=0; i<rows.length; i++){
									var index = $dataItemgrid.hdatagrid('getRowIndex', rows[i]);
									$dataItemgrid.hdatagrid("refreshRow", index);
								}
								$('#btn_ok').linkbutton('disable');
								$('#btn_cancel').linkbutton('disable');
								successFun(that, data);
							}else{
								errFun(that, data);
							}
						},
						error: function(xhr, code, msg){
							errFun(that, "msg");
						}
					});
				}else{
					$.messager.alert("操作提示", "审批意见不能为空!","error");
				}
		   }
		
		   function activityNameFormatter(val,row){
			     if(val != null){
						return "<a href='###' id='activityName' onClick='openActivity(\"" + row.id + "\",\"" + row.type + "\",\"" + row.cityId + "\")'>"+val+"</a>";
			     }
			}
		   function openActivity( id, type, cityId ){
			   switch(type){
				   case 'Combination':window.top.quickEnter('组合','组合','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/combinationList.jsp?id=' + id);break;
				   case 'FightGroup':window.top.quickEnter('拼团','拼团','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/groupActivityList.jsp?id=' + id);break;
				   case 'Second Kill':window.top.quickEnter('秒杀','秒杀','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/seckill.jsp?id=' + id);break;
				   case 'Limited Purchase':window.top.quickEnter('特价限购','特价限购','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/specialrestriction.jsp?id=' + id);break;
				   case 'Platform Promotion':window.top.quickEnter('平台优惠','平台优惠','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/platformfavorable.jsp?id=' + id);break;
				   case 'Coupon':window.top.quickEnter('优惠券','优惠券','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/coupon.jsp?id=' + id);break;
				   case 'Free Buy':window.top.quickEnter('买赠促销','买赠促销','campaign_management','${AppContext.ctxPath}/portal/campaignmanagement/campaignManagement.jsp?id=' + id);break;
				   default:$.messager.alert('Warning','促销类型未知！');
			  }
		  }
	</script>
</body>
</html>