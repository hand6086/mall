<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	
   <div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:580px;padding:0px;">
   
   <fieldset class="x-fieldset">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">问卷筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="question-type-keyfilter" data-toggle="keyfilter"
				data-title="问卷类型" data-filter-filed="questionType"
				data-table-Id="question-table">
				<li data-value="问卷">问卷</li>
				<li data-value="答题">答题</li>
				<li data-value="投票">投票</li>
			</ul>
		</div>
		
	</fieldset>
	
	<table id="question-table" style="width:100%;height:470px;">
		<thead>
			<tr>
				<th field="questionName" width="350px" editor="{type:'validatebox'}" defaultSearch="true" formatter="showFormatter">问卷名称</th>
				<th field="questionType" width="100px" editor="{type:'validatebox'}" >问卷类型</th>
				<th field="questionInfo" width="200px" editor="{type:'validatebox'}">问卷描述</th>
				<th field="answerCount" width="100px" editor="{type:'validatebox'}">已参与人数</th>
		</thead>
	</table>
	</div>
	<script type="text/javascript">
	    $('#question-type-keyfilter').keyFilter();
		$datagrid = $('#question-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			oauthFlag:true,
			buttonDelete:false,
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/questionsurvey/queryQuestionSurveyPage'
		});
		
		function showFormatter(value,row,index){
			return "<a href='###' class='easyui-tooltip' onclick='gotoContentPage(\"/action/questionsurvey/questionDetail/" + row.id + "\")'>" + value + "</a>";
		}
	</script>
</body>
</html>