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
				<form method="post" id="queryPanelCountReport" action="/action/portal/chart/queryPanelCountReport">
					
					<table class="form-table">
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
	 $('#queryPanelCountReport').submit(); 

}
</script>
</body>
</html>