<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<%@ include file="/portal/header.jsp" %>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=X19IbB6EWVWpGrNBZuyUI9LpCi2aXMXr"></script>
<script src="${AppContext.ctxPath}/static/baiduMap/Heatmap.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/baiduMap/TextIconOverlay.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/baiduMap/MarkerClusterer.js?version=<%=version%>"></script>
<title>热力图功能示例</title>
<style type="text/css">

/* ul,li{list-style: none;margin:0;padding:0;float:left;}
html{height:100%}
body{height:100%;margin:0px;padding:0px;font-family:"微软雅黑";}*/
#container{height:500px;width:100%;}

</style>
<body>
  <div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false"
		style="width: 100%;" fit="true">
		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">快速筛选</span>
			</legend>
			<div class="row keyfilter-border">
				<ul id="sales-year-keyfilter" data-toggle="keyfilter"
					data-title="年份" data-filter-filed="year"
					data-table-Id="OptyReport-table">
				</ul>
			</div>
		
			<div class="row keyfilter-border">
				<ul id="sales-month-keyfilter" data-toggle="keyfilter"
					data-title="月份" data-filter-filed="month"
					data-table-Id="OptyReport-table">
				</ul>
			</div>
		</fieldset>

		<br/>
	
		<div id="container"></div>
	</div>
  </div>
<script type="text/javascript">
	$('#sales-year-keyfilter').keyFilter({
		remoteData:true,
		filterByValue:true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/workplan/list/YEAR',
		onClickKeyFilter:function(filedName,filedValue){
			//checkWeekPeriod(filedName,filedValue);
		}
		
	});
	
	$('#sales-month-keyfilter').keyFilter({
		remoteData:true,
		filterByValue:true,
		remoteUrl:'${ctx}/action/portal/basic/list/MONTH',
		onClickKeyFilter:function(filedName,filedValue){
			//checkWeekPeriod(filedName,filedValue);
		}
	});

	var map = new BMap.Map("container");          // 创建地图实例
	var point = new BMap.Point(116.418261, 39.921984);
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.addControl(new BMap.NavigationControl({enableGeolocation:true}));
	map.addControl(new BMap.OverviewMapControl());
    map.centerAndZoom(point, 5);             // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(); // 允许滚轮缩放
    $.ajax({
	     url:'/action/portal/saleorder/querySalesOrderOfDistrict',
	     type:"post",
	     data:{"usercorpid":appCtx.corpId},
	     dataType:"json",
	     success:function(data){
	      if (data.success){
	    	  var row = data.rows;
	    	  //var points = [];
	    	  var markers=[];
              $.each(row, function(index, item) {
                  /*var pt = { "lng": item.attr1, "lat": item.attr2, "count": 100 }; //count 权重
                  points.push(pt);*/
            	  var pt = new BMap.Point(item.attr1, item.attr2);
           	   	  markers.push(new BMap.Marker(pt));
              });
	    	  if(!isSupportCanvas()){
	    		  alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
	    	  }
	    	  //详细的参数,可以查看heatmap.js的文档 https://github.com/pa7/heatmap.js/blob/master/README.md
	    		//参数说明如下:
	    		/* visible 热力图是否显示,默认为true
	    	     * opacity 热力的透明度,1-100
	    	     * radius 势力图的每个点的半径大小   
	    	     * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
	    	     *	{
	    				.2:'rgb(0, 255, 255)',
	    				.5:'rgb(0, 110, 255)',
	    				.8:'rgb(100, 0, 255)'
	    			}
	    			其中 key 表示插值的位置, 0~1. 
	    			    value 为颜色值. 
	    	     */
	    	    /* heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":50});
	    		map.addOverlay(heatmapOverlay);
	    		heatmapOverlay.setDataSet({data:points,max:100}); */
	    		//closeHeatmap();
	    		
	    		//最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
	    		var markerClusterer = new BMapLib.MarkerClusterer(map, {
	    			markers:markers,
	    			girdSize : 100,
	    			styles : [{
	    	            url:'/static/images/red.png',
	    	            size: new BMap.Size(92, 92),
	    				backgroundColor : '#E64B4E'
	    			}],
	    		}); 
	    		markerClusterer.setMaxZoom(13);
	    		markerClusterer.setGridSize(100);
	      }
	        	
	    }
	 });
    
    
	//是否显示热力图
    function openHeatmap(){
        //heatmapOverlay.show();
    }
	function closeHeatmap(){
        //heatmapOverlay.hide();
    }
    function setGradient(){
     	/*格式如下所示:
		{
	  		0:'rgb(102, 255, 0)',
	 	 	.5:'rgb(255, 170, 0)',
		  	1:'rgb(255, 0, 0)'
		}*/
     	var gradient = {};
     	var colors = document.querySelectorAll("input[type='color']");
     	colors = [].slice.call(colors,0);
     	colors.forEach(function(ele){
			gradient[ele.getAttribute("data-key")] = ele.value; 
     	});
        heatmapOverlay.setOptions({"gradient":gradient});
    }
	//判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
	
	
	
</script>

</body>

</html>