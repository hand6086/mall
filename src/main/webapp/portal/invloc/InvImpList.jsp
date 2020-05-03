<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
	<fieldset class="x-fieldset">
		<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">筛选条件</span>
		</legend>
		<div class="row keyfilter-border">
			<ul data-toggle="keyfilter" data-title="状态" data-filter-filed="status"
				data-table-Id="inv-imp-table">
				<li data-value="NEW">新建</li>
				<li data-value="CHECK_SUCCESS">校验成功</li>
				<li data-value="CHECK_FAIL">校验失败</li>
				<li data-value="IMP_FAIL">导入失败</li>
			</ul>
		</div>
		<div class="row keyfilter-border">
			<ul data-toggle="keyfilter" data-title="类型" data-filter-filed="type"
				data-table-Id="inv-imp-table">
				<li data-value="销售出库">销售出库</li>
				<li data-value="销售调入">销售调入</li>
				<li data-value="销售调出">销售调出</li>
				<li data-value="采购进货">采购进货</li>
			</ul>
		</div>
	</fieldset>
	
	<table id="inv-imp-table">
		<thead>
			<tr>
				<th field="tradeDate" width="110px" mark="DATE" editor="{type:'datetimebox', options:{required:true,showSeconds: false}}">交易日期</th>
				<th field="accntCode" width="90px" editor="{type:'textbox', options:{required:true}}">客户编码</th>
				<th field="accntName" width="90px" defaultSearch="true" editor="{type:'textbox'}">客户名称</th>
				<th field="prodCode" width="90px" editor="{type:'textbox'}">产品编码</th>
				<th field="prodName" width="90px" editor="{type:'textbox'}">产品名称</th>
				<th field="qty" width="70px" editor="{type:'numberspinner',options:{
															min:0,
															validType:'integer',
															required:true}}">数量</th>
				<th field="type" width="90px" editor="{type:'textbox', options:{required:true}}">类型</th>
				<th field="status" lov="IMP_STATUS" width="70px">状态</th>
				<th field="errorMessage" width="200px" formatter="titleFormatter">错误信息</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	getLovOfList("[IMP_STATUS]");
	$('.fixed-keyfilter-ul').keyFilter();
		$datagrid = $('#inv-imp-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			buttonImport:true,
			buttonNew:true,
			buttonDelete:true,
			oauthFlag:true,
			width:'100%',
			height:'100%',
			url : '${AppContext.ctxPath}/action/portal/invImp/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-folder-page" plain="true" onclick="check()">校验数据</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="invTxnInsert()">提交数据</a>',that);
			},
			onInsertAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/invImp/upsert', {
						row_status  : row.row_status,
						tradeDate	: row.tradeDate,
						accntCode	: row.accntCode,
						accntName	: row.accntName,
						prodCode	: row.prodCode,
						prodName	: row.prodName,
						qty			: row.qty,
						type		: row.type,
						status		: 'NEW'
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					status:getLovShowName('IMP_STATUS','NEW')
					 
				};
			},	
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/invImp/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					}
				});
			}
		});
		
		function titleFormatter(val,row){
		     if(val != null){
		        var content = '';
		        var content = val.replace(/\\n/g,'\n');
		        var val = val.replace(/\\n/g,'; ');
		     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
		     }
		}
		
		function check(){
			$.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/invImp/check', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		function invTxnInsert(){
			$.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/invImp/invTxnInsert', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		$.extend($.fn.validatebox.defaults.rules, {
			integer: {
				validator: function(value, param){
					return /^[+]?[1-9]+\d*$/i.test(value);
				},
				message: '请输入正整数'
		    }
		});
	</script>
</body>
</html>