<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<style type="text/css">
.form-table {
	margin: 5px auto;
	width: 100%;
}

.td-label {
	width: 180px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}

.td-content input {
	width: 162px;
}
</style>

<body>
	<div  class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
   <fieldset class="x-fieldset" id="pageStatisticalKeyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>
		<div class="row keyfilter-border">
	   		<table class="form-table">
			    <tr>
			    	<td class="td-label"><label>选择类型：</label></td>
						<td class="td-input">
						<input  class="easyui-combobox" name="chooseType" type="text" id="chooseType" size="25" />
					</td>
					<td class="td-label"><label>开始时间：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="startTime" type="text" id="startTime" size="25" />
					</td>
					
					<td class="td-label"><label>结束时间：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="endTime" type="text" id="endTime" size="25" />
					</td>
				</tr>
				<tr>
					<td class="td-label"><label>页面名称 ：</label></td>
					<td class="td-content">
						<input type="text" id="pageName" name="pageName" />
					</td>
					<td class="td-label"><label>城市 ：</label></td>
					<td class="td-content">
						<input type="text" id="city" name="city" />
					</td>
					<td class="td-label"><label>省份：</label></td>
					<td class="td-content">
						<input type="text" id="province" name="province" />
					</td>
				</tr>
	   		</table>
	   	</div>
	</fieldset>
   <table id="page-statistucal-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="pageStatisticalKeyFilter">
		<thead>
			<tr>
				<th field="pageName" width="200px">页面名称</th>
				<th field="pV" width="100px">页面访问量</th>
				<th field="uV" width="100px">去重页面访问量</th>
				<th field="city" width="100px">城市</th>
				<th field="province" width="100px">省份</th>
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
		var city = null;
		var province = null;
		var chooseType = '快购';
		var pageName = null;
		 $(function()  
			   		{     
			   		    $('#startTime').datetimebox('setValue',startDate);
			   		    $('#endTime').datetimebox('setValue',endDate);

			   			startTime = $('#startTime').datetimebox('getValue');
					   	endTime = $('#endTime').datetimebox('getValue');
			   		});
	
	    $datagrid = $('#page-statistucal-table');
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
			oauthFlag:false, //安全性
			striped:true,
			nowrap:false, //换行
			border:false,
			url:'${AppContext.ctxPath}/action/portal/pageStatisticalAnalysis/queryByExamplePage',
			
			onBeforeLoad:function(param){
				if(startTime != null && startTime != ''){
		    		param.startTime = startTime;
				}
				if(endTime != null && endTime != ''){
		    		param.endTime = endTime;
				}
				if(pageName !=null && pageName !=''){
					param.pageName = pageName;
				}
				if(city != null && city != ''){
		    		param.city = city;
				}
				if(province != null && province != ''){
		    		param.province = province;
				}
				if(chooseType != null && chooseType != ''){
		    		param.chooseType = chooseType;
				}
			},
			
 			 onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="pageStatisticalKeyFilterSearch()" iconCls="icon-search" plain="true">查询</a>',that);
 				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="pageStatisticalKeyFilterClean()" iconCls="icon-reload" plain="true">重置</a>',that);
 			 } 
		});
		
		$('#chooseType').combobox({ 
			method:'get',
			data:getLovArray('CHANNEL_TYPE'),
			valueField:'name',
			textField:'name',
			panelHeight: 'auto',
			value:'快购',
		    cache: false
		});
		
		function pageStatisticalKeyFilterSearch(){
			
		   	startTime = $('#startTime').datetimebox('getValue');
		   	endTime = $('#endTime').datetimebox('getValue');
		   	pageName = $("#pageName").val();
		   	city = $("#city").val();
		   	chooseType = $("#chooseType").combobox('getValue');
		   	province = $("#province").val();
		   	
		   	$datagrid.datagrid('reload');
		}
		
		function pageStatisticalKeyFilterClean(){
			
			   $('#chooseType').combobox('setValue','快购');
			   $('#pageName').val('');
			   $('#city').val('');
			   $('#province').val('');
			   
			   pageName = null;
			   city = null;
			   province = null;
			   chooseType = '快购';
			   
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