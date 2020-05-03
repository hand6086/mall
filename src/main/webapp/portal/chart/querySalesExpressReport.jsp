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
				<form method="post" id="querySalesExpressReport" action="/action/portal/chart/querySalesExpressReport">
					<br/>
					<table class="form-table">
						<tr>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>开始日期 :</label></td>
										<td class="td-content">
											<input required="required"   class="easyui-datebox" id="DATE_FROM" name="DATE_FROM" />
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>结束日期 :</label></td>
										<td class="td-content">
											<input  required="required"    class="easyui-datebox" id="DATE_TO" name="DATE_TO" />
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
										<td class="td-label"><label>开始日期 -小时:</label></td>
										<td class="td-content">
											<input required="required"  value="00"   list="itemlist"  id="START_HOUR" name="START_HOUR" />
											<datalist id="itemlist">
													<option>00</option>
												    <option>01</option>
												    <option>02</option>
												    <option>03</option>
												    <option>04</option>
												    <option>05</option>
												    <option>06</option>
												    <option>07</option>
												    <option>08</option>
												    <option>09</option>
												    <option>10</option>
												    <option>11</option>
												    <option>12</option>
												    <option>13</option>
												    <option>14</option>
												    <option>15</option>
												    <option>16</option>
												    <option>17</option>
												    <option>18</option>
												    <option>19</option>
												    <option>20</option>
												    <option>21</option>
												    <option>22</option>
												    <option>23</option>
												    
												   
											</datalist>  
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>结束日期-小时 :</label></td>
										<td class="td-content">
											<input  required="required" value='00'  list="itemlist" id="END_HOUR" name="END_HOUR" />
											<datalist id="itemlist">
													<option>00</option>
												    <option>01</option>
												    <option>02</option>
												    <option>03</option>
												    <option>04</option>
												    <option>05</option>
												    <option>06</option>
												    <option>07</option>
												    <option>08</option>
												    <option>09</option>
												    <option>10</option>
												    <option>11</option>
												    <option>12</option>
												    <option>13</option>
												    <option>14</option>
												    <option>15</option>
												    <option>16</option>
												    <option>17</option>
												    <option>18</option>
												    <option>19</option>
												    <option>20</option>
												    <option>21</option>
												    <option>22</option>
												    <option>23</option>
											</datalist>  
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
$("#START_HOUR").click(function(){
    $("#START_HOUR").val("");
});
$("#END_HOUR").click(function(){
    $("#END_HOUR").val("");
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
	 $('#querySalesExpressReport').submit(); 

}
</script>
</body>
</html>