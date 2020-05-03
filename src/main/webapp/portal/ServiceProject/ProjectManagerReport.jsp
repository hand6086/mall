<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%-- <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.hdatagrid.js"></script> 
<!-- <script src="${AppContext.ctxPath}/static/js/echarts.min.js"></script>  -->
<script type="text/javascript" src="${AppContext.ctxPath}/static/js/ichart.latest.min.js"></script>
<script src="${AppContext.ctxPath}/static/js/main.js"></script> --%>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<style type="text/css">
#report{
	width: 100%;
	text-align:center;
}
#bottomDiv{
	width: 100%;
	line-height:30px;
}
.showTableDiv{
	vertical-align: middle;
	padding-left: 20px;
    padding-right: 20px;
    width: auto;
    overflow: auto;
}

.titleTr{
	background-color: rgb(70, 156, 231);
	/* background-color: rgb(239, 240, 241); */
}

.titleTd{
	border:solid #999; 
	/* border-width:0px 1px 1px 0px;  */
	border-width:1px 1px 1px 1px;
	padding:10px;
	font-size: 10px;
    color: #ffffff;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 400;
    text-align: center;
  
}

#ProjectReport-table{
	/* border:solid #add9c0; */
	border:solid #999;
	/* border-width:1px 0px 0px 1px; */
	border-width: 0px 0px 0px 0px;
	line-height: 16px;
	border-collapse: collapse;
	margin: auto;
    position: relative;
}

.conTr{

}

.conTd{
	border:solid #999; 
	/* border-width:0px 1px 1px 0px;  */
	border-width:1px 1px 1px 1px;
	padding:3px 0px;
	font-size: 10px;
    /* color: #469ce7; */
    color: #000000;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 200;
    text-align: center;
    /* padding-right: 3px; */
}

.conTdTitle{
	border:solid #999; 
	/* border-width:0px 1px 1px 0px;  */
	border-width:1px 1px 1px 1px;
	padding:3px 0px;
	font-size: 10px;
    color: #000000;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 200;
    text-align: left;
    /* width: 80px; */
}
</style>
<body>
  <div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false"
		style="width: 100%;" fit="true">
		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">快速筛选</span>
			</legend>

			<div class="row keyfilter-border">
				<ul id="attr02Keyfilter" data-toggle="keyfilter" data-title="项目名称"
					data-filter-filed="attr02" data-table-Id="ProjectReport-table"></ul>
			</div> 

			<!-- <div class="row keyfilter-border">
				<ul id="statusKeyfilter" data-toggle="keyfilter" data-title="筛选条件"
					data-filter-filed="reportType" data-table-Id="ProjectReport-table"></ul>
			</div> -->
			<div class="row keyfilter-border">
				<ul id="priorityLevelKeyfilter" data-toggle="keyfilter"
					data-title="优先级" data-filter-filed="priorityLevel"
					data-table-Id="ProjectReport-table"></ul>
			</div>
			
			<div class="row keyfilter-border">
				<ul id="severityLevelKeyfilter" data-toggle="keyfilter"
					data-title="严重性" data-filter-filed="severityLevel"
					data-table-Id="ProjectReport-table"></ul>
			</div>

		</fieldset>

		<br/>
	
		<div id="report"></div>
		<div id="bottomDiv">&nbsp;</div>
	</div>
  </div>
