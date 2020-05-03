<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.css?version=<%=version%>" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/home.css?version=<%=version%>" />
<script src="${AppContext.ctxPath}/static/js/ichart.latest.min.js?version=<%=version%>"></script>


<style>
.panel-body{
	border:0px;
}
.col-md-3,.col-md-6 ,.col-md-7,.col-md-8,.col-md-9 {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.modal-line{
	margin:15px 0;
	overflow:hidden;
}
.form-input{
	font-size:14px !important;
}
.img200 {
	width: 110px;
	height: 110px;
	margin-left: 7px;
	margin-bottom: 9px;
}

.imgDevbox {
	border-style: solid solid solid solid;
	border-width: 1px;
	border-color: rgb(228, 230, 235);
}

.imgClose {
	float: right;
	font-size: 14px;
}

.imgClose:hover {
	color: red;
}

</style>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false" height="100%" style="OVERFLOW-Y: auto; OVERFLOW-X:hidden;">
			<div class="kuaisu">
			<div class="dangqian_juti">
				<div class="dangqian_juti_left"
					style="font-size: 12px !important; padding-top: 8px;">
					<!-- <select id="subMenuItem"></select> -->
				</div>
				<div class="dangqian_juti_right" style="font-size: 12px !important;">
					<div style="float: right">
					${AppContext.storeName} 欢迎您!
						<a href="javascript:;"
							onclick="window.parent.mainFrameContent('切换职位','${AppContext.ctxPath}/portal/basic/ChangePostn.jsp')"
							style="color: rgb(122, 128, 148);"> <i
							class="fa fa-refresh" aria-hidden="true"
							style="vertical-align: middle; margin-left: 14px;margin-right: 3px;"></i>${UserContext.postnName}</a>
						<a href=""
							onclick=""
							style="color: rgb(122, 128, 148);"data-toggle="modal" data-target="#myModal"> <i
							class="fa fa-smile-o fa-lg" aria-hidden="true"
							style="margin-left: 14px;margin-right: 3px;"></i>反馈</a>
						<a href="javascript:;"
							onclick="window.parent.mainFrameContent('修改密码','${AppContext.ctxPath}/portal/user/UserChangePassword.jsp')"
							style="color: rgb(122, 128, 148);"> <img
							src="${AppContext.ctxPath}/static/css/img/11.png"
							style="vertical-align: middle; margin-left: 14px;width:14px;margin-right:3px;">修改密码</a> 
						<a href="javascript:void(0)" onclick="$(window.top.location).attr('href', '${AppContext.ctxPath}/j_spring_security_logout')"
							style="color: rgb(122, 128, 148);"> <img
							src="${AppContext.ctxPath}/static/css/img/13.png"
							style="vertical-align: middle; margin-left: 14px;width:14px;margin-right:3px;"><span
								style="margin-right: 5px;">退出登录<span /></a>
					</div>

					<div class="head_notice_div">
					<a href="javascript:void(0)" title="查看系统消息" onclick="window.parent.quickEnter('公告', '系统提示', 'ANNOUNCE_MANAGE', '${AppContext.ctxPath}/portal/message/notice.jsp')">
						<div class="head_notice_img" id="head_notice_img" ></div>
						<div class="head_notice_point" style="display: none"></div>
						<div class="head_notice_connect_status" style="display: none"></div>
						</a>
					</div>
				</div>
			</div>
			
		</div>
	<div style="width: 100%; height: 0px; border: 1px solid #e0ecff"></div>
    <div class="rukou_juti">本周业务数据统计</div>
    <ul class="xiadan">
    	<c:if test="${productCount != null }">
		    <li>
		    	<!-- <a href="###" onClick="window.top.quickEnter('线索','','CLUE_MANAGE')"> -->
					<div class="panel-static bg-yellow" >
		    			<span class="number-static">${productCount}</span></br>
		    			<c:if test="${UserContext.systemRole == 'super_administrator'}">
		    				本周新上架商品总量
		    			</c:if>
		    			<c:if test="${UserContext.systemRole != 'super_administrator'}">
		    				本周新上架商品
		    			</c:if>
		    		</div>
	    		<!-- </a> -->
			</li>
		</c:if>
		<c:if test="${orderCount != null }">
		    <li>
		    	<!-- <a href="###" onClick="window.top.quickEnter('客户','','ACCOUNT_MANAGE')"> -->
					<div class="panel-static bg-green" >
		    			<span class="number-static">${orderCount}</span></br>
		    			<c:if test="${UserContext.systemRole == 'super_administrator'}">
		    				本周各店铺订单总量
		    			</c:if>
		    			<c:if test="${UserContext.systemRole != 'super_administrator'}">
		    				本周新增订单
		    			</c:if>
		    		</div>
	    		<!-- </a> -->
		    </li>
	    </c:if>
	    
		<c:if test="${saleCount != null }">
		    <li>
		    	<!-- <a href="###" onClick="window.top.quickEnter('订单','','ORDER_MANAGE')"> -->
					<div class="panel-static bg-teal" >
		    			<span class="number-static">${saleCount}</span></br>
		    			<c:if test="${UserContext.systemRole == 'super_administrator'}">
		    				本周各店铺销售总额
		    			</c:if>
		    			<c:if test="${UserContext.systemRole != 'super_administrator'}">
		    				本周销售额
		    			</c:if>
		    		</div>
	    		<!-- </a> -->
	    	</li>
    	</c:if>
    	
		<c:if test="${productSaleCount != null }">
		    <li>
		    	<!-- <a href="###" onClick="window.top.quickEnter('活动','','ACTIVITY_MANAGE')"> -->
					<div class="panel-static bg-blue" >
		    			<span class="number-static">${productSaleCount}</span></br>
		    			<c:if test="${UserContext.systemRole == 'super_administrator'}">
		    				本周各店铺销售总量
		    			</c:if>
		    			<c:if test="${UserContext.systemRole != 'super_administrator'}">
		    				本周商品销量
		    			</c:if>
		    		</div>
	    		<!-- </a> -->
	    	</li>
    	</c:if>
    </ul>
    <div style="width:100%;clear:both;">
    	<div style="width:49%;float:left;margin-left:0.5%;">
    		<div class="panel panel-default">
			  	<div class="panel-heading">
					<div class="daohuo">
					 	<strong>待办事项</strong><a class="daohuo_right"  onClick="window.top.quickEnter('公告', '待办事项', 'ANNOUNCE_MANAGE', '${AppContext.ctxPath}/portal/message/flow.jsp')">更多待办 >></a>
				    </div>
				</div>
				<div id="approvalList" class="panel-body list-group" style="height:265px;padding:0px 5px;overflow: hidden;">
				</div>
			</div>
			
    		<div class="panel panel-default">
			  	<div class="panel-heading">
					<div class="daohuo">
					 	<strong>系统消息</strong><a class="daohuo_right"  onClick="window.top.quickEnter('公告', '系统提示', 'ANNOUNCE_MANAGE', '${AppContext.ctxPath}/portal/message/notice.jsp')">更多消息 >></a>
				    </div>
				</div>
				<div id="messageList" class="panel-body list-group" style="height:265px;padding:0px 5px;overflow: hidden;">
				</div>
			</div>
			
    		<%--<div class="panel panel-default">
			  	<div class="panel-heading">
					<div class="daohuo">
					 	<strong>公告栏</strong><a class="daohuo_right"  onClick="window.top.quickEnter('公告','公告列表','ANNOUNCE_MANAGE')">更多公告 >></a>
				    </div>
				</div>
				<div id="announceList" class="panel-body list-group" style="height:265px;padding:0px 5px;overflow: hidden;">
				</div>
			</div>--%>
    	</div>
    	<div style="width:49%;float:right;margin-right:0.5%;">

			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="daohuo">
						<strong>公告栏</strong><a class="daohuo_right"  onClick="window.top.quickEnter('公告','公告列表','ANNOUNCE_MANAGE')">更多公告 >></a>
					</div>
				</div>
				<div id="announceList" class="panel-body list-group" style="height:265px;padding:0px 5px;overflow: hidden;">
				</div>
			</div>
    		
			
    		<%--<div class="panel panel-default">
			  	<div class="panel-heading">
					<div class="daohuo">
					 	<strong>上周销量情况(万)</strong>
				    </div>
				</div>
				<div class="panel-body" style="padding: 0px;overflow: hidden;">
				 	<div class="message" style="width:100%;"> <div id="lastWeekSalesChart" style="height:270px;"></div></div>
				</div>
			</div>
			<div class="panel panel-default">
			  	<div class="panel-heading">
					<div class="daohuo">
					 	<strong>客户分类统计</strong>
				    </div>
				</div>
				<div class="panel-body" style="overflow: hidden;">
				  <div class="message" style="width:100%;"> <div id="accountReportChart" style="height:170px;"></div></div>
				</div>
			</div>
			
			<div class="panel panel-default">
			  	<div class="panel-heading">
					<div class="daohuo">
					 	<strong>我的商机Top 10</strong>
				    </div>
				</div>
				<div class="panel-body" style="padding: 0px;padding-bottom:3px;overflow: hidden;">
				  <div id="optyTop10Canvas" style="height:320px;"></div>
				</div>
			</div>--%>
		</div>
    </div>
</div>
    
    
    
    <!--反馈弹出框-->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="width:450px;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" onclick="clearForm()"><span aria-hidden="true" style="font-size:22px;">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">信息反馈</h4>
	      </div>
	      <div class="modal-body" style="padding:10px 30px;">
	        <form role="form" id="feedbackForm" method="post">
			  <div class="modal-line">
			    <input type="text" class="form-control form-input" id="callName" name="callName" placeholder="怎么称呼您">
			  </div>
			  <div class="modal-line">
			    <input type="text" class="form-control form-input" id="phoneNumber" name="phoneNumber" placeholder="请留下您的手机号码">
			  </div>
			  <div class="modal-line">
			    <textarea class="form-control form-input easyui-validatebox" data-options="required:true" rows="6" id="suggest" name="suggest" missingMessage="该输入项为必输项" placeholder="如您有关于产品的任何问题，欢迎反馈给我们，我们将在第一时间回复。"></textarea>
			  </div>
			  <div class="modal-line">
				<button type="button" class="btn btn-success btn-xs" onclick="addForumAtt()">添加图片</button>
				<div id="imgForm"></div>
			  </div>
	 	      <div class="modal-line">
		      	<button type="button" class="btn btn-info btn-lg btn-block form-input" onclick="saveFeedbackInfo()">提交</button>
		      </div>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	
	
     <script>
     	 window.history.forward(1);//防止浏览器后退
     	 var appCtx  = window.parent.appCtx;
     	$feedbackForm = $("#feedbackForm");   //反馈表单
    	$.post('${AppContext.ctxPath}/action/portal/pushNotice/queryFlowPage',{row:50,page:1},function (data) {
    		 var html = [];
    		 for(var i=0; data != null && data.rows != null && i< data.rows.length;i++){
    			 var item = data.rows[i];
                 var myDate = new Date(item.created.replace(/-/g,'/'));
                 var created = myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate());
    			 if(item.flowName == null) {
    				 item.flowName = "";
    			 }
		    	 var attr4 = '${AppContext.ctxPath}' + item.attr4;
    			 html.push('<a href="###" onclick="window.top.quickEnter(\''+item.attr1+'\',\''+item.attr2+'\',\''+item.attr3+'\',\''+attr4+'\')" class="list-group-item"> <div class="row" style="margin:0px 0px;">');
   			 	 html.push('<div class="col-md-9">'+'【'+item.type +'】'+item.pushNote +'</div>');
   			 	 html.push('<div class="col-md-3">'+created+'</div>');
    			 html.push('</div></a>');
    		 }
    	 	$('#approvalList').html(html.join(''));
    	 });

   		 $.post('${AppContext.ctxPath}/action/portal/pushNotice/queryPushNoticePage',{row:50,page:1},function (data) {
       		 if(data.success){
       			var html = [];
          		 for(var i=0; data != null && data.rows != null && i< data.rows.length;i++){
          			var item = data.rows[i];
                    var myDate = new Date(item.created.replace(/-/g,'/'));
                    var created = myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate());
          			if(item.pushNote == null) {
   	   				 	item.pushNote = "";
   	   			 	}
          			html.push('<a href="###" onclick="gotoContentPage(\'/portal/announce/AnnouceReadOnly.jsp?anneType='+item.pushType
          					+'&captions='+item.type+'&publishDate='+item.created+'&contents='+item.attr2+'&attr1='
          					+item.attr4+'&attr2='+item.attr5+'&attr3='+item.attr6+'&attr4='+item.attr7+'&attr5='
          					+item.attr1+'&attr6='+item.attr3+'\')" class="list-group-item"> <div class="row" style="margin:0px 0px;">');
   			 		html.push('<div class="col-md-9">'+'【'+item.type +'】'+ item.pushNote+'</div>');
   			 		html.push('<div class="col-md-3">'+created+'</div>');
   			 		html.push('</div></a>');
          		 }
          	 	$('#messageList').html(html.join(''));
       		 }
       	 });

    	 $.post('${AppContext.ctxPath}/action/portal/announce/manageList',{row:50,page:1,anneStatus:'PUBLISHED',attr1:'home'},function (data) {
    		 var html = [];
    		 for(var i=0; data != null && data.rows != null && i< data.rows.length;i++){
    			 var item = data.rows[i];
    			 var anneType = '公告';
                 var myDate = new Date(item.publishDate.replace(/-/g,'/'));
                 var publishDate = myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate());
       			html.push('<a href="###" onclick="gotoContentPage(\'${AppContext.ctxPath}/action/portal/announce/edit/' + item.id +'\')" class="list-group-item"> <div class="row" style="margin:0px 0px;height:33.34%;overflow:hidden;">');
 			 	html.push('<div class="col-md-9" style="height:70px;overflow: hidden;">'+'【'+item.captions +'】'+item.contents +'</div>');
 			 	html.push('<div class="col-md-3">'+publishDate+'</div>');
 			 	html.push('</div></a>');
    		 }
    	 	$('#announceList').html(html.join(''));
    	 });
         
     
           /* function makeHomeTop10Ichart(data){
        	   var BODY_WIDTH = 0;
        	   BODY_WIDTH = Math.floor((document.body.clientWidth * 0.5 - 100));
	           chartTop10= new iChart.Bar2D({
	               render : 'optyTop10Canvas',
	               data: data,
	               animation:true,
	               turn_off_touchmove: true,
	               sub_option:{
	                   border:{
	                       color:"#BCBCBC",
	                       width:1
	                   },
	                   listeners:{
	                       parseText:function(t,x,y){
	                           return "";
	                       }
	                   },
	                   label:{
	                       fontweight:500,
	                       fontsize:12,
	                       color:"#4572a7",
	                       sign:"square",
	                       sign_size:12,
	                       border:{
	                           color:"#BCBCBC",
	                           width:1
	                       },
	                       background_color:"#fefefe"
	                   }
	               },
	               z_index:-1,
	               offsetx:0,
	               offsety:-18,
	               background_color: null,
	               border: {
	                   width: 0
	               },
	               showpercent:false,
	               // decimalsnum:2,    color:'#FFFFFF',
	               width : BODY_WIDTH,
	               //column_width:"70%",
	               bar_height: 20,
	               height : 340,
	               coordinate:{
	            	   width:"95%",
	                   height:"90%",
	                   axis: {
	                       color: '#9f9f9f',
	                       width: [1, 1, 1, 1]
	                   },
	                   scale:[{
	                       position:'bottom',
	                       start_scale:0,
	                       // end_scale:40,
	                       // scale_space:8,
	                       listeners:{
	                           parseText:function(t,x,y){
	                               return {text:t}
	                           }
	                       }
	                   }]
	               }
	           });
	         	//利用自定义组件构造左侧说明文本
               chartTop10.plugin(new iChart.Custom({
                   drawFn:function(){
                       //计算位置

                       var _bar_height=chartTop10.options._bar_height;
                       var bar_space=chartTop10.options.bar_space;
                       var coo = chartTop10.getCoordinate(),
                           x = coo.get('originx'),
                           y = coo.get('originy'),
                           h = coo.height;

                       //在左下侧的位置，渲染一个单位的文字
                       chartTop10.target.textAlign('start')
                           .textFont('normal 12px "Microsoft YaHei"');
                       for(var i=0;i<data.length;i++){
                    	   chartTop10.target.fillText(data[i].label+" ("+(data[i].value)+"万)",x+10,y+bar_space+_bar_height/2+4+(_bar_height+bar_space)*(i),false,'#333333');
                       }
                   }
               }));
               chartTop10.draw();
           } */
           
           /* $.get('${AppContext.ctxPath}/action/portal/report/queryOptyTop10Report').success(function (data) {
                  if (data.success) {
                	  var dataNew =[];
                      var dataList = data.rows;
                      var l = dataList.length;
                      
                      for (var i = 0; i < l; i++) {
                          //var temp = dataList[l - 1 - i];
                          //option.series[0].data.push(yuanToWanFormatter(temp.amount));
                          //option.yAxis[0].data.push(l - i);
                          //option.series[0].data1.push(temp.optyName);
                    	  var temp=dataList[i];
                    	  temp.amount = yuanToWanFormatter(temp.amount)
                          dataNew.push({name :i+1,value : temp.amount,color:'#39b6d6',label:temp.optyName});
                      }
                      //myChart.setOption(option);
                      makeHomeTop10Ichart(dataNew);
                  }
              })
              .error(function (data) {
                 
              }); */
	          
           /* function yuanToWanFormatter(value,row){
	        	var showValue = parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
	        };
           function makeLastWeekIchart(data,MAX){
        	   //var P_MAX = Math.ceil(MAX / 5 / 10) * 10 * 5;
        	   var P_MAX = getMaxValueForReport(MAX,5);
        	   var BODY_WIDTH = 0;
        	   BODY_WIDTH = Math.floor((document.body.clientWidth * 0.5 - 100));
               var data1 = [
                   {
                       name: '销售金额',
                       value: data,
                       color: '#0d8ecf',
                       line_width: 2
                   }
               ];
               var labels = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
               chartLastWeek = new iChart.LineBasic2D({
                   render: 'lastWeekSalesChart',
                   data: data1,
                   align: 'center',
                   animation:true,
                   background_color: null,
                   offsetx:0,
	               offsety:-5,
                   turn_off_touchmove: true,
                   subtitle: {
                       text: '已成交订单 (单位：万)',
                       fontsize: '12px',
                       color: '#999999'
                   },
                   border: {
                       color: "#BCBCBC",
                       width: 0
                   },
                   width: BODY_WIDTH,
                   height: 270,
                   sub_option: {
                       smooth: false,//平滑曲线
                       point_size: 10
                   },
                   legend: {
                       enable: false
                   },
                   crosshair: {
                       enable: true,
                       line_color: '#62bce9'
                   },
                   coordinate: {
                	   width:"85%",
	                   height:"80%",
                       axis: {
                           color: '#9f9f9f',
                           width: [0, 0, 1, 1]
                       },
                       scale: [{
                           position: 'left',
                           start_scale: 0,
                           end_scale: P_MAX,
                           scale_color: '#9f9f9f'
                       }, {
                           position: 'bottom',
                           labels: labels
                       }]
                   }
               });
               //开始画图
               chartLastWeek.draw();
           } */
           /* $.get('${AppContext.ctxPath}/action/portal/report/queryLastWeekSales').success(function (data) {
                  if (data.success) {
                	  var flow = [0, 0, 0, 0, 0, 0, 0];
                      var MAX = 1;
                      for (var i = 0; i < data.rows.length; i++) {
                          data.rows[i].amount = yuanToWanFormatter(data.rows[i].amount);
                          if (data.rows[i].type == 'L') {
                              if (parseInt(data.rows[i].amount) > parseInt(MAX)) {
                                  MAX = data.rows[i].amount;
                              }
                          }
                          if (data.rows[i].type == 'L' && data.rows[i].dt == "星期一") {
                              //lastWeekSalesOption.series[0].data[0] = data.rows[i].amount;
                        	  flow[0] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'L' && data.rows[i].dt == "星期二") {
                              //lastWeekSalesOption.series[0].data[1] = data.rows[i].amount;
                        	  flow[1] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'L' && data.rows[i].dt == "星期三") {
                              //lastWeekSalesOption.series[0].data[2] = data.rows[i].amount;
                        	  flow[2] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'L' && data.rows[i].dt == "星期四") {
                              //lastWeekSalesOption.series[0].data[3] = data.rows[i].amount;
                        	  flow[3] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'L' && data.rows[i].dt == "星期五") {
                              //lastWeekSalesOption.series[0].data[4] = data.rows[i].amount;
                        	  flow[4] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'L' && data.rows[i].dt == "星期六") {
                              //lastWeekSalesOption.series[0].data[5] = data.rows[i].amount;
                        	  flow[5] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'L' && data.rows[i].dt == "星期日") {
                              //lastWeekSalesOption.series[0].data[6] = data.rows[i].amount;
                        	  flow[6] = data.rows[i].amount;
                          }
                      }
                      //lastWeekSalesChart.setOption(lastWeekSalesOption);
                      makeLastWeekIchart(flow,MAX);
                  }
              })
              .error(function (data) {
                 
              }); */
           /* 	  var firstTimeLoad = true;
	          
           function getMaxValueForReport(MAX, N) {
        	    MAX = parseFloat(MAX);
        	    var P_MAX;
        	    if (MAX > 10 || MAX == 10) {

        	        P_MAX = Math.ceil(MAX / N / 10) * 10 * N;
        	    }
        	    else if (MAX > 1.1 && MAX < 10) {
        	        P_MAX = Math.ceil(MAX / N) * N;
        	    }
        	    else if (MAX < 1) {
        	        var temp = MAX.toString();
        	        var f = 0;//小数位数
        	        if (temp.toLowerCase().indexOf("e") != -1) {
        	            f = temp.charAt(temp.length - 1);
        	        } else {
        	            f = temp.search(/[1-9]/i) - 1;
        	        }
        	        P_MAX = Math.ceil(MAX * Math.pow(10, f) / N) / Math.pow(10, f) * N;
        	    }
        	    return P_MAX;
        	};
           		function makeHomeAccntTypeIchart(data){
             	   chartAccnt= new iChart.Pie2D({
                        render: 'accountReportChart',
                        data: data,
                        animation: true,
                        offsetx:0,
     	               offsety:-18,
                        background_color: null,
                        turn_off_touchmove: true,
                        legend: {
                            enable: false
                        },
                        gradient: false,
                        border: {
                            color: "#BCBCBC",
                            width: 0
                        },
                        sub_option: {
                            border: {
                                color: "#BCBCBC",
                                width: 2
                            },
                            label: {
                                fontweight: 500,
                                fontsize: 12,
                                color: "#4572a7",
                                sign: "",
                                sign_size: 12,
                                border: {
                                    color: "#BCBCBC",
                                    width: 0
                                },
                                background_color: null
                            }
                        },
                        showpercent: false,
                        decimalsnum: 2,
                        width: 500,
                        height: 200,
                        radius: 66
                    });
             	  chartAccnt.draw();
                } */
           /* $.get('${AppContext.ctxPath}/action/portal/report/queryAccntTypeReport').success(function (data) {
                  if (data.success) {
                	  var dataNew = [];
                	  var aPieChartColor= ['#778899', '#BC8F8F', '#4682B4', '#B0C4DE', '#3CB371', 
                	                       '#66CDAA', '#808000',
                	                       '#C23531', '#2F4554', '#91C7AE', '#61A0A8', '#D48265',
                	                       '#66CDAA', '#808000', '#E87C25', '#27727B', '#FCCE10', 
                	                       '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
                	                       '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'];

                	  for (var i = 0; i < data.rows.length; i++) {
                          var temp = data.rows[i];
                          //accountOption.series[0].data.push({
                          //    value: temp.num,
                          //    name: temp.accntType
                          //});
                          dataNew.push({name: getLovShowName('ACCT_TYPE',temp.accntType), value: parseFloat(temp.num),color:aPieChartColor[i]});
                      }
                	  //myAccountChart.setOption(accountOption);
                	  makeHomeAccntTypeIchart(dataNew);
                  }
              })
              .error(function (data) {
                 
              }); */
           
         //清空表单
   		/* function clearForm() {
   			imgNum = 1;//重置照片计数
   			$("#imgForm").empty();//清除div内容 
   			$('#feedbackForm')[0].reset();
   		} */
   		
   		//添加图片事件
   		/* var imgNum = 1;
   		var nestImg = 'img' + imgNum;
   		var nestImgInput = 'imgInput' + imgNum;
   		var nestImgDiv = 'imgDiv' + imgNum;
   		function addForumAtt() {
   			var html = '<div class="imgDevbox" style="width:125px;float:left;display:none;" id="'+nestImgDiv+'">'
   					+ '<div style="width:117px;"><a class="fa fa-times imgClose" onclick="$(&quot;#'
   					+ nestImgDiv
   					+ '&quot;).remove();"></a></div>'
   					+ '<img id="'+nestImg+'"  src="" class="img200"/>'
   					+ '<input id="'
   					+ nestImgInput
   					+ '" type="file" name="uploadAttachment" accept="image/gif,image/jpeg,image/jpg,image/png,image/bmp" style="display:none;" onchange="preImg(this.id,&quot;'
   					+ nestImg
   					+ '&quot;,&quot;'
   					+ nestImgDiv
   					+ '&quot;)"/>'
   					+ '</div>'
   			$('#imgForm').append(html);
   			imgNum++;
   			$('#' + nestImgInput).trigger('click');
   			nestImg = 'img' + imgNum;
   			nestImgInput = 'imgInput' + imgNum;
   			nestImgDiv = 'imgDiv' + imgNum;
   		}	 */

   		//获取文件url
   		/* function getFileUrl(sourceId) {
   			var url;
   			if (navigator.userAgent.indexOf("MSIE") >= 1) { // IE 
   				url = document.getElementById(sourceId).value;
   			} else if (navigator.userAgent.indexOf("Firefox") > 0) { // Firefox 
   				url = window.URL.createObjectURL(document
   						.getElementById(sourceId).files.item(0));
   			} else if (navigator.userAgent.indexOf("Chrome") > 0) { // Chrome 
   				url = window.URL.createObjectURL(document
   						.getElementById(sourceId).files.item(0));
   			}
   			return url;
   		} */
   		/**文件预览方法**/
   		/* function preImg(sourceId, targetId, outTargetId) {
   			var url = getFileUrl(sourceId);
   			var imgPre = document.getElementById(targetId);
   			imgPre.src = url;
   			$('#' + outTargetId).css("display", "");
   		} */		

   		//提交保存反馈信息
/*    		var headId;
   		var headName;
   		function saveFeedbackInfo(){
    			var isPass = $feedbackForm.form('validate');
   			if(!isPass){
   				$.messager.alert("提示", "请先输入您的建议再提交！");
   				return isPass;
   			}
   			$.post('${AppContext.ctxPath}/action/portal/appSuggest/insert', {
   				callName   :$("#callName").val(),
   				phoneNumber:$("#phoneNumber").val(),
   				suggest    :$("#suggest").val(),
   				origin     :"CRM",
   				empId      :appCtx.userId
   			}, function(data) {
   				if (!data.success) {
   					window.parent.operationtip(data.result,'error');
   				} else {
   					record = data.newRow;
   					headId = record.id;
   					headName = "信息反馈图片";
   					if(imgNum>1){
   						uploadAttachment();//添加照片						
   					}
    				//	$('#myModal').on('hidden.bs.modal', function () {
   					//	$.messager.alert("操作提示", "提交成功！");
   					//  })
   					$('#myModal').modal('hide');
   					clearForm();		
					$.messager.alert("操作提示", "提交成功！");			
   				}
   			});
   		} */
   		
   	/**
   		添加图片
   	 */
   	/* function uploadAttachment() {
   		$.messager.progress();
   		var options = {
   			url : '${AppContext.ctxPath}/action/portal/attachment/insertWithFiles',
   			type : 'post',
   			data : {
   				headId : headId,
   				moduleType : "feedback",
   				headCode : headId,
   				headName : headName
   			},
   			dataType : 'json',
   			contentType : "application/vnd.ms-excel;charset=utf-8",
   			success : function(data) {
   				if (data.success) {
   					//successFun(that, data);
   					$.messager.progress('close');
   				} else {
   					if (data.result == null) {
   						data.result = "上传失败！";
   					}
   					$.messager.alert("警告", data.result);
   				}
   			}
   		}; 
   		$("#feedbackForm").ajaxSubmit(options); 		
   	}	 */
    </script>
</body>
</html>