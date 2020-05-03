<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/header.jsp"%>
<title>移动信息反馈</title>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<style type="text/css">
.img200{
	width:80px;
	height:80px;
	margin:5px 5px;
}
.small_picture{
display:inline;
}
a:hover {
text-decoration:underline;
}
</style>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false"
		fit="true">
		<table id="appSuggestList-table" singleSelect="true" rownumbers="true"
			pagination="true" fit="true">
			<thead>
				<tr>
					<th field="id" width="80px" >编号</th>
					<th field="created" width="120px" >创建时间</th>
					<th field="userName" width="80px" defaultSearch="true">工号 </th>
					<th field="userFirstName" width="80px">员工姓名 </th>
					<th field="callName" width="120px">称呼</th>
					<th field="phoneNumber" width="120px">联系电话</th>
					<th field="origin" width="100px">来源</th>	
					<th field="suggest" width="300px">建议</th>
					<th field="ImagePath" width="500px" formatter="imageFormatter">图片</th> 
				</tr>
			</thead>
		</table>
	</div>
</div>
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<script type="text/javascript">
		$datagrid = $('#appSuggestList-table');
		$datagrid.hdatagrid({
			updateable : false,
			toolbarShow : true, //显示工具栏
			buttonSearch : true, //搜索框功能
			buttonMenu : true,
			nowrap:false,
			striped : true,
			title : '',
			border : false,
			url : '${AppContext.ctxPath}/action/portal/appSuggest/queryByExamplePage',
			onLoadSuccess:function(data){
				$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1});
			}
		});
		
		
		function imageFormatter(val,row)
		{   
			if(row.attachmentList!=null){
				imgHtml = '<div class="replyContent" id="div-' + row.id + '" >';
				for(var j=0;j<row.attachmentList.length;j++){
					imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img  src="'+row.attachmentList[j].attachmentPath+'"  class="img200"/></a></div>';
				}
				imgHtml +='</div>';				
			}
			 return imgHtml;
		}
	</script>
</body>

</body>
</html>