<script type="text/javascript">
	$('#attr02Keyfilter').keyFilter({
		remoteData : true,
		filterByValue : true,
		dataValue:'id',
		dataName:'projName',
		remoteUrl : '${AppContext.ctxPath}/action/portal/project/projectlistvalbyuser',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/ServiceProject/queryProjStatusReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		tableId: 'ProjectReport-table'
	});
	
	$('#priorityLevelKeyfilter').keyFilter({
		remoteData : true,
		filterByValue : true,
		remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/SER_PRIORITY_LEVEL',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/ServiceProject/queryProjStatusReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		tableId: 'ProjectReport-table'
	});
	
	$('#severityLevelKeyfilter').keyFilter({
		remoteData : true,
		filterByValue : true,
		remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/SER_SEVERITY_LEVEL',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/ServiceProject/queryProjStatusReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		tableId: 'ProjectReport-table'
	});
	
	var row1 = {name: '项目状态', value: 'status'};
	var row2 = {name: '项目优先级', value: 'priority'};
	var row3 = {name: '项目严重性', value: 'severity'};
	var data = [];
	data.push(row1);
	data.push(row2);
	data.push(row3);
	/* $('#statusKeyfilter').keyFilter({
		remoteData : false,
		filterByValue : true,
		filterList : data,
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/ServiceProject/queryProjReport',
		tableId: 'ProjectReport-table'
	}); */
	 
	$.ajax({
	     url:'${AppContext.ctxPath}/action/portal/ServiceProject/queryProjStatusReport',
	     type:"post",
	     data:{	
	    	 "usercorpid":appCtx.corpId,
	    	 "oauthFlag":true,
	    	 "oauth":top.oauth 
	     },
	     dataType:"json",
	     success:function(data){
	      if (data.success){
	         $('#report').html(data.html);
	         $('#ProjectReport-table').before('<div style="margin-right: 100px; margin-top: 0px;margin-bottom: 5px;margin-left:80%;">'+
						'<a id="downloadReport" href="###" class="easyui-linkbutton" onclick="exportReport(\'ProjectReport-table\',\'项目进度报表\',\'项目进度报表\')">&nbsp;&nbsp;导出报表&nbsp;&nbsp;</a>'+ 
						'</div>');
	         
	      }
	        	
	    }
	 });
	
	var idTmr;
	function exportReport(tableid,name,fileName){
		if(getExplorer() == 'ie'){  
			fileName = fileName + ".xlsx";
			var curTbl = document.getElementById(tableid);  
               var oXL = new ActiveXObject("Excel.Application");  
               var oWB = oXL.Workbooks.Add();  
               var xlsheet = oWB.Worksheets(1);  
               var sel = document.body.createTextRange();  
               sel.moveToElementText(curTbl);  
               sel.select();  
               sel.execCommand("Copy");  
               xlsheet.Paste();  
               oXL.Visible = true;  
 
               try {  
                   var fname = oXL.Application.GetSaveAsFilename(fileName, "Excel Spreadsheets (*.xlsx), *.xlsx");  
               } catch (e) {  
                   print("Nested catch caught " + e);  
               } finally {  
                   oWB.SaveAs(fname);  
                   oWB.Close(savechanges = false);  
                   oXL.Quit();  
                   oXL = null;  
                   idTmr = window.setInterval("Cleanup();", 1);  
               } 
           }
		else{
			fileName = fileName + ".xls";
			tableToExcel(tableid,name,fileName,getExplorer());
			/* tableToExcelP(tableid,name,fileName); */
		}
		
	}
	
	function  getExplorer() {  
           var explorer = window.navigator.userAgent ;  
           //ie  
           if (explorer.indexOf("MSIE") >= 0) {  
               return 'ie';  
           }  
           //firefox  
           else if (explorer.indexOf("Firefox") >= 0) {  
               return 'Firefox';  
           }  
           //Chrome  
           else if(explorer.indexOf("Chrome") >= 0){  
               return 'Chrome';  
           }  
           //Opera  
           else if(explorer.indexOf("Opera") >= 0){  
               return 'Opera';  
           }  
           //Safari  
           else if(explorer.indexOf("Safari") >= 0){  
               return 'Safari';  
           }  
       }
	
	function Cleanup(){  
           window.clearInterval(idTmr);  
           CollectGarbage();  
       }
	
	var tableToExcel = (function() {  
		var uri = 'data:application/vnd.ms-excel;base64,',  
		   template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table border="1">{table}</table></body></html>',
           //template = '<html><head><meta charset="UTF-8"></head><body><table border="1">{table}</table></body></html>',  
           base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },  
           format = function(s, c) {  
               return s.replace(/{(\w+)}/g,  
                       function(m, p) { return c[p]; }) }  
	    return function(table, name, filename,explorer) {  
	        if (!table.nodeType){table = document.getElementById(table)}
	        var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML};
	        //window.location.href = uri + base64(format(template, ctx));
	        if (explorer == 'Chrome'){
		        var a = document.createElement("a");
				a.download = filename;
				a.href = uri + base64(format(template, ctx));
				a.click();
			}else{
				//window.location.href = uri + base64(format(template, ctx));
				document.getElementById("downloadReport").href = uri + base64(format(template, ctx));
	            document.getElementById("downloadReport").download = filename;
	            document.getElementById("downloadReport").click();
			}
	    }
       })(jQuery, window, document);
       /* function tableToExcelP(tableid,name,filename){
		$("#"+tableid).table2excel({
            exclude: ".noExl",
            name: name,
            filename: filename,
            exclude_img: true,
            exclude_links: true,
            exclude_inputs: true
        });
	} */
</script>

</body>

</html>