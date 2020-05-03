<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
fieldset{
	margin:10px 10px;
	border:1px solid #acacac;
}

fieldset .textbox{
	border-color:#acacac;
	border-radius:0px;
}

/* -- td css start -- */
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
	width:120px;
}
.td-input{
	width:160px;
	padding-left: 10px;
}
/* -- td css end -- */

.td-input-input{
	width:150px;
}
</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false" style="width: 100%; height: 100%; padding: 0px;">
    <div data-options="region:'center'" collapsible="false" title="" border="false" style="width:100%;height:97%;padding:0px;">
	  <div  data-options="fit:true" style="width:100%;padding:1px;"> 
	    <fieldset>
			<legend>价格表信息</legend>
		<form id="priceListForm" method="post">
			<table style="width:100%;">
				<tr>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>名称：</label></td>
								<td class="td-input">
								    <input hidden="true" name="id" id="id" display="none"/>
								    <input class="easyui-textbox td-input-input"  disabled="disabled" name="priceListName" id="priceListName"  data-options="required:true"/> 
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>是否激活 :</label></td>
								<td class="td-input">
				         			<input id="activated" disabled="disabled" name="activated" class="easyui-textbox td-input-input"/>												
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>有效期开始时间：</label></td>
								<td class="td-input">
								    <input class="easyui-datetimebox td-input-input"  disabled="disabled" name="effStartDate" id="effStartDate" value="${notices.release_time}"/> 
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>有效期结束时间：</label></td>
								<td class="td-input">
								    <input class="easyui-datetimebox td-input-input"  disabled="disabled" name="effEndDate" id="effEndDate"/> 
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>组织：</label></td>
								<td class="td-input">
									<input name="orgId" id="orgId" hidden="true"/> 
								    <input class="easyui-textbox td-input-input"  disabled="disabled" name="orgName" id="orgName"  lov="ACTIVATED"  disabled="disabled"/> 
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>说明：</label></td>
								<td class="td-input">
									<textarea rows="5"disabled="disabled"  name="comments" id="comments" style="width:150px;"></textarea>								   
								</td>
							</tr>
							<tr></tr>
						</table>
					</td>
				</tr>
		 	</table>
		 </form>
 		 <div style="width:100%;height:30px;padding:0px;margin-top:10px;" margin-bottom:10px;">
			<a href="javascript:void(0)" id="btn_back" class="easyui-linkbutton" iconCls="icon-undo" 
					plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="goBack()">返回</a><!-- 
		    <a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
		    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="savePriceListInfo()">保存</a> -->
		 </div> 
		 </fieldset>
	 	</div>
	 	<div data-options="region:'center',split:true" border="false" style="width:100%;height:70%">
			<table id="priceListInfo-table"  data-options="fit:true">
				<thead>
					<th field="prodName" width="200px">产品名称</th>
					<th field="prodCode" width="200px" >产品编码</th>
					<th field="price" width="100px" currency="CNY" >原价</th>
					<th field="promoPrice" width="100px" currency="CNY">促销价</th>
				    <th field="effStartDate" width="180px" sortable="true">有效开始时间</th>
				    <th field="effEndDate" width="180px" sortable="true">有效结束时间</th>
					<th field="comments" width="300px" sortable="true">说明</th>
				</thead>
			</table>				
 	</div>
 	</div>
 	
 	
	<script type="text/javascript">
		var existRecord = false;
		var priceListId = getUrlParams("id");
		var agrId = "noMatchSelect";
		var activated = ""
		
		$headerForm = $("#priceListForm");   //头表单
		$dataPriceListgrid = $("#priceListInfo-table");     //价格表行项目

		
		//页面元素加载完成事件
		$(document).ready(function(){
			priceListInfoInit();
		});
		
		
		//头表单及信息初始化
		function priceListInfoInit(){
			$.post("${AppContext.ctxPath}/action/portal/priceList/queryById", {
				id : priceListId
			}, function(data) {
				if (data.success) {
					var record = data.result;
					activated = record.activated;
					$('#priceListForm').form("load", record);
				} else {
					$.messager.alert("提示", data.result);
				}
			});
			
		};	

			function goBack(){
				gotoContentPage("${AppContext.ctxPath}/portal/product/PriceList.jsp");
			};
			
		 	/**
			 * 价格表行项目
			 */	
				$dataPriceListgrid.hdatagrid({
					toolbarShow:true,
					buttonSearch:true,
					buttonExport:true,
					striped:true,
					border:false,
					title:'价格表行项目',
					url:'${AppContext.ctxPath}/action/portal/priceListItem/queryByExamplePage',
					onBeforeLoad:function(param){
						param.headId = priceListId;
					}
			 	}); 	
		 	   
				
			 	/**
				 * 产品picklist回调事件
				 */
			 	function prodPickListComplete(selectRow){
			 		$dataPriceListgrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
			 		$dataPriceListgrid.hdatagrid('getCurrentRow').prodCode = selectRow.prodCode;
					$prodCode.textbox('setValue',selectRow.prodCode);
					//alert(selectRow.prodCode);
			 		return selectRow.prodName;
			 	}; 
 
 
	</script>	
 	
</body>