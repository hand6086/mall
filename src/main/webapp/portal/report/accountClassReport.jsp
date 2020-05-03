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
<script src="${AppContext.ctxPath}/static/js/main.js"></script>

<body>
   <div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'west',split:true" title="客户分类统计" border="false" style="width:50%;height:100%;padding:0px;">
	   <div id="accountReportChart" style="height:480px;"></div>
	 </div>
  	<div data-options="region:'center'" border="false">
	   <table id="account-report-table" width="100%" height="100%" singleSelect="true" rownumbers="true"  pagination="false">
			<thead>
				<tr>
					<th field="accntType" lov="ACCT_TYPE" width="50%">客户分类</th>
					<th field="num" width="40%" align="right">数量（单位：个）</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
   <script>
   			/*
           var myAccountChart = echarts.init(document.getElementById('accountReportChart'));
           var accountOption = {
                   title: {
                       text: '客户分类统计',
                       subtext: '有效客户',
                       x: 'center'
                   },
                   tooltip: {
                       trigger: 'item',
                       formatter: "{a} <br/>{b} : {c} ({d}%)"
                   },
                   toolbox: {
                       show: true,
                       feature: {}
                   },
                   calculable: true,
                   series: [
                       {
                           type: 'pie',
                           radius: '35%',
                           center: ['50%', '60%'],
                           colorData: ['#778899', '#BC8F8F', '#4682B4', '#B0C4DE', '#3CB371', '#66CDAA', '#808000'],
                           itemStyle: {
                               normal: {
                                   color: function (params) {
                                       for (var i = 0, l = accountOption.series[0].data.length; i < l; i++) {
                                           if (params.data.name == accountOption.series[0].data[i].name) {
                                               return accountOption.series[0].colorData[i];
                                           }
                                       }
                                   },
                                   label: {
                                       show: true,
                                       formatter: function (params) {
                                           for (var i = 0, l = accountOption.series[0].data.length; i < l; i++) {
                                               if (params.name == accountOption.series[0].data[i].name) {
                                                   return params.name + "(" + accountOption.series[0].data[i].value + "个)";
                                               }
                                           }
                                       }
                                   }
                               }
                           },
                           data: []
                       }
                   ]
               };
           */
           function makeAccntTypeIchart(data){
        	   chart= new iChart.Pie2D({
                   render: 'accountReportChart',
                   data: data,
                   title : '客户分类统计',
                   animation: false,
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
                           fontsize: 11,
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
                   width: 420,
                   height: 420,
                   radius: 90
               });
               chart.draw();
           }
           $.get('${AppContext.ctxPath}/action/portal/report/queryAccntTypeReport').success(function (data) {
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
                          dataNew.push({name: getLovShowName('ACCT_TYPE',temp.accntType), value: parseFloat(temp.num),color:aPieChartColor[i]});
                      }
                	  //myAccountChart.setOption(accountOption);
                	  if(dataNew.length > 0){
                	  		makeAccntTypeIchart(dataNew);
                	  }
                  }
              })
              .error(function (data) {
                 
              });
           	  var firstTimeLoad = true;
	           $('#account-report-table').hdatagrid({
	        	    toolbarShow:false,	//显示工具栏
	        	    buttonExport:true,
					striped:true,
					title:'客户分类统计',
					buttonMenu:false,
					border:false,
					height:'330px',
					url:'${AppContext.ctxPath}/action/portal/report/queryAccntTypeReport',
					onLoadSuccess:function(data){
						
					}
			});
	           
           function yuanToWanFormatter(value,row){
	        	var showValue = parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
	        }
    </script>
</body>
</html>