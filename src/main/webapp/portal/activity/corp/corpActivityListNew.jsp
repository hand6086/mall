<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type=""text/css"">
#report{
	width: 100%;
	text-align:center;
}
.showTableDiv{
	vertical-align: middle;
	padding-left: 20px;
    padding-right: 20px;
    width: auto;
    overflow: auto;
    margin-top: 20px;
}
.showTableDiv p{
	font-weight: bold;
	margin-top: 10px;
    margin-bottom: 10px;
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

#avticityReport-table{
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
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false"
		style="width: 100%;" fit="true">
		<table id="corpActivity-table" style="height: 50%; width: 100%">
			<thead>
				<tr>
					<th field="id" width="100px">编号</th>
					<th field="created" width="100px">创建时间</th>
					<th field="activityName" width="100px" defaultSearch="false"
						editor="{type:'validatebox',options:{required:false}}">活动名称</th>
					<th field="activityType" width="100px" defaultSearch="false"
						editor="{type:'validatebox',options:{required:false}}">活动类型</th>
					<th field="comments" width="100px" defaultSearch="false"
						editor="{type:'validatebox',options:{required:false}}">描述</th>
				</tr>
			</thead>
		</table>

		<div data-options="region:'center',split:true" border="false"
			style="height: 600px; width: 100%;">
			<div class="easyui-tabs" data-options="fit:true" border="false"
				style="height: 600px; width: 100%;">
				<div title="字段配置">
					<table id="activityConfig-table" style="height: 50%; width: 100%">
						<thead>
							<tr>
								<th field="id" width="100px">编号</th>
								<th field="created" width="100px">创建时间</th>
								<th field="displayName" width="100px" defaultSearch="false"
									editor="{type:'validatebox',options:{required:true}}">显示名称</th>
								<th field="inputType" width="100px" defaultSearch="false"
									lov="LNK_INACT_INPUTTYPE"
									editor="{type:'combobox',options:{valueField:'val',
				textField:'name',data:getLovArray('LNK_INACT_INPUTTYPE'),editable:false,required:true}}">输入类型</th>
								<th field="selectRange" width="100px" defaultSearch="false"
									editor="{type:'validatebox',options:{required:false}}">选址范围(逗号分隔)</th>
								
								<th field="seq" width="100px" defaultSearch="false"
									editor="{type:'validatebox',options:{required:false}}">排序</th>
								<th field="isReq" width="60px" defaultSearch="false"
									editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否必输字段</th>
									<th field="coms" width="100px" defaultSearch="false"
									editor="{type:'validatebox',options:{required:false}}">说明</th>
								 

							</tr>
						</thead>
					</table>
				</div>
				<div title="结果表">
					<table id="activityResult-table" style="height: 50%; width: 100%">
						<thead>
							<tr>
								<th field="id" width="100px">编号</th>
								<th field="created" width="100px">创建时间</th>
								<th field="name" width="100px" defaultSearch="false"
									editor="{type:'validatebox',options:{required:false}}">名称</th>
								<th field="value" width="100px" defaultSearch="false"
									editor="{type:'validatebox',options:{required:false}}">值</th>
							

							</tr>
						</thead>
					</table>
				</div>
				<!-- 结果报表标签页 -->
				<div id="report" title="报表">
				
					<div id="showTableDiv" class="showTableDiv">
					<!-- keyFilterDiv="keyFilter" -->
						<!-- <table id="avticityReport-table" style="height: 100%;" >
						</table> -->
					</div>
				</div>
			</div>
		</div>


	</div>


	<script type="text/javascript">
		$datagrid = $('#corpActivity-table');
		$datagridItem = $('#activityConfig-table');
		$datagridItemresult = $('#activityResult-table');
		$activityReportTable = $('#activityReport-table');
		$datagrid
				.hdatagrid({
					title : '',
					pageSize : 15,//每页显示的记录条数，默认为20 
					pageList : [ 15, 30, 50 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonExport : true,
					striped : true,
					border : false,
					oauthFlag:true,
					subGridIds : [ 'activityConfig-table',
							'activityResult-table' ],
					url : '${AppContext.ctxPath}/action/portal/corpActivity/queryByExamplePage',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/corpActivity/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
							dataType:"json",
							contentType: "application/json",
							success: function(data){
								if(data.success){
									successFun(that, data);
								}else{
									errFun(that, data);
								}
							},
							error: function(xhr, code, msg){
								errFun(that, "msg");
							}
						});
					},				
					onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {

						$
								.post(
										'${AppContext.ctxPath}/action/portal/corpActivity/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/corpActivity/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(that);
																	}
																});
											}
										});
					},
					onChangeSelectedItem : function(row) {
						var parentId = row.id ? row.id : "";
						if (parentId != '' && row.row_status != 'NEW') {

							$datagridItem.hdatagrid(
									"changeParentItemAndParams", {
										ParentId : row.id
									});
							$datagridItemresult.hdatagrid(
									"changeParentItemAndParams", {
										ParentId : row.id
									});

						} else {

							$datagridItem.hdatagrid(
									"changeParentItemAndParams", {
										ParentId : row.id
									});
							$datagridItemresult.hdatagrid(
									"changeParentItemAndParams", {
										ParentId : row.id
									});
						}
					},
					/**
					 * 初始化新建的数据
					 */
					onInitNewData : function(that) {
						return {
							created : appCtx.sysdate(),
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="preViewPage()" iconCls="icon-edit" plain="true">预览</a>',that);
					}
				});

		
		function preViewPage() {
			var myDate = new Date();
			var a=myDate.getTime();
			var row = $datagrid.datagrid('getSelected');
			window.open('${AppContext.ctxPath}/action/portal/share/preViewPage?id='+row.id+'&dt='+a);
			 

		};
		
		
		$datagridItem
				.hdatagrid({
					title : '',
					pageSize : 15,//每页显示的记录条数，默认为20 
					pageList : [ 15, 30, 50 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : true,
					newDefaultValue : true,
					striped : true,
					border : false,
					parentGridId : 'corpActivity-table',
					parentGridField : 'id',
					linkGridField : 'parentId',
					url : '${AppContext.ctxPath}/action/portal/activityConfig/queryByExamplePage',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/activityConfig/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
							dataType:"json",
							contentType: "application/json",
							success: function(data){
								if(data.success){
									successFun(that, data);
								}else{
									errFun(that, data);
								}
							},
							error: function(xhr, code, msg){
								errFun(that, "msg");
							}
						});
					},				
					onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {

						$
								.post(
										'${AppContext.ctxPath}/action/portal/activityConfig/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/activityConfig/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(that);
																	}
																});
											}
										});
					},
					onChangeSelectedItem : function(row) {
						//$datagrid.hdatagrid("changeParentItemAndParams",{ActivityConfigId:row.id});
					},
					/**
					 * 初始化新建的数据
					 */
					onInitNewData : function(that) {
						return {
							parentId : $datagrid.hdatagrid("getSelected").id,
							created : appCtx.sysdate(),
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editActivityConfigPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
					}
				});
		//queryByExamplePage
		$datagridItemresult
				.hdatagrid({
					title : '',
					pageSize : 15,//每页显示的记录条数，默认为20 
					pageList : [ 15, 30, 50 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : true,
					newDefaultValue : true,
					striped : true,
					border : false,
					parentGridId : 'corpActivity-table',
					parentGridField : 'id',
					linkGridField : 'parentId',
					url : '${AppContext.ctxPath}/action/portal/activityResult/queryByExamplePage',
					onLoadSuccess : function(data){
						var parentId = $datagrid.hdatagrid("getSelected").id;
						showReport(parentId);
					},
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/activityResult/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
							dataType:"json",
							contentType: "application/json",
							success: function(data){
								if(data.success){
									successFun(that, data);
								}else{
									errFun(that, data);
								}
							},
							error: function(xhr, code, msg){
								errFun(that, "msg");
							}
						});
					},				
					onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {

						$
								.post(
										'${AppContext.ctxPath}/action/portal/activityResult/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/activityResult/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(that);
																	}
																});
											}
										});
					},
					onChangeSelectedItem : function(row) {
						//$datagrid.hdatagrid("changeParentItemAndParams",{ActivityResultId:row.id});
					},
					/**
					 * 初始化新建的数据
					 */
					onInitNewData : function(that) {
						return {
							parentId : $datagrid.hdatagrid("getSelected").id,
							created : appCtx.sysdate(),
							orgId : appCtx.orgId,
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editActivityResultPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
					}
				});
		
		var editFormatter = function(value, row, index) {
			return value;
		}
		
		//输出活动报表
		function showReport(parentId){
			$.post('${AppContext.ctxPath}/action/portal/activityResult/queryAll', {
				pageFlag : false,
				parentId : parentId
				}, function(data) {
					 /* $("#avticityReport-table").html(""); */
					 var reportTitle = [];
					 $("#showTableDiv").html("");
					 var html = '';
					 var jData = JSON.parse(data.result); 
					 var dataRow;
					 var existTitle;
					 var contentTr;
					 var conTentTd;
					 var content = [];
					 var row;
					 var mainTitle = '暂无活动报表';
					 var parentTitle = 'ParentTitle';
					 if (data.success) {
						 if (data.result != '[]'){
							for (var i=0;i<jData.length;i++){
								dataRow = jData[i];
								for(var item in dataRow){
									existTitle = $.inArray(item,reportTitle);
									//item != 'ParentTitle' 为报表不显示ParentTitle字段
									if (existTitle == -1 && item != 'ParentTitle'){
										reportTitle.push(item);
									}
								}
								
							}
							mainTitle = jData[0].ParentTitle + "活动报表";
							$("#showTableDiv").append('<div><p>'+mainTitle+'</p></div>');
							$("#showTableDiv").append('<div style=" margin-right: 100px; margin-top: 0px; margin-bottom: 5px;margin-left:80%;">'+
									'<a id="downloadReport" href="###" class="easyui-linkbutton" onclick="exportReport(\'avticityReport-table\',\''+mainTitle+'\',\''+mainTitle+'\')">&nbsp;&nbsp;导出报表&nbsp;&nbsp;</a>'+ 
									'</div>');
							
							/* 
							//对报表的标题进行排序--
							
							//排序结束
							 */
							html += '<table id="avticityReport-table" style="height: 100%;" >';
							//输出报表标题
							html += '<tr class="titleTr">';
							for (var i=0;i<reportTitle.length;i++){
								html += '<td width="100" class="titleTd">'+reportTitle[i]+'</td>'
							}
							html += '</tr>';
							//输出报表体
							for (var i=0;i<jData.length;i++){
								row = data[i];
								contentTr = [];
								for(var j=0;j<reportTitle.length;j++){
									contentTd = null;
									for(var item in jData[i]){
										if(item == reportTitle[j]){
											contentTd = jData[i][item];
										}
									}
									contentTr.push(contentTd);
								}
								/* console.log(contentTr); */
								content.push(contentTr);
							}
							/* console.log(content[1]); */
							//输出报表
							//循环输出每一行
							for(var i=0; i<content.length;i++){
								row = content[i];
								html += '<tr class="conTr">';
								//循环输出每一行的每一列
								for(var j=0; j<row.length;j++){
									/* console.log(row[j]); */
									html += '<td width="100" class="conTd">'+transNullInnerHtml(row[j])+'</td>';
								}
								/* console.log("-------------------------------------------"); */
								html += '</tr>';
							}
							/* console.log(html); */
							html += '</table>'
							/* $("#avticityReport-table").append(html); */
							$("#showTableDiv").append(html);
							/* $("#showTableDiv").append('<a id="download" onclick="exportReport(\'avticityReport-table\',\''+mainTitle+'\',\''+mainTitle+'\')">导出</a>'); */
							
						 }else{
							 $("#showTableDiv").append('<p>'+mainTitle+'</p>');
						 }
					 }else{
						 console.log("fail");
						 /* $("#avticityReport-table").html(""); */
						 $("#showTableDiv").html("");
					 }
		 	});
		};
		
		function transNullInnerHtml(val){
			if (val == null){
				val = '';
			}
			return val;
		}
		/* 
		function timeFormatter(date){
			var time = new Date(date);
			var text = time.getYear()+"-"+time.getMonth()+"-"+time.getDay()+" "
					  +time.getHours()+":"+time.getMinutes()+":"+time.getSeconds();
		    return text;
		}
		 */
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
				/* tableToExcelP(tableid,name,fileName); */
				tableToExcel(tableid,name,fileName,getExplorer());
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
