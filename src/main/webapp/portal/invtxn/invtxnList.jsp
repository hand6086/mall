<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">标准筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="invtxn-type-keyfilter" data-toggle="keyfilter"
				data-title="交易类型" data-filter-filed="type"
				data-table-Id="invtxn-table">
			</ul>
		</div>
		<div class="row keyfilter-border">
				<ul class="invtxn-submit-keyfilter" data-toggle="keyfilter" 
				data-title="提交状态" data-filter-filed="submit"
					data-table-Id="invtxn-table">
					<li data-value="Y">已提交</li>
					<li data-value="N">未提交</li>
				</ul>
			</div>
		
	</fieldset>
	
	<table id="invtxn-table"  fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px">交易编号</th>
				<th field="tradeDate" width="100px" mark="DATE" editor="{type:'datebox',options:{
																			showSeconds:false,
																			editable:false,
																			required:true
																					}}">交易日期</th>
				<th field="type" lov="INVTXN_TYPE" width="90px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('INVTXN_TYPE'),
																		editable:false,
																		required:true}}">类型</th>													
				<th field="prodName" width="230px" editor="{type:'picklistbox',options:{title:'选择产品',
															completeFun:prodPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp',
															editable:false,
															required:true}}">产品</th>
				<th field="prodCode" width="100px">产品编码</th>
				<th field="amount" width="100px" editor="{type:'numberspinner',options:{min:0}}">数量</th>
				<th field="origInvloc" width="100px" editor="{type:'picklistbox',options:{title:'选择仓库',
															completeFun:origInvlocPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/InvlocPickList.jsp',
															editable:false,
															required:true}}">来源仓库</th>
				<th field="desInvloc" width="100px" editor="{type:'picklistbox',options:{title:'选择仓库',
															completeFun:desInvlocPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/InvlocPickList.jsp',
															editable:false,
															required:true}}">目的仓库</th>
				<th field="origAccnt" width="100px">来源客户</th>
				<th field="desAccnt" width="120px">目的客户</th>
				<th field="submit" lov="S_IF" width="120px" >提交</th>
                <th field="origAvailability" lov="INV_AVAILABILITY" width="80px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('INV_AVAILABILITY'),
																		editable:false,
																		required:true}}">源可用性</th>
				<th field="origStatus" lov="INV_STATUS" width="100px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('INV_STATUS'),
																		editable:false,
																		required:true}}">源状态</th>
				<th field="desAvailability" lov="INV_AVAILABILITY" width="100px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('INV_AVAILABILITY'),
																		editable:false,
																		required:true}}">目的可用性</th>
				<th field="desStatus" lov="INV_STATUS" width="100px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('INV_STATUS'),
																		editable:false,
																		required:true}}">目的状态</th>
				<th field="sourceId" width="90px">源id</th>
				<th field="sourceNum" width="90px">源编号</th>
				<th field="note" width="100px" editor="{type:'textbox'}">备注</th>
				
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	   
		$datagrid = $('#invtxn-table');
		getLovOfList("[INV_STATUS,INV_AVAILABILITY,INVTXN_TYPE,INV_AVAILABILITY,INV_STATUS,S_IF]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			oauthFlag:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/invtxn/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			:row.id,
							tradeDate	:row.tradeDate,
							type		:row.type,
							prodId		:row.prodId,
							amount		:row.amount,
							origInvlocId :row.origInvlocId,
							desInvlocId	 :row.desInvlocId,
							submit		:row.submit,
							origAvailability :row.origAvailability,
							origStatus :row.origStatus,
							desAvailability :row.desAvailability,
							desStatus :row.desStatus,
							note :row.note,
							sourceId :row.sourceId,
							sourceNum:row.sourceNum
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/invtxn/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/invtxn/upsert', {
					row_status  : row.row_status,
					id			:row.id,
					tradeDate	:row.tradeDate,
					type		:row.type,
					prodId		:row.prodId,
					amount		:row.amount,
					origInvlocId :row.origInvlocId,
					desInvlocId	 :row.desInvlocId,
					submit		:row.submit,
					origAvailability :row.origAvailability,
					origStatus :row.origStatus,
					desAvailability :row.desAvailability,
					desStatus :row.desStatus,
					note :row.note,
					sourceId :row.sourceId,
					sourceNum:row.sourceNum
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				if(row.submit == 'Y'){
					 $.messager.alert("操作提示", "数据已提交，不能删除！","error"); 
				}else{
					$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
						if(data){
							$.post('${AppContext.ctxPath}/action/portal/invtxn/deleteById', {
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
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-css-go" plain="true" onclick="goodConfirm()">提交</a>',that);
			},
			onInitCopyData:function(that){
				return {submit:'N'};
			},
			onInitNewData:function(that){
				return {tradeDate:getCurrentDHM(),
						amount:'1',
						submit:'N'
					};
			}
		});	

	   $('#invtxn-type-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/INVTXN_TYPE'
	   });
	   $('#invtxn-submit-keyfilter').keyFilter();
		function prodPicklistComplete(selectRow) {
			$datagrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			})
			return selectRow.prodName;
		}
		function origInvlocPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				origInvlocId : selectRow.id			
			})
			return selectRow.invlocName;
		}
		function desInvlocPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				desInvlocId : selectRow.id
			})
			/* var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');				
			setTimeout(function(){
				$datagrid.datagrid('endEdit',editIndex);
		    	$datagrid.datagrid('updateRow',{
		    		index:editIndex,
		    		row:{
		    			desAccnt:selectRow.ownerName
		    		}
		    	});
		    	$datagrid.datagrid('beginEdit',editIndex);
	    	},5)	 */
			return selectRow.invlocName;
		}
		function goodConfirm(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/invtxn/goodConfirm', 
			{
				id	: row.id
		    },
			function(data){
		    	if(data.success){
		    		$datagrid.datagrid('reload');
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			});
		}		
	</script>
</body>
</html>