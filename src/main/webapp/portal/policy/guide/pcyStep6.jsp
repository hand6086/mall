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
.step-form .item .select-item{display: inline-block;width: 24%;}
.div-pcyImg {height: 200px;line-height: 200px;mtext-align: center;overflow: hidden;border: solid 1px #eee;}
.div-pcyImg img {vertical-align: middle;margin: 0 auto;width:auto;height:auto;max-width:100%;max-height:100%;}
#guide-step{margin-left: -100px;}
.step-form .item .item-left{display: inline-block;width: 400px;padding-left: 10px;}
.step-form .item .item-right{display: inline-block;width: 400px;margin-left: 50px;}
.step-form .item .box-title-div{text-align: left;height: 25px;line-height: 25px;}
.step-form .item .box-text-div{width: 100%;}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div region="center" border="false">
			<div class="context">
				<div id="guide-step"></div><!-- 步骤条 -->
				<form class="step-form" method="post">
					<div style="width: 100%;">
						<div class="item">
							<div class="title-div">
								<label>政策名称 : </label>
							</div>
							<div class="text-div">
								<input class="easyui-textbox text-input list-textbox" type="text" id="pcyName" name="pcyName" style="height: 26px;"/>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>首单 : </label>
							</div>
							<div class="text-div">
								<input class="iCheck" type="checkbox" disabled="disabled" name="isOneTime" value="Y"></input>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>政策大类 : </label>
							</div>
							<div class="text-div majorType-div">
								<!-- 备份用于静态网页调试 -->
								<!-- <div class="select-item">
									<label><input class="iCheck" type="radio" name="majorType" value="1"/> 当单政策</label>
								</div> -->
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>政策类型 : </label>
							</div>
							<div class="text-div subType-div">
								<!-- 备份用于静态网页调试 -->
								<!-- <div class="select-item">
									<label><input class="iCheck" type="radio" name="subType" value="1"/> 特价</label>
								</div> -->
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>开始时间 : </label>
							</div>
							<div class="text-div">
								<input class="easyui-datebox text-input" disabled="disabled" type="text" name="startTime" style="height: 26px;"/>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>结束时间 : </label>
							</div>
							<div class="text-div">
								<input class="easyui-datebox text-input" disabled="disabled" type="text" name="endTime" style="height: 26px;"/>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>是否推荐 : </label>
							</div>
							<div class="text-div">
								<div class="select-item" style="display: none;">
									<label><input class="iCheck" disabled="disabled" type="radio" name="isRcmd" value="Y"/> 是</label>
								</div>
								<div class="select-item" style="display: none;">
									<label><input class="iCheck" disabled="disabled" type="radio" name="isRcmd" value="N"/> 否</label>
								</div>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>推荐方式 : </label>
							</div>
							<div class="text-div">
								<div class="select-item" style="display: none;">
									<label><input class="iCheck" disabled="disabled" type="radio" name="isTop" value="Y"/> 置顶</label>
								</div>
								<div class="select-item" style="display: none;">
									<label><input class="iCheck" disabled="disabled" type="radio" name="isTop" value="N"/> 随机</label>
								</div>
							</div>
						</div>
						<div class="item" style="width: 700px;padding-left: 10px;">
							<div style="background-color: #eee;height: 35px;">
								<div style="display: inline-block;height: 100%;width:50px;">
									<a href="javascript:void(0)" disabled="disabled" class="easyui-linkbutton" iconCls="icon-uploadImg" 
										style="width: 100%;height: 100%;" plain="true" onclick=""></a>
								</div>
								<span id="fileNameShowBox" style="margin-left: 5px;"></span>
							</div>
							<div class="div-pcyImg">
								<img id="pcyImg" alt="" src="">
								<input type="hidden" name="imgId" style="display:none;"/><!-- 政策图片ID -->
							</div>
						</div>
						<div class="item">
							<div class="item-left">
								<div class="box-title-div">
									<label>政策说明 : </label>
								</div>
								<div class="box-text-div">
									<input class="easyui-textbox list-textbox" data-options="multiline:true" 
										type="text" name="comments" style="width: 100%;height: 200px;"/>
								</div>
							</div>
							<div class="item-right">
								<div class="box-title-div">
									<label>针对指定客户应用政策 : </label>
								</div>
								<div class="box-text-div">
									<input class="easyui-textbox list-textbox" data-options="multiline:true" 
										type="text" id="acctListBox" style="width: 100%;height: 200px;"/>
								</div>
							</div>
						</div>
						<div class="item">
							<div class="item-left">
								<div class="box-title-div">
									<label>针对指定区域应用政策 : </label>
								</div>
								<div class="box-text-div">
									<input class="easyui-textbox list-textbox" data-options="multiline:true" 
										type="text" id="rgnListBox" style="width: 100%;height: 200px;"/>
								</div>
							</div>
							<div class="item-right">
								<div class="box-title-div">
									<label>针对指定组织应用政策 : </label>
								</div>
								<div class="box-text-div">
									<input class="easyui-textbox list-textbox" data-options="multiline:true" 
										type="text" id="orgListBox" style="width: 100%;height: 200px;"/>
								</div>
							</div>
						</div>
						<div class="item">
							<div class="item-left">
								<div class="box-title-div">
									<label>政策规则 : </label>
								</div>
								<div class="box-text-div">
									<input class="easyui-textbox list-textbox" data-options="multiline:true" 
										type="text" id="ruleListBox" style="width: 100%;height: 200px;"/>
								</div>
							</div>
							<div class="item-right">
								<div class="box-title-div">
									<label>规则条件&结果 : </label>
								</div>
								<div class="box-text-div">
									<input class="easyui-textbox list-textbox" data-options="multiline:true" 
										type="text" id="ruleItemListBox" style="width: 100%;height: 200px;"/>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div region="south" border="false" style="height:40px;">
			<div style="width: 100%; height: 40px;line-height:40px; text-align:right; background:#e8f1ff;">
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-cancel" 
						onclick="cancelOpt()" style="width: 100px;margin-right: 20px;">取 消</a>
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-save" 
						onclick="finishOpt('N')" style="width: 100px;margin-right: 20px;">稍后发布</a>
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-ok" 
						onclick="finishOpt('Y')" style="width: 100px;margin-right: 20px;">完成并发布</a> 
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	iCheckInit();
});
var ajaxCount = 2;//记录未执行完成ajax数量
var $form = $('.step-form');
var policy = window.parent.$guideWinFram.wholePolicy;
$('.list-textbox').textbox();
createStepFlow('guide-step', 6);
majorTypeInitTag();
subTypeInitTag();
/**
 * 取消
 */
