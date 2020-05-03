<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/question-survey.css">
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>

<body id="right" class="body" style="overflow:scroll;">
	<div class="survey">
		<div class="survey-body">
			<div class="survey-header">
				<h1 class="survey-title">${question.questionName}</h1>
			</div>
			<div class="survey-content">
				<c:forEach var="questionItem" items="${question.itemList}">
					<c:if test="${questionItem.itemType == '单选'}">
						<div class="part select" data-id="${questionItem.id}">
							<h4 class="title">
								<span class="index"></span>
								<span class="subject">${questionItem.itemName}</span>
								<label class="rules">(单选)</label>
							</h4>
							<ul class="options">
								<c:forEach var="optionItem" varStatus="status" items="${questionItem.optionList}">
									<c:choose>
										<c:when test="${status.index %2 == 0}">
											<li class="option" onclick="$(this).children('input').attr('checked','checked')">
										</c:when>
										<c:otherwise>
											<li class="option even" onclick="$(this).children('input').attr('checked','checked')">
										</c:otherwise>
									</c:choose>
										<input id="i_12" type="radio" name="${optionItem.itemId}" value="${optionItem.id}"> <label for="i_12">${optionItem.optionName}</label>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${questionItem.itemType == '多选'}">
						<div class="part select" data-id="${questionItem.id}">
							<h4 class="title">
								<span class="index"></span>
								<span class="subject">${questionItem.itemName}</span>
								<label class="rules">(多选)</label>
							</h4>
							<ul class="options">
								<c:forEach var="optionItem" varStatus="status" items="${questionItem.optionList}">
									<c:choose>
										<c:when test="${status.index %2 == 0}">
											<li class="option" onclick="$(this).children('input').attr('checked','checked')">
										</c:when>
										<c:otherwise>
											<li class="option even" onclick="$(this).children('input').attr('checked','checked')">
										</c:otherwise>
									</c:choose>
										<input id="i_12" type="checkbox" name="${optionItem.itemId}" value="${optionItem.id}"> <label for="i_12">${optionItem.optionName}</label>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${questionItem.itemType == '回答'}">
						<div class="part select" data-id="${questionItem.id}">
							<h4 class="title">
								<span class="index"></span>
								<span class="subject">${questionItem.itemName}</span>
								<label class="rules">(回答)</label>
							</h4>
							<ul class="options">
								<li class="option">
									<textarea class="blank option" name="${questionItem.id}" rows="5" cols="30" value="" type="text"></textarea>
								</li>
							</ul>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="survey-footer">
			<div class="buttons" style="">
				<button class="prev" style="display:none;" type="button">上一页</button>
				<button class="submit" data-submit-text="提交" data-submitting-text="正在提交 ..." onClick="submitMethod()" type="button">提交</button>
				<button class="next" style="display:none;" type="button">下一页</button>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	//启动mask控件
	function startMask(content, target) {
	    var doc = window.document;
		var sw = Math.max(doc.documentElement.scrollWidth, doc.body.scrollWidth);
	    var sh = Math.max(doc.documentElement.scrollHeight, doc.body.scrollHeight); //考虑滚动的情况
	    var sl = Math.max(doc.documentElement.scrollLeft, doc.body.scrollLeft);
	    var st = Math.max(doc.documentElement.scrollTop, doc.body.scrollTop); //考虑滚动的情况
	    var cw = doc.documentElement.clientWidth;
	    var ch = doc.documentElement.clientHeight;
		var _PageHeight = Math.max(sh, ch), _PageWidth = Math.max(sw, cw);
		//计算loading框距离顶部和左部的距离（loading框的宽度为300px，高度为88px）
		var _LoadingTop = ch > 88 ? (ch - 88 - 70) / 2 + st: 0,
			_LoadingLeft = cw > 300 ? (cw - 200) / 2 + sl: 0;
		if (content == null) {
			content = '正在加载数据...';
		}
		//在页面未加载完毕之前显示的loading Html自定义内容
		var _LoadingHtml = '<div id="loadingDiv" style="position:absolute;width:100%;top:0px;left:0px;height:'
				+ _PageHeight
				+ 'px;background:#f7f7f7;opacity:0.8;filter:alpha(opacity=80);z-index:10000;">'
				+ '<div style="text-align:center; position: absolute; cursor1: wait; left: ' + _LoadingLeft + 'px; top:' + _LoadingTop + 'px;  width: 300px; height: 88px; line-height: 40px; padding:5px;background: #f7f7f7 scroll">'
				+ '<img src="${AppContext.ctxPath}/static/images/loading.gif" height="30" width="30"></img>'
				+ '<div>' + content + '</div>' + '</div>' + '</div>';
		//呈现loading效果
		if (target == 'firstPage') {
			document.write(_LoadingHtml);
		} else {
			$('#right').append(_LoadingHtml);
		}
	}
	
	//结束mask控件
	function stopMask() {
		var loadingMask = document.getElementById('loadingDiv');
		loadingMask.parentNode.removeChild(loadingMask);
	}

	var questionItems = [];
	<c:forEach var="questionItem" items="${question.itemList}">
		questionItems.push({id:'${questionItem.id}',type:'${questionItem.itemType}'});
	</c:forEach>
	
	function submitMethod(){
		var postInfo = {
				questionId:'${question.id}',
				list:[]
			};
		for(var i=0;i<questionItems.length;i++){
			var item = questionItems[i];
			if(item.type == '单选'){
				var value = $('input[name="'+item.id+'"]:checked ').val();
				postInfo.list.push({
					questionItemId:item.id,
					answerId:postInfo.questionId,
					singleSelectId:value
				});
			}else if(item.type == '多选'){
				var selectedList = [];
				$('input[name="'+item.id+'"]').each(function(){
				    if(this.checked){
				    	selectedList.push({
				    		answerSelectId:$(this).val()
				    	});
				    }
				});
				postInfo.list.push({
					questionItemId:item.id,
					answerId:postInfo.questionId,
					list:selectedList
				}); 
			}else if(item.type == '回答'){
				var value = $('textarea[name="'+item.id+'"]').val();
				postInfo.list.push({
					questionItemId:item.id,
					answerId:postInfo.questionId,
					singleAnswer:value
				});
			}
		}
		startMask("正在提交问卷信息，请稍后...");
		$.ajax({ 
            type:"POST", 
            url:'${AppContext.ctxPath}/anonymousPageAction/anonymous/questionsurvey/answerInsert', 
            contentType:"application/json",  //发送信息至服务器时内容编码类型。             
            dataType:"json",
			data:JSON.stringify(postInfo),
			success:function(data){
    		  stopMask();
	    	  if(data.success)
	    	  {
    			  alert('操作成功，谢谢！');
    			  window.location.href="${AppContext.ctxPath}/anonymousPageAction/questionsurvey/questionResultDetail/${question.id}";
	    	  }else{
    			  alert('操作失败，请稍后重试！');
	    	  }
			}
	      });
	}
</script>
</body>
</html>