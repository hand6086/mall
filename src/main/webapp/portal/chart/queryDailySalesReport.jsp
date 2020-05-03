<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
fieldset{
	margin: 0px auto;
	width:300px;
}
fieldset legend{
	font-size: 16px;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:100%" title="报表参数">
				<form method="post" id="querySalesJournalReport" action="/action/portal/chart/queryDailySalesReport">
					<br/>
					<table class="form-table">
						<tr>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>开始日期 :</label></td>
										<td class="td-content">
											<input required="true" class="easyui-datebox" id="DATE_FROM" name="DATE_FROM" />
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>结束日期 :</label></td>
										<td class="td-content">
											<input  required="true"  class="easyui-datebox" id="DATE_TO" name="DATE_TO" />
										</td>
									</tr>
								</table>
							</td>
							<td width="300px;">
								<table class="table-block" >
									<tr>
										<td class="td-label"><label></label></td>
										<td class="td-content">
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>城市 :</label></td>
										<td class="td-content">
											<input type="text" id="O2O_CITY" name="O2O_CITY" />
										</td>
									</tr>
								</table>
							</td>
							<td>
								
							</td>
							<td width="300px;">
								<table class="table-block" >
									<tr>
										<td class="td-label"><label></label></td>
										<td class="td-content">
											
										</td>
									</tr>
								</table>
							</td>
							
							
						</tr>
					</table>
					
					<input type="hidden" name="O2O_CITY_ID" id="O2O_CITY_ID">
				
				</form>
				
				<div style="float: right; margin-top: 100px; margin-right: 100px; margin-bottom: 20px;">
					<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="">重置&nbsp;&nbsp;&nbsp;</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="###" class="easyui-linkbutton" iconCls="icon-page-white-excel" onclick="thisFormSubmit()">导出&nbsp;&nbsp;&nbsp;</a> 
				</div>

			</div>
			
		</div>
	</div>
<script type="text/javascript">

$STATUS_ZB = $('#STATUS_ZB');
$DATE_FROM=$('#DATE_FROM');
//得到当前日期
formatterEndDate = function(date) {
var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
+ (date.getMonth() + 1);
return date.getFullYear() + '-' + month + '-' + day;
};
formatterStartDate = function(date) {
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	month=month-1;
	return date.getFullYear() + '-' + month + '-' + day;
	};

window.onload = function () { 
	$('#DATE_TO').datebox('setValue', formatterEndDate(new Date()));
	$('#DATE_FROM').datebox('setValue', formatterStartDate(new Date()));
	}
$O2O_CITYPicklist = $('#O2O_CITY');
$O2O_CITYPicklist.picklist({
	title:'选择城市',
	tableUrl:'/portal/picklist/Tbo2oDistrictPickList.jsp',
	/* required:true, */
	completeFun:function (selectRow){
		$('#O2O_CITY_ID').val(selectRow.id);
		return selectRow.name;
	}
});

function thisFormSubmit(){
	var DATE_FROM=$("#DATE_FROM").datebox("getValue");
	var DATE_TO=$("#DATE_TO").datebox("getValue");
	var d1 = new Date(DATE_FROM.replace(/\-/g, "\/"));  
	 var d2 = new Date(DATE_TO.replace(/\-/g, "\/"));  

	  if(DATE_FROM!=""&&DATE_TO!=""&&d1 >=d2)  
	 {  
	  alert("开始时间不能大于结束时间！");  
	  return false;  
	 }
	 $('#querySalesJournalReport').submit(); 

}
</script>
</body>
</html>