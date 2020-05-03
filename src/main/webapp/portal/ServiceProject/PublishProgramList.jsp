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
				<span class="x-fieldset-title">快速筛选</span>
			</legend>

			<div class="row keyfilter-border">
				<ul id="publishType" data-toggle="keyfilter" data-title="发布状态"
					data-filter-filed="publishStatus" data-table-Id="publishProgram-table"></ul>
			</div> 
		</fieldset>
	
	<table id="publishProgram-table" style="height:100%;width:100%" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" formatter="publishProgramIdFormatter">编号</th>
				<th field="name" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >程序发布名称</th>
				<th field="type" noSearch="false" defaultSearch="false" lov="PUBLISH_TYPE" width="100px" editor="{type:'combobox',options:{valueField:'val',
				textField:'name',data:getLovArray('PUBLISH_TYPE'),editable:false,required:false}}"  >发布类型</th>
				<th field="originator" noSearch="false" defaultSearch="false" width="100px" editor="{type:'validatebox',options:{required:false}}"  >发起人</th>
				
				<!-- <th field="publishStatus" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >状态</th> --><!-- 审核状态 -->
				<th field="publishStatus" width="60px" lov="PROGRAM_PUBLISH_STATUS"
						editor="{type:'combobox',options:{valueField:'val',
				textField:'name',method:'get',data:getLovArray('PROGRAM_PUBLISH_STATUS'),editable:false,required:true}}">状态</th><!-- 审核状态 -->
				<th field="applyComment" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >备注</th><!-- 申请说明 -->
				<th field="created" width="150px" >创建时间</th>
				<th field="auditDate" noSearch="false" defaultSearch="false"   width="150px" editor="{type:'validatebox',options:{required:false}}"  >审核日期</th>
					<th field="lastAuditorName" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >最后审核人</th>
				<th field="auditHistoryId" width="60px" formatter="flowHisFormatter">审核历史</th>
				
				
				<th field="project" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  hidden>项目</th>
				<th field="auditSuggestion" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  hidden>审批意见</th>
				<th field="developers" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  hidden>开发人员</th>
				<th field="relatedTasks" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  hidden>相关任务</th>
				<th field="implementation" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  hidden>执行情况</th>
 				
			</tr>
		</thead>
	</table>
	
	</div>
	<div id="readOnlyWin" class="crmWin" style="width:100%; height:100%">
    <iframe src=""  id="readOnlyWinFram" name=readOnlyWinFram width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
   	<div id="editWin" class="crmWin" style="width:100%; height:100%">
    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="100%" frameborder="0" scrolling="yes">
    </iframe>
    </div>
   	<div id="nextUserDiv" style="display:none">
  		<input id="nextUser">
  	</div>
   	
	<script type="text/javascript">
	getLovOfList("[PUBLISH_TYPE]");
	getLovOfList("[PROGRAM_PUBLISH_STATUS]");
	$readOnlyWin = $("#readOnlyWin");
	$readOnlyWinFram = $("#readOnlyWinFram");
	$editWin = $("#editWin");
	$editWinFram = $("#editWinFram");
	
/* 	$readOnlyWin.window({
		title: "申请详情",
		top: 0,
		width:'100%',
		height:'100%',
		closed:true,
		border:false,//边框
		shadow:false,
		draggable:false,//拖曳
		minimizable:false,//最小化按钮
		maximizable:false,
		resizable: false,//改变大小
	}); */
	
		$datagrid = $('#publishProgram-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : false,
			toolbarShow : true,
			buttonSearch : true,
			//buttonNew : true,
			buttonDelete : true,
			buttonCopy : false,
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/publishProgram/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			buttonBatchEdit : true,//批量修改
			
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/publishProgram/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/publishProgram/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/publishProgram/deleteById', {
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{PublishProgramId:row.id});
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
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="PublishProgramSubmit()">申请发布</a>',that);
				addButtonFun(1,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="PublishProgramNew()">添加</a>',that);
				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editPublishProgram()" iconCls="icon-edit" plain="true">编辑</a>',that);
				addButtonFun(21,'<a href="javascript:void(0)" id="btn-inactive" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="publishSuccess()">发布成功</a>',that);
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
		
		$('#publishType').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/PROGRAM_PUBLISH_STATUS'
		});
		
		function PublishProgramSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.publishStatus != 'No Published'){
				alert("该程序发布申请状态不对，无法提交审批");
				return;
			}
			/* if(row.publishStatus == 'No Published'){ */
				$.post('${AppContext.ctxPath}/action/portal/publishProgram/PublishProgramSubmit', 
				{
					id	: row.id/* ,
					publishStatus : 'Submitted' */
			    },
				function(data){
			    	if(!data.success){
						//window.parent.operationtip(data.result, 'error');
			    		if(data.mustSelectUser){
							$('#nextUser').picklist("destroy")
							$('#nextUser').picklist({
								title:'选择审批人',
						        required:false,
						        initParam:function(){
						        	return {
						        		nodeId:data.nodeId,
						        		userId:data.userId
						        	};
						        },
						        completeFun:function(selectedRow){
						    		$.post("${AppContext.ctxPath}/action/portal/publishProgram/PublishProgramSubmit",{
						    			id	: row.id,
						    			selectUserId	:selectedRow.id
						    		}, function(data){
						    			if(data.success){
						    				$.messager.alert("提示","已申请程序发布！");
											$datagrid.datagrid('reload');
						    			}else{
											$.messager.alert("提示",data.result);
										}
						    		});
						        },
						        tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/userSelectPickList.jsp'
							});
							$('.searchbox-button','#nextUserDiv').click();
						}else{
							$.messager.alert("提示",data.result);
						}
					}else{
						$datagrid.datagrid('reload');
					}
				});
			/* }else{
				window.parent.operationtip('该程序发布状态为'+row.publishStatus+'，无法提交！', 'error');
			} */
		}
		
		function PublishProgramNew(){
			$.post("${AppContext.ctxPath}/action/portal/publishProgram/initNew", {}, function(data){
				if(data.success){
					if( !$editWinFram.attr("src") ){//弹出窗口
						$editWinFram.attr("src", "${AppContext.ctxPath}/portal/ServiceProject/PublishProgramNew.jsp");
						$editWinFram[0].onload = function() {
							$editWinFram[0].contentWindow.initInfo('', data.result);//等待窗口加载完毕
						}
					}else{
						$editWinFram[0].contentWindow.initInfo('', data.result);
					}
					$editWin.css("display", "block");
				}else{
					$.messager.alert("错误", data.result, "error");
				}
			});
		}
		function editPublishProgram(){
			var row = $datagrid.datagrid('getSelected');
			if(row.publishStatus!="No Published"){
				alert("无法对该程序发布申请进行编辑");
				return;	
			}
			$.post("${AppContext.ctxPath}/action/portal/publishProgram/queryById", {id:row.id}, function(data){
				if(data.success){
					if( !$editWinFram.attr("src") ){//弹出窗口
						$editWinFram.attr("src", "${AppContext.ctxPath}/portal/ServiceProject/PublishProgramNew.jsp");
						$editWinFram[0].onload = function() {
							$editWinFram[0].contentWindow.initInfo(row.id, data.result);//等待窗口加载完毕
						}
					}else{
						$editWinFram[0].contentWindow.initInfo(row.id, data.result);
					}
					$editWin.css("display", "block");
				}else{
					$.messager.alert("错误", data.result, "error");
				}
			});
		}
		function windowShow(id){
 			if(id){
				$.post("${AppContext.ctxPath}/action/portal/publishProgram/queryById", {id:id}, function(data){
					if(data.success){
						var publishProgram = data.result;
						publishProgram.row_status="readOnly";
						if( !$readOnlyWinFram.attr("src")){
							$readOnlyWinFram.attr("src", "${AppContext.ctxPath}/portal/ServiceProject/PublishProgramNew.jsp");
							$readOnlyWinFram[0].onload = function() {
								//publishProgram.row_status="readOnly";
								//alert(publishProgram);
								$readOnlyWinFram[0].contentWindow.initInfo('',data.result);//等待窗口加载完毕
							}
						}else{
							$readOnlyWinFram[0].contentWindow.initInfo('',data.result);
						}
						$readOnlyWin.css("display", "block");
					}else{
						$.messager.alert("错误", data.result, "error");
					}
				});
 			}
		}
		function publishSuccess(){
			var row = $datagrid.hdatagrid('getSelected');
			//alert(row.publishStatus);
			if(row.publishStatus!="Pending Published"){
				alert("无法修改该程序发布申请的状态");
				return;
			}
			if(row){
				$.post('${AppContext.ctxPath}/action/portal/publishProgram/updatePublishStatus',{
					id : row.id,
				},function(data){
					if(data.success){
						$.messager.alert("提示","发布成功！");
						var index = $wxcpadatagrid.hdatagrid('getRowIndex', row);
						$datagrid.hdatagrid("refreshRow", index);
						refreshAddrToolBar();
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				});
			}
		}
		function editWinClose(operate,publishProgram){
			//$editWin.window("close");
			$editWin.css("display", "none");
			if(operate == "CANCEL"){
				return;
			}
			if(!publishProgram){
				$.messager.alert("警告", "获取新数据失败，请刷新数据", "warning");
				return;
			}
			if(operate == "NEW"){
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.datagrid('getRowIndex', row);
				$datagrid.datagrid('insertRow',{index: index, row: publishProgram});	
				$datagrid.datagrid('acceptChanges');
				$datagrid.datagrid("selectRow", index);
			}else if(operate == "UPDATE"){
				//关闭编辑窗口时刷新编辑后数据
				//$datagrid.datagrid('rejectChanges');
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.hdatagrid('getRowIndex', row);
				$datagrid.datagrid('updateRow', {index: index, row:publishProgram});
				$datagrid.datagrid('acceptChanges');
			}else{
				$.messager.alert("警告", "无法识别操作，刷新数据失败！", "warning");
			}
		}
		function readOnlyWinClose(operate,publishProgram){
			//$editWin.window("close");
			$readOnlyWin.css("display", "none");
			if(operate == "CANCEL"){
				return;
			}
			if(!publishProgram){
				$.messager.alert("警告", "获取新数据失败，请刷新数据", "warning");
				return;
			}
			if(operate == "NEW"){
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.datagrid('getRowIndex', row);
				$datagrid.datagrid('insertRow',{index: index, row: publishProgram});	
				$datagrid.datagrid('acceptChanges');
				$datagrid.datagrid("selectRow", index);
			}else if(operate == "UPDATE"){
				//关闭编辑窗口时刷新编辑后数据
				//$datagrid.datagrid('rejectChanges');
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.hdatagrid('getRowIndex', row);
				$datagrid.datagrid('updateRow', {index: index, row:publishProgram});
				$datagrid.datagrid('acceptChanges');
			}else{
				$.messager.alert("警告", "无法识别操作，刷新数据失败！", "warning");
			}
		}
		function publishProgramIdFormatter(val,row){
			if (val != null) {
				var content = "程序发布申请编号:" + row.id + "\n申请名称:" + row.name;
			    return "<a class='easyui-tooltip' title='"
			    		+content+
			    		"' href='javascript:void(0)' onclick='windowShow(\""+row.id+"\")'>" + val + "</a>";
			}	
		}	
		
		function flowHisFormatter(val,row){
		     if(val != null){
		    	 var url = '${AppContext.ctxPath}/portal/approval/FlowDetail.jsp?flowId=' + row.auditHistoryId +'&flowObjId='+row.id;
	 		     var URL = '<a href="###" onclick="gotoContentPage(\'' + url + '\')">' + '审批历史' + '</a>';
		    	 return URL; 
		     }
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
		
		function productPicklistComplete(selectRow){ 
			$datagrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			});
			return selectRow.prodName;
		}
		*/
	</script>
</body>
</html>
