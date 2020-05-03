<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
		<table id="smsSend-table" height="347px">
			<thead>
				<tr>
					<th field="id" width="100px">短信编码</th>
					<th field="textContent" width="100px" editor="{type:'textbox',options:{required:true}}">短信内容</th>
					<th field="sendTime" width="120px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:true,required:true}}">发送时间</th>
					<th field="fullName" width="120px" >发送人</th>
					<th field="activeFlag" width="100px" >是否有效</th>
					<th field="determineFlag" width="115px" >是否已生成工作流</th>
					<th field="sendFlag" width="100px" >是否已发送</th>
					<th field="succeedNum" width="100px" >接收成功数量</th>
					<th field="failedNum" width="100px" >接收失败数量</th>
					<th field="succeedRate" width="100px" >接收成功率</th>
				</tr>
			</thead>
		</table>
		<div data-options="region:'center',split:true" border="false"
			style="height: 400px; width: 100%;">
			<div class="easyui-tabs" data-options="fit:true" border="false"
				style="height: 400px; width: 100%;">
				<div title="短信发送列表">
					<table id="smsSend-table-Line" fit="true">
						<thead>
							<tr>
								<th field="headId" width="100px" hidden="ture">短信编码</th>
								<th field="phoneNumber" width="100px" editor="{type:'textbox',options:{required:true}}">目标号码</th>
								<th field="sendLotId" width="100px" >短信发送批次</th>
								<th field="dateCreated" width="120px" mark="date" >实际调用时间</th>
								<th field="statusCode" width="80px" >调用状态码</th>
								<th field="statusMessage" width="100px" >调用状态内容</th>
								<th field="sendTime" width="120px" mark="date" >实际发送时间</th>
								<th field="sendStatus" width="100px" >发送状态</th>
								<th field="receiveTime" width="120px" mark="date" >接收时间</th>
								<th field="receiveStatus" width="80px" >接收状态</th>
								<th field="backFlag" width="100px" >是否已返回状态</th>
							</tr>
						</thead>
					</table>
				</div>
				<div title="短信发送批次">
					<table id="smsSend-table-Lot" fit="true">
						<thead>
							<tr>
								<th field="id" width="100px">批次编码</th>
								<th field="dateCreated" width="150px" mark="date" >容联云返回-调用时间</th>
								<th field="messageSid" width="150px" editor="{type:'textbox',options:{showSeconds:true}}">容联云返回-调用编码</th>
								<th field="statusCode" width="150px" editor="{type:'textbox',options:{showSeconds:true}}">容联云返回-状态编码</th>
								<th field="statusMsg" width="150px" editor="{type:'textbox',options:{showSeconds:true}}">容联云返回-状态内容</th>
								<th field="sendStatus" width="150px" editor="{type:'textbox',options:{showSeconds:true}}">容联云返回-发送状态</th>
								<th field="sendTime" width="150px" mark="date" >容联云返回-发送时间</th>
							</tr>
						</thead>
					</table>
				</div>

			</div>
		</div>
	</div>
	
	<!-- 弹出窗 -->
    <div id="editWin" class="crmWin" hidden>
    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="100%" frameborder="0" scrolling="no">
    </iframe>
    </div>
	<script type="text/javascript">
		$('.easyui-layout').layout();
		$datagrid = $('#smsSend-table');
		$linDatagrid = $('#smsSend-table-Line');
		$lotDatagrid = $('#smsSend-table-Lot');
		$datagrid.hdatagrid({
			toolbarShow : true,
			buttonSearch : true,
			buttonNew:true,
			buttonDelete : true,
			newDefaultValue : true,
			oauthFlag : true,
			pageSize: 10, 
		    pageList: [10,15,30],
			url : '${AppContext.ctxPath}/action/portal/smsSend/queryByExamplePage',
			subGridIds : ['smsSend-table-Line','smsSend-table-Lot'],
			buttonBatchEdit : false,
			
			onInsertAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/smsSend/insert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
						$datagrid.datagrid('reload');
					}
				});
			},
			
			onUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/smsSend/update",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
						refreshAddrToolBar();
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/smsSend/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			
			onInitNewData:function(that){
				return {
					activeFlag : 'Y',
					determineFlag : 'N',
					sendFlag : 'N'
					};
			},

 			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="sendBt()" iconCls="icon-sms_send" plain="true">确认发送</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="sendReturn()" iconCls="icon-folder-page" plain="true">发送回调</a>',that);
            }, 
		});
		$linDatagrid.hdatagrid({
					pageSize : 200,//每页显示的记录条数，默认为20 
					pageList : [ 200, 300, 500 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					newDefaultValue : true,
					buttonImport : true,
					pageSize: 10, 
				    pageList: [10,15,30],
					url : '${AppContext.ctxPath}/action/portal/smsLine/queryByExamplePage',

					parentGridId : 'smsSend-table',
					parentGridField : 'id',
					linkGridField : 'headId',
					buttonBatchEdit : false,
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
						row.headId=$datagrid.datagrid('getSelected').id;
						$.post("${AppContext.ctxPath}/action/portal/smsLine/upsert",row, 
						function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
								refreshAddrToolBar();
							}
						});
					},
					
					onDeleteAction : function(row,successFun,errFun,that){
						$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
							if(data){
								$.post('${AppContext.ctxPath}/action/portal/smsLine/deleteById', {
										id : row.id
								}, function(data) {
										if (!data.success) {
											errFun(data.result,that);
										} else {
											successFun(that, data);
										}
								});
							}
						});
					}, 
					
					onInitNewData:function(that){
						return {
							backFlag : 'N'
						};
					},

				});
		$lotDatagrid.hdatagrid({
					toolbarShow : true,
					buttonSearch : true,
					newDefaultValue : true,
					pageSize: 10, 
				    pageList: [10,15,30],
					url : '${AppContext.ctxPath}/action/portal/smsLot/queryByExamplePage',

					parentGridId : 'smsSend-table',
					parentGridField : 'id',
					linkGridField : 'headId',
					buttonBatchEdit : false,
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
						row.headId=$datagrid.datagrid('getSelected').id;
						$.post("${AppContext.ctxPath}/action/portal/smsLot/upsert",row, 
						function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					},
					
					onDeleteAction : function(row,successFun,errFun,that){
						$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
							if(data){
								$.post('${AppContext.ctxPath}/action/portal/smsLot/deleteById', {
										id : row.id
								}, function(data) {
										if (!data.success) {
											errFun(data.result,that);
										} else {
											successFun(that, data);
										}
								});
							}
						});
					}, 
					onInitNewData:function(that){
						return {
							backFlag : ''
						};
					},
				});

		//失效
		function Invalid(){
			var row = $datagrid.datagrid('getSelected');
			$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,activeFlag:"N"});
		}
		
		//发送反馈
		function sendReturn(){
			var row = $datagrid.datagrid('getSelected');
			if(row.determineFlag!='Y'){
				window.parent.operationtip('请确保，是否已生成工作流为：Y，', 'info');
			}else{
				$.post("${AppContext.ctxPath}/action/portal/smsSend/sendReturn",row, 
						function(data) {
							if (!data.success) {
								window.parent.operationtip(data.result, 'error');
							}else{
								$datagrid.datagrid('reload');
				            	$linDatagrid.datagrid('reload');
				            	$lotDatagrid.datagrid('reload');
				            	window.parent.operationtip(data.result, 'info');
							}
						});
			}
		}
		
		//确认发送
		function sendBt(){
			var row = $datagrid.datagrid('getSelected');
			if(row.activeFlag!='Y'||row.determineFlag!='N'||row.sendFlag!='N'){
				window.parent.operationtip('请确保，是否有效为：Y，是否已生成工作流为：N，是否已发送为：N。', 'info');
			}else{
				row.determineFlag = 'Y';
				$.post("${AppContext.ctxPath}/action/portal/smsSend/update",row, 
						function(data) {
							if (!data.success) {
								window.parent.operationtip(data.result, 'error');
							}else{
								var index = $datagrid.hdatagrid('getRowIndex', row);
					            $datagrid.datagrid('selectRow',index);
					            
								$.ajax({
						            type: "post",//数据发送的方式（post 或者 get）
						            url: "${AppContext.ctxPath}/action/portal/smsSend/send",//要发送的后台地址
						            data: {id:row.id,textContent:row.textContent,sendTime:row.sendTime,activeFlag:row.activeFlag},//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
						            dataType: "json",//后台处理后返回的数据格式
						            success: function (data) {//ajax请求成功后触发的方法
						            	if (data.success) {
							            	$datagrid.datagrid('reload');
							            	$linDatagrid.datagrid('reload');
							            	$lotDatagrid.datagrid('reload');
							            	window.parent.operationtip('短信发送成功！', 'info');
						            	} else {
											window.parent.operationtip(data.result, 'error');
										}
						            },
						        });
							}
						});
			}
		}
	</script>
</body>
</html>