<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
.td-label {
	font-size: 12px;
	text-align: right;
	height: 30px;
}
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" border="false" style="width: 100%; height:70px; padding: 0px;">
		<fieldset class="x-fieldset">
			<legend class="x-fieldset-header" style="width: 70px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">筛选条件</span>
			</legend>
			<div class="row keyfilter-border">
				<ul data-toggle="keyfilter" data-title="状态" data-filter-filed="status"
					data-table-Id="user-imp-table">
					<li data-value="NEW">新建</li>
					<li data-value="CHECK_SUCCESS">校验成功</li>
					<li data-value="CHECK_FAIL">校验失败</li>
					<li data-value="IMP_FAIL">导入失败</li>
				</ul>
			</div>
		</fieldset>
	</div>
	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
		<table id="user-imp-table">
			<thead>
				<tr>
					<th field="firstName" width="100px" editor="{type:'textbox', options:{required:true}}">姓名</th>
					<th field="username" width="100px" editor="{type:'textbox', options:{required:true}}">用户名</th>
					<th field="contactPhone" width="100px" editor="{type:'validatebox',options:{required:true}}">联系电话</th>
					<th field="email" width="100px" editor="{type:'textbox', options:{required:true}}">邮件</th>
					<th field="postnName" width="150px" editor="{type:'textbox'}">主要职位</th>
					<th field="dutyName" width="140px" editor="{type:'textbox'}">职责</th>
					<!-- <th field="role" width="100px" lov="ROLE" editor="{type:'combobox',	
										options:{valueField:'val',
										textField:'name',
										method:'get',
										data:getLovArray('ROLE'),
										editable:false,
										required:true}}">角色</th> -->
					<th field="role" width="100px" editor="{type:'textbox', options:{required:true}}">角色</th>
					<%-- <th field="appResp" width="130px" editor="{type:'picklistbox',options:{title:'选择App职责',
															completeFun:appDutyPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/appDutyPickList.jsp'}}">APP职责</th> --%>
					<th field="appResp" width="130px" editor="{type:'textbox'}">APP职责</th>
					<!-- <th field="appRole" width="100px" lov="EMP_APP_ROLE" editor="{type:'combobox',	
															options:{valueField:'val',
															textField:'name',
															method:'get',
															data:getLovArray('EMP_APP_ROLE'),
															editable:false,
															required:true}}">APP角色</th> -->
					<th field="appRole" width="100px" editor="{type:'textbox', options:{required:true}}">APP角色</th>						
					<th field="contact" width="100px" editor="{type:'textbox'}">联系人</th>
					<th field="basename" width="100px" editor="{type:'textbox'}">base地点</th>
					<th field="formuladate" width="100px" editor="{type:'textbox'}">聘用日期</th>
					<th field="hometown" width="100px" editor="{type:'textbox'}">常住地</th>
					<th field="joblevel" width="100px" editor="{type:'textbox'}">级别</th>
					<th field="joindate" width="100px" editor="{type:'textbox'}">入职日期</th>
					<th field="nextproj" width="100px" editor="{type:'textbox'}">下一项目</th>
					<th field="positionname" width="100px" editor="{type:'textbox'}">职务</th>
					<th field="trialdate" width="100px" editor="{type:'textbox'}">开始试用期</th>
					<th field="workdate" width="100px" editor="{type:'textbox'}">转正日期</th>
					<th field="empType" width="100px" editor="{type:'textbox', options:{required:true}}">类型</th>
					<!-- <th field="corpid" width="120px" lov="CORP_ID" editor="{type:'combobox',
															options:{valueField:'val',
															textField:'name',
															method:'get',
															data:getLovArray('CORP_ID'),
															editable:false,
															required:false}}">公司账套</th> -->
					<th field="status" lov="IMP_STATUS" width="100px">状态</th>
					<th field="errorMessage" width="500px" formatter="titleFormatter">错误信息</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
	$('.fixed-keyfilter-ul').keyFilter();
		$datagrid = $('#user-imp-table');
		getLovOfList("[CORP_ID,EMP_APP_ROLE,ROLE,IMP_STATUS]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			buttonImport:true,
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
			oauthFlag:true,
			striped : true,
			border : false,
			width:'100%',
			height:'100%',
			url:'${AppContext.ctxPath}/action/portal/userImp/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-folder-page" plain="true" onclick="check()">校验数据</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="userImpInsert()">提交数据</a>',that);
			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			   : row.id,
							username       : row.username,
							firstName      : row.firstName,
							role           : row.role,
							appRole        : row.appRole,
							appResp        : row.appResp,
							corpid         : row.corpid,
							contact        : row.contact,
							contactPhone   : row.contactPhone,
							email          : row.email,
							basename       : row.basename,
							formuladate    : row.formuladate,
							hometown       : row.hometown,
							joblevel       : row.joblevel,
							joindate       : row.joindate,
							nextproj       : row.nextproj,
							positionname   : row.positionname,
							trialdate      : row.trialdate,
							workdate       : row.workdate,
							empType        : row.empType,
							postnName 	   : row.postnName,
							dutyName	   : row.dutyName
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/userImp/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
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
				$.post('${AppContext.ctxPath}/action/portal/userImp/upsert',{
					row_status     : row.row_status,
					id			   : row.id,
					username       : row.username,
					firstName      : row.firstName,
					role           : row.role,
					appRole        : row.appRole,
					appResp        : row.appResp,
					corpid         : row.corpid,
					contact        : row.contact,
					contactPhone   : row.contactPhone,
					email          : row.email,
					basename       : row.basename,
					formuladate    : row.formuladate,
					hometown       : row.hometown,
					joblevel       : row.joblevel,
					joindate       : row.joindate,
					nextproj       : row.nextproj,
					positionname   : row.positionname,
					trialdate      : row.trialdate,
					workdate       : row.workdate,
					empType        : row.empType,
					postnName 	   : row.postnName,
					dutyName	   : row.dutyName
				}, 
				function(data) {
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
				return {
					status:'新建'
				};
			},	
			onDeleteAction:function(row,successFun,errFun,that) {
		    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
		    		if(data){
		    			$.post('${AppContext.ctxPath}/action/portal/userImp/deleteById',{
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
		function titleFormatter(val,row){
		     if(val != null){
		        var content = '';
		        var content = val.replace(/\\n/g,'\n');
		        var val = val.replace(/\\n/g,'; ');
		     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
		     }
		}
		
		function appDutyPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').appResp = selectRow.respName;
			return selectRow.respName;
		}
		
		function check(){
			$.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/userImp/check', {},
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
		
		function userImpInsert(){
			$.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/userImp/userImpInsert', {},
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

	</script>
</body>
</html>