function cancelOpt(){
	window.parent.closeGuide("CANCEL");
}
/**
 * 完成
 */
function finishOpt(status){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	var pcyStatus = status;
	if(!pcyStatus){
		pcyStatus = 'N';
	}
	policy.pcyStatus = pcyStatus;
	var url = '';
	if(policy.row_status == 'NEW'){
		url = '${AppContext.ctxPath}/action/portal/policy/newPolicy';
	} else {
		url = '${AppContext.ctxPath}/action/portal/policy/updatePolicy';
	}
	delete policy.newPcyRule;
	delete policy.attachmentOriginal;
	$.ajax({
		type: "POST",
        url: url,
        data: JSON.stringify(policy),
        dataType: "json",
        contentType: 'application/json', 
        success:function(data){
        	if(data.success){
        		window.parent.closeGuide("CMPL");//向导完成
        	}else{
        		$('.step-opt').linkbutton('enable');//解锁按钮
        		$.messager.alert("错误", data.result, "error");
        	}
        },
        error:function(obj, status, desc){
        	$('.step-opt').linkbutton('enable');//解锁按钮
        	$.messager.alert("错误", "请求错误", "error");
        }
	});
}

/**
 * 初始化html[政策大类]
 */
function majorTypeInitTag(){
	$.post('${AppContext.ctxPath}/action/portal/basic/listOfVal/types',{
		types : JSON.stringify('[PCY_MAJOR_TYPE]')
	},function(data){
		if (data.success) {
			var tagHtml = "";
			for (var i = 0; i < data.rows.length; i++) {
				var row = data.rows[i];
				if(policy.majorType == row.val){
					tagHtml += '<div class="select-item"><label>'
						+' <input class="iCheck" disabled="disabled" type="radio" name="majorType" value="'+row.val+'"/> '+row.name+'</label></div>';
					break;
				}
			}
			$(".majorType-div").append(tagHtml);
		}
		ajaxCount--;
		ajaxFinished();
	});
}
/**
 * 初始化html[政策类型]
 */
