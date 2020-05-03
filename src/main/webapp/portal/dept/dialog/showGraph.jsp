<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/jquery.orgchart.css">
<script src="${AppContext.ctxPath}/static/js/jquery-3.1.0.min.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.orgchart.js"></script>
<style type="text/css">
.orgchart .node .title {
    background-color: rgb(70, 156, 231);border-radius: 4px 4px 0 0;color: #fff;font-size: 12px;font-weight: bold;height: 40px;line-height: 40px;overflow: hidden;text-align: center;text-overflow: ellipsis;white-space: nowrap;
}
.orgchart {
    display: inline;min-height: 202px;min-width: 202px;-webkit-touch-callout: none;-webkit-user-select: none;-khtml-user-select: none;-moz-user-select: none;-ms-user-select: none;user-select: none;
    background-image: linear-gradient(90deg, rgba(200, 0, 0, 0.15) 10%, rgba(0, 0, 0, 0) 10%), linear-gradient(rgba(200, 0, 0, 0.15) 10%, rgba(0, 0, 0, 0) 10%);
    background-size: 10px 10px;border: 1px dashed rgba(0,0,0,0);padding: 0px;
}
.orgchart .node .content {
    width: 100%;height: 20px;font-size: 11px;line-height: 18px;border: 1px solid rgb(70, 156, 231);border-radius: 0 0 4px 4px;text-align: center;background-color: #fff;color: #333;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;
}
.orgchart tr.lines td.rightLine {
    border-right: 1px solid rgb(70, 156, 231);float: none;border-radius: 0px;
}
.orgchart tr.lines td.leftLine {
    border-left: 1px solid rgb(70, 156, 231);float: none;border-radius: 0px;
}
.orgchart tr.lines td.topLine {
    border-top: 2px solid rgb(70, 156, 231);
}
.orgchart tr.lines .downLine {
    background-color: rgb(70, 156, 231);margin: 0px auto;height: 20px;width: 2px;float: none;
}
.fa {
    display: none;font: normal normal normal 14px/1 FontAwesome;font-size: inherit;text-rendering: auto;-webkit-font-smoothing: antialiased;-moz-osx-font-smoothing: grayscale;
}
.orgchart .node {
	display: inline-block;position: relative;margin: 0;padding: 3px 10px;border: 0px dashed transparent;text-align: center;width: 180px;
}
.orgchart .node .title {
    border-radius: 0;
}
.orgchart .node .content {
    border-radius: 0;
}
.orgchart .node .title:hover
{
text-overflow:inherit;
overflow:visible;
}
.orgchart .node .content:hover
{
text-overflow:inherit;
overflow:visible;
}
.orgchart .node:hover {
    background-color: rgba(238, 217, 54, 0.5);
    transition: .5s;
    cursor: default;
    z-index: 20;
}
</style>
<body>
	<div id="chart-container"></div>
	<script type="text/javascript">
			//var id = getQueryParam('id');
			//console.log(id);
			$('#chart-container').orgchart({
			      'data' : '${AppContext.ctxPath}/action/portal/dept/treelist/'+'${param.id}',
			      'depth': 10,
			      //'toggleSiblingsResp': true,
			      'nodeTitle': 'text'			      
			    });
			
			//获取父窗口参数值
			/* function getQueryParam(name) {
	            var obj = $('#showgrah').dialog('options');
	            var queryParams = obj["queryParams"];

	            return queryParams[name];
	        } */
	</script>
</body>
</html>