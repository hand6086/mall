<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<script type="text/javascript">
		$goodsHeaderForm = $('#goodsHeaderForm');
		$.post("${AppContext.ctxPath}/action/portal/salesPromotionSchema/queryApplyList", {
			startRow : 1,
			type     : 'Second Kill'
		}, function(data) {
				if (data) {
					$goodsHeaderForm.form("load", data);
					window.location.href = "${AppContext.ctxPath}/portal/brandPromotion/brandSeckillApplyList.jsp"
				} else {
					window.parent.operationtip(data.result, 'error');
				}
		});
</script>
</body>
</html>