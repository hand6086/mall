<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<%@ include file="/portal/header.jsp"%>
	<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=X19IbB6EWVWpGrNBZuyUI9LpCi2aXMXr"></script>
</head>

<body class="easyui-layout" data-options="fit:true" border="false">
	   <fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">拜访筛选条件</span>
			</legend>
			
			<div class="row keyfilter-border">
				<ul id="visit-status-keyfilter" 
					data-title="拜访状态" data-filter-filed="status"
					data-table-Id="visit-table">
					<li data-value="未开始">未开始</li>
					<li data-value="已完成">已完成</li>
				</ul>
			</div>
			
		</fieldset>
		
		<table id="visit-table" fit="true" keyFilterDiv="keyFilter">
			<thead>
				<tr>
					<th field="id" width="60px" >拜访编号</th>
					<th field="acctName" width="200px" defaultSearch="true" >客户名称</th>
					<th field="contact" width="100px" >联系人</th>
					<th field="contactTel" width="100px" >联系方式</th>
					<th field="visitDec" width="100px" editor="{type:'textbox'}">拜访描述</th>
					<th field="visitTime" width="100px" mark="DATE" editor="{type:'datebox'}">拜访时间</th>
					<th field="endDate" width="100px" mark="DATE" editor="{type:'datebox'}">拜访结束时间</th>
					<th field="planDesc" width="100px" editor="{type:'textbox'}">计划描述</th>
					<th field="status" width="100px" >状态</th>
					<th field="province" width="100px" >省份</th>
					<th field="city" width="100px" >城市</th>
					<th field="address" width="200px" >街道</th>
				</tr>
			</thead>
		</table>

	
	<div id="allmap" class="easyui-dialog" style="width:50%;height:80%"
		closed="true" maximizable="true">
	</div>

	<script type="text/javascript">
		$datagrid = $('#visit-table');
		$allmap = $('#allmap');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			buttonImport:false,
			oauthFlag:true,
			updateable:true,
			url:'${AppContext.ctxPath}/action/portal/visit/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/visit/batchUpdate",
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
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="newVisit()" iconCls="icon-add" plain="true">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="showLocation()" iconCls="icon-locate" plain="true">定位</a>',that);
			},
			onUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/visit/update',{
					id:row.id,
					visitDec:row.visitDec,
					visitTime:row.visitTime,
					endDate:row.endDate,
					planDesc:row.planDesc,
					status:row.status
				},function(data){
					if(data.success){
						successFun(that, data);
					}else{
						errFun(data.result,that);
					}
				})
			}
		});

	  	$('#visit-status-keyfilter').keyFilter();
	  	
		function newVisit(){
			window.location.href = '${AppContext.ctxPath}/portal/visit/visitAdd.jsp';
		}
		
		// 用经纬度设置地图中心点
		function showLocation(){
			var row = $datagrid.datagrid('getSelected');
			console.log('经度:'+row.longitude+';'+'纬度：'+row.latitude);
			if(row.longitude != "" && row.longitude != null
					&& row.latitude != "" && row.latitude != null){
				$allmap.dialog('open').dialog('setTitle','定位地址信息');
				// 百度地图API功能
				var map = new BMap.Map("allmap");
				var new_point = new BMap.Point(row.longitude,row.latitude);
				map.centerAndZoom(new_point,18);
				map.enableScrollWheelZoom(true);				
				map.clearOverlays();
				var marker = new BMap.Marker(new_point);  // 创建标注
				map.addOverlay(marker);              // 将标注添加到地图中
				map.panTo(new_point);      
			}else{
				$.messager.alert('提示','没有位置信息可展示！');
			}
		}
	</script>
</body>
</html>