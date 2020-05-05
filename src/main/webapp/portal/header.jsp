<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.hand.base.user.model.User"%>
<%@ page language="java" import="com.hand.core.util.AppConstants"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Access-Control-Allow-Origin" content="link-crm.cn">
<meta charset="utf-8" />
<%
	User user = (User) session.getAttribute("UserContext");
	String staticPath = AppConstants.portalStaticUrl;
	String userId = "";
	String username = "";
	String firstName = "";
	String role = "";
	String systemRole = "";
	String orgId = "";
	String orgName = "";
	String postnId = "";
	String postnName = "";
	String corpId = "";
	String corpName = "";
	if (user != null) {
		userId = user.getId();
		username = user.getUsername();
		role = user.getRole();
		systemRole = user.getSystemRole();
		orgId = user.getOrgId();
		orgName = user.getOrgName();
		postnId = user.getPostnId();
		postnName = user.getPostnName();
		firstName = user.getFirstName();
		corpId = user.getCorpid();
		corpName = user.getCorpName();
	};
	String version = "2.9.21" + application.getAttribute("contextInitTimeStamp");//版本号
%>
<script type="text/javascript">
window.history.forward(1);//防止浏览器后退
var appCtx = {
		appName: "Portal",
		ctxPath: "<%=request.getContextPath()%>",
		serverName:"<%=request.getServerName()%>",
		serverPort : "<%=request.getServerPort()%>",
		userId : "<%=userId%>",
		role: "<%=role%>",
		systemRole: "<%=systemRole%>",
		username:"<%=username%>",
		firstName:"<%=firstName%>",
		dateFormat: "Y-m-d",
		datetimeFormat: "Y-m-d H:i:s",
		dateDisplayFormat: "Y-m-d",
		datetimeDisplayFormat: "Y-m-d H:i:s",
		orgId  : "<%=orgId%>",
		orgName : "<%=orgName%>",
		postnId : "<%=postnId%>",
		version : "<%=version%>",
		postnName : "<%=postnName%>",
		corpId:"<%=corpId%>",
		corpName:"<%=corpName%>",
		ssid: "<%=session.getId()%>",
		sysdate: function(){
		    var myDate = new Date();
		    return myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate())
		        + " " + NumbertoLen2String(myDate.getHours()) + ":" + NumbertoLen2String(myDate.getMinutes()) + ":" + NumbertoLen2String(myDate.getSeconds())
		},
		sysdateNoSeconds: function(){
		    var myDate = new Date();
		    return myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate())
		        + " " + NumbertoLen2String(myDate.getHours()) + ":" + NumbertoLen2String(myDate.getMinutes())
		},
		sysdateNoTime: function(){
		    var myDate = new Date();
		    return myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate())
		},
		getNowDateShortn: function(n) {
		    var myDate = new Date();
		    myDate.setDate(myDate.getDate()+n); 
		    return myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate())
		},
		getNowDateLongn: function(n) {
		    var myDate = new Date();
		    myDate.setDate(myDate.getDate()+n); 
		    return myDate.getFullYear() + "-" + NumbertoLen2String(Number(myDate.getMonth()) + Number(1)) + "-" + NumbertoLen2String(myDate.getDate())
		        + " " + NumbertoLen2String(myDate.getHours()) + ":" + NumbertoLen2String(myDate.getMinutes()) + ":" + NumbertoLen2String(myDate.getSeconds())
		}
	};
function NumbertoLen2String(n) {
    if (n.toString().length == 1) {
        return '0' + n.toString();
    }
    else {
        return n;
    }
};

function toUpper(value) {
	if (value != undefined && value != '') {
		return value.toUpperCase();
	} else {
		return "";
	}

};

function toLower(value) {
	if (value != undefined && value != '') {
		return value.toLowerCase();
	} else {
		return "";
	}

};

function toFirstLower(value){
	if (value != undefined && value != '') {
		if(value.length>1){
			return value.substring(0,1).toLowerCase()+value.substring(1,value.length);
			
		}else{
			return value.toLowerCase();
		}
		
	} else {
		return "";
	}
};

</script>

<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/bootstrap/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/font/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/css/keyfilter.css">
<link rel="stylesheet" type="text/css" href="<%=staticPath%>/static/css/mvg.css">


<script src="<%=staticPath%>/static/js/jquery.min.js"></script>
<script src="<%=staticPath%>/static/js/public.app.js"></script>
<script src="<%=staticPath%>/static/js/main.js"></script>
<script src="<%=staticPath%>/static/js/jquery-validate.js"></script>
<script src="<%=staticPath%>/static/js/jquery.form.js"></script>
<script src="<%=staticPath%>/static/easyui/js/jquery.easyui.min.js"></script>
<script src="<%=staticPath%>/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.datagrid.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.hdatagrid.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.common.js"></script>
<script src="<%=staticPath%>/static/js/mask.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.picklist.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.mvg.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.multiselect.js"></script>
<script src="<%=staticPath%>/static/js/keyfilter.js"></script>
<script src="<%=staticPath%>/static/js/jquery.menu.js"></script>
<script src="<%=staticPath%>/static/js/jquery.easyui.validate.js"></script>
<script src="<%=staticPath%>/static/js/jquery.hdatagrid.columns.drap.js"></script>
<script src="<%=staticPath%>/static/js/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">

/**
 * 监控会话过期后跳转到登录页
 */
$(document).ajaxComplete(function(event, xhr, settings ){
	if(xhr.responseText.substring(0,8) == '正在跳转到登录页'){
		window.top.location.href = '${AppContext.ctxPath}/portal/handler.jsp';
	}
});
</script>

