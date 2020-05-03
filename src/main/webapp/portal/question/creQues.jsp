<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 0px auto; 
	width: 100%;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:80%;
	text-align:center;
}
.td-label {
	text-align:center;
}
#headerForm {
	width:60%;
	text-align:center;
	margin: 0 auto;
	font-size: 18px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false" >
		<div data-options="region:'center'" title="新建问题" fit="true">
			<div id="header" class="easyui-panel" style="height:90%;" data-options="border:false">
			<div style="margin-left:10px">
				<form id="headerForm" method="post" style="width:80%;">
					<table>
						<tr>
							<td class="td-label"><label>问卷标题 </label></td>
						</tr>
						<tr>
							<td class="td-content">
								<input class="easyui-textbox" id="questionName" name="questionName" required="true"/>
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>问卷类型 </label></td>
						</tr>
						<tr>
							<td class="td-content">
							    <input class="easyui-combobox"  id="questionType" name="questionType" required="true"/>
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>问卷描述 </label></td>
						</tr>
						<tr>
							<td class="td-content">
								<input id="questionInfo" name="questionInfo" required="true"class="easyui-textbox" data-options="multiline:true" style=" height: 100%" />
							</td>
						</tr>
					</table>
				</form>
				</div>
			</div>
			<div id="floor" style="position:fixed; bottom: 0; left: 0; width: 100%; height: 40px; background:#e8f1ff;">
				<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
					<a class="easyui-linkbutton" iconCls="icon-save" onclick="save()">保存&nbsp;&nbsp;&nbsp;</a> 
						&nbsp;
					<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="cancel()">取消创建&nbsp;&nbsp;&nbsp;</a> 
						&nbsp;
					<a class="easyui-linkbutton" iconCls="icon-redo" onclick="next()">创建问题&nbsp;&nbsp;&nbsp;</a> 
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">	    
		$form = $("#headerForm");               
		var obj =  window.parent.$guideWinFram.obj;
		var opt = obj.attr1;                    //操作
		$questionName = $("#questionName");
		$questionType = $("#questionType"); 
		$questionInfo = $("#questionInfo");
		$(document).ready(function() {
			$questionType.combobox({
                valueField: "Id",
                textField: "Name",
                data: [
                    { "Id": "问卷", "Name": "问卷" },
                    { "Id": "投票", "Name": "投票" },
                    { "Id": "答题", "Name": "答题" }
                ],
                onLoadSuccess:function(){
                	$questionType.combobox('setValue',"问卷");
                }
			})
			
			//从上一步回退
			if(opt == 'last'){
				$questionName.textbox('setValue',obj.questionName);
				$questionType.combobox('setValue',obj.questionType);
				$questionInfo.textbox('setValue',obj.questionInfo);
			}
	   });
		
		/**
		 * 	取消创建
		 */
		function cancel(){
			obj = {};                                            //对象置空
			window.parent.closeGuide("CANCEL");
		}
		
		/**
		 * 下一步
		 */
		function next(){
			var isPass = $form.form('validate');
			if(!isPass){
				return;
			}
			
			obj['questionName'] = $questionName.textbox('getValue');
			obj['questionType'] = $questionType.combobox('getValue');											   
			obj['questionInfo'] = $questionInfo.textbox('getValue');
			obj['attr1'] = 'next';                                       //操作
			window.parent.$guideWinFram.obj = obj;
			window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/question/creQueIt.jsp");
		}
		
		/**
		 * 保存
		 */
		var saveFlag = false;
		function save(){
			if(saveFlag){
				return;
			}
			var isPass = $form.form('validate');
			if(!isPass){
				return;
			}
			saveFlag = true;
			obj['questionName'] = $questionName.textbox('getValue');
			obj['questionType'] = $questionType.combobox('getValue');											   
			obj['questionInfo'] = $questionInfo.textbox('getValue');
		 	$.ajax({
				type : "POST",
				url : '${AppContext.ctxPath}/action/anonymous/questionsurvey/saveQuestionSurvey',
				cache : false,
				data  : JSON.stringify(obj),
				dataType : "json",
				contentType: "application/json",
				success : function(data) {
					if (!data.success) {
						$.messager.alert('错误',data.result);
					}else{
						window.parent.closeGuide("CMPL");//向导完成
					}
				}
			}); 
			saveFlag = false;
		}		
	</script>
</body>
</html>