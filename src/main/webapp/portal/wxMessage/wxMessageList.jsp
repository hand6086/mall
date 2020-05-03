<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
   <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="activity-type-keyfilter" data-toggle="keyfilter"
				data-title="消息类型" data-filter-filed="subscribe"
				data-table-Id="subscriber-table">
			</ul>
		</div>
	</fieldset>
	<table id="wxMessage-table" style="height:100%;width:100%" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="100px" >创建时间</th>
				<th field="toUserName" width="150px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">开发者微信号</th>
				<th field="fromUserName" width="250px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">发送方账号</th>
				<th field="createTime" width="150px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}" formatter="createTimeFormatter">消息创建时间</th>
				<th field="msgType" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}" formatter="msgTypeFormatter">消息类型</th>
				<th field="msgId" width="150px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">消息ID</th>
				<th field="contents" width="300px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}" formatter="fieldFormatter">消息内容</th>
			</tr>
		</thead>
	</table>
	
	</div>

	<div id="msg-dlg-buttons" style="display: none;">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit"
			onclick="reply()">回复</a>
			
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-ok"
			onclick="javascript:$('#field-dlg').dialog('close')">确定</a>
	</div>
	<div id="field-dlg" class="easyui-dialog"
		style="width: 500px; height: 400px;" closed="true"
		buttons="#msg-dlg-buttons" style="display: none;">
		<div class="ftitle"></div>
		<form id="fm" method="post">
			<table class="table-block" align="center">
				<!-- <tr>
					<td class="td-content">
						开发者微信号:<input id="toUserName" name="toUserName" class="easyui-validatebox" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td class="td-content">
						发送方账号:<input id="fromUserName" name="fromUserName" class="easyui-validatebox" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td class="td-content">
						创建时间:<input id="createTime" name="createTime" class="easyui-validatebox" readonly="readonly" />
					</td>
				</tr> -->
				<tr>
					<td class="td-content">
					<textarea id="contents" name="contents"
							readonly="readonly" class="easyui-validatebox"
							style="width: 470px; height: 300px; font-size: 12px; border-style: none;"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<script type="text/javascript">
		$datagrid = $('#wxMessage-table');
		$fm = $('#fm');
		$msgDlg = $('#field-dlg');
		
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : false,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : false,
			buttonDelete : true,
			buttonCopy : false,
			buttonExport : true,
			buttonImport : false,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/wxMessage/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/wxMessage/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/wxMessage/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/wxMessage/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},
			onChangeSelectedItem:function(row){
				//$datagrid.hdatagrid("changeParentItemAndParams",{WxMessageId:row.id});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editWxMessagePrice()" iconCls="icon-edit" plain="true">修订</a>',that);
				//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);
			
			},
			/**
			 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
			 */
			//readOnlyCondition: function(row, that){
			//	return false;
			//},
		});

	   
		
		
		var editFormatter = function(value,row,index){
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
		function WxMessageSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.WxMessageStatus == '新建'||row.WxMessageStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/WxMessage/WxMessageSubmit', 
				{
					id	: row.id,
					WxMessageStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.WxMessageStatus+'，无法提交！', 'error');
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
		订阅者关注时间格式
	 */
	function createTimeFormatter(val, row) {
		return getDateTime(val);
	}

	/**
		时间格式
		@param milliseconds 毫秒数
	 */
	 function getDateTime(timestamp) {
			if (timestamp != "" && timestamp != null
					&& timestamp != "null") {
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
			消息类型格式 
		*/
		function msgTypeFormatter(val,row){
			if(val=="text")
				return "文本(text)";
			else if(val=="image")
				return "图片(image)";
			else if(val=="voice")
				return "语音(voice)";
			else if(val=="video")
				return "视频(video)";
			else if(val=="shortvideo")
				return "小视频(shortvideo)";
			else if(val=="location")
				return "地理位置(location)";
			else if(val=="link")
				return "链接(link)";
			else
				return "";
		}
		
		
		/**
			消息内容格式 
		*/
		function fieldFormatter(val, row, index) {
			if (val == null) {
				val = '';
			}
			var content = "点击查看详细";
			return "<a href='###' class='easyui-tooltip' title='" + content
					+ "' onClick='fieldDetailShow(" + index + ")'>" + val
					+ "</a>";
		}

		function fieldDetailShow(index) {
			var selectRow = $datagrid.hdatagrid('getRows')[index];
			$msgDlg.dialog('open').dialog('setTitle', '消息内容');
			$fm.form('load', selectRow);
		}
	</script>
</body>
</html>
