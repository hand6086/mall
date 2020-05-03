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
					<input type="hidden" name="SalesJournalReport" id="reportKey">
					<input type="hidden" name="销量日报" id="reportName">
				
				</form>
				
				<div style="float: right; margin-top: 100px; margin-right: 100px; margin-bottom: 20px;">
					<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="">重置&nbsp;&nbsp;&nbsp;</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="###" class="easyui-linkbutton" iconCls="icon-page-white-excel" onclick="thisFormSubmit()">导出&nbsp;&nbsp;&nbsp;</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a
						href="###" class="easyui-linkbutton"
						iconCls="icon-detail" onclick="repoertShowNow()">实时查看&nbsp;&nbsp;&nbsp;</a> 
				</div>

			</div>
			
		</div>
	</div>
<script type="text/javascript">

$STATUS_ZB = $('#STATUS_ZB');
$DATE_FROM=$('#DATE_FROM');

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
	 
	 /* $('#querySalesJournalReport').submit();  */

}


function repoertShowNow(){
    var cityId=  $("#O2O_CITY_ID").val();
	var DATE_FROM=$("#DATE_FROM").datebox("getValue");
	var DATE_TO=$("#DATE_TO").datebox("getValue");
	var reportKey=$("#reportKey").attr("name");
	var reportName=$("#reportName").attr("name");
	
	var array = new Array();
	if(cityId=null){
		cityId='';
	}
	array[0] ="cityId;"+cityId ;
	array[1]="dateForm;"+DATE_FROM;
	array[2]="dateTo;"+DATE_TO;
	array[3]="reportKey;"+reportKey;
	array[4]="reportName;"+reportName;
 	$.ajax({  
	    type : 'POST',  
	    url: '/action/portal/chartsParam/repotInert',  
	    contentType : "application/json" ,
	    data : JSON.stringify(array), 
	    success : function(data) {  

	    }  
	});  
	 alert(reportName);
	  alert(reportKey);
	  alert(O2O_CITY_ID);

	
}
</script>
</body>
</html>