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
				<th field="id" width="140px">促销方案编码</th>
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
					<th field="cityName" width="140px" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															initParam:initPickCityParam,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/cityNamePickList.jsp',
															required:true}}">大区</th>
					<th field="activityCode" width="100px" >促销活动编码</th>
					<th field="activityName" width="200px" formatter="activityNameFormatter" editor="{type:'textbox',options:{required:true}}" >促销活动名称</th>
					<th field="startTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>
					<!--<th field="status" width="120px" lov="TB_O2O_STATUS">活动状态</th>-->
					<th field="type" width="120px" lov="TB_O2O_CAMPAIGN_TYPE" editor="{type:'combobox',options:{ valueField:'val', 
																												textField:'name',
																												method:'get',
																												url:'${AppContext.ctxPath}/action/portal/promotion/queryType',
																												editable:false,
																												onSelect:selectType,
																												onBeforeLoad:function(param){
																													param.schemaId = $datagrid.hdatagrid('getCurrentRow').id;
																												},required:true
																												}}">促销形式</th>
					<th field="approvalStatus" width="120px" lov="TB_O2O_APPROVAL_STATUS" >审批状态</th>
					<th field="createdName" width="120px">创建人</th>
					<th field="created" width="120px">创建时间</th>
					<th field="approvalSuggest" width="240px">审批意见</th>
					<th field="activityNotes" width="230px" editor="{type:'textarea',options:{required:true}}" >说明</th>
				</tr>
			</thead>
		</table>
		</div>
	</div>
	<script type="text/javascript">
	   $datagrid = $('#schema-table');
	   $dataItemgrid=$('#activity-table');
	   var enable = false;
	   if(appCtx.systemRole =='super_administrator'){
		   enable = true;
	   }
	   $datagrid.hdatagrid({
			buttonNew:enable,
			buttonDelete:enable,
			updateable:enable,
			toolbarShow:true,
			buttonCopy:enable,
			buttonSearch:true,
			buttonExport:true,
			title : '促销方案发布',
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,30,50],//可以设置每页记录条数的列表 
		    newDefaultValue:true,
			subGridIds: ['activity-table'],
			url:'${AppContext.ctxPath}/action/portal/salesPromotionSchema/queryByExamplePage',
			buttonBatchEdit : false,				
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
			/**
			 *	删除方案级联更新活动头和活动行表
			 */
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						row.deleteFlg = 'Y';
						row.status = 'Inactive';
						$.post('${AppContext.ctxPath}/action/portal/salesPromotionSchema/update', row, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							} else {
								updateActivityFun(row.id);
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
 			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">无效</a>',that);
 			}, 
			/**
			 * 切换行，或加载数据成功后，触发选中行信息
			 */
			onChangeSelectedItem:function(row,that){
				if(row.status == 'Active'){
					$("#btn_add").linkbutton({text:'无效'});
					$('.easyui-linkbutton-delete-list-table',$datagrid.datagrid('getPanel')).linkbutton('disable');
				} else{
					$("#btn_add").linkbutton({text:'有效'});
					$('.easyui-linkbutton-delete-list-table',$datagrid.datagrid('getPanel')).linkbutton('enable');
				}
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
			newDefaultValue:true,
			title:"促销活动报名",
			pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
			parentGridId : 'schema-table',
		    parentGridField : 'id',
		    linkGridField : 'schemaId',
		    onBeforeLoad:function(param){
				param.attr1 = 'Schema';
			},
			onInitNewData:function(that){
				var headRow = $datagrid.hdatagrid('getCurrentRow');
				return{
					status:'Inactive',
					approvalStatus:'New',
					startTime:headRow.startDate,
					endTime:headRow.endDate
	 			};
			},
			/**
			 * 选择数据后，触发事件
			 * ① "待审批"和"审批通过"的记录都不可删除、不可复制
			 * ② 只允许【活动状态】为"无效",且【审批状态】为"新建"或"审批拒绝"可以点  提交 按钮
			 */
			onSelect:function(index, row){
				$('.easyui-linkbutton-delete-list-table',$dataItemgrid.datagrid('getPanel')).linkbutton('enable');
				$('.easyui-linkbutton-copy-list-table',$dataItemgrid.datagrid('getPanel')).linkbutton('enable');
				if(row.approvalStatus != 'New' && row.approvalStatus != 'Rejected'){
					$('.easyui-linkbutton-delete-list-table',$dataItemgrid.datagrid('getPanel')).linkbutton('disable');
					$('.easyui-linkbutton-copy-list-table',$dataItemgrid.datagrid('getPanel')).linkbutton('disable');
				}
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
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				var headRow = $datagrid.hdatagrid('getCurrentRow');
				row.merchStartTime=headRow.startDate;
				row.merchEndTime=headRow.endDate;
				row.schemaId = headRow.id;
				row.attr1 = 'salesPromotionSchema'
				$.post('${AppContext.ctxPath}/action/portal/promotion/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						if(row.row_status == 'NEW'){
							$dataItemgrid.hdatagrid('reload');
						}
						
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
			readOnlyCondition: function(row, that){//行不可编辑判断，true为只读
				if(row.approvalStatus != 'New' && row.approvalStatus != 'Rejected'){
		    		return true;
		    	}else{
		    		return false;
		    	}
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="submit()">提交</a>',that);
				addButtonFun(100,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="cancel()">撤销</a>',that);
			},
		});
	
		/**
		 * 大区mvgPick 按【确定】后执行的方法
		 */
		function salesCityMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null ){
				currentRow.city = rightRowsMvg.cityName;
				currentRow.cityId = rightRowsMvg.id;
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
				currentRow.type = rightRowsMvg.val;
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
		* 提交按钮
		*/
		function submit(){
			var row = $dataItemgrid.hdatagrid('getCurrentRow');
			var headRow = $datagrid.hdatagrid('getCurrentRow');
			if(row.status == 'Inactive' && (row.approvalStatus == 'New' || row.approvalStatus == 'Rejected' )){
				if(headRow.approvalFlg == 'Y'){
					row.status = 'Active';
					row.approvalStatus = 'Approved';
				} else {
					row.approvalStatus='Pending';
				}
				row.merchStartTime=headRow.startDate;
				row.merchEndTime=headRow.endDate;
				row.schemaId = headRow.id;
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
		
		function selectType(selectRow){
			$dataItemgrid.hdatagrid('getCurrentRow').type = selectRow.val;
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
	   

		//失效、有效
		function Invalid() {
			var row = $datagrid.datagrid('getSelected');
			var headRow = $dataItemgrid.datagrid('getSelected');
			//活动行中没有选中行即headRow=null,默认为无数据
			if(headRow == null){
				if(row.status=="Inactive"){
					$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
				}else{
					$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
				}
				return;
			}
			$.messager.confirm('操作提示', '本次操作将使得方案下的活动全部进行修改,确定要这样操作吗?', function(data) {
				if(data){
					if (row.status == "Inactive") {
						//方案状态从无效变为有效,其下面的审批通过的活动也变为有效
						headRow.schemaId = row.id;
						headRow.status = 'Active';
						headRow.approvalStatus = 'Approved';
						$.post('${AppContext.ctxPath}/action/portal/promotion/batchUpdateStatus', headRow, function(data) {
						   if (!data.success) {
							   $.messager.alert("错误", "修改活动状态时出错", "error");
							}else{
								//活动状态修改不成功的话 不修改方案状态
								$datagrid.hdatagrid('changeAndSaveRowValue', {
									id : row.id,
									status : "Active"
								});
								$.messager.alert("操作提示", "操作成功！","info");
							}
						});
	
					} else {
						//方案状态从有效变为无效,其下面的所有的活动也变为无效
						headRow.schemaId = row.id;
						headRow.status = 'Inactive';
						$.post('${AppContext.ctxPath}/action/portal/promotion/batchUpdateStatus', headRow, function(data) {
						   if (!data.success) {
							   $.messager.alert("错误", "修改活动状态时出错", "error");
							}else{
								$datagrid.hdatagrid('changeAndSaveRowValue', {
									id : row.id,
									status : "Inactive"
								});
								$.messager.alert("操作提示", "操作成功！","info");
							}
						});
					}
					var index = $datagrid.hdatagrid('getRowIndex', row);
					$datagrid.datagrid('selectRow', index);
				}
			});
		}
		/**
		 * 删除方案级联更新活动头和活动行表 status、delete_flg 字段
		 */
		 function updateActivityFun(schemaId){
			 var row = $datagrid.datagrid('getSelected');
			 $.post('${AppContext.ctxPath}/action/portal/promotion/updateStatusBySchemaId', {schemaId:schemaId}, function(data) {
				   if (!data.success) {
					   $.messager.alert("错误", "修改活动状态时出错", "error");
					}else{
					   $.messager.alert("操作提示", "操作成功！","info");
					}
				});
		}
	</script>
</body>
</html>