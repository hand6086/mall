<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false" fit="true">
    <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">筛选条件</span>
		</legend>
		<div class="row keyfilter-border">
			<ul id="serviceTypeKeyfilter" data-toggle="keyfilter"
				data-title="业务类型" data-filter-filed="serviceType"
				data-table-Id="internal-table">
			</ul>
		</div>
		<div class="row keyfilter-border">
			<ul id="placeOrderTypeKeyfilter" data-toggle="keyfilter"
				data-title="下单类型" data-filter-filed="placeOrderType"
				data-table-Id="internal-table">
			</ul>
		</div>
	</fieldset>
	<table id="internal-table" keyFilterDiv="keyFilter" 
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
			   <th field="orderNoticeId" width="120px"  formatter="idFormatter">通知书编号</th>
			   <th field="contractCode" width="120px" editor="{type:'textbox',options:{required:true}}" defaultSearch="true">合同编号</th>
  			   <th field="optyName" width="120px" editor="{type:'picklistbox',options:{title:'选择商机',
  			                                                    completeFun:optyPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp',
																required:false}}">商机名称</th>
			   <th field="optyAddr" width="200px"  editor="{type:'textbox',options:{disabled:true}}"  >商机地址</th> 
   			   <th field="acctName" width="200px" editor="{type:'picklistbox',options:{title:'选择客户',
  													completeFun:accntPicklistComplete,
  													tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
													required:true}}">客户名称</th>
			   <th field="status" width="100px" lov="ORDER_STATUS" editor="{type:'textbox',options:{valueField:'name',
																			textField:'name',
																			method:'get',
																			data:getLovArray('ORDER_STATUS'),
																			editable:false,
																			disabled:true,
																			required:false}}">状态 </th>
			   <th field="serviceType" lov="BUSINESS_TYPE" width="80px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('BUSINESS_TYPE'),
																			editable:false,
																			required:false}}">业务类型</th>
               <th field="placeOrderType" lov="PLACE_ORDER_TYPE" width="80px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('PLACE_ORDER_TYPE'),
																			editable:false,
																			required:false}}">下单类型</th>
               <th field="approachDt" width="100px" editor="{type:'datebox'}">进场日期 </th>
			   
   			   <th field="salesmenName" width="100px" editor="{type:'picklistbox',options:{title:'选择用户',
   			   																		completeFun:salesmenPickListComplete,
   			   																		tableUrl:'${AppContext.ctxPath}/portal/picklist/PostnJoinByEmpPickList.jsp',
   			   																		required:true}}">业务员</th>
   			   <th field="salesmenPhone"  width="100px"  editor="{type:'numberbox',options:{disabled:true}}" >业务员电话</th>																																		
   			   <th field="sceneChargeName"  width="100px"  editor="{type:'textbox'}" >现场负责人</th>
   			   <th field="sceneChargePhone"  width="100px"  editor="{type:'numberbox'}" >现场负责人电话</th>
			</tr>
		</thead>
	</table>
	</div>
	<script type="text/javascript">
		$datagrid = $('#internal-table');
		getLovOfList("[BUSINESS_TYPE,ORDER_STATUS,PLACE_ORDER_TYPE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:true,
			buttonCopy:false,
			buttonExport:false,
			buttonImport:false,
			oauthFlag:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/saleorder/queryDomesticNoticeListPage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addInnerNotice()">新建</a>',that);
			},
			onUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/saleorder/update',{
					 id 			   :     row.id,
					 acctId            :     row.acctId,
					 postnId           :     row.postnId,
					 orderNoticeId 	   :     row.orderNoticeId,
					 orderNoticeType   :     row.orderNoticeType,
					 contractCode      :     row.contractCode,
					 serviceType       :     row.serviceType,
					 placeOrderType    :     row.placeOrderType,
					 approachDt        :     row.approachDt,
					 completedDt       :     row.completedDt,
		   			 sceneChargeName   :     row.sceneChargeName,
					 sceneChargePhone  :     row.sceneChargePhone,
					 wallThickness     :     row.wallThickness,
					 door              :     row.door,
					 doorMaterial      :     row.doorMaterial,
					 windowType        :     row.windowType,
					 windowParts       :     row.windowParts,
					 roofTile          :     row.roofTile,
					 outsourceType     :     row.outsourceType,
					 otherParts        :     row.otherParts,
					 approachCondition :     row.approachCondition,
					 baseType          :     row.baseType,
					 electricityUsage  :     row.electricityUsage,
					 approachSq        :     row.approachSq,
					 approachOther     :     row.approachOther,
					 deliveryDt        :     row.deliveryDt,
					 deliverySite      :     row.deliverySite,
					 installDemand     :     row.installDemand,
					 optyId            :     row.optyId
				},function(data){
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				})
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/saleorder/delete', {
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
			}
		});
		
		//添加国内下单通知书
		function addInnerNotice(){
			var recordId = "noMatchSelect";
			gotoContentPage("/portal/notice/InternalNoticeNew.jsp?id="+recordId);
		};
		//选择商机
		function optyPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').optyId = selectRow.id;
			
			/* var acctId = $datagrid.hdatagrid('getCurrentRow').acctId;
			if(acctId == null ||acctId ==''){
				$datagrid.hdatagrid('getCurrentRow').acctId = selectRow.accntId;
				$datagrid.hdatagrid('getCurrentRow').acctId = selectRow.accnt;
			} */
			$datagrid.hdatagrid('getCurrentRow').acctId = selectRow.accntId;
			$datagrid.hdatagrid('getCurrentRow').acctName = selectRow.accnt;
			return selectRow.optyName;
		};
		//选择客户
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').acctId = selectRow.id;
			return selectRow.acctName;
		};
		//选择业务员
		function salesmenPickListComplete(selectRow){
		    $datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
		 	return selectRow.fstName;
		};
		function idFormatter(val,row){
			return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/notice/InternalNoticeNew.jsp?id=" + row.id +"\")'>" + row.orderNoticeId + "</a>";
		};
		
		$('#serviceTypeKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/BUSINESS_TYPE'
		});
		
		$('#placeOrderTypeKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/PLACE_ORDER_TYPE'
		});
	</script>
</body>
</html>