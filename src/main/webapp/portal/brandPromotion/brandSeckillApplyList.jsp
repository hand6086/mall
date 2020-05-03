<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<link rel="stylesheet" type="text/css"
	href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.css?version=<%=version%>" />
<link rel="stylesheet" type="text/css"
	href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap-theme.css?version=<%=version%>" />


<script
	src="${AppContext.ctxPath}/static/bootstrap/js/bootstrap.min.js?version=<%=version%>"></script>
<script
	src="${AppContext.ctxPath}/static/js/jquery.form.js?version=<%=version%>"></script>

<style type="text/css">
tbody {
	width: 100px;
	height: 30px;
	margin-bottom: 5px;
}
.row-img {
	margin-left:30px;
	margin-top:-19px;
}
.row-button {
	padding-top:20px;
}
</style>
<body class="easyui-layout">
	<div id="p1" class="easyui-panel" collapsible="true" collapsed="false" border="false" style="height: 100%; padding: 0px;">
		<form id="goodsHeaderForm" class="form-horizontal" method="post">
			<c:if test="${result.size() > 0 }">
			  <div class="col-md-12 col-sm-12">&nbsp;</div>
				<c:forEach var="brandPromotionSchema" items="${result}">
					<div class="row">
						<div class="col-md-2 col-sm-2 row-img">
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<label>&nbsp;</label>
								</div>
							</div>
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<img src="${brandPromotionSchema.path }" class="img-thumbnail img-responsive center-block"
										alt="Responsive image" onerror="this.src='${AppContext.ctxPath}/static/images/404.jpg';this.onerror=null">
								</div>
							</div>
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<label>&nbsp;</label>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-4 col-md-offset-1 col-sm-offset-1">
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<label class="text-danger">${brandPromotionSchema.schemaName }</label>
								</div>
							</div>
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<input class="form-control" type="text" disabled
										value="报名时间：${brandPromotionSchema.tattr13 }~${brandPromotionSchema.tattr14 }" />
								</div>
							</div>
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<input class="form-control" type="text" disabled
										value="活动时间：${brandPromotionSchema.startDate }~${brandPromotionSchema.endDate }" />
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1 row-button">
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<label>&nbsp;</label>
								</div>
							</div>
							<div class="col-md-12 col-sm-12">
								<input type="button" class="btn btn-success btn-block brandStatus" disabled="enabled" value="${brandPromotionSchema.brandStatus }" onclick="openCampaignApplyWin('${brandPromotionSchema.id }')"/>
							</div>
							<div class="form-group form-group-sm">
								<div class="col-md-12 col-sm-12">
									<label>&nbsp;</label>
								</div>
							</div>
						</div>
					</div>
					<div></div>
					<br />
				</c:forEach>
			</c:if>
			<c:if test="${result.size() <= 0 }">
				<h5 style="text-align: center;font-size: 14px !important;font-weight: 800 !important;font-family: '微软雅黑' !important;color: #777;">当前没有记录可显示~</h5>
			</c:if>
		</form>
		<div id="campaignApplyEditWin" class="crmWin" style="width:100%;height:100%">
	   	 	<iframe src=""  id="campaignApplyEditWinFram" name="campaignApplyEditWinFram" width="100%" height="100%" frameborder="0">
	    	</iframe>
	    </div>
	</div>
<script type="text/javascript">
	$campaignApplyEditWin = $("#campaignApplyEditWin");
	$campaignApplyEditWinFram = $("#campaignApplyEditWinFram");
	var approvalStatus = '';
    function openCampaignApplyWin(schemaId){
	 	 if(!schemaId){
			 $.messager.show("错误", "参数错误，无法获取方案id", "error");
			 return;
		 }
		 $campaignApplyEditWinFram.attr("src","");
		 if( !$campaignApplyEditWinFram.attr("src") ){
			//查询是方案下是否有活动即是否报名
			//未报名则获取方案信息作为活动信息并跳转到活动报名编辑页面
			var headId = 'noMatchId';
			$.post("${AppContext.ctxPath}/action/portal/promotion/brandQueryBySchemaId",{schemaId:schemaId},
				function(data){
					if(data){
						if(data.success){
							promotion = data.result;
							if(promotion != '' && promotion != null ){
								headId = promotion.id;
								approvalStatus = promotion.approvalStatus;
							}
							$campaignApplyEditWinFram.attr("src", "${AppContext.ctxPath}/portal/brandPromotion/brandSeckillApplyEdit.jsp?headId=" + headId);
						}
					}
			 });
			 $campaignApplyEditWinFram[0].onload = function() {
				$campaignApplyEditWinFram[0].contentWindow.secKillCampaignInit(schemaId, approvalStatus, "reload");//等待窗口加载完毕
			 }
		 }else{
			$campaignApplyEditWinFram[0].contentWindow.secKillCampaignInit(schemaId, approvalStatus, "reload");
		 }
		 $campaignApplyEditWin.css("display", "block");
	}
    //子页面返回按钮
    function closeCampaignApplyWin(){
		$campaignApplyEditWin.css("display", "none");
	 }
	 $('.brandStatus').each(function(index, item) {
		if($(item).val() == '报名中'){
			 $(item).removeAttr("disabled");
		}
	 });
</script>
	
</body>
</html>