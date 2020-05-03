<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true">
   
     <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">仓库筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="invloc-type-keyfilter" data-toggle="keyfilter"
				data-title="类型" data-filter-filed="invlocType"
				data-table-Id="invloc-table">
			</ul>
		</div>
		
	</fieldset>
	
	<table id="invloc-table" fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="invlocName" width="180px" editor="{type:'textbox',options:{required:true}}" formatter="invlocNameFormatter">仓库名称</th>
				<th field="invlocType" lov="INVLOC_TYPE" width="100px" editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											data : getLovArray('INVLOC_TYPE'),
											editable:false,
											required:true}}">类型</th>
				<th  field="ownerId" width="100px"  hidden="true">所有者ID</th> 
				<th  field="ownerName" width="100px" editor="{type:'picklistbox',
				                                            options:{title:'选择所有人',
				                                                     required:true,
                                                                     completeFun:completeContactSelect,
                                                                     tableUrl:'${AppContext.ctxPath}/portal/account/contact/picklist/AccountPickList.jsp'}}">仓库所有者</th>
				<th field="orgId" width="150px"  hidden="true">组织id</th>
				<th field="orgName" width="150px" editor="{type:'picklistbox',
				                                            options:{title:'选择所有人',
				                                                     required:true,
                                                                     completeFun:completeOrgSelect,
                                                                     tableUrl:'${AppContext.ctxPath}/portal/basic/picklist/orgPickList.jsp'}}">组织</th>
				<th field="invoiceAddr" width="240px" editor="{type:'textbox'}">开票地址</th>
				<th field="shipmentAddr" width="240px" editor="{type:'textbox'}">装运地址</th>
				<th field="reciveAddr" width="240px" editor="{type:'textbox'}">接收地址</th>
			</tr>
		</thead>
	</table>
   	
	<script type="text/javascript">
	  
	    $datagrid = $('#invloc-table');
	    getLovOfList("[INVLOC_TYPE]");
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
 			url:'${AppContext.ctxPath}/action/portal/invloc/queryByExamplePage',
 			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id            :  row.id,
				        	invlocName    :  row.invlocName,
				        	invlocType    :  row.invlocType,
				        	ownerId       :  row.ownerId,
				        	ownerName     :  row.ownerName,
				        	orgId         :  row.orgId,
				        	orgName       :  row.orgName,
				            invoiceAddr   :  row.invoiceAddr,
				            shipmentAddr  :  row.shipmentAddr,
				        	reciveAddr    :  row.reciveAddr
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/invloc/batchUpdate",
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
		        $.post('${AppContext.ctxPath}/action/portal/invloc/upsert',{
		        	row_status    :	 row.row_status,
		        	id            :  row.id,
		        	invlocName    :  row.invlocName,
		        	invlocType    :  row.invlocType,
		        	ownerId       :  row.ownerId,
		        	ownerName     :  row.ownerName,
		        	orgId         :  row.orgId,
		        	orgName       :  row.orgName,
		            invoiceAddr   :  row.invoiceAddr,
		            shipmentAddr  :  row.shipmentAddr,
		        	reciveAddr    :  row.reciveAddr
		        },function(data){
		        	if(!data.success){
		        		errFun(data.result,that);
		        	}
		        	else{
		        		successFun(that,data);
		        	}
		        });
		    },
		    onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/invloc/deleteById', {
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
		  
		
		$('#invloc-type-keyfilter').keyFilter({
			remoteData : true,
			filterByValue:true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/INVLOC_TYPE'
		});

		function invlocNameFormatter(val, row) {
			if (val != null) {
				return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/invloc/invlocInfo.jsp?invlId="
						+ row.id + "\")'>" + row.invlocName + "</a>";

			}
		}

		function completeContactSelect(selectRow) {
			$datagrid.hdatagrid('updateCurrentRow', {
				ownerId : selectRow.id
			})
			return selectRow.acctName;
		}

		function completeOrgSelect(selectRow) {
			$datagrid.hdatagrid('updateCurrentRow', {
				orgId : selectRow.id
			})
			return selectRow.text;
		}
	</script>
</body>
</html>