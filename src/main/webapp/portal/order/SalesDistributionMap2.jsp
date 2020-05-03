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
<script src="${AppContext.ctxPath}/static/baiduMap/mapv.js?version=<%=version%>"></script>

<title>百度热力图.区域销量分布图</title>
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
					data-table-Id="SalesDistribution-table">
				</ul>
			</div>
		
			<div class="row keyfilter-border">
				<ul id="sales-month-keyfilter" data-toggle="keyfilter"
					data-title="月份" data-filter-filed="month"
					data-table-Id="SalesDistribution-table">
				</ul>
			</div>
		</fieldset>

		<br/>
	
		<div id="container"></div>
	</div>
  </div>
<script type="text/javascript">
	$.ajax({
	    url:'/action/portal/saleorder/querySalesOfDistrict',
	    type:"post",
	    data:{"usercorpid":appCtx.corpId},
	    dataType:"json",
	    success:function(data){
	     if (data.success){
	   	  loadPoints(data);
	     }
	       	
	   }
	});
	$('#sales-year-keyfilter').keyFilter({
		remoteData:true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/workplan/list/YEAR',
		dataReport:true,
		dataReportUrl:'/action/portal/saleorder/querySalesOfDistrict',
		userDefined:true,
		userDefinedFunction:function(data){
			loadPoints(data);
		},
		tableId: 'SalesDistribution-table'
	});
	
	$('#sales-month-keyfilter').keyFilter({
		remoteData:true,
		remoteUrl:'${ctx}/action/portal/basic/list/MONTH',
		dataReport:true,
		dataReportUrl:'/action/portal/saleorder/querySalesOfDistrict',
		userDefined:true,
		userDefinedFunction:function(data){
			loadPoints(data);
		},
		tableId: 'SalesDistribution-table'
	});
	
	var map = new BMap.Map("container");          // 创建地图实例
	var point = new BMap.Point(116.418261, 39.921984);
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.addControl(new BMap.NavigationControl({enableGeolocation:true}));
	map.addControl(new BMap.OverviewMapControl());
    map.centerAndZoom(point, 5);             // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(); // 允许滚轮缩放
    
    //动态加载数据库的点
    function loadPoints(data){
    	map.clearOverlays(); 
    	var points = [];//热力图点
    	var bPoints = [];//大数据可视化点
        $.each(data.rows, function(index, item) {
            var pt = { "lng": item.attr1, "lat": item.attr2, "count": item.attr3 }; //count 权重
            points.push(pt);
            bPoints.push({
                geometry: {
                    type: 'Point',
                    coordinates: [item.attr1, item.attr2]
                },
                text: '￥' + item.orderTotalAmount
            });
        });
	  	if(!isSupportCanvas()){
		  	alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
	  	}
	  	
	  	var dataSet = new mapv.DataSet(bPoints);
	    var options = {
	        draw: 'text',
	        font: '18px Arial',
	        fillStyle: '#469ce7',
	        //shadowColor: '#469ce7',
	        shadowBlur: 10
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
  	    heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":50});
  		map.addOverlay(heatmapOverlay);
  		heatmapOverlay.setDataSet({data:points,max:10});
    	var mapvLayer = new mapv.baiduMapLayer(map, dataSet, options);
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