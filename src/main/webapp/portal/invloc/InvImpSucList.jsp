<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
.td-label {
	font-size: 12px;
	text-align: right;
	height: 30px;
}
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
	<fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">标准筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="invimp-type-keyfilter" data-toggle="keyfilter"
				data-title="类型" data-filter-filed="type"
				data-table-Id="inv-imp-table">
				<li data-value="销售出库">销售出库</li>
				<li data-value="销售调入">销售调入</li>
				<li data-value="销售调出">销售调出</li>
				<li data-value="采购进货">采购进货</li>
			</ul>
		</div>
	</fieldset>
	
	<table id="inv-imp-table" fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="tradeDate" width="110px" mark="DATE">交易日期</th>
				<th field="accntCode" width="90px">客户编码</th>
				<th field="accntName" defaultSearch="true" width="90px">客户名称</th>
				<th field="prodCode" width="90px">产品编码</th>
				<th field="prodName" width="90px">产品名称</th>
				<th field="qty" width="60px">数量</th>
				<th field="type" width="90px">类型</th>
				<th field="status" width="70px" lov="IMP_STATUS">状态</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	getLovOfList("[IMP_STATUS]");
	$datagrid = $('#inv-imp-table');
	$datagrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		oauthFlag:true,
		striped : true,
		border : false,
		url : '${AppContext.ctxPath}/action/portal/invImp/querySuccessListPage'
	});
	
	function titleFormatter(val,row){
	     if(val != null){
	        var content = '';
	        var content = val.replace(/\\n/g,'\n');
	        var val = val.replace(/\\n/g,'; ');
	     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
	     }
	}
	/* $('#invimp-type-keyfilter').keyFilter({
		remoteData:true,
		filterByValue:true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/IMP_STATUS'
    }); */
	$('#invimp-type-keyfilter').keyFilter();
		
	</script>
</body>
</html>