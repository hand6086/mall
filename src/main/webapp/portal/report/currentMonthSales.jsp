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
<!-- <script src="${AppContext.ctxPath}/static/js/echarts.min.js"></script> --> 
<script type="text/javascript" src="${AppContext.ctxPath}/static/js/ichart.latest.min.js"></script>

<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'west',split:true" title="本月产品销售情况" border="false" style="width:50%;height:100%;padding:0px;">
	   <div id="productSalesTCanvas" style="height:480px;"></div>
	 </div>
  	<div data-options="region:'center'" border="false">
	   <table id="opty-top-table" width="100%" height="100%" singleSelect="true" rownumbers="true"  pagination="false">
			<thead>
				<tr>
					<th field="product" width="50%">产品名称</th>
					<th field="salesamount" width="40%" align="right" formatter="yuanToWanFormatter">销售额（单位：万）</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
   <script>
           function makeCurrentMonthIchart(data){
        	   var CHART_HEIGHT=440;
        	   var l = data.length;
               CHART_HEIGHT=l*40;
               if(CHART_HEIGHT<200)
            	   {
            	   CHART_HEIGHT=200;
            	   }
              document.getElementById("productSalesTCanvas").style.height=CHART_HEIGHT+"px";
        	   chart= new iChart.Bar2D({
                   render : 'productSalesTCanvas',
                   data: data,
                   turn_off_touchmove: true,
                   animation:true,
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
                   title : {
                       text:"本月产品销售情况",
                       height:20
                   },
                
                   background_color: null,
                   border: {
                       width: 0
                   },
                   showpercent:false,
                   bar_height: 25,
                   width : 700,
                   height : CHART_HEIGHT,
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
               })
               //利用自定义组件构造左侧说明文本
               chart.plugin(new iChart.Custom({
                   drawFn:function(){
                       //计算位置
                       //console.log(chart);
                       //console.log(chart.options);
                       var _bar_height=chart.options._bar_height;
                       var bar_space=chart.options.bar_space;
                       var coo = chart.getCoordinate(),
                           x = coo.get('originx'),
                           y = coo.get('originy'),
                           h = coo.height;
                       //console.log("x:"+x+",y:"+y+",h:"+h);
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
           $.get('${AppContext.ctxPath}/action/portal/report/queryCurrentMonthSales').success(function (data) {
                  if (data.success) {
                	  var dataNew = [];
                	  var n=0;
                	  for (var i = 0; i < data.rows.length; i++) {
                		  /* if(data.rows[i].type== 'T'){
                              //option.series[0].data.push(yuanToWanFormatter(data.rows[data.rows.length - i - 1].salesamount ));
                              //option.yAxis[0].data.push(data.rows.length - i);
                              //option.series[0].data1.push(data.rows[data.rows.length - i - 1].product);
                			  n++;
                			  data.rows[i].salesamount = yuanToWanFormatter(data.rows[i].salesamount);
                			  dataNew.push({name :n,value : data.rows[i].salesamount,color:'#39b6d6',label:data.rows[i].product});
                		  } */
                		  n++;
            			  data.rows[i].salesamount = yuanToWanFormatterNoLogo(data.rows[i].salesamount);
            			  dataNew.push({name :n,value : data.rows[i].salesamount,color:'#39b6d6',label:data.rows[i].product});
                      };
                      //myChart.setOption(option, true);
                      if(dataNew.length > 0){
                      		makeCurrentMonthIchart(dataNew);
                      }
                  }
              })
              .error(function (data) {
                 
              });
           	  //var firstTimeLoad = true;
	           $('#opty-top-table').hdatagrid({
	        	    toolbarShow:false,	//显示工具栏
	        	    buttonExport:true,
					striped:true,
					title:'本月产品销售情况',
					buttonMenu:false,
					border:false,
					height:'100%',
					url:'${AppContext.ctxPath}/action/portal/report/queryCurrentMonthSales',
					onLoadSuccess:function(data){
						/* console.log("1:"+data.rows[1].type);
						for(var i=0;data != null && data.rows != null && i<data.rows.length;i++){
							if(data.rows[i].type != 'T'){
								data.rows.splice(i,1);
								i--;
							}
						}
						if(firstTimeLoad){
							firstTimeLoad = false;
							$(this).datagrid('loadData',data);
							console.log("2:"+data);
						}*/
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
    </script>
</body>
</html>