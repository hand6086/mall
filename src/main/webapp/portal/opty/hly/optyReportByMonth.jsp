<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="${AppContext.ctxPath}/partner/static/js/calculate.js?version=<%=version%>"></script>
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
		<h2 style="text-align:center">今年所有商机赢单率及金额</h2>
		<br/>
	
		<div id="report"></div>
		<div id="bottomDiv">&nbsp;</div>
	</div>
  </div>
<script type="text/javascript">
	var rates = getLovArray('OPTY_SUCCESS_RATE');
	$.ajax({
	     url:'${AppContext.ctxPath}/action/portal/opty/queryCountAndAmountByMonthAndRate',
	     type:"post",
	     data:{
	    	 	"usercorpid":appCtx.corpId,
	    	 	"oauthFlag":true,
	    	 	"oauth":top.oauth
	    	  },
	     dataType:"json",
	     success:function(data){
	      if (data.success){
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
           //alert(explorer);
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
	        document.getElementById("downloadReport").href = uri + base64(format(template, ctx));
	        document.getElementById("downloadReport").download = filename;
	    }
       })(jQuery, window, document);
	
	function togetherCol(tableId, startRow, endRow, col) { 
		var tb = document.getElementById(tableId); 
		if (col >= tb.rows[0].cells.length) { 
			return; 
		} 
		if (col == 0) { 
			endRow = tb.rows.length-1; 
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
	
	function successFun(data){
		//$('#report').html(data.html);
		render(data.rows);
        togetherCol('OptyReport-table',0,0,0); //合并所属组别
        togetherCol('OptyReport-table',0,0,0); //合并商机阶段
        $('#OptyReport-table').before('<div style="margin-right: 100px; margin-top: 0px;margin-bottom: 5px;margin-left:80%;">'+
					'<a id="downloadReport" href="javascript:void(0)" class="easyui-linkbutton" onclick="exportReport(\'OptyReport-table\',\'商机报表\',\'商机报表\')">&nbsp;&nbsp;导出报表&nbsp;&nbsp;</a>'+ 
					'</div>');
	}
	
	function render(rows){
		var arr = [];
		for(var i=0; i<13; i++){
			arr[i] = [];
			for(var j=0; j<rates.length; j++){
				arr[i][j] = {};
			}
		}
		
		for(var k=0; k<rows.length; k++){
			var row = rows[k];
			var i = parseInt(row.optyDt.substring(5,7));
			var j = "";
			for(var t=0; t<rates.length; t++){
				if(row.rate == rates[t].val){
					j = t;
					break;
				}
			}
			arr[i][j] = {};
			arr[i][j].count = row.attr21;
			arr[i][j].totalAmount = row.totalAmount;
			arr[i][j].flag = true;
		}
		var str = "";
		var html = "<table id=\"OptyReport-table\" style=\"height: 100%;\" keyFilterDiv=\"keyFilter\">";
		
		str += "<tr class=\"titleTr\">";
		str += "<td class=\"titleTd\" width='180px'></td>";
		for(var i=0; i<rates.length; i++){
			str += "<td width='120px' class=\"titleTd\">"+rates[i].name+"</td>";
		}
		html += str +"</tr>";
		for(var i=1; i<13; i++){
			var str = "";
			str += "<tr>";
			str += "<td class=\"conTd\" width='180px'>"+i+"月</td>";
			for(var j=0; j<rates.length; j++){
				str += "<td width='100' class=\"conTd\">";
				if(arr[i][j].flag){
					str += arr[i][j].count+" <br>"+div(arr[i][j].totalAmount, 10000).toFixed(2)+" 万";
				}
				str+= "</td>";
			}
			str += "</tr>"
			html += str;
		}
		html += "</table>"
		$('#report').html(html);
	}
</script>

</body>

</html>