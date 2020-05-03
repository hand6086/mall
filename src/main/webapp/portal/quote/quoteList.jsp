<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="height:50%;width:100%">
	   <fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style=" margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">报价筛选条件</span>
			</legend>
	
			<div class="row keyfilter-border">
				<ul id="quote-status-keyfilter" data-toggle="keyfilter"
					data-title="报价单状态" data-filter-filed="quoteStatus"
					data-table-Id="quote-table">
				</ul>
			</div>
		</fieldset>
		
		<table id="quote-table" keyFilterDiv="keyFilter" fit="true">
			<thead>
				<tr>
					
					<th field="owner"			width="100px" >创建人</th>
					<th field="quoteNumb"		width="100px" defaultSearch="true">报价单编号</th>
					<th field="quoteVers"		width="100px" >报价单版本</th>
					<th field="quoteName" width="100px" editor="{type:'validatebox', options:{required:true}}" formatter="editFormatter">报价单名称</th>
					<th field="isEffective"		width="100px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否有效</th>
					<!-- <th field="quoteStatus"		width="100px"  lov="QUOTE_STATUS" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('QUOTE_STATUS'),
																			editable:false,
																			required:true}}">报价单状态</th>-->
					<th field="quoteStatus"		width="100px" lov="QUOTE_STATUS" >报价单状态</th>
					<th field="comments"		width="100px"editor="{type:'validatebox'}">备注</th>
					<th field="acctName"		width="100px" editor="{type:'picklistbox',options:{title:'选择客户',
																				completeFun:accntPicklistComplete,
																				tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp',
																				required:true}}">客户名称</th>
					<th field="contact"			width="100px" editor="{type:'validatebox'}">法人联系人</th>
					<th field="contactTel"		width="100px" editor="{type:'validatebox'}">法人联系人电话</th>
					<th field="validDate"		width="100px" mark="DATE" editor="{type:'datebox'}">有效期</th>
					<th field="payAcctName"		width="100px" editor="{type:'picklistbox',options:{title:'选择付款客户',completeFun:payAccntPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'}}">付款方名称</th>
					<th field="addr"			width="100px" editor="{type:'picklistbox',options:{title:'选择地址',
																				initParam:initAddresssPicklistParam,
																				completeFun:addressPicklistComplete,
																				tableUrl:'${AppContext.ctxPath}/portal/picklist/addressPickList.jsp'}}">收货地址</th>
					<th field="addrType"		width="100px" >地址类型</th>
					<th field="acctArea"		width="100px" >客户所在地区</th>
					<th field="orgName" width="130px" editor="{type:'picklistbox',options:{title:'选择组织',
																completeFun:orgPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
					<th field="postnName" width="130px" editor="{type:'picklistbox',options:{title:'选择职位',
																completeFun:postnPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'}}">职位</th>
					<th field="newQuoteDate"	width="100px" mark="DATE">创建日期</th>
					<th field="submitDate"		width="100px" mark="DATE">提交日期</th>
					<th field="cancelDate"		width="100px" mark="DATE">取消日期</th>
					<th field="reviseDate"		width="100px" mark="DATE">修订日期</th>
					<th field="turnOrderDate" 	width="100px" mark="DATE">报价单转订单的时间</th>
					<th field="approveDate"		width="100px" mark="DATE">批准日期</th>
					<th field="rejectDate"		width="100px" mark="DATE">拒绝日期</th>
					<th field="quoteTotalAmount"width="100px"  currency="CNY">报价单总金额</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'south',split:true" border="false" style="width:100%;height:50%;">
		<table id="quote-Item-table" fit="true">
			<thead>
				<tr>
					<th field="prodName" width="120px" editor="{type:'picklistbox',options:{title:'选择产品',completeFun:productPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp'}}">产品名称</th>
					<th field="prodCode" width="100px" >产品编码</th>
					<th field="price" width="100px" currency="CNY" >销售单价</th>
					<th field="qty" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">产品数量</th>
					<th field="comments" width="100px" editor="{type:'textbox'}">备注</th>
				</tr>
			</thead>
		</table>
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#quote-table');
		getLovOfList("[QUOTE_STATUS]");
		$dataItemgrid=$('#quote-Item-table');
		$datagrid.hdatagrid({
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			newDefaultValue:true,
			oauthFlag:true,
			url:'${AppContext.ctxPath}/action/portal/quote/queryByExamplePage',
			 buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/quote/batchUpdate",
					type:"post",
					data:JSON.stringify(rows),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},				
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				delete row.prodList;
				$.post('${AppContext.ctxPath}/action/portal/quote/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/quote/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					}
				});
			},
			onChangeSelectedItem:function(row){
				$dataItemgrid.hdatagrid("changeParentItemAndParams",{quoteId:row.id});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					owner: appCtx.firstName,
					isEffective:"Y",
					quoteVers:"1",
					newQuoteDate:appCtx.getNowDateShortn(0),
					quoteStatus : getLovShowName("QUOTE_STATUS", "New"),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editQuotePrice()" iconCls="icon-edit" plain="true">修订</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="quoteSubmit()" iconCls="icon-ok" plain="true">提交</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="quoteApprove()" iconCls="icon-redo" plain="true">审批通过</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="quoteReject()" iconCls="icon-undo" plain="true">审批拒绝</a>',that);
				addButtonFun(94,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="quoteCancel()" iconCls="icon-no" plain="true">取消</a>',that);
				addButtonFun(95,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="quoteGenerateOrder()" iconCls="icon-newOrder" plain="true">生成订单</a>',that);
			}
		});

	   $('#quote-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/QUOTE_STATUS'
	   });
		
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				acctId : selectRow.id
			});
			return selectRow.acctName;
		}
		
		function payAccntPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				payAcctId : selectRow.id
			});
			return selectRow.acctName;
		}
		
		function contactPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				contactId : selectRow.id
			});
			return selectRow.contactsName;
		}
		
		function optyPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				optyId : selectRow.id
			});
			return selectRow.optyName;
		}
		
		function addressPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				addressId : selectRow.id
			});
			return selectRow.province+selectRow.city+selectRow.district+selectRow.addr;
		}
		
		//初始化联系人客户Id
		function initContactPicklistParam(){
			var acctId = $datagrid.hdatagrid('getCurrentRow').acctId;
			if (acctId == null || acctId == '') {
				return {
					id : 'noMatchId'
				};
			} else {
				return {
					id : acctId
				};
			}
		}
		
		//初始化选择客户地址
		function initAddresssPicklistParam(){
			var acctId = $datagrid.hdatagrid('getCurrentRow').acctId;
			if (acctId == null || acctId == '') {
				return {
					id : 'noMatchId'
				};
			} else {
				return {
					id : acctId
				};
			}
		}
		/**
		修订报价 -yrf
		*/
		function editQuotePrice(){
			var that = $datagrid;
			var options = $datagrid.datagrid('options').hdatagrid.options;
			if(options.editIndex != null){
				$.messager.alert("提示","存在数据没有保存，请先保存数据!");
				return;
			}
			var selectedRow = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex',selectedRow);
			if(selectedRow == null){
				$.messager.alert("提示","请选中要修订的数据!");
				return;
			}
			var initCopyRow = {};
			var copyRow = $.extend(true,{},selectedRow,initCopyRow);
			if(copyRow.quoteVers && !isNaN(copyRow.quoteVers)){
				copyRow.quoteVers = parseInt(copyRow.quoteVers, 10) + 1;
			}else{
				window.parent.operationtip("没有有效版本号", 'error');
				return;
			}
			$.post('${AppContext.ctxPath}/action/portal/quote/quoteEdit',{id : copyRow.id},function(data){
				if(data){
					if(data.success){
						
						//行已复制成功后操作
						options.insertOneFlag = true;
						options.editIndex = index + 1;
						copyRow.id = data.newId;
						/* if(copyRow.quoteVers && !isNaN(copyRow.quoteVers)){
							copyRow.quoteVers = parseInt(copyRow.quoteVers, 10) + 1;
						} */
						copyRow.owner = '${sessionScope.UserContext.firstName}';
						copyRow.row_status = 'NEW';//插入操作
						copyRow.quoteNumb = data.newQuoteNumb;
						var date = new Date();
						var dateStr = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
						copyRow.reviseDate = dateStr;
						$datagrid.datagrid('options').hdatagrid.toSaveOrUndoOperation();//刷新工具栏
						$datagrid.datagrid('insertRow',{index: options.editIndex, row:copyRow});
						$datagrid.datagrid('selectRow', options.editIndex).datagrid('beginEdit', options.editIndex);
						options.onChangeSelectedItem(copyRow);//选中新行
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				}
			});
		}

		//报价行
		$dataItemgrid.hdatagrid({
			title:'报价行信息',
			updateable:true,
			pagination:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			url:'${AppContext.ctxPath}/action/portal/QuoteItem/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			:row.id,
							prodId		:row.prodId,
							qty			:row.qty,
							quoteId		:row.quoteId,
							comments	:row.comments
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/QuoteItem/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},				
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				console.info(row.quoteId);
				$.post('${AppContext.ctxPath}/action/portal/QuoteItem/upsert', {
					row_status  : row.row_status,
					id			:row.id,
					prodId		:row.prodId,
					qty			:row.qty,
					quoteId		:row.quoteId,
					comments	:row.comments
				},function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/QuoteItem/deleteById', {
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
					quoteId : $datagrid.datagrid('getSelected').id
				};
			}
		});
		
		//提交
		function quoteSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.acctName == '' || row.acctName == null){
				$.messager.alert('提示','请选择客户，客户不能为空！');
				return;
			}
			if(row.quoteStatus == 'New'||row.quoteStatus == 'Rejected'){
				$.post('${AppContext.ctxPath}/action/portal/quote/quoteSubmit', 
				{
					id	: row.id
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						refreshRow(data.newRow);
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName("QUOTE_STATUS", row.quoteStatus)+'，无法提交！', 'error');
			}
		}
		//审批通过
		function quoteApprove(){
			var row = $datagrid.datagrid('getSelected');
			if(row.quoteStatus == 'Submitted'){
				$.post('${AppContext.ctxPath}/action/portal/quote/quoteApprove', 
				{
					id	: row.id
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						refreshRow(data.newRow);
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName("QUOTE_STATUS", row.quoteStatus)+'，无法审批通过！', 'error');
			}
		}
		//审批拒绝
		function quoteReject(){
			var row = $datagrid.datagrid('getSelected');
			if(row.quoteStatus == 'Submitted'){
				$.post('${AppContext.ctxPath}/action/portal/quote/quoteReject', 
				{
					id	: row.id
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						refreshRow(data.newRow);
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName("QUOTE_STATUS", row.quoteStatus)+'，无法审批拒绝！', 'error');
			}
		}
		//取消
		function quoteCancel(){
			var row = $datagrid.datagrid('getSelected');
			if(row.quoteStatus != 'Approved'){
				$.post('${AppContext.ctxPath}/action/portal/quote/quoteCancel', 
				{
					id	: row.id
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						refreshRow(data.newRow);
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName("QUOTE_STATUS", row.quoteStatus)+'，无法取消！', 'error');
			}
		}
		//报价生成订单
		function quoteGenerateOrder(){
			var row = $datagrid.datagrid('getSelected');
			if(row.quoteStatus == 'Approved'){
				delete row.prodList;
				$.post('${AppContext.ctxPath}/action/portal/quote/quoteGenerateOrder',row,
				function(data){
					if(!data.success){
						$.messager.alert("操作提示", data.result,"error");
					}else{
						$.messager.alert("操作提示", "订单生成成功!");
						refreshRow(data.newRow);
						
					}
				});
			}else{
				$.messager.alert('提示','该报价单未获批准，不能转换为订单！');
			}
		}
		
		/**
		 * 刷新选中行
		 */
		function refreshRow(newRow){
			if(!newRow){
				$datagrid.datagrid('reload');
				return;
			}
			var selectedRow = $datagrid.hdatagrid('getSelected');
			var index = $datagrid.hdatagrid('getRowIndex', selectedRow);
			$datagrid.datagrid('updateRow', {index: index, row:newRow});
			$datagrid.datagrid('acceptChanges');
		}
		
		function productPicklistComplete(selectRow){
			$dataItemgrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			});
			return selectRow.prodName;
		}
		
		var editFormatter = function(value,row,index){
			return value;
		}
		

		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
	</script>
</body>
</html>