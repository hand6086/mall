<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">


	
   <div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
   
   <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">问卷筛选条件</span>
		</legend>
		
		<div class="row keyfilter-border">
			<ul data-toggle="keyfilter" data-title="问卷类型" 
				data-filter-filed="questionType"
				data-table-Id="question-table">
				<li data-value="问卷">问卷</li>
				<li data-value="答题">答题</li>
				<li data-value="投票">投票</li>
			</ul>
		</div>
		
	</fieldset>
	
	<table id="question-table" keyFilterDiv="keyFilter" fit="true">
		<thead>
			<tr>
				<th field="questionName" width="350px" editor="{type:'validatebox'}" defaultSearch="true" formatter="showFormatter">问卷名称</th>
				<th field="questionType" width="100px" editor="{type:'validatebox'}" >问卷类型</th>
				<th field="questionInfo" width="200px" editor="{type:'validatebox'}">问卷描述</th>
				<th field="answerCount" width="100px" editor="{type:'validatebox'}">已参与人数</th>
		</thead>
	</table>
	</div>
    <div id="quesGuideWin" class="crmWin" style="display:none">
    	<iframe src="" id="quesGuideWinFram" style="width: 100%;height: 100%;" frameborder="0" scrolling="no"></iframe>
    </div>
	<script type="text/javascript">
		$datagrid = $('#question-table');
		var $guideWin = $("#quesGuideWin");
		var $guideWinFram = $("#quesGuideWinFram");
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			oauthFlag:true,
			buttonDelete:false,
			url:'${AppContext.ctxPath}/action/portal/questionsurvey/queryQuestionSurveyPage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(26,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addQuestion()">添加</a>',that);
			}
		});
		
		function showFormatter(value,row,index){
			return "<a href='###' class='easyui-tooltip' onclick='gotoContentPage(\"${AppContext.ctxPath}/action/questionsurvey/questionDetail/" + row.id + "\")'>" + value + "</a>";
		}
		
		function addQuestion(){
			$guideWinFram.obj= {id : '',questionName:'',questionType:'',questionInfo:'',itemList:[],attr1:'next'};
			$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/question/creQues.jsp");
			$guideWin.css("display", "block");
		}
		function closeGuide(operate){
			delete $guideWinFram.obj;
			$guideWinFram.attr("src", "");
			$guideWin.css("display", "none");
			if('CANCEL' == operate){//取消向导操作
				//nothing
			}
			else if('CMPL' == operate){//完成向导操作
				$datagrid.datagrid("reload");
			}
		}
	    $('#question-type-keyfilter').keyFilter();
	</script>
</body>
</html>