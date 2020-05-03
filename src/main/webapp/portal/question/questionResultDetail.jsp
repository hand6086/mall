<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/question-survey.css">
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/js/ichart.latest.min.js"></script>

<script type="text/javascript">
	var questionItems = [];	//问题集合
	var listOflistAns = [];	//（一个问题的回答集合的集合）
	
	<c:forEach var="questionItem" items="${question.itemList}">
		questionItems.push({id:'${questionItem.id}',type:'${questionItem.itemType}'});
		var ansList = [];
		<c:forEach var="answer" items="${questionItem.ansList}">
			ansList.push({itemType:'${answer.itemType}',itemcount:'${answer.itemcount}'});
		</c:forEach>
		listOflistAns.push(ansList);
	</c:forEach>
	
	function haveAtry(){
		console.log(questionItems);
		console.log('-==-========--------');
		console.log(listOflistAns);
	}
	//haveAtry();
	
	function showQuestionReport() {
		if(questionItems == null){
			return;
		}
        var animation = true;
        for (var i = 0; i < questionItems.length; i++) {
            var color = ['#9d4a4a', '#5d7f97', '#97b3bc', '#a5aaaa', '#778088', '#6f83a5',
                         '#778899', '#BC8F8F', '#4682B4', '#B0C4DE', '#3CB371', 
	                       '#66CDAA', '#808000',
	                       '#C23531', '#2F4554', '#91C7AE', '#61A0A8', '#D48265',
	                       '#66CDAA', '#808000', '#E87C25', '#27727B', '#FCCE10', 
	                       '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
	                       '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'];
            var data = [];
            var temp = questionItems[i];
            var ansListTemp = listOflistAns[i];
            
            if (ansListTemp != null || ansListTemp.length > 0) {
                for (var j = 0; j < ansListTemp.length; j++) {
                    var temp1 = ansListTemp[j];
                    data.push({name: temp1.itemType, value: parseFloat(temp1.itemcount), color: color.shift()});
                }
            } else {
                data.push({name: '未选择', value: 100, color: '#9d4a4a'});
            }
            if (i < 2) {
                animation = true;
            } else {
                animation = false;
            }
            console.log(temp.id);
            new iChart.Pie2D({
                render: temp.id,
                data: data,
                animation: animation,
                turn_off_touchmove: true,
                legend: {
                    enable: false
                },
                gradient: false,
                border: {
                    color: "BCBCBC",
                    width: 0
                },
                sub_option: {
                    border: {
                        color: "#BCBCBC",
                        width: 2
                    },
                    label: {
                        fontweight: 500,
                        fontsize: 11,
                        color: "#4572a7",
                        sign: "",
                        sign_size: 12,
                        border: {
                            color: "#BCBCBC",
                            width: 0
                        },
                        background_color: "#ffffff"
                    }
                },
                showpercent: true,
                decimalsnum: 2,
                width: 400,
                height: 200,
                radius: 140
            }).draw();
        }
    };
    $(document).ready(function(){
    	showQuestionReport();
    })

   	//showQuestionReport();
	
	function closePage(){
		self.close();
		window.close(); 
	};
</script>
<body id="right" class="body">
	<div class="survey">
		<div class="survey-body">
			<div class="survey-header">
				<h1 class="survey-title">${question.questionName}-调查结果</h1>
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
								<c:forEach var="ansItem" varStatus="status" items="${questionItem.ansList}">
									<c:choose>
										<c:when test="${status.index %2 == 0}">
											<li class="option">
										</c:when>
										<c:otherwise>
											<li class="option even">
										</c:otherwise>
									</c:choose>
										 <label>${ansItem.itemType}- (已选择：${ansItem.itemcount} 次)</label>
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
								<c:forEach var="ansItem" varStatus="status" items="${questionItem.ansList}">
									<c:choose>
										<c:when test="${status.index %2 == 0}">
											<li class="option">
										</c:when>
										<c:otherwise>
											<li class="option even">
										</c:otherwise>
									</c:choose>
										 <label>${ansItem.itemType}- (已选择：${ansItem.itemcount} 次)</label> 
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
								<c:forEach var="ansItem" varStatus="status" items="${questionItem.ansList}">
									<c:choose>
										<c:when test="${status.index %2 == 0}">
											<li class="option">
										</c:when>
										<c:otherwise>
											<li class="option even">
										</c:otherwise>
									</c:choose>
										 <label>${ansItem.itemType} - (回答：${ansItem.itemcount} 次) </label>
									</li>
								</c:forEach>
							</ul>
							
						</div>
					</c:if>
					<div id="${questionItem.id}" style="height:200px;"></div>
				</c:forEach>
			</div>
		</div>
		<div class="survey-footer">
			<div class="buttons" style="">
				<label>谢谢您的参与！</label>
			</div>
		</div>
	</div>
</body>
</html>