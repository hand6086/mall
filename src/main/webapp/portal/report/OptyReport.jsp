<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<!-- <script src="${AppContext.ctxPath}/static/js/echarts.min.js"></script>  -->
<script type="text/javascript" src="${AppContext.ctxPath}/static/js/ichart.latest.min.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.hdatagrid.js"></script>
<body>
   <div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'west',split:true" title="商机TOP10" border="false" style="width:50%;height:100%;padding:0px;">
	   		<div id="optyTop10Canvas" style="height:480px;"></div>
	    </div>
	    <div data-options="region:'center'" border="false">
		   <table id="opty-top-table" width="100%" height="100%" singleSelect="true" rownumbers="true"  pagination="false">
				<thead>
					<tr>
						<th field="optyName" width="50%">商机名称</th>
						<th field="amount" width="40%" align="right" currency="CNY" formatter="yuanToWanFormatter">销售额（单位：万）</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
   <script>
   			
   			
           /*
           var myChart = echarts.init(document.getElementById('optyTop10Canvas'));
           //echarts
           var option = {
               tooltip: {
                   trigger: 'item',
                   axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                       type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                   },
                   formatter: function (params) {
                       for (var i = 0, l = option.yAxis[0].data.length; i < l; i++) {
                           if (params.name == option.yAxis[0].data[i]) {
                               return params.name + '<br/>' + option.series[0].data1[i] + '<br/>' + option.series[0].data[i];
                           }
                       }
                   }
               },
               legend: {
                   x: 'left',
                   data: ['销售额']
               },
               xAxis: [
                   {
                       name: "(万)",
                       sho: true,
                       type: 'value'
                   }
               ],
               yAxis: [
                   {
                       type: 'category',
                       axisTick: {show: true},
                       data: []
                   }
               ],
               series: [
                   {
                       name: '销售额',
                       type: 'bar',
                       itemStyle: {
                           normal: {
                               color: '#39b6d6',
                               label: {
                                   show: true,
                                   position: 'insideLeft',
                                   formatter: //'{a}:{b}: {c}'+series[0].data1['{b}']
                                   	function (params) {
                                       for (var i = 0, l = option.series[0].data.length; i < l; i++) {
                                           if (params.name == option.yAxis[0].data[i]) {
                                               return option.series[0].data1[i] + "("+option.series[0].data[i] + "万)";
                                           }
                                       }
                                   },
                                   textStyle: {
                                       color: '#595959'
                                   }
                               }
                           }
                       },
                       data: [],
                       data1: []
                   }
               ]
           };
           */
           function makeIchart(data){
        	   //console.log(data);
	           chart= new iChart.Bar2D({
	               render : 'optyTop10Canvas',
	               data: data,
	               animation:false,
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
	               title : '我的商机Top 10',
	               background_color: null,
	               border: {
	                   width: 0
	               },
	               showpercent:false,
	               // decimalsnum:2,    color:'#FFFFFF',
	               width : 700,
	               height : 500,
	               coordinate:{
	                   axis: {
	                       color: '#9f9f9f',
	                       width: [1, 1, 1, 1]
	                   },
	                   scale:[{
	                       position:'bottom',
	                       start_scale:0,
	                       // end_scale:40,
	                       // scale_space:8,
	                       /**/ listeners:{
	                           parseText:function(t,x,y){
	                               return {text:t}
	                           }
	                       }
	                   }]
	               }
	           });
	         	//利用自定义组件构造左侧说明文本
               chart.plugin(new iChart.Custom({
                   drawFn:function(){
                       //计算位置

                       var _bar_height=chart.options._bar_height;
                       var bar_space=chart.options.bar_space;
                       var coo = chart.getCoordinate(),
                           x = coo.get('originx'),
                           y = coo.get('originy'),
                           h = coo.height;

                       //在左下侧的位置，渲染一个单位的文字
                       chart.target.textAlign('start')
                           .textFont('normal 12px "Microsoft YaHei"');
                       for(var i=0;i<data.length;i++){
                           chart.target.fillText(data[i].label+" ("+(data[i].value)+"万)",x+10,y+bar_space+_bar_height/2+4+(_bar_height+bar_space)*(i),false,'#333333');
                       }
                   }
               }));
               chart.draw();
           }
           
           $.get('${AppContext.ctxPath}/action/portal/report/queryOptyTop10Report').success(function (data) {
                  if (data.success) {
                	  var dataNew =[];
                      var dataList = data.rows;
                      
                      var l = dataList.length;
                      for (var i = 0; i < l && i < 10; i++) {
                          var temp=dataList[i];
                          temp.amount = yuanToWanFormatterNoLogo(temp.amount);
                          dataNew.push({name :i+1,value : temp.amount,color:'#39b6d6',label:temp.optyName});
                      }
                      makeIchart(dataNew);
                      /*
                      for (var i = 0; i < l; i++) {
                          var temp = dataList[l - 1 - i];
                          option.series[0].data.push(yuanToWanFormatter(temp.amount));
                          option.yAxis[0].data.push(l - i);
                          option.series[0].data1.push(temp.optyName);
                      }
                      myChart.setOption(option);
                      */
                  }
              })
              .error(function (data) {
                 
              });
	           $('#opty-top-table').hdatagrid({
	        	    toolbarShow:false,	//显示工具栏
	        	    buttonExport:true,
					striped:true,
					title:'商机Top10',
					//method:'GET',
					border:false,
					height:'100%',
					url:'${AppContext.ctxPath}/action/portal/report/queryOptyTop10Report'
			});
	           
           function yuanToWanFormatter(value,row){
	        	var showValue = '¥' +parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
	        }
           function yuanToWanFormatterNoLogo(value){
        	   var showValue = parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
           }
    </script>
</body>
</html>