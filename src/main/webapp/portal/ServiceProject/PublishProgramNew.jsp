<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
 <%@ include file="/portal/header.jsp" %>
 
<style type="text/css">
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
	width:180px;
}
.td-label-1{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
	width:102px;
/* 	width:85px; */
}
.td-content {
	padding-right:8px;
	width:600px;
}
.td-content input{
	width:100%;
	height:60px;
	text-align:left;
}
.td-content textarea{
	width:100%;
	height:60px;
	text-align:left;
}

/* .td-content .input-width{
	width:100%;
} */


.td-showselect {
	/* padding-right:6px; */
	padding-right:2px;
}
.td-showselect input{
	/* width:800px; */
	width:600px;
}
.td-input{
	/* width:270px; */
	width:220px;
	height:30px;
	/* border:1px solid #00ff00; */
}

.td-input input{
	/* width: 28%; */
	width: 22%;
	
}
fieldset{
	margin:10px 10px;
	border:1px solid #acacac;
}
.delIcon{
	width:10px;
	height:10px;
	background:url('/static/images/icon_warn.png')
}

#developers{
	height:60px;
	border:1px solid #A9A9A9;
	width:100.6%;
	background:#EBEBE4;
}
#relatedTasks{
	height:100px;
	border:1px solid #A9A9A9;
	width:100.6%;
	overflow:scroll;
	background:#EBEBE4;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'center'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;" title="" >
		<form id="publishProrgramEditForm" method="post">
			<fieldset>
			<legend>程序发布申请表</legend>
			<table id="publish-program-table" style="padding-left:3%;">	
				
         		
		       	<tr>
		       		<td class="td-label"><label>名称：&nbsp;</label></td>
		       		<td class="td-input"><input  id="name" name="name"  class="easyui-textbox"  editor="{type:'textbox',options:{required:true}}"/>
					</td>
		       		<td class="td-label-1"><label>类型：&nbsp;</label></td>
		       		<td class="td-input"><input class="easyui-combobox" id="type" data-options="required:true"/>
					</td>
		       	</tr>
		       	<tr>
		       		<td class="td-label"><label>发起人：&nbsp;</label></td>
		       		<td class="td-input">
		       			<input  id="originator" name="originator" disabled class="easyui-textbox" editor="{type:'textbox',options:{required:true}}"/>
		       		</td>
		 	
		       		<td class="td-label-1"><label>审核状态：&nbsp;</label></td>
		       		<td class="td-input">
		       			<input id="auditStatus" class="easyui-textbox" disabled/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td class="td-label"><label>项目：&nbsp;</label></td>
		       		<td class="td-showselect" colspan="3"><input style="width:100%;" class="easyui-textbox" id="project" editor="{type:'textbox',options:{required:true}}" /> 
					</td>
		       	</tr>
		       	<tr>
		       		<td  class="td-label"><label>审核历史：&nbsp;</label></td>
		       		<td  class="td-content" colspan="3">
		       			<textarea rows="8" id="flowRecordHistory" name="flowRecordHistory" disabled></textarea>
