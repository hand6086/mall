/*可以定义规则*/
var at_config = {
	at : "@", // 触发的条件
	data : "/action/portal/test/getUserList",// 数据来源 返回json数据 
	searchKey : 'firstName', // 定义匹配字段
	insertTpl : "@" + '${firstName}' + "(${id})",// 选中时插入的文本
	displayTpl : "<li>${firstName}<small>${userName} </small></li>",// 显示提示文本格式
	startWithSpace : true, // 是否必须有空格后才能触发
	limit : 10, // 显示记录条数
	max_len : 20,// 匹配字符长度
	display_timeout : 300,
	delay : null,
	callbacks : {
		beforeReposition : function(offset) {
			// alert(offset.top+', '+offset.left);
			offset.top -= 150;// 调整提示列表显示位置
			return offset;
		}
	}
}
//$('.inputor').atwho(at_config);
//引入@插件
//<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/at/css/jquery.atwho.min.css"> 
//<script src="${AppContext.ctxPath}/static/at/js/jquery.atwho.js"></script>
//<script type="text/javascript" src="${AppContext.ctxPath}/static/at/js/jquery.caret.min.js"></script>