<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.common.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script> 
<script src="${AppContext.ctxPath}/static/js/mask.js"></script>
<body>
   	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<div id="account-table-toolbar">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				搜索条件:
			    <input class="easyui-combobox" style="width:100px" url="/portal/json/deliveryOrder.json" valueField="id" textField="text"/> 
			    <input style="width: 200px;" type="text" class="easyui-textbox" />
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#account-table').datagrid('doSearch')">查询</a> 
				<a href="javascript:void(0)" id="btn_inport" class="easyui-linkbutton" style="" iconCls="icon-table-add" plain="true" onclick="importParamsPicklist('account-table','${AppContext.ctxPath}/action/portal/account/uploadExcel','')">导入</a>
			</div>
			
			<table id="account-table" width="100%" height="100%" singleSelect="true" rownumbers="true" toolbar="#account-table-toolbar" pagination="true">
				<thead>
					<tr>
						<th field="acctId" width="80px">客户编码</th>
						<th field="acctAgencyName" width="80px">客户名称</th>
						<th field="acctName" width="80px" >法人联系人</th>
						<th field="acctType" width="80px" >客户类型</th>
						<th field="acctGroup" width="80px" >科目组</th>
						<th field="country" width="80px" >国家</th>
						<th field="province" width="80px" >省</th>
						<th field="city" width="80px" >市</th>
						<th field="district" width="80px" >区/县</th>
						<th field="town" width="80px" >乡镇</th>
						<th field="acctStatus" width="80px" >客户状态</th>
						<th field="buildDate" width="80px" >签约日期</th>
						<th field="withdrawDate" width="80px" >撤点日期</th>
						<th field="mobilePhone" width="80px" >移动电话</th>
						<th field="fixedPhone" width="80px" >固定电话</th>
						<th field="gender" width="80px" >性别</th>
						<th field="idNumber" width="80px" >身份证</th>
						<th field="searchItem" width="80px" >搜索项</th>	
						<th field="comments" width="80px" >备注</th>
						<th field="mainBusiness" width="80px" >主营业务</th>
						<th field="accountBankName" width="80px" >开户行名称</th>
						<th field="regTaxNum" width="80px" >银行账户</th>
						<th field="taxpayerNumber" width="80px" >纳税人识别号</th>	
						<th field="billPhone" width="80px" >开票电话</th>
						<th field="billAddr" width="80px" >开票地址</th>
						<th field="lithiumCode" width="80px" >客户锂电代码</th>
						<th field="prodLineId" width="80px" >售后基地ID</th>
						<th field="wareId" width="80px" >中转仓库</th>
						<th field="tubularCode" width="80px" >客户管式代码</th>
						<th field="tubular2vDeadline" width="80px" >管式2V换新期</th>	
						<th field="licByCmp" width="80px" >公司承运物流</th>
						<th field="wechatNum" width="80px" >微信号</th>
						<th field="qqNum" width="80px" >QQ号</th>	
						<th field="coordinate" width="80px" >坐标信息</th>

					</tr>
				</thead>
			</table>
		</div>
		
	</div>
   	
		
	<script type="text/javascript">
	        var pickSelectedRow = undefined;
	        var id = undefined;
			$datagrid = $('#account-table');
			var dataGridSelectIndex = undefined;
			$datagrid.datagrid({
					striped:true,
					title:'客户导入',
					pageSize: 20,//每页显示的记录条数，默认为20 
					pageList: [20,30,50],//可以设置每页记录条数的列表 
					width:$(window).width(),
					border:false,
					url:'${AppContext.ctxPath}/action/portal/account/listOfImport',
					onLoadSuccess:function(data){
						if(data.rows.length > 0){
							$datagrid.datagrid('selectRow', 0);
						}
				    }
			});
			
			
			
	</script>
</body>
</html>