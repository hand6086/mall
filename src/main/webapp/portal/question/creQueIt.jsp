<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">

/* -- td css start -- */
.td-label {
	font-size: 14px;
	font-weight: 200;
	text-align: left;
	height: 30px;
	width: 180px;
}

.td-input {
	width: 180px;
	height: 30px;
	padding-left: 10px;
}
/* -- td css end -- */
.td-input-input {
	width: 180px;
}
.td-content {
	width: 180px;
	margin: 10px auto;
}
.td-content input{
	width:180px;
	text-align:center;
}
</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="问卷问题" fit="true">
			<div id="header" class="easyui-panel" style="height:90%" data-options="border:false">
				<div style="margin-left:10px">
				<form id="headerForm" method="post">
					<table>
						<tr>
							<td class="td-label"><label>选择问题类型 </label></td>
						</tr>
						<tr>
							<td class="td-content">
								<input class="easyui-combobox" id="itemType" name="itemType" required="true"/>
							</td>
						</tr>
						
						<tr>
							<td class="td-label"><label>新增问题内容 </label></td>
						</tr>
						<tr>
							<td class="td-content">
								<input id="itemName" name="itemName" required="true"
									class="easyui-textbox" data-options="multiline:true" style="width: 180px; height: 80px;">
							</td>
						</tr>
					</table>
					<div id="questionItemOption" style="display:none">
					<div id="floor" style="left: 0; width: 100%; height: 30px; background:#e8f1ff;">
						<label style="float:left; margin-top: 5px;margin-left: 20px;">新增问题选项</label>
						<div style="float: right; margin-top: 3px; margin-right: 30px; margin-bottom: 20px;">
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delQuestionOption()"></a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addQuestionOption()"></a>
						</div>
					</div>
											
					<div id="optionInputs">
						<table id="optionsTable" style="width:100%;heigh:20px">
							<tr>
								
							</tr>
						</table>
					</div>
					</div>
				</form>
				</div>
			</div>
			<div id="floor" style="position:fixed; bottom: 0; left: 0; width: 100%; height: 40px; background:#e8f1ff;">
				<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
					<a class="easyui-linkbutton" iconCls="icon-save" onclick="save()">保存&nbsp;&nbsp;&nbsp;</a> 
						&nbsp;
					<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="cancel()">取消创建&nbsp;&nbsp;&nbsp;</a> 
						&nbsp;
					<a class="easyui-linkbutton" iconCls="icon-redo" onclick="next()">下一题&nbsp;&nbsp;&nbsp;</a> 
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
		var alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        var arrayRepeat = alphabet.concat();      //复制
        
		//问题答案选项条数
		var qstOptionCount = 0;
        $form = $('#headerForm');
		$itemType = $('#itemType');
		$itemName = $('#itemName');
		var mainObj =  window.parent.$guideWinFram.obj;
		var obj = {};                    
		var operate = mainObj.attr1;	
		
		$(document).ready(function() {
			$itemType.combobox({
                valueField: "Id",
                textField: "Name",
                data: [
                    { "Id": "单选", "Name": "单选" },
                    { "Id": "多选", "Name": "多选" },
                    { "Id": "回答", "Name": "回答" }
                ],
                onLoadSuccess:function(){
            		initpage();
                },
                onSelect:function(record){
                	var itemType = record['Id'];
                	if(itemType == "回答"){
                		hideQuestionItemOption();
                	}else{
                		showQuestionItemOption();
                	}
                }
			})
	
		});
		
		//頁面初始化
		function initpage(){
			if(operate == "next"){              //下一步跳转
				$itemType.combobox('setValue',"单选");
				questionItemOption.style.display="block";
				obj = {itemType:'',itemName:'',optionList:[]};   //新建问题对象
				addQuestionOption();                             //默认初始化一条问题答案选项
			}
			if(operate == "last"){              //取消创建跳转
				obj = mainObj.itemList.pop();                    //获取问题对象
				$itemName.textbox('setValue',obj.itemName);
				$itemType.combobox('setValue',obj.itemType);
				if(obj.itemType == '回答'){     
					questionItemOption.style.display="block";
					hideQuestionItemOption();
					return;
				}else{
					questionItemOption.style.display="block";
					setDataToObj(obj);
				}
			}
		}
		
		/**
		 * 问题选项数据初始化
		 */
		function setDataToObj(qstItem){
			var optionList = qstItem.optionList;
			for(var i=0;i< optionList.length;i++){
				var optionValue = optionList[i].optionName;
				var index = i+1;
				var optionIndex = "("+index+")";
				var trHTML = '<tr><td style="width:5%; text-align:center"> <lable readonly; value="'+optionIndex+'">'+optionIndex+'</label></td><td><input style="width:93%;text-align:left" required="true" value="'+optionValue+'"/></td></tr>';
				$("#optionsTable").append(trHTML);
				qstOptionCount+=1; 
			}
		}
		
		/**
		 * 添加问题答案选项
		 */
		function addQuestionOption(){
			var isChecked = false;
			isChecked = beforeAddQstOpt(); 
			if(isChecked){
				var optionIndex = "("+arrayRepeat[qstOptionCount]+")";
				var trHTML = '<tr><td style="width:5%; text-align:center"> <lable readonly; value="'+optionIndex+'">'+optionIndex+'</label></td><td><input style="width:93%;text-align:left" required="true"/></td></tr>';
				$("#optionsTable").append(trHTML);
				qstOptionCount+=1; 
			}else{
				$.messager.alert('警告','请完善问题选项信息！');
			}
		}
		/**
		 * 删除问题答案选项
		 */
		function delQuestionOption(){
			 if(qstOptionCount > 1){
				 $("#optionsTable tr").last().remove();
				 qstOptionCount -= 1;
			 }else{
				 $("#optionsTable input").last().val("");
			 }
		}
		/**
		 * 校验当前答案选项信息是否完善
		 */
		function beforeAddQstOpt(){
			var result = true;
			var inputList = $("#questionItemOption").find("input");
			var listLenth = inputList.length;
			if(listLenth > 0){
				 inputList.each(function(i, item){
					var inputValue = $(this).val();
					if(inputValue == ""){
						result = false;
					}else{
						result = true;
					}
				 }) 
			}else{
				result = true;
			}
			
			return result;
		}
		
		//隐藏问题选项
		function hideQuestionItemOption(){
			$("#questionItemOption").find("tr").remove();
			qstOptionCount = 0;
			$("#questionItemOption").hide();
		}
		//显示问题选项		
		function showQuestionItemOption(){
			if(qstOptionCount <= 0){
				arrayRepeat = alphabet.concat();
				qstOptionCount = 0;
				addQuestionOption();
				$("#questionItemOption").show();
			}
		}	
		
		/**
		 * 下一步
		 */
		function next(){
			//验证问题头信息
			var isPassHead = $form.form('validate');
			if(!isPassHead){
				return;	
			}
			//验证答案选项信息
			var isPassItem = beforeAddQstOpt();
			if(!isPassItem){
				$.messager.alert('警告','请完善问题选项信息！');
				return;
			}
			obj['itemName'] = $itemName.textbox('getValue');
			obj['itemType'] = $itemType.combobox('getValue');
			
			if(obj['itemType'] != '回答'){    //获取答案选项数据
				var inputList = $("#questionItemOption").find("input");
				var listLenth = inputList.length;
				if(listLenth > 0){
					 inputList.each(function(i, item){
						var inputValue = $(this).val();
						var optionItem = {itemId:'',optionName:inputValue};
						obj.optionList.push(optionItem);
					 })
				}
			}
			mainObj.itemList.push(obj);
			mainObj.attr1 = 'next';
			window.parent.$guideWinFram.obj = mainObj;
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
			saveFlag = true;
			
			var isPassHead = $form.form('validate');
			if(!isPassHead){
				$.messager.alert('警告','请完善问题信息！');
				return;	
			}
			var isPassItem = beforeAddQstOpt();
			if(!isPassItem){
				$.messager.alert('警告','请完善问题选项信息！');
				return;
			}
			obj['itemName'] = $itemName.textbox('getValue');
			obj['itemType'] = $itemType.combobox('getValue');
			if(obj['itemType'] == '回答'){
				
			}else{
				var inputList = $("#questionItemOption").find("input");
				var listLenth = inputList.length;
				if(listLenth > 0){
					 inputList.each(function(i, item){
						var inputValue = $(this).val();
						var optionItem = {itemId:'',optionName:inputValue};
						obj.optionList.push(optionItem);
					 })
				}
			}
			mainObj.itemList.push(obj);
			$.ajax({
				type : "POST",
				url : '${AppContext.ctxPath}/action/anonymous/questionsurvey/saveQuestionSurvey',
				cache : false,
				data  : JSON.stringify(mainObj),
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
		
		/**
		 * 	取消创建
		 */
		function cancel(){
			mainObj.attr1 = 'last';  //取消创建操作
			var itemList = mainObj.itemList;
			window.parent.$guideWinFram.obj = mainObj;
			if(itemList.length > 0){ //返回上一个问题页面
				window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/question/creQueIt.jsp");
			}else{
				window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/question/creQues.jsp");//返回调查问卷页面
			}
		}
		
</script>
</body>
</html>