<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false" fit="true">
	<table id="international-table" style="width:100%;height:100%">
		<thead>
			<tr>
			   <th field="orderNoticeId" width="120px"  formatter="idFormatter">通知书编号</th>
			   <th field="contractCode" width="120px" editor="{type:'textbox',options:{required:true}}" defaultSearch="true">合同编号</th>
  			   <th field="optyName" width="120px" editor="{type:'picklistbox',options:{title:'选择商机',
  			                                                    completeFun:optyPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp',
																required:false}}">商机名称</th>
			   <th field="acctName" width="200px" editor="{type:'picklistbox',options:{title:'选择客户',
			  													completeFun:accntPicklistComplete,
			  													tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
																required:true}}">客户名称</th>												
			   <th field="status" lov="ORDER_STATUS" width="100px" editor="{type:'textbox',options:{valueField:'name',
																			textField:'name',
																			method:'get',
																			data:getLovArray('ORDER_STATUS'),
																			editable:false,
																			disabled:true,
																			required:false}}">状态 </th>												
			   <th field="orgName" width="120px" editor="{type:'picklistbox',options:{title:'选择组织',
  			                                                    completeFun:orgPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp',
																required:false}}">所属区域</th> 												
			   <th field="deliveryDt" width="120px" editor="{type:'datebox'}" >交易时间</th>	
			   <th field="deliverySite" width="200px" editor="{type:'textbox'}" >交易地点</th>												
   			   <th field="salesmenName" width="120px" editor="{type:'picklistbox',options:{title:'选择用户',
   			   																		completeFun:salesmenPickListComplete,
   			   																		tableUrl:'${AppContext.ctxPath}/portal/picklist/PostnJoinByEmpPickList.jsp',
   			   																		required:false}}">业务员</th>	
   			   <th field="salesmenPhone" width="120px" editor="{type:'textbox',options:{required:true,disabled:true}}" >业务员电话</th>																																	
			</tr>
		</thead>
	</table>
	</div>
	<script type="text/javascript">
	    getLovOfList("[ORDER_STATUS]");
		$datagrid = $('#international-table');
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
			url:'${AppContext.ctxPath}/action/portal/saleorder/queryIntlNoticeListPage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addOuterNotice()">新建</a>',that);
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
					 sceneChargeId     :     row.sceneChargeId,
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
					 optyId            :     row.optyId,
					 orgId             :     row.orgId
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
		function addOuterNotice(){
			var recordId = "noMatchSelect";
			gotoContentPage("/portal/notice/InternationalNoticeNew.jsp?id="+recordId);
		};
		//选择商机
		function optyPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').optyId = selectRow.id;
			//带出商机记录的客户信息
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
		//选择所属区域
		function orgPicklistComplete(selectRow){
		    $datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
		 	return selectRow.text;
		};
		
		function idFormatter(val,row){
			return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/notice/InternationalNoticeNew.jsp?id=" + row.id +"\")'>" + row.orderNoticeId + "</a>";
		};
	</script>
</body>
</html>