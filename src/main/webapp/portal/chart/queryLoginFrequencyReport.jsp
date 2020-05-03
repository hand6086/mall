<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css" >
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:180px;
}
</style>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
<body>
	<div  class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
   <fieldset class="x-fieldset" id="goodsKeyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>
		<div class="row keyfilter-border">
	   		<table class="form-table">
			    <tr>	
					<td class="td-label"><label>开始时间：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="startTime" type="text" id="startTime" size="25" />
					</td>
					
					<td class="td-label"><label>结束时间：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="endTime" type="text" id="endTime" size="25" />
					</td>
				</tr>
	   		</table>
	   	</div>
	</fieldset>
   <table id="brand-goods-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="goodsKeyFilter">
		<thead>
			<tr>
				<th field="name" width="100px">用户</th>
				<th field="phoneNumber" width="100px">手机号</th>
				<th field="count" width="100px">登录频次</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
   
	<script type="text/javascript">
		var curr_time=Math.round(new Date()/1000);
		
		var startDate = timestampToTime(curr_time - 60*60);
		var endDate = timestampToTime(curr_time);
	
		var startTime = startDate;
		var endTime = endDate;
		
		$(function(){     
		   		    $('#startTime').datetimebox('setValue',startDate);
		   		    $('#endTime').datetimebox('setValue',endDate);
		
		   			startTime = $('#startTime').datetimebox('getValue');
				   	endTime = $('#endTime').datetimebox('getValue');
		   		});
		
	    $datagrid = $('#brand-goods-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:false,
			buttonNew:false,
			buttonDelete:false,
			buttonExport:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			nowrap:false,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/loginfrequeny/queryByExamplePage',
			onBeforeLoad:function(param){
				
				if(startTime != null && startTime != ''){
		    		param.startTime = startTime;
				}
				if(endTime != null && endTime != ''){
		    		param.endTime = endTime;
				}
			},
			
			
 			 onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="paramSearch()" iconCls="icon-search" plain="true">查询</a>',that);
			} 
		});
		
		
		function paramSearch(){
		   	startTime = $('#startTime').datetimebox('getValue');
		   	endTime = $('#endTime').datetimebox('getValue');
		   	$datagrid.datagrid('reload');
		}
		
		function timestampToTime(timestamp) {
	        var date = new Date(timestamp * 1000);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
	        Y = date.getFullYear() + '-';
	        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
	        D = date.getDate() + ' ';
	        h = date.getHours() + ':';
	        m = date.getMinutes() + ':';
	        s = date.getSeconds();
	        return Y+M+D+h+m+s;
	    }
	</script>
</body>
</html>