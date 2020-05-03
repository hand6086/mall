<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.js?version=<%=version%>"></script>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.css?version=<%=version%>">
<style type="text/css">
.context{padding-top: 10px;}
.context-item{width: 400px;height: 400px;margin: 0 auto}
.context-item .title-div{width: 100%;height: 50px;}
.context-item .title-div .item-title {width: 50%;height: 100%;line-height: 50px;text-align: left;float: left;}
.context-item .title-div .item-opt {width: 50%;height: 100%;line-height: 50px;text-align: right;float: right;}
.context-item .list-div{width: 100%;height: 300px;border: solid 1px #ddd;}
.context-item .opt-div{width: 100%;height: 50px;line-height: 50px;text-align: center;}
/* 修改列表的行高 */
.context-item .list-div .datagrid-btable tr{height: 40px;}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div region="center" border="false">
			<div id="guide-step"></div><!-- 步骤条 -->
			<div class="context">
				<table style="width: 100%;">
					<tr>
						<td>
							<div class="context-item left">
								<div class="title-div">
									<div class="item-title" style="width: 40%;">
										<span>针对指定客户应用政策</span>
									</div>
									<div class="item-opt" style="width: 60%;">
										<a href="javascript:void(0)" class="easyui-linkbutton" id="selectAcct" 
											onclick="selectAcctWindow()" iconCls="icon-add" style="width: 100px;margin-right: 10px;">选择客户</a>
										<a href="javascript:void(0)" class="easyui-linkbutton" id="selectAcctType" 
											onclick="selectAcctTypeWindow()" iconCls="icon-add" style="width: 100px;">选择类型</a>
									</div>
								</div>
								<div class="list-div">
									<table id="acct-table" fit="true">
										<thead>
											<tr>
												<th field="accntName" width="80%">客户名称</th>
												<th field="opt" width="11%" align="right" formatter="optAcctFormatter"></th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="opt-div">
									<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="delAllRow('acct-table')" style="width: 100px;">全部清空</a>
								</div>
							</div>
						</td>
						<td>
							<div class="context-item left">
								<div class="title-div">
									<div class="item-title">
										<span>针对指定区域应用政策</span>
									</div>
									<div class="item-opt">
										<a href="javascript:void(0)" class="easyui-linkbutton" id="selectRgn" 
											onclick="selectRgnWindow()" iconCls="icon-add" style="width: 100px;">选择区域</a>
									</div>
								</div>
								<div class="list-div">
									<table id="rgn-table" fit="true">
										<thead>
											<tr>
												<th field="addrName" width="80%">区域名称</th>
												<th field="opt" width="11%" align="right" formatter="optScpFormatter"></th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="opt-div">
									<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="delAllRow('rgn-table')" style="width: 100px;">全部清空</a>
								</div>
							</div>
						</td>
						<td>
							<div class="context-item left">
								<div class="title-div">
									<div class="item-title">
										<span>针对指定组织应用政策</span>
									</div>
									<div class="item-opt">
										<a href="javascript:void(0);" class="easyui-linkbutton" id="selectOrg" 
											onclick="selectOrgWindow()" iconCls="icon-add" style="width: 100px;">选择组织</a>
									</div>
								</div>
								<div class="list-div">
									<table id="org-table" fit="true">
										<thead>
											<tr>
												<th field="orgName" width="80%">组织名称</th>
												<th field="opt" width="11%" align="right" formatter="optOrgFormatter"></th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="opt-div">
									<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="delAllRow('org-table')" style="width: 100px;">全部清空</a>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div region="south" border="false" style="height:40px;">
			<div style="width: 100%; height: 40px;line-height:40px; text-align:right; background:#e8f1ff;">
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-undo" 
						onclick="prevOpt()" style="width: 100px;margin-right: 20px;">上一步</a> 
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-redo" 
						onclick="nextOpt()" style="width: 100px;margin-right: 20px;">下一步</a>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	initData(policy);
});
var policy = window.parent.$guideWinFram.wholePolicy;
createStepFlow('guide-step', 2);

/**
 * 上一步
 */
function prevOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	saveObj(policy);
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep1.jsp");
}
/**
 * 下一步
 */
function nextOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	$.post('${AppContext.ctxPath}/action/portal/pcyRule/preDefaultValue',{},function(data){
		if (data.success) {
			saveObj(policy);
			policy.newPcyRule = {
					id : data.result.id,
					row_status : 'NEW'
			};//新建的规则
			window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep3.jsp");
		} else {
			$('.step-opt').linkbutton('enable');//解锁按钮
			$.messager.alert("错误", data.result, "error");
		}
	});
}
/**
 * 保存并返回对象值
 */
function saveObj(pcyObj){
	var obj = pcyObj;
	obj.scpAccList = $acctDatageid.datagrid('getRows');
	obj.scpRgnList = $rgnDatageid.datagrid('getRows');
	obj.scpOrgList = $orgDatageid.datagrid('getRows');
	//初始化规则list
	if(obj.ruleList == undefined){
		obj.ruleList = [];
	}
}

/**
 * 初始化列表数据
 */
function initData(pcyObj){
	var obj = pcyObj;
	if(obj.scpAccList == undefined){
		obj.scpAccList = [];
	}
	if(obj.scpRgnList == undefined){
		obj.scpRgnList = [];
	}
	if(obj.scpOrgList == undefined){
		obj.scpOrgList = [];
	}
	$acctDatageid.datagrid({data:{rows:obj.scpAccList}});
	$rgnDatageid.datagrid({data:{rows:obj.scpRgnList}});
	$orgDatageid.datagrid({data:{rows:obj.scpOrgList}});
}


var $acctDatageid = $('#acct-table');
var $rgnDatageid = $('#rgn-table');
var $orgDatageid = $('#org-table');
/* --------------------------------- 客户列表 ----------------------------------------- */
$acctDatageid.datagrid({
	striped : true,
	border : false,
	rownumbers : true,
	singleSelect : true,
	showHeader : false,//隐藏表头
	onLoadSuccess:function(data){
		$('.opt-btn').linkbutton();
	}
});

/**
 * 在操作列添加按钮
 */
function optAcctFormatter(val,row,index){
	var html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRowByIndex(\'acct-table\',\''+index+'\')" iconCls="icon-cancel" plain="true"></a>';
	return html;
}

/**
 * 打开选择客户的窗口
 */
function selectAcctWindow(){
	$('#selectAcct').multiSelect({
		title:'选择客户',
		completeFun:function(selectedRows){
			for(var i = 0; selectedRows != null && i < selectedRows.length; i++){
				var selectedRow = selectedRows[i];//已选中的行
				var newRow = {
						row_status : 'NEW',
						pcyId : policy.id,
						accntId : selectedRow.id,
						accntName : selectedRow.acctName
				};//新插入的行
				$acctDatageid.datagrid('insertRow', {index:0,row:newRow});
			}
			$acctDatageid.datagrid('acceptChanges');
			$acctDatageid.datagrid('loadData', $acctDatageid.datagrid('getRows'));
		},
		initParam:function(){
			var filterVal = objListJoinAry($acctDatageid.datagrid('getRows'), 'accntId');
			return {filtersRaw:'[{"id":"pcyScpAcctId","property":"id","operator":"NOT IN","value":"'+filterVal+'"}]'};
		},
		tableUrl:'${AppContext.ctxPath}/portal/policy/picklist/accntMultiSelect.jsp'
	});
};
/**
 * 打开选择客户类型的窗口
 */
function selectAcctTypeWindow(){
	$('#selectAcctType').multiSelect({
		title:'选择客户类型',
		completeFun:function(selectedRows){
			for(var i = 0; selectedRows != null && i < selectedRows.length; i++){
				var selectedRow = selectedRows[i];//已选中的行
				var newRow = {
						row_status : 'NEW',
						pcyId : policy.id,
						accntType : selectedRow.val,
						accntName : '类型：['+selectedRow.name+']'
				};//新插入的行
				$acctDatageid.datagrid('insertRow', {index:0,row:newRow});
			}
			$acctDatageid.datagrid('acceptChanges');
			$acctDatageid.datagrid('loadData', $acctDatageid.datagrid('getRows'));
		},
		initParam:function(){
			var filtersRaw = [];
			filtersRaw.push({id:'activeFlag',property:'activeFlag',value:'Y'});
			filtersRaw.push({id:'type',property:'type',value:'ACCT_TYPE'});
			var accntTypeFilterVal = objListJoinAry($acctDatageid.datagrid('getRows'), 'accntType');
			filtersRaw.push({id:"pcyScpAcctType",property:"val",operator:"NOT IN",value:accntTypeFilterVal});
			return {filtersRaw:formatRequest({filtersRaw:filtersRaw}).filtersRaw};
		},
		tableUrl:'${AppContext.ctxPath}/portal/policy/picklist/accntTypeMultiSelect.jsp'
	});
};

/* --------------------------------- 区域列表 ----------------------------------------- */
$rgnDatageid.datagrid({
	striped : true,
	border : false,
	rownumbers : true,
	singleSelect : true,
	showHeader : false,//隐藏表头
	onLoadSuccess:function(data){
		$('.opt-btn').linkbutton();
	}
});
/**
 * 在操作列添加按钮
 */
function optScpFormatter(val,row,index){
	var html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRowByIndex(\'rgn-table\',\''+index+'\')" iconCls="icon-cancel" plain="true"></a>';
	return html;
}

/**
 * 打开选择区域的窗口
 */
function selectRgnWindow(){
	$('#selectRgn').multiSelect({
		title:'选择区域',
		completeFun:function(selectedRows){
			for(var i = 0; selectedRows != null && i < selectedRows.length; i++){
				var selectedRow = selectedRows[i];//已选中的行
				var newRow = {
						row_status : 'NEW',
						pcyId : policy.id,
						addrId : selectedRow.id,
						addrName : selectedRow.addrName
				};//新插入的行
				$rgnDatageid.datagrid('insertRow', {index:0,row:newRow});
			}
			$rgnDatageid.datagrid('acceptChanges');
			$rgnDatageid.datagrid('loadData', $rgnDatageid.datagrid('getRows'));
		},
		initParam:function(){
			var filtersRaw = [];
			filtersRaw.push({id:'active',property:'active',value:'Y'});
			filtersRaw.push({id:'addrType',property:'addrType',operator:"IN",value:'[State,City]'});
			var filterVal = objListJoinAry($rgnDatageid.datagrid('getRows'), 'addrId');
			filtersRaw.push({id:"pcyScpRgnId",property:"id",operator:"NOT IN",value:filterVal});
			return {filtersRaw:formatRequest({filtersRaw:filtersRaw}).filtersRaw};
		},
		tableUrl:'${AppContext.ctxPath}/portal/policy/picklist/addrpstMultiSelect.jsp'
	});
};

/* --------------------------------- 组织列表 ----------------------------------------- */
$orgDatageid.datagrid({
	striped : true,
	border : false,
	rownumbers : true,
	singleSelect : true,
	showHeader : false,//隐藏表头
	onLoadSuccess:function(data){
		$('.opt-btn').linkbutton();
	}
});
/**
 * 在操作列添加按钮
 */
function optOrgFormatter(val,row,index){
	var html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRowByIndex(\'org-table\',\''+index+'\')" iconCls="icon-cancel" plain="true"></a>';
	return html;
}

/**
 * 打开选择组织的窗口
 */
function selectOrgWindow(){
	$('#selectOrg').multiSelect({
		title:'选择组织',
		completeFun:function(selectedRows){
			for(var i = 0; selectedRows != null && i < selectedRows.length; i++){
				var selectedRow = selectedRows[i];//已选中的行
				var newRow = {
						row_status : 'NEW',
						pcyId : policy.id,
						orgId : selectedRow.id,
						orgName : selectedRow.text
				};//新插入的行
				$orgDatageid.datagrid('insertRow', {index:0,row:newRow});
			}
			$orgDatageid.datagrid('acceptChanges');
			$orgDatageid.datagrid('loadData', $orgDatageid.datagrid('getRows'));
		},
		initParam:function(){
			var filterVal = objListJoinAry($orgDatageid.datagrid('getRows'), 'orgId');
			return {filtersRaw:'[{"id":"pcyScpOrgId","property":"id","operator":"NOT IN","value":"'+filterVal+'"}]'};
		},
		tableUrl:'${AppContext.ctxPath}/portal/policy/picklist/orgMultiSelect.jsp'
	});
};

</script>
</body>
</html>