function subTypeInitTag(){
	$.post('${AppContext.ctxPath}/action/portal/basic/listOfVal/types',{
		types : JSON.stringify('[PCY_SUB_TYPE]')
	},function(data){
		if (data.success) {
			var tagHtml = "";
			for (var i = 0; i < data.rows.length; i++) {
				var row = data.rows[i];
				if(policy.subType == row.val){
					tagHtml += '<div class="select-item"><label>'
						+' <input class="iCheck" disabled="disabled" type="radio" name="subType" value="'+row.val+'"/> '+row.name+'</label></div>';
					break;
				}
			}
			$(".subType-div").append(tagHtml);
		}
		ajaxCount--;
		ajaxFinished();
	});
}

/**
 * 判断是否执行完所有ajax，如果是则执行公共回调方法
 */
function ajaxFinished(){
	if(ajaxCount > 0){
		//do nothing
	} else {
		$form.form("load", policy);
		iCheckInit();
		//显示选中的单选框对应的div
		$.each(["isRcmd", "isTop"], function(i, inputName) {
			$('input:radio[name="' + inputName + '"]:checked').closest('.select-item').css('display','');
		});
		
		$('#pcyImg').attr('src', policy.imagePath);
		//遍历拼接客户范围
		var acctsStr = '';
		for (var i = 0; i < policy.scpAccList.length; i++) {
			var acctObj = policy.scpAccList[i];
			var accntName = acctObj.accntName;
			if(!accntName){
				accntName = '[空]';
			}
			if(i == 0){
				acctsStr += accntName;
			} else {
				acctsStr += '、' + accntName;
			}
		}
		$('#acctListBox').textbox('setValue',acctsStr);
		
		//区域范围
		var rgnsStr = '';
		for (var i = 0; i < policy.scpRgnList.length; i++) {
			var rgnObj = policy.scpRgnList[i];
			var addrName = rgnObj.addrName;
			if(!addrName){
				addrName = '[空]';
			}
			if(i == 0){
				rgnsStr += addrName;
			} else {
				rgnsStr += '、' + addrName;
			}
		}
		$('#rgnListBox').textbox('setValue',rgnsStr);
		
		//组织范围
		var orgsStr = '';
		for (var i = 0; i < policy.scpOrgList.length; i++) {
			var orgObj = policy.scpOrgList[i];
			var orgName = orgObj.orgName;
			if(!orgName){
				orgName = '[空]';
			}
			if(i == 0){
				orgsStr += orgName;
			} else {
				orgsStr += '、' + orgName;
			}
		}
		$('#orgListBox').textbox('setValue',orgsStr);
		
		//规则列表
		var rulesStr = '';
		var ruleItemsStr = '';
		for (var i = 0; i < policy.ruleList.length; i++) {
			var ruleObj = policy.ruleList[i];
			var ruleName = ruleObj.ruleName;
			if(!ruleName){
				ruleName = '[空]';
			}
			if(i == 0){
				rulesStr += ruleName;
			} else {
				rulesStr += '、' + ruleName;
			}
			//规则条件
			for (var j = 0; j < ruleObj.conditionList.length; j++) {
				var cndObj = ruleObj.conditionList[j];
				var cndComments = cndObj.comments;
				if(!cndComments){
					cndComments = '[空]';
				}
				if(j == 0){
					ruleItemsStr += cndComments;
				} else {
					ruleItemsStr += '、' + cndComments;
				}
			}
			ruleItemsStr += '\n';
			//规则结果
			for (var j = 0; j < ruleObj.resultList.length; j++) {
				var resultObj = ruleObj.resultList[j];
				var resultComments = resultObj.comments;
				if(!resultComments){
					resultComments = '[空]';
				}
				if(j == 0){
					ruleItemsStr += resultComments;
				} else {
					ruleItemsStr += '、' + resultComments;
				}
			}
			ruleItemsStr += '\n';
		}
		$('#ruleListBox').textbox('setValue',rulesStr);
		$('#ruleItemListBox').textbox('setValue',ruleItemsStr);
		$('.list-textbox').textbox('disable');
	}
}
</script>
</body>
</html>
