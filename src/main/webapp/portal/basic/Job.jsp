<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script>
<script src="${AppContext.ctxPath}/static/js/mask.js"></script>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north'" title="" border="false" style="width:100%;height:100%;padding:0px;">
				<div id="job-table-toolbar">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					搜索条件:
				    <input class="easyui-combobox" style="width:100px" url="" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#job-table').datagrid('doSearch')">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_control_play" plain="true" onclick="jobResume()">恢复</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_control_pause" plain="true" onclick="jobPause()">暂停</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_control_power" plain="true" onclick="jobRestart()">全部启动</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_control_record" plain="true" onclick="jobShutdown()">全部停止</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_control_remove" plain="true" onclick="jobDelete()">移除</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_add" plain="true" onclick="jobUpdate()">新建</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon_ok" plain="true" onclick="pick()">手动调用</a>
					
				</div>
				<table id="job-table" width="100%" height="50%" singleSelect="true" rownumbers="true" toolbar="#job-table-toolbar" pagination="true">
					<thead>
						<tr>
							<th field="jobName" width="100">名称</th>
							<th field="jobGroup" width="120">工作流组</th>
							<th field="triggerName" width="120">触发器名称</th>
							<th field="triggerGroup" width="120">触发器组</th>
							<th field="cronExpression" width="120">触发规则</th>
							<th field="triggerState" width="120">状态</th>
							<th field="startTime" width="200">开始时间</th>
							<th field="endTime" width="200">结束时间</th>
							<th field="prevFireTime" width="200">上次执行时间</th>
							<th field="nextFireTime" width="200">下次执行时间</th>
						</tr>
					</thead>
				</table>
		</div>
		<div data-options="region:'south',split:true" border="false" style="width:100%;height:50%;padding:0px;">
			<div id="jobLog-table-toolbar">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					搜索条件:
				    <input class="easyui-combobox" style="width:100px" url="" valueField="id" textField="text"/> 
				    <input style="width: 200px;" type="text" class="easyui-textbox" />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#jobLog-table').datagrid('doSearch')">查询</a>
				</div>
				<table id="jobLog-table" width="100%" height="100%" singleSelect="true" rownumbers="true" toolbar="#jobLog-table-toolbar" pagination="true">
					<thead>
						<tr>
							<th field="startDate" width="200">执行开始时间</th>
							<th field="endDate" width="200">执行结束时间</th>
							<th field="rType" width="200">消息类型</th>
							<th field="rNumber" width="200">消息编号</th>
							<th field="rMessage" width="200">消息文本</th>
						</tr>
					</thead>
				</table>
		</div>
	</div>
	
	<script type="text/javascript">
	$datagrid = $('#job-table');
	$datagrid.datagrid({
			striped:true,
			oauthFlag:true,
			title:'工作流',
		    pageSize: 10, 
		    pageList: [5,10,15], 
			border:false,
			url:'${AppContext.ctxPath}/action/portal/job/list',
			onClickRow:function(index,row){
				$dataitemgrid.datagrid('load',{headId:row.key});
			},
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$datagrid.datagrid('selectRow', 0)
				}
		   }
	});
	$dataitemgrid = $('#jobLog-table');
	$dataitemgrid.datagrid({
			striped:true,
			title:'工作流日志',
			pageSize: 10, 
		    pageList: [5,10,15], 
			border:false,
			url:'${AppContext.ctxPath}/action/portal/jobLog/list',
			onLoadSuccess:function(data){
				if(data.rows.length > 0){
					$dataitemgrid.datagrid('selectRow', 0)
				}
		   }
	});
	function jobResume(){
		var row = $datagrid.datagrid('getSelected');
		$.post('${AppContext.ctxPath}/action/portal/job/resume',{
			jobName:row.jobName,
			jobGroup:row.jobGroup
		},function(data){
			if(data.success){
				$dataitemgrid.datagrid('reload');
			}
		});
	}
	function jobPause(){
		var row = $datagrid.datagrid('getSelected');
		$.post('${AppContext.ctxPath}/action/portal/job/paused',{
			jobName:row.jobName,
			jobGroup:row.jobGroup
		},function(data){
			if(data.success){
				$datagrid.datagrid('reload');
			}
		});
	}
	function jobRestart(){
		var row = $datagrid.datagrid('getSelected');
		$.post('${AppContext.ctxPath}/action/portal/job/start',{
		},function(data){
			if(data.success){
				$datagrid.datagrid('reload');
			}
		});
	}
	function jobShutdown(){
		var row = $datagrid.datagrid('getSelected');
		$.post('${AppContext.ctxPath}/action/portal/job/shutdown',{
		},function(data){
			if(data.success){
				$datagrid.datagrid('reload');
			}
		});
	}
	function jobDelete(){
		var row = $datagrid.datagrid('getSelected');
		$.post('${AppContext.ctxPath}/action/portal/job/delete',{
			jobName:row.jobName,
			jobGroup:row.jobGroup
		},function(data){
			if(data.success){
				$datagrid.datagrid('reload');
			}
		});
	}
	function jobUpdate(){
		//var row = $datagrid.datagrid('getSelected');
		$.post('${AppContext.ctxPath}/action/portal/job/add',{
			jobName:'prodJob',
			//jobGroup:row.jobGroup,
			//cronExpression:'*/15 * * * * ?'
		},function(data){
			if(data.success){
				$datagrid.datagrid('reload');
			}
		});
	}
	function pick(){
		window.parent.operationprogress('进度提示', '正在调用接口...'); 
		$.post('${AppContext.ctxPath}/action/portal/job/pick',{
		},function(data){
			window.parent.$.messager.progress('close');
			if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				var sapReturn = data.sapReturn;
				if(sapReturn.type == 'S'){
					window.parent.operationtip("基地分配同步成功！", 'success');
					$datagrid.datagrid('reload');
				}else{
					window.parent.operationtip(sapReturn.type + ":" + sapReturn.message, 'error');
				}
			}
		});
	}
	</script>
</body>
</html>