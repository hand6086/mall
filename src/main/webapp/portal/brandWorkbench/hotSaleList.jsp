<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
<body>
<div  class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="hotSale-table" width="100%" height="100%">
		<thead>
			<tr>
				<th field="storeName" width="180px">店铺名称</th>
				<th field="linePath" width="150px" formatter="linePathFormatter">商品图片</th>
				<th field="o2oDisplayName" width="180px">商品名称</th>
				<th field="productCode" width="140px">商品69码</th>
				<th field="isDisplay" width=20% editor="{type:'checkbox', options:{on:'Y', off:'N',required:true}}">是否展示</th>
				<th field="displayOrder" width=20% editor="{type:'numberbox',options:{
																				min:0,
																				precision:0,
																				required:true}}">展示顺序</th>
			</tr>
		</thead>
	</table>
	
	</div>
	</div>
   	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<script type="text/javascript">
	    $datagrid = $('#hotSale-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			newDefaultValue:false,
			border:false,
			nowrap:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/goods/queryByExamplePage',
		    onBeforeLoad:function(param){
				param.brandQuery = '1';
				param.saleStatus = 'SELLING';
			},
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
		    	row.brandUpsert = '1';
				$.post("${AppContext.ctxPath}/action/portal/goods/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        }
		});
		
		function linePathFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A + row.linePath +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
	</script>
</body>
</html>