<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>

<body>
	<div class="easyui-layout" data-options="fit:true">
	
 	<div data-options="region:'north',collapsible:false" title="仓库基本信息"  style="width:80%;height:100%;padding:0px;">

			<form id="invlocForm" method="post" align="center">
				<div class="row row-control">
					<div class="col-xs-3">
						<label class="input-label">仓库名称 : </label> <input
							class="easyui-textbox form-control" disabled="true" name="invlocName"
							id="invlocName" />
					</div>
					
					<div class="col-xs-3">
					<label class="input-label">类型 : </label> <input
						data-options="{ valueField:'val',
										textField:'name',
										data:getLovArray('INVLOC_TYPE'),
										editable:false,
										required:true}",
						class="easyui-combobox form-control"  disabled="true" name="invlocType" id="invlocType" />
				    </div>
					
					<div class="col-xs-3">
					<label class="input-label">仓库所有者 :</label> <input
						class="easyui-textbox form-control"  disabled="true" name="ownerName" id="ownerName" /> <input
						hidden="true" name="ownerId" id="ownerId" />
				   </div>
					
				</div>
	            
				<div class="row row-control">
					<div class="col-xs-3">
					<label class="input-label">组织 :</label> <input
						class="easyui-textbox form-control"  disabled="true" name="orgName" id="orgName" /> <input
						hidden="true" name="orgId" id="orgId" />
				   </div>
					
					<div class="col-xs-3">
						<label class="input-label">开票地址 : </label> <input
							class="easyui-textbox form-control"  disabled="true" name="invoiceAddr" id="invoiceAddr" />
					</div>
					
					<div class="col-xs-3">
						<label class="input-label">预计签单时间 : </label> <input
							class="easyui-textbox form-control"  disabled="true" name="shipmentAddr" id="shipmentAddr" />
					</div>
					
				</div>
	
				<div class="row row-control">
					<div class="col-xs-3">
						<label class="input-label">接收地址: </label> <input
							class="easyui-textbox form-control"  disabled="true" name="reciveAddr" id="reciveAddr" />
					</div>
				</div>
			</form>
		   
	       
	        <div id="p1" title="产品库存"  class="easyui-panel" collapsible="true" collapsed="false" border="false" style="height:60%; padding:0px;" >
	       	<table id="inv-prod-table" singleSelect="true" rownumbers="true" pagination="true" style="width:100%;height:100%;">
			<thead>
				<tr>
					<th field="prodId" width="100px">产品id</th>
					<th field="prodName" width="150px" defaultSearch="true">产品</th>
					<th field="prodNumMin" width="150px">最小值</th>
				    <th field="prodNumMax" width="150px" >最大值</th>
				    <th field="invlocId" width="150px" hidden="true">仓库id</th>
				</tr>
			</thead>
           </table>
           </div>
           
	      <div id="p2" title="库存量"  class="easyui-panel" collapsible="true" collapsed="false" border="false" style="height:40%; padding:0px;" >
	       	<table id="prod-loc-table" singleSelect="true" rownumbers="true" pagination="true" style="width:100%;height:100%;">
			<thead>
				<tr>
				    <th field="usable" lov="INV_AVAILABILITY" width="100px" editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											data : getLovArray('INV_AVAILABILITY'),
											editable:false,
											required:true}}">可用性</th>
					   <th field="status" lov="INV_STATUS" width="100px" editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											data : getLovArray('INV_STATUS'),
											editable:false,
											required:true}}">状态</th>
				    <th field="qty" width="150px" >数量</th>
				    <th field="stockId" hidden width="150px">库存ID</th>
				</tr>
			</thead>
           </table>
          </div> 
	       
     </div>
    </div>
    
<script type="text/javascript">
	var invlId = "noMatch";
	invlId = getUrlParams("invlId");
	$.post("${AppContext.ctxPath}/action/portal/invloc/queryById", {
		id : invlId
	}, function(data) {
		if (data.success) {
			record = data.result;
			$('#invlocForm').form("load", record);
		} else {
			$.messager.alert("警告", data.result);
		}
	});
	
	$('#ownerName').picklist({
		title:'选择客户',
		completeFun:function(selectRow){
			$('#accntId').val(selectRow.id)
			return selectRow.acctName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/account/contact/picklist/AccountPickList.jsp'
	});
	
	$('#orgName').picklist({
		title:'选择组织',
		completeFun:function(selectRow){
			$('#accntId').val(selectRow.id)
			return selectRow.text;
		},
		tableUrl:'${AppContext.ctxPath}/portal/basic/picklist/orgPickList.jsp'
	});

    $datagrid = $('#inv-prod-table');
	$dataitemgrid = $('#prod-loc-table');
	getLovOfList("[INV_AVAILABILITY,INV_AVAILABILITY]");
 	$datagrid.hdatagrid({
	    toolbarShow:true,
		buttonSearch:true,
		buttonExport:false,
		striped:true,
		border:false,
		pagePosition:'bottom',
	    pageSize: 10,   //每页显示的记录条数，默认为
	    pageList: [10,10,20],//可以设置每页记录条数的列表 
 		url:'${AppContext.ctxPath}/action/portal/invPro/queryByExamplePage/'+invlId,
 		onChangeSelectedItem:function(row,that){
			var prodRecord = $datagrid.hdatagrid('getSelected');
			$dataitemgrid.hdatagrid('changeParentItemAndParams',{stockId:prodRecord.id});
		}
	});  
	
	$dataitemgrid.hdatagrid({
		                        toolbarShow:true,
								buttonSearch:true,
								buttonExport:false,
								updateable:false,
								striped:true,
								border:false,
								pagePosition:'bottom',
							    pageSize: 5,   //每页显示的记录条数，默认为
							    pageList: [5,5,10],//可以设置每页记录条数的列表 
								url:'${AppContext.ctxPath}/action/portal/invProLoc/queryByExamplePage'
	});  
	
</script>

</body>
</html>