<!-- 		       			<input id="flowRecordHistory" name="flowRecordHistory" disabled  editor="{type:'textbox',options:{required:true}}" />
 -->		       		</td>
		       		
		       	</tr>
		       	<tr>
		       		<td class="td-label"><label>申请说明：&nbsp;</label></td>
		       		<td class="td-content" colspan="3">
		       		<textarea rows="8" id="applyComment" name="applyComment"></textarea>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td class="td-label"><label>审批意见：&nbsp;</label></td>
		       		<td class="td-content" colspan="3">
		       		<textarea rows="8"  id="auditSuggestion" name="auditSuggestion" disabled></textarea>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td class="td-label"><label>开发人员：&nbsp;</label></td>
		       		<td class="td-content" colspan="3">
		       			<div id="developers" name="develpopers" disabled></div>
		       		</td>
		       		<td id="developersBtn"><a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" 
		    		plain="false" style="width: 80px;height:20px;margin-bottom:10px;"id="addDevelopers" onclick="addDevelopers()">增加</a><br>
		    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeAllSelected('developers')" style="width: 80px;height:20px;">清空</a>
		    		</td>
		       	</tr>
		       	<tr>
		       		<td class="td-label">相关任务：&nbsp;</td>
		       		<td class="td-content" colspan="3">
		       			<div id="relatedTasks" name="relatedTasks" disabled> </div> 
		       		</td>
		       		<td id="relatedTasksBtn"><a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" 
		    		plain="false" style="width: 80px;height:20px;margin-bottom:10px;"id="addTasks" onclick="addTasks()">增加</a><br/>
		    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeAllSelected('relatedTasks')" style="width: 80px;height:20px;">清空</a>
		    		</td>
		       	</tr>
		       	<tr>
		       		<td rowspan="2" class="td-label"><label>执行情况：&nbsp;</label></td>
		       		<td rowspan="2" colspan="3" class="td-content">
		       		<textarea rows="8"  id="implementation" name="implementation"></textarea>
		       		</td>
		       	</tr>
		       	<input type="hidden" id="id" name="id" />
		       	<input type="hidden" id="row_status" name="row_status" />
		       	<input type="hidden" id="developerIds" name="developerIds" />
		       	<input type="hidden" id="publishStatus" name="publishStatus" />
		    </table>
		</form>
		    <div style="width:100%;height:30px;padding:0px;margin-top:20px;">
		   		<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
		    		plain="false" style="margin-left:320px;width: 100px;height:30px;" onclick="submitForm()">保存</a>
		    	<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
					plain="false" style="margin-left:160px;width: 100px;height:30px;" onclick="goBack()">返回</a>
		   	<!-- 	<a id="publishRefuse" href="javascript:void(0)" id="btn_no" class="easyui-linkbutton" iconCls="icon-no" 
		    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="publishRefuse()">审批拒绝</a>
		   		<a id="publishAgree" href="javascript:void(0)" id="btn_ok" class="easyui-linkbutton" iconCls="icon-ok" 
		    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="publishAgree()">审批通过</a> -->
		    </div>
		    </fieldset>
		</div>
	</div>
</div>
    

<script type="text/javascript">
getLovOfList("[PROGRAM_APPROVAL_STATUS,LNK_SRPRO_PROJECT,PUBLISH_TYPE]");
$datagrid = $('#publish-program-table');
$projectPickList=$("#project");
$typeCombobox=$("#type");
var id=$("#id").val();
var $publishProrgramEditForm = $("#publishProrgramEditForm");

/* $publishStatusCombobox.combobox({
	method:'get',
	data:getLovArray('PROGRAM_APPROVAL_STATUS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false    
}); */
$("#name").textbox({
	required:true
});
$("#originator").textbox({
	required:true
});
$("#auditStatus").textbox({
	required:false
});
$projectPickList.picklist({
	title : '选择项目',
	/* initParam : function() {
		//var row = $datagrid.hdatagrid('getCurrentRow');
		return {
			id : initAcctId
		}
	}, */
	completeFun : function(selectedRow) {
		$('#project').val(selectedRow.projName);
		return selectedRow.projName;
	},
	tableUrl : '${AppContext.ctxPath}/portal/picklist/SrproProjectPickList.jsp'
});
$typeCombobox.combobox({
	method:'get',
	data:getLovArray('PUBLISH_TYPE'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});
function goBack(){
	//gotoContentPage('${AppContext.ctxPath}/portal/order/SaleOrderList.jsp');
	var row_status=$('#row_status').val();
	//alert(row_status);
	if(row_status=='readOnly'){
		window.parent.readOnlyWinClose("CANCEL");
	}else{
		window.parent.editWinClose("CANCEL");
	}
}
function submitForm(){
	var type = $('#type').combobox('getValue');
	var name = $('#name').textbox('getValue');
	var project = $('#project').textbox('getValue');
	if (type==null){
		alert('类型不能为空！');
	}
	if (name==null){
		alert('名字不能为空！');
	}
	if (project==null){
		alert('项目不能为空！');
	}
	
	//var relatedTasks = $('#relatedTasks').text();
	//var tasks = relatedTasks.split("%%%").join("");
	$.post('${AppContext.ctxPath}/action/portal/publishProgram/upsert',
	{
		row_status			: $('#row_status').val(), 
		id					: $('#id').val(),
		name				: $('#name').textbox('getValue'),
		type				: $('#type').combobox('getValue'),//类型
		auditStatus			: $('#auditStatus').val(),	
		publishStatus		: $('#publishStatus').val(),
		originator			: $('#originator').val(),
		project				: $('#project').textbox('getValue'),
		flowRecordHistory	: $('#flowRecordHistory').val(),
		applyComment		: $('#applyComment').val(),
		auditSuggestion		: $('#auditSuggestion').val(),
		developers 			: $('#developers').text(),	
		relatedTasks		: $('#relatedTasks').text(),
		implementation		: $('#implementation').val()
    },function(data){
    	if(!data.success){
			window.parent.operationtip(data.result, 'error');
		}else{
			//alert("保存成功");
			window.parent.editWinClose($("#row_status").val(), data.newRow);
		}
	});
}

function addDevelopers(){
	var project =$('#project').textbox('getValue');
	if(project==''||project==null){
		alert("请选择一个项目后再重试");
		//$.messager.alert('错误', '请选择一个项目后再重试!', 'error');
		return;
	}
	$('#developers').multiSelect({
		title:'添加开发人员',
		initParam:function(){
			//alert(project);
			return {project:project,developers:$("#developers").text()};
		},
		tableUrl:'${AppContext.ctxPath}/portal/ServiceProject/dialog/DevelopersMultiSelect.jsp',
		completeFun:function(selectedRows){
			for(var i =0; selectedRows != null && i<selectedRows.length;i++){
				$("#developers").append("<span style='height:20px;' onmouseleave='hideIcon(this)' onmouseover='showIcon(this)' onclick='removeSelected(this)'>"+selectedRows[i].firstName+",</span>");
			} 
			console.info($('#developers').text());
			return developers;
		}
	});
}

	
function addTasks(){
		var project =$('#project').textbox('getValue');
		if(project==''||project==null){
			alert("请选择一个项目后再重试");
			//$.messager.alert('错误', '请选择一个项目后再重试!', 'error');
			return;
		}
	$('#relatedTasks').multiSelect({
		title:'添加相关任务',
		initParam:function(){
			return {project:project,relatedTasks:$("#relatedTasks").text()};
		},
		tableUrl:'${AppContext.ctxPath}/portal/ServiceProject/dialog/TasksMultiSelect.jsp',
		completeFun:function(selectedRows){
			if(selectedRows.length==0){
				$('#relatedTasks').text("无");
			}
			for(var i =0; selectedRows != null && i<selectedRows.length;i++){
				$("#relatedTasks").append("<div onmouseleave='hideIcon(this)' onmouseover='showIconTask(this)' onclick='removeSelected(this)'>"+selectedRows[i].rFirstName+"-"+selectedRows[i].abstracts+"<span hidden>%%%</span></div>");
			}
			//console.info($('#relatedTasks').text());
			return relatedTasks;
		}
	});
}


function initInfo(id,publishProgram){
	if(id){
		$.post('${AppContext.ctxPath}/action/portal/publishProgram/queryById', 
				{
					id	: id
			    },
				function(data){
			    	if(data.success){
			    		var obj = data.result;
			    		//alert("更新");
			    		if(!obj.row_status){
			    			obj.row_status = 'UPDATE';//设为更新状态
			    		}
			    		fillData(obj);
					}else if(data.result){
						$.messager.alert('错误',data.result, "error");
					}else{
						$.messager.alert("错误", "加载数据出错啦!", "error");
					}
				});
	}else if(publishProgram){
		var obj = publishProgram;
		//alert(obj.row_status);
		if(!obj.row_status){
			$.messager.alert("错误", "加载数据出错啦!<br>无法识别当前为更新或新建状态", "error");
			return;
		}
		//console.info(obj);
		fillData(obj);
	}else{
		$.messager.alert("错误", "加载数据出错啦!<br>请传入正确参数", "error");
	}
}

function fillData(obj){
	$publishProrgramEditForm.form("load", obj);
	if(obj.row_status == 'UPDATE'){
		$('#type').combobox('setValue',obj.type);
		$('#project').textbox('setValue',obj.project);
		$('#auditStatus').val(obj.auditStatus);
		$('#auditSuggestion').val(obj.auditSuggestion);
		$('#flowRecordHistory').val(obj.flowRecordHistory);
		var developers = obj.developers;
		if(developers){
			var developerArr = developers.split(",");
			for(var i =0; developerArr != null && i<developerArr.length-1;i++){
				$("#developers").append("<span style='height:20px;' onmouseleave='hideIcon(this)' onmouseover='showIcon(this)' onclick='removeSelected(this)'>"+developerArr[i]+",</span>");
			} 
		}
		var relatedTasks= obj.relatedTasks;
		if(relatedTasks){
			relatedTaskArr = relatedTasks.split("%%%");
			for(var i =0; relatedTaskArr != null && i<relatedTaskArr.length;i++){
				$("#relatedTasks").append("<div onmouseleave='hideIcon(this)' onmouseover='showIconTask(this)' onclick='removeSelected(this)'>"+relatedTaskArr[i]+"<span hidden>%%%</span></div>");
			} 
		}
	}
	if(obj.row_status== 'readOnly'){
		//alert("只读");
		$('#type').combobox({disabled: true});
		$('#project').combobox({disabled: true});
		
		$('#type').combobox('setValue',obj.type);
		$('#project').textbox('setValue',obj.project);
		$('#developers').text(obj.developers);	
		$('#auditStatus').val(obj.auditStatus);
		$('#auditSuggestion').val(obj.auditSuggestion);
		$('#flowRecordHistory').val(obj.flowRecordHistory);
		
		$('#name').textbox('textbox').attr('disabled',true);
		
		$('#applyComment').attr("disabled",true);
		$('#implementation').attr("disabled",true);
		
		$('#btn_submit').css("display","none");
		
		$("#developersBtn").hide();
		$("#relatedTasksBtn").hide();
		
		var relatedTasks = obj.relatedTasks;
		if(relatedTasks){
			var html="";
			var tasksArr = relatedTasks.split("%%%");
			for(var i=0;i<tasksArr.length;i++){
				//html += "<div style='width:100%;'>"+tasksArr[i]+"</div>"
				$('#relatedTasks').append("<span>"+tasksArr[i]+"</span><br/>");;
			}
			//$('#relatedTasks').css("width","700px");
			//$('#relatedTasks').html(html);	
		}
		//$publishProrgramEditForm.attr('readOnly',true);
	}	
}

var tag=true;
function removeSelected(target){
	$(target).remove();
	tag=true;
}
function removeAllSelected(id){
	document.getElementById(id).innerHTML='';
}
function showIcon(target){
	if(tag){
		$(target).append("<img style='width:10px;height:10px;margin-bottom:5px;' src='/static/images/icon_warn.png'></span>")
		tag=false;
	}
	$(target).css({
		"background":"#FFF3F3",
		"border":"1px solid #FFA8A8"
	});
	//console.info("showIcon");
}
function showIconTask(target){
	if(tag){
		$(target).prepend("<img style='width:10px;height:10px;margin-bottom:5px;' src='/static/images/icon_warn.png'></span>")
		tag=false;
	}
	$(target).css({
		"background":"#FFF3F3",
		"border":"1px solid #FFA8A8"
	});
	//console.info("showIcon");
}

function hideIcon(target){
	console.info("hideIcon");
	$(target).children('img').remove()
	tag=true;
	$(target).css({
		"background":"#EBEBE4",
		"border":"none"
	});
}

/**
 * 在操作列添加按钮
 */
function optAcctFormatter(val,row,index){
	var html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRowByIndex(\'developers\',\''+index+'\')" iconCls="icon-cancel" plain="true"></a>';
	return html;
}


</script>
</body>
</html>