<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<link href="${AppContext.ctxPath}/static/icheck/skins/square/_all.css?version=<%=version%>" rel="stylesheet">
<script src="${AppContext.ctxPath}/static/icheck/icheck.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.js?version=<%=version%>"></script>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.css?version=<%=version%>">
<style type="text/css">
.context{padding-top: 10px;width: 1100px;margin: 0 auto;}
.step-form {width: 100%;}
.step-form .item{margin-bottom: 30px;}
.step-form .text-input{width: 500px;}
.step-form .item .title-div{display: inline-block;text-align: right;width: 65px;height: 25px;line-height: 25px;}
.step-form .item .text-div{display: inline-block;vertical-align: top;margin-left: 5px;width: 700px;}
.step-form .item .select-item{display: inline-block;width: 19%;}
#guide-step{margin-left: -100px;}
.ruleTable {width: 700px;min-height: 300px;margin-bottom: 10px;margin-left: 10px;border: solid 1px #ddd;}
/* 修改列表的行高 */
.ruleTable .datagrid-btable tr{height: 40px;}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div region="center" border="false">
			<div class="context">
				<div id="guide-step"></div><!-- 步骤条 -->
				<form class="step-form" method="post">
					<div class="item">
						<div class="title-div">
							<label>规则名称 : </label>
						</div>
						<div class="text-div">
							<input class="easyui-textbox text-input" type="text" name="ruleName" style="height: 26px;"></input>
						</div>
					</div>
					<div class="item">
						<div class="title-div">
							<label>规则类型 : </label>
						</div>
						<div class="text-div ruleType-div">
							<!-- 备份用于静态网页调试 -->
							<!-- <div class="select-item">
								<label">当单政策<input class="iCheck" type="radio" name="ruleType" value="1"/></label>
							</div> -->
						</div>
					</div>
					<div class="item">
						<div class="title-div">
							<label>规则说明 : </label>
						</div>
						<div style="width: 700px;padding-left: 10px;">
							<input class="easyui-textbox" data-options="multiline:true" type="text" name="comments" style="width: 100%;height: 150px;"/>
						</div>
					</div>
					<div class="item">
						<div class="title-div">
							<label>已有规则 : </label>
						</div>
						<div class="ruleTable">
							<table id="rule-table" fit="true">
								<thead>
									<tr>
										<th field="ruleName" width="80%">名称</th>
										<th field="opt" width="11%" formatter="optRuleFormatter"></th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div region="south" border="false" style="height:40px;">
			<div style="width: 100%; height: 40px;line-height:40px; text-align:right; background:#e8f1ff;">
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-undo" 
						onclick="prevOpt()" style="width: 100px;margin-right: 20px;">上一步</a> 
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-redo" 
						onclick="nextOpt()" style="width: 100px;margin-right: 20px;">下一步</a>
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-ok" 
						onclick="jumpEndOpt()" style="width: 100px;margin-right: 20px;">结束</a>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	iCheckInit();
});
var $form = $('.step-form');
var $ruleDatageid = $('#rule-table');
var policy = window.parent.$guideWinFram.wholePolicy;
var pcyRule = policy.newPcyRule;
createStepFlow('guide-step', 3);
ruleTypeInitTag();
/**
 * 上一步
 */
function prevOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep2.jsp");
}
/**
 * 下一步
 */
function nextOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	saveObj(pcyRule);
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep4.jsp");
}

/**
 * 跳到最后一步
 */
function jumpEndOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	policy.newPcyRule = {};//置空新建规则
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep6.jsp");
}

/**
 * 保存并返回对象值
 */
function saveObj(obj){
	var elements = $form.serializeArray();
	$.each(elements, function() {
		obj[this.name] = this.value;
    });
	//初始化规则条件list
	if(obj.conditionList == undefined){
		obj.conditionList = [];
	}
	//初始化规则结果list
	if(obj.resultList == undefined){
		obj.resultList = [];
	}
	return obj;
}

/**
 * 初始化数据
 */
function initData(pcyObj){
	var obj = pcyObj;
	$('.step-form').form("load", pcyRule);
	iCheckInit();
	$ruleDatageid.datagrid({data:{rows:obj.ruleList}});
}

/**
 * 初始化html[规则类型]
 */
function ruleTypeInitTag(){
	$.post('${AppContext.ctxPath}/action/portal/basic/listOfVal/types',{
		types : JSON.stringify('[PCY_RULE_TYPE]')
	},function(data){
		if (data.success) {
			var tagHtml = "";
			for (var i = 0; i < data.rows.length; i++) {
				var row = data.rows[i];
				tagHtml += '<div class="select-item"><label>'
					+'<input class="iCheck" type="radio" name="ruleType" value="'+row.val+'"/> '+row.name+'</label></div>';
			}
			$(".ruleType-div").append(tagHtml);
		}
		initData(policy);
	});
}

/* --------------------------------- 规则列表 ----------------------------------------- */
$ruleDatageid.datagrid({
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
function optRuleFormatter(val,row,index){
	var html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRow(\'rule-table\',\''+row.id+'\')" iconCls="icon-cancel" plain="true"></a>';
	return html;
}

</script>
</body>
</html>
