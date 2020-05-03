<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/baiduMap/echarts.min.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/baiduMap/china.js?version=<%=version%>"></script>

<title>ECharts区域销量分布图</title>
<style type="text/css">
#report{
	width: 100%;
	text-align:center;
}
#bottomDiv{
	width: 100%;
	line-height:30px;
}
.showTableDiv{
	vertical-align: middle;
	padding-left: 20px;
    padding-right: 20px;
    width: auto;
    overflow: auto;
}

.titleTr{
	background-color: rgb(70, 156, 231);
	/* background-color: rgb(239, 240, 241); */
}

.titleTd{
	border:solid #999; 
	/* border-width:0px 1px 1px 0px;  */
	border-width:1px 1px 1px 1px;
	padding:10px;
	font-size: 10px;
    color: #ffffff;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 400;
    text-align: center;
  
}

#SalesOrderDistribution-table{
	/* border:solid #add9c0; */
	border:solid #999;
	/* border-width:1px 0px 0px 1px; */
	border-width: 0px 0px 0px 0px;
	line-height: 16px;
	border-collapse: collapse;
	margin: auto;
    position: relative;
}

.conTr{

}

.conTd{
	border:solid #999; 
	/* border-width:0px 1px 1px 0px;  */
	border-width:1px 1px 1px 1px;
	padding:3px 0px;
	font-size: 10px;
    /* color: #469ce7; */
    color: #000000;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 200;
    text-align: center;
    /* padding-right: 3px; */
}

</style>
<body>
  <div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false"
		style="width: 100%;" fit="true">
		<fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">订单筛选条件</span>
		</legend>
		<div class="row keyfilter-border">
			<ul id="orderTypeKeyfilter" data-toggle="keyfilter"
				data-title="订单类型" data-filter-filed="orderTypeLovType"
				data-table-Id="SalesOrderDistribution-table">
			</ul>
		</div>
		<div class="row keyfilter-border">
			<ul data-toggle="keyfilter" data-title="订单状态" 
				data-filter-filed="statusLovType"
				data-table-Id="SalesOrderDistribution-table">
				<li data-value="New">新建</li>
				<li data-value="Submitted">已提交</li>
				<li data-value="Approved">已批准</li>
				<li data-value="Rejected">已拒绝</li>
				<li data-value="Closed">已完成</li>
				<li data-value="Cancelled">已取消</li>
			</ul>
		</div>
	</fieldset>

		<br/>
		<div id="report"></div>
		<div id="bottomDiv">&nbsp;</div>
		<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    	<div id="main" style="width: 99%;height:600px;"></div>
	</div>
  </div>
<script type="text/javascript">
	$('#orderTypeKeyfilter').keyFilter({
		remoteData:true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/ORDER_TYPE',
		//filterByValue:true,
		dataReport:true,
		dataReportUrl:'/action/portal/saleorder/querySalesOrderOfDistrict',
		userDefined:true,
		userDefinedFunction:function(data){
			loadPoints(data);
		},
		tableId: 'SalesOrderDistribution-table'
	});
	
/* 	$('#sales-month-keyfilter').keyFilter({
		remoteData:true,
		remoteUrl:'${ctx}/action/portal/basic/list/MONTH',
		dataReport:true,
		dataReportUrl:'/action/portal/saleorder/querySalesOrderOfDistrict',
		userDefined:true,
		userDefinedFunction:function(data){
			loadPoints(data);
		},
		tableId: 'SalesOrderDistribution-table'
	}); */
	
	// 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
	
	$.ajax({
	    url:'/action/portal/saleorder/querySalesOrderOfDistrict',
	    type:"post",
	    data:{"usercorpid":appCtx.corpId},
	    dataType:"json",
	    success:function(data){
	     if (data.success){
	   	  loadPoints(data);
	     }
	       	
	   }
	});
    
    //动态加载数据库的点
    function loadPoints(data){
    	$('#report').html(data.html);
    	//myChart.refresh();
    	myChart.clear();
    	var points = [];//销量数据
        $.each(data.rows, function(index, item) {
            var pt = {name: item.province,value: item.orderTotalAmount };
            points.push(pt);
        });
    	var maxDate;
    	if(data.rows[0] == null){
    		maxDate=1;
    	}else{
    		maxDate = data.rows[0].orderTotalAmount;
    	}
    	option = {
    		    /* title: {
    		        text: '区域销量分布图',
    		        subtext: '纯属虚构',
    		        left: 'center'
    		    }, */
    		    tooltip: {
    		        trigger: 'item'
    		    },
    		    legend: {
    		        orient: 'vertical',
    		        left: 'left',
    		        //data:['iphone7']
    		    },
    		    visualMap: {
    		        min: 0,
    		        max: maxDate,
    		        //left: 'left',
    		        //top: 'bottom',
    		        //text: ['高','低'],           // 文本，默认为数值文本
    		        //calculable: true
    		        show: false
    		    },
    		    toolbox: {
    		        show: false,
    		        orient: 'vertical',
    		        left: 'right',
    		        top: 'center',
    		        feature: {
    		            dataView: {readOnly: false},
    		            restore: {},
    		            saveAsImage: {}
    		        }
    		    },
    		    series: [
    		        {
    		            name: '金额',
    		            type: 'map',
    		            mapType: 'china',
    		            roam: false,
    		            label: {
    		                normal: {
    		                    show: true
    		                },
    		                emphasis: {
    		                    show: true
    		                }
    		            },
    		            data:points
    		        }
    		    ]
    		};
    	
     	// 使用刚指定的配置项和数据显示图表。
     	myChart.setOption(option);
    }
</script>

</body>

</html>