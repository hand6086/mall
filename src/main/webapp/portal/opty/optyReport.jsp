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

#OptyReport-table{
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
#tdDetailContent{
	width:250px;
}
#tdDetailTitle{
	width:250px;
}
.detailContent{
	margin:2px 0px 2px 0px; 
}
.empDetail{
	margin:2px 0px 2px 0px; 
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

			<!-- <div class="row keyfilter-border">
				<ul id="optyStatus" data-toggle="keyfilter" 
					data-title="商机状态" data-filter-filed="status" 
					data-table-Id="OptyReport-table"></ul>
			</div>  -->
			
			<div class="row keyfilter-border">
				<ul id="optyStage" data-toggle="keyfilter" 
					data-title="商机阶段" data-filter-filed="stage" 
					data-table-Id="OptyReport-table"></ul>
			</div> 
	
			<div class="row keyfilter-border">
				<ul id="optySuccessRate" data-toggle="keyfilter"
					data-title="成交概率" data-filter-filed="rate"
					data-table-Id="OptyReport-table"></ul>
			</div>
			
			<div class="row keyfilter-border">
				<ul id="businessGroup" data-toggle="keyfilter"
					data-title="所属组别" data-filter-filed="managerOrgId"
					data-table-Id="OptyReport-table"></ul>
			</div>
			
			<div class="row keyfilter-border">
			<ul id="optyYear" data-toggle="keyfilter"
				data-title="所属年份" data-filter-filed="optyYear"
				data-table-Id="OptyReport-table">
			</ul>
		</div>

		</fieldset>

		<br/>
	
		<div id="report"></div>
		<div id="bottomDiv">&nbsp;</div>
	</div>
  </div>
<script type="text/javascript">
	$('#optyStage').keyFilter({
		remoteData : true,
		filterByValue : true,
		remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/OPTY_STAGE',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/opty/queryOptyReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		userDefined:true,
		userDefinedFunction:function(data){
			successFun(data);
		},
		tableId: 'OptyReport-table'
	});

	/* $('#optyStatus').keyFilter({
		remoteData : true,
		filterByValue : true,
		remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/OPTY_STATUS',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/opty/queryOptyReport',
		userDefined:true,
		userDefinedFunction:function(data){
			successFun(data);
		},
		tableId: 'OptyReport-table'
	}); */
	
	$('#optySuccessRate').keyFilter({
		remoteData : true,
		filterByValue : true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_SUCCESS_RATE',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/opty/queryOptyReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		userDefined:true,
		userDefinedFunction:function(data){
			successFun(data);
		},
		tableId: 'OptyReport-table'
	});
	
	$('#businessGroup').keyFilter({
		remoteData : true,
		filterByValue : true,
		dataValue:'managerOrgId',
		dataName:'managerOrgName',
		remoteUrl:'${AppContext.ctxPath}/action/portal/opty/queryOptyReportOrg',
		//remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/CRM_BU',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/opty/queryOptyReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		userDefined:true,
		userDefinedFunction:function(data){
			successFun(data);
		},
		tableId: 'OptyReport-table'
	});
	
	$('#optyYear').keyFilter({
		remoteData:true,
		filterByValue:true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/workplan/list/YEAR',
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/opty/queryOptyReport',
		data:{"oauthFlag":true,"oauth":top.oauth},
		userDefined:true,
		userDefinedFunction:function(data){
			successFun(data);
		},
		tableId: 'OptyReport-table'
 	});
	/* var row1 = {name: '状态', value: 'status'};
	var row2 = {name: '类型', value: 'type'};
	var row3 = {name: '阶段', value: 'stage'};
	var data = [];
	data.push(row1);
	data.push(row2);
	data.push(row3);
	$('#statusKeyfilter').keyFilter({
		remoteData : false,
		filterByValue : true,
		filterList : data,
		dataReport:true,
		dataReportUrl:'${AppContext.ctxPath}/action/portal/ServiceProject/queryProjReport',
		tableId: 'ProjectReport-table'
	}); */
	//alert('安全性：'+top.oauth);
	$.ajax({
	     url:'${AppContext.ctxPath}/action/portal/opty/queryOptyReport',
	     type:"post",
	     data:{
	    	 	"usercorpid":appCtx.corpId,
	    	 	"oauthFlag":true,
	    	 	"oauth":top.oauth
	    	  },
	     dataType:"json",
	     success:function(data){
	      if (data.success){
	         /* $('#report').html(data.html);
	         togetherCol('OptyReport-table',0,0,0); 
	         $('#OptyReport-table').before('<div style="margin-right: 100px; margin-top: 0px;margin-bottom: 5px;margin-left:80%;">'+
						'<a id="downloadReport" href="###" class="easyui-linkbutton" onclick="exportReport(\'OptyReport-table\',\'商机报表\',\'商机报表\')">&nbsp;&nbsp;导出报表&nbsp;&nbsp;</a>'+ 
						'</div>'); */
			 successFun(data);
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
           else if(explorer.indexOf("Edge")>-1 || explorer.indexOf("Trident/7.0") > -1){
        	   return "ie";
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
	/* 
	function togetherCol(tableId, startRow, endRow, col) { 
		var tb = document.getElementById(tableId); 
		if (col >= tb.rows[0].cells.length) { 
			return; 
		} 
		if (col == 0) { 
			endRow = tb.rows.length - 1; 
		} 
		for (var i = startRow; i < endRow; i++) { 
			if (tb.rows[startRow].cells[col].innerHTML == tb.rows[i + 1].cells[0].innerHTML) { 
				tb.rows[i + 1].removeChild(tb.rows[i + 1].cells[0]); 
				tb.rows[startRow].cells[col].rowSpan = (tb.rows[startRow].cells[col].rowSpan | 0) + 1; 
				if (i == endRow - 1 && startRow != endRow) { 
					togetherCol(tableId, startRow, endRow, col + 1); 
				} 
			} else { 
				//startRow = i + 1; 
				togetherCol(tableId, startRow, i + 0, col + 1); 
				startRow = i + 1; 
			} 
		} 
	} 
	 */
	function togetherTableCol(tableId, col) {  
        var tableFirstTd = "";  
        var tableCurrentTd = "";  
        var tableSpanNum = 0;  
        var tableObject = $(tableId + " tr td:nth-child("  + col + ")");  
        tableObject.each(function (i) {tableObject
            if (i == 0) {  
                tableFirstTd = $(this);  
                tableSpanNum = 1;  
            } else {  
                tableCurrentTd = $(this);  
                if (tableFirstTd.text() == tableCurrentTd.text()) {
                    tableSpanNum++;  
                    tableCurrentTd.remove();//hide(); //remove();  
                    tableFirstTd.attr("rowSpan", tableSpanNum);  
                } else {  
                    tableFirstTd = $(this);  
                    tableSpanNum = 1;  
                }  
            }  
        });  
    }  
	
	function successFun(data){
		$('#report').html(data.html);
		togetherTableCol('#OptyReport-table',2);
		togetherTableCol('#OptyReport-table',1);
        $('#OptyReport-table').before('<div style="margin-right: 100px; margin-top: 0px;margin-bottom: 5px;margin-left:80%;">'+
					'<a id="downloadReport" href="javascript:void(0)" class="easyui-linkbutton" onclick="exportReport(\'OptyReport-table\',\'商机报表\',\'商机报表\')">&nbsp;&nbsp;导出报表&nbsp;&nbsp;</a>'+ 
					'</div>');
	}
</script>

</body>

</html>