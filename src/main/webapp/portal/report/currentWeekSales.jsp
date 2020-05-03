<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.hdatagrid.js"></script> 
<!-- <script src="${AppContext.ctxPath}/static/js/echarts.min.js"></script>  -->
<script type="text/javascript" src="${AppContext.ctxPath}/static/js/ichart.latest.min.js"></script>

<body>
   <div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'west',split:true" title="本周销量情况" border="false" style="width:50%;height:100%;padding:0px;">
		<div id="thisWeekSalesAmountCanvas" style="height:480px;"></div>
  	</div>
  	<div data-options="region:'center'" border="false">
	  	<table id="opty-top-table" width="100%" height="100%" singleSelect="true" rownumbers="true"  pagination="false">
			<thead>
				<tr>
					<th field="dt" width="50%">星期</th>
					<th field="amount" width="40%" align="right" formatter="yuanToWanFormatter">销售额（单位：万）</th>
				</tr>
			</thead>
		</table>
	</div>
	</div>
   <script>
   		/*
           var myChart = echarts.init(document.getElementById('reportChart'));
           var option = {
                   title: {
                       text: '本周销量情况',
                       subtext: '已成交订单',
                       x: 'center'
                   },
                   tooltip: {
                       trigger: 'axis'
                   },
                   xAxis: {
                       type: 'category',
                       boundaryGap: false,
                       data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
                   },
                   yAxis: {
                       type: 'value',
                       axisLabel: {
                           formatter: '{value} 万', textStyle: {
                               fontSize: 10
                           }
                       }
                   },
                   grid: {
                       top: '80px',
                       left: '20px',
                       right: '40px',
                       bottom: '20px',
                       containLabel: true
                   },
                   series: [
                       {
                           name: '销售金额',
                           type: 'line',
                           data: [0, 0, 0, 0, 0, 0, 0],
                           markPoint: {
                               data: [
                                   {type: 'max', name: '最大值'},
                                   {type: 'min', name: '最小值'}
                               ]
                           },
                           markLine: {
                               data: [
                                   {type: 'average', name: '平均值'}
                               ]
                           }
                       }
                   ]
               };
           */
           function makeCurrentWeekIcharts(data,MAX){
        	   //var P_MAX = Math.ceil(MAX / 5 / 10) * 10 * 5;
        	   var P_MAX = getMaxValueForReport(MAX,5);
        	   
               var data1 = [
                   {
                       name: '销售金额',
                       value: data,
                       color: '#0d8ecf',
                       line_width: 2
                   }
               ];
               var labels = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
               chart = new iChart.LineBasic2D({
                   render: 'thisWeekSalesAmountCanvas',
                   turn_off_touchmove: true,
                   data: data1,
                   align: 'center',
                   animation:false,
                   title: '本周销量情况',
                   background_color: null,
                   subtitle: {
                       text: '已成交订单 (单位：万)',
                       fontsize: '12px',
                       color: '#999999'
                   },
                   border: {
                       color: "#BCBCBC",
                       width: 0
                   },
                  width: 700,
                   height: 500,
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
                       width: '80%',
                       height: '80%',
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
               chart.draw();
           }
           $.get('${AppContext.ctxPath}/action/portal/report/queryCurrentWeekSales').success(function (data) {
                  if (data.success) {
                	  var flow = [0, 0, 0, 0, 0, 0, 0];
                      var MAX = 1;
                      
                      for (var i = 0; i < data.rows.length; i++) {
                          data.rows[i].amount = yuanToWanFormatterNoLogo(data.rows[i].amount);
                          
                          if (data.rows[i].type == 'T') {
                              if (parseInt(data.rows[i].amount) > parseInt(MAX)) {
                                  MAX = data.rows[i].amount;
                              }
                          }
                          if (data.rows[i].type == 'T' && data.rows[i].dt == "星期一") {
                              //option.series[0].data[0] = data.rows[i].amount;
                        	  flow[0] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'T' && data.rows[i].dt == "星期二") {
                            //  option.series[0].data[1] = data.rows[i].amount;
                        	  flow[1] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'T' && data.rows[i].dt == "星期三") {
                          //    option.series[0].data[2] = data.rows[i].amount;
                        	  flow[2] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'T' && data.rows[i].dt == "星期四") {
                              //option.series[0].data[3] = data.rows[i].amount;
                        	  flow[3] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'T' && data.rows[i].dt == "星期五") {
                            //  option.series[0].data[4] = data.rows[i].amount;
                        	  flow[4] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'T' && data.rows[i].dt == "星期六") {
                          //    option.series[0].data[5] = data.rows[i].amount;
                        	  flow[5] = data.rows[i].amount;
                          }
                          else if (data.rows[i].type == 'T' && data.rows[i].dt == "星期日") {
                        //      option.series[0].data[6] = data.rows[i].amount;
                        	  flow[6] = data.rows[i].amount;
                          }
                      }
                    //  myChart.setOption(option);
                    makeCurrentWeekIcharts(flow,MAX)
                  }
              })
              .error(function (data) {
                 
              });
           	  var firstTimeLoad = true;
	           $('#opty-top-table').hdatagrid({
	        	    toolbarShow:false,	//显示工具栏
	        	    buttonExport:true,
					striped:true,
					title:'本周销量情况',
					//method:'GET',
					buttonMenu:false,
					border:false,
					height:'100%',
					url:'${AppContext.ctxPath}/action/portal/report/queryCurrentWeekSales',
					onLoadSuccess:function(data){
						/* for(var i=0;data != null && data.rows != null && i<data.rows.length;i++){
							if(data.rows[i].type != 'T'){
								data.rows.splice(i,1);
								i--;
							}
						}
						if(firstTimeLoad){
							firstTimeLoad = false;
							$(this).datagrid('loadData',data);
						} */
					}
			});
	           
	        function yuanToWanFormatter(value,row){
	        	var showValue = '¥' + parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
	        };
	        function yuanToWanFormatterNoLogo(value){
	        	var showValue = parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
	        };
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
    </script>
</body>
</html>