<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
   
   <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">客户筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
				<ul id="check-status-keyfilter" data-toggle="keyfilter"
				data-title="校验状态" data-filter-filed="checkStatus"
				data-table-Id="account-imp-table">
				</ul>
			</div>
	</fieldset>
	
	<table id="account-imp-table" keyFilterDiv="keyFilter"
			singleSelect="false" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="checkStatus" width="80px" lov="TB_CHECK_STATUS" defaultSearch="true" >校验状态</th>
				<th field="impStatus" width="80px" lov="TB_IMPORT_STATUS">导入状态</th>
				<th field="errMessage" width="400px" formatter="titleFormatter">错误信息</th>
				<th field="lastName" width="80px"editor="{type:'validatebox',options:{required:true}}">姓氏</th>
				<th field="firstName" width="200px" editor="{type:'validatebox',options:{required:true}}">名字</th>			
				<th field="cellPhone" width="100px" editor="{type:'validatebox',options:{required:true}}">手机号</th>
				<th field="status" width="80px" editor="{type:'validatebox'}">状态</th>
				<th field="acctCode" width="100px" defaultSearch="true" editor="{type:'validatebox', options:{required:true}}">所属客户Siebel编码</th>
				<th field="acctName" width="80px" defaultSearch="true" editor="{type:'validatebox', options:{required:true}}">所属客户名称</th>			
		</thead>
	</table>
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#account-imp-table');
		getLovOfList("[ACCT_TYPE,ACCT_STATUS,ACCT_LEVEL,IMP_STATUS]");
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonExport:true,
			buttonCopy:true,
			buttonImport:true,
			oauthFlag:true,
			striped:true,
			title:'',
			border:false,
			url:'${AppContext.ctxPath}/action/portal/shopkeeperTemp/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_check" class="easyui-linkbutton" iconCls="icon-folder-page" plain="true" onclick="check()">校验数据</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="accntImpInsert()">提交数据</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="batchDeleteById()">批量删除</a>',that);
			},
			 readOnlyCondition: function(row, that){
					//先清除所有选择行,在选择当前编辑行
					 if(row.checkStatus == 'Check Ok'){
				    		return true;
				    	}else{
				    		$datagrid.hdatagrid('clearSelections');
							var index = $datagrid.hdatagrid('getRowIndex', row);
							$datagrid.datagrid('selectRow',index)
				    		return false;
				    	}
				},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						for(var i=0; i< rows.length; i++){
							var row = rows[i];
							delete row.children;
						}
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/shopkeeperTemp/batchUpdate",
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
				onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/shopkeeperTemp/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				//var firstName = appCtx.firstName != null ? '' : appCtx.firstName;
				return {
					checkStatus : 'New',
					impStatus : 'New'
					
				};
			},
	
			onDeleteAction:function(row,successFun,errFun,that) {
		    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
		    		if(data){
		    			$.post('${AppContext.ctxPath}/action/portal/shopkeeperTemp/deleteById',{
		    				id : row.id
		    			},function(data){
		    				if (!data.success) {
								errFun(data.result,that);
							} else {
								successFun(that, data);
							}
		    			});
		    		}
		    		
		    	});
		    }
		});
		
		$('.fixed-keyfilter-ul').keyFilter();
		$('#check-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_CHECK_STATUS'
	    });
		
		//错误信息title
		function titleFormatter(val,row){
		     if(val != null){
		        var content = '';
		        var content = val.replace(/\\n/g,'\n');
		        var val = val.replace(/\\n/g,'; ');
		     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
		     }
		}
		
		function orgPicklistComplete(selectRow){
			//$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}
		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').empTel = selectRow.empTel;
			return selectRow.fstName;
		}
		
		function check(){
			$.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/shopkeeperTemp/check', {},
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
		
		function accntImpInsert(){
			$.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/shopkeeperTemp/userImpInsert', {},
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
		function batchDeleteById(rows, successFun, errFun, that){
			var rows=$datagrid.hdatagrid('getSelections');
			 $.ajax({
				url: "${AppContext.ctxPath}/action/portal/shopkeeperTemp/batchDelete",
				type:"post",
				data:JSON.stringify(rows),
				dataType:"json",
				contentType: "application/json",
				
			 	function(data){					
			    	if(data.success){
			    		$datagrid.datagrid('reload');
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				} 
			});
	    	$datagrid.datagrid('reload');

		}
	</script>
</body>
</html>