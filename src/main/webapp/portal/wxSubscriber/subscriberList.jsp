<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false"
		style="width: 100%;" fit="true">
		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">筛选条件</span>
			</legend>

			<!-- <div class="row keyfilter-border">
				<ul id="subscribe-type-keyfilter" data-toggle="keyfilter"
					data-title="是否关注" data-filter-filed="subscribe"
					data-table-Id="subscriber-table">
				</ul>
			</div> -->
			<div class="row keyfilter-border">
				<ul id="group-type-keyfilter" data-toggle="keyfilter"
					data-title="所在分组" data-filter-filed="groupid"
					data-table-Id="subscriber-table">
				</ul>
			</div>
		</fieldset>

		<table id="subscriber-table" style="height: 100%; width: 100%"
			keyFilterDiv="keyFilter">
			<thead>
				<tr>
					<th field="id" width="100px">编号</th>
					<th field="headimgurl" width="100px" defaultSearch="false"
						formatter="imgFormatter">用户头像</th>
					<th field="subscribe" width="100px" defaultSearch="false"
						formatter="subFormatter">是否订阅</th>
					<th field="openid" width="250px" defaultSearch="false">用户标识</th>
					<th field="nickname" width="150px" defaultSearch="false">用户昵称</th>
					<th field="remark" width="150px" defaultSearch="false"
						editor="{type:'validatebox',options:{required:false,validType:'length[1,30]'}}">用户备注</th>
					<th field="groupid" width="100px" defaultSearch="false"
						editor="{type:'combobox',options:{	valueField:'groupid',
															textField:'groupName',
															url:'${AppContext.ctxPath}/action/portal/wxGroup/queryAllGroup',
															editable:false}}">分组ID</th>
					<th field="sex" width="100px" defaultSearch="false"
						formatter="sexFormatter">用户性别</th>
					<th field="country" width="100px" defaultSearch="false">所在国家</th>
					<th field="province" width="100px" defaultSearch="false">所在省份</th>
					<th field="city" width="100px" defaultSearch="false">所在城市</th>
					<th field="language" width="100px" defaultSearch="false"
						formatter="langFormatter">用户语言</th>
					<th field="subscribe_time" width="120px" defaultSearch="false"
						formatter="subTimeFormatter">关注时间</th>
					<th field="unionid" width="100px" defaultSearch="false" hidden="true">UNIONID</th>
					<th field="created" width="100px">创建时间</th>
				</tr>
			</thead>
		</table>

	</div>

	<script type="text/javascript">
		$datagrid = $('#subscriber-table');
		$datagrid
				.hdatagrid({
					title : '',
					pageSize : 15,//每页显示的记录条数，默认为20 
					pageList : [ 15, 30, 50 ],//可以设置每页记录条数的列表 
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : false,
					buttonDelete : false,
					buttonCopy : false,
					buttonExport : true,
					buttonImport : false,
					newDefaultValue : true,
					striped : true,
					border : false,
					url : '${AppContext.ctxPath}/action/portal/subscriber/queryByExamplePage',
					buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/subscriber/batchUpdate",
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
										'${AppContext.ctxPath}/action/portal/subscriber/upsert',
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
																'${AppContext.ctxPath}/action/portal/subscriber/deleteById',
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
						//$datagrid.hdatagrid("changeParentItemAndParams",{SubscriberId:row.id});
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
						//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editSubscriberPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
						addButtonFun(
								90,
								'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="ansySub()" iconCls="icon-reload" plain="true">订阅者同步</a>',
								that);
					}
				});

		var editFormatter = function(value, row, index) {
			return value;
		}

		/*以下为部分参考函数*/
		/*
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				accntId : selectRow.id
			});
			return selectRow.acctName;
		}
		function contactPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				contactId : selectRow.id
			});
			return selectRow.contactsName;
		}
		function SubscriberSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.SubscriberStatus == '新建'||row.SubscriberStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/Subscriber/SubscriberSubmit', 
				{
					id	: row.id,
					SubscriberStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.SubscriberStatus+'，无法提交！', 'error');
			}
		}
		function productPicklistComplete(selectRow){ 
			$datagrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			});
			return selectRow.prodName;
		}
		 */

		/**
			用户头像
		 */
		function imgFormatter(val, row) {
			if (val)
				return "<img height='46' width='46' src='"+val+"'>";
			return "<img height='46' width='46' src='${AppContext.ctxPath}/static/images/404.jpg'>";
		}

		/**
			地区语言
		 */
		function langFormatter(val, row) {
			if (val == "zh_CN")
				return "简体中文";
			else if (val == "zh_TW")
				return "繁体中文";
			else if (val == "en")
				return "英语";
			else
				return "";
		}

		/**
			是否关注
		 */
		function subFormatter(val, row) {
			if (val == "1") {
				return "已关注";
			} else if (val == "0") {
				return "未关注";
			}
		}

		/**
			性别格式
		 */
		function sexFormatter(val, row) {
			if (val == "1") {
				return "男";
			} else if (val == "2") {
				return "女";
			} else {
				return "未知";
			}
		}

		/**
			订阅者关注时间格式
		 */
		function subTimeFormatter(val, row) {
			return subscribeTime(val);
		}

		/**
			订阅者关注时间格式
			@param timestamp 时间戳
		 */
		function subscribeTime(timestamp) {
			if (timestamp != "" && timestamp != null && timestamp != "null") {
				var datetime = new Date();
				datetime.setTime(timestamp * 1000);
				var year = datetime.getFullYear();
				var month = datetime.getMonth() + 1 < 10 ? "0"
						+ (datetime.getMonth() + 1) : datetime.getMonth() + 1;
				var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
						: datetime.getDate();
				var hour = datetime.getHours() < 10 ? "0" + datetime.getHours()
						: datetime.getHours();
				var minute = datetime.getMinutes() < 10 ? "0"
						+ datetime.getMinutes() : datetime.getMinutes();
				var second = datetime.getSeconds() < 10 ? "0"
						+ datetime.getSeconds() : datetime.getSeconds();
				return year + "-" + month + "-" + date + " " + hour + ":"
						+ minute + ":" + second;
			} else {
				return "";
			}
		}

		/**
			订阅者同步
		 */

		function ansySub() {
			operationprogress('进度提示', '正在同步...');
			$.get('${AppContext.ctxPath}/action/portal/subscriber/ansySub',
					function(data) {
						/* console.log(data); */
						if (!data.success) {
							$.messager.alert("操作提示", data.result, "error");
						} else {
							$.messager.progress('close');
							$datagrid.datagrid('reload');
							$.messager.alert("操作提示","已同步" + data.total + "条记录", "info");
						}
					});
		}
		
		$('.fixed-keyfilter-ul').keyFilter();
		   $('#group-type-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				dataName:'groupName',
				dataValue:'groupid',
				remoteUrl:'${AppContext.ctxPath}/action/portal/wxGroup/queryAllGroup'
		   });
	</script>
</body>
</html>
