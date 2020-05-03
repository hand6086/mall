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
						<th field="optyName" width="30%">商机名称</th>
						<th field="attr22"  width="20%"  formatter="yuanToWanFormatter">license金额预测</th>
						<th field="amount"  width="20%"  formatter="yuanToWanFormatter">实施费用预测</th>
						<th field="totalAmount" width="20%" align="right" currency="CNY" formatter="yuanToWanFormatter">总额</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
   <script>
   			
   			
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
           
           $.get('${AppContext.ctxPath}/action/portal/opty/queryOptyTop10').success(function (data) {
                  if (data.success) {
                	  var dataNew =[];
                      var dataList = data.rows;
                      
                      var l = dataList.length;
                      for (var i = 0; i < l && i < 10; i++) {
                          var temp=dataList[i];
                          temp.amount = yuanToWanFormatterNoLogo(temp.totalAmount);
                          dataNew.push({name :i+1,value : temp.amount,color:'#39b6d6',label:temp.optyName});
                      }
                      makeIchart(dataNew);
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
					url:'${AppContext.ctxPath}/action/portal/opty/queryOptyTop10'
			});
	           
           function yuanToWanFormatter(value,row){
        	    if(isNaN(value) || !value){
        	    	return value;
        	    }
	        	var showValue = parseFloat(parseFloat(value)/10000).toFixed(2)+" 万";
	        	return showValue;
	        }
           function yuanToWanFormatterNoLogo(value){
        	   var showValue = parseFloat(parseFloat(value)/10000).toFixed(2);
	        	return showValue;
           }
    </script>
</body>
</html>