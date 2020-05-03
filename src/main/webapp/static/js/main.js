var widthVal = 0;
var heightVal = 110;

/**
 * 操作提示后自动关闭
 * @param message
 * @param debug
 */
function operationtipautoclose(message, debug){
	 var autoclose = $.messager.alert("操作提示", message, debug);
	 setTimeout(function(){$(autoclose).window('close') },800);
}

/**
 * 操作提示
 * @param message
 * @param debug
 */
function operationtip(message, debug){
	$.messager.alert("操作提示", message, debug);
	
}

/**
 * 进度提示
 * @param title
 * @param text
 */
function operationprogress(title, text){
	$.messager.progress({
		title:title,
		text:text
	});
}


/**
 * 操作确认
 */
function operationconfirm(obj, url, id, text){
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				id:id
		    },
			function(data){
				if(!data.success){
					operationtip(data.result, 'error');
					return;
				}
				else
				{
					obj.datagrid('reload');
				}
			});
		}
	});
}

/**
 * 操作确认
 */
function operfirm(url, id, text, callback){
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				id:id
		    },
			function(data){
				if(data.success){
					callback();
				} else {
					operationtip(data.result, 'error');
				}
			});
		}
	});
}

/**
 * 操作确认:是否执行一个方法
 */
function operationconfirmToDo(text, sureToDo){
	$.messager.confirm("操作提示", text, function(data){
		if(data){
			sureToDo();
		}
	});
}

/**
 * 操作删除购物车
 */
function shopCartOperationconfirmDel(url, id, text, completeUrl){
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				id:id
		    },
			function(data){
				if(!data.success){
					operationtip(data.result, 'error');
					return;
				}
				else
				{
					loadFrame(completeUrl);
				}
			});
		}
	});
}


/**
 * 操作确认:2个参数
 */
function paramoperationconfirm(url, pre, rear, text, callback){
	var preObjId = null;
	var rearObjId = null;
	preObjId = pre;
	rearObjId = rear;
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				preObjId : preObjId,
				rearObjId : rearObjId
		    },
			function(data){
		    	if(data.success=="error"){
		    		operationtip("您扔有检查结果未填写！", 'error');
		    		return;
		    	}
		    	else if(!data.success){
					operationtip(data.result, 'error');
					return;
				}
				else
				{
					callback();
				}
			});
		}
	});
}

/**
 * 操作确认:3个参数
 */
function moreparamoperationconfirm(url, pre, rear, attr, text, callback){
	var preObjId = null;
	var rearObjId = null;
	var attr1 = null;
	preObjId = pre;
	rearObjId = rear;
	attr1 = attr;
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				preObjId : preObjId,
				rearObjId : rearObjId,
				attr1 : attr1
		    },
			function(data){
		    	if(rearObjId == "fstExamine"){
		    		alert("接口："+data.sapParam);
		    	}
		    	if(data.success=="error"){
		    		operationtip("您扔有解析结果未填写！", 'error');
		    		return;
		    	}
		    	else if(!data.success){
					operationtip(data.result, 'error');
					return;
				}
				else
				{
					callback();
				}
			});
		}
	});
}


/**
 * 操作确认:4个参数
 */
function mostparamoperationconfirm(url, pre, rear, attr, attrSec, text, callback){
	var preObjId = null;
	var rearObjId = null;
	var attr1 = null;
	var attr2 = null;
	preObjId = pre;
	rearObjId = rear;
	attr1 = attr;
	attr2 = attrSec;
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				preObjId : preObjId,
				rearObjId : rearObjId,
				attr1 : attr1,
				attr2 : attr2
		    },
			function(data){
		    	alert("接口："+data.sapParam);
		    	if(data.success=="error"){
		    		operationtip("您扔有内容未填写！", 'error');
		    		return;
		    	}
		    	else if(!data.success){
					operationtip(data.result, 'error');
					return;
				}
				else
				{
					callback();
				}
			});
		}
	});
}

/**
 * 操作确认:5个参数
 */
function fiveparamoperationconfirm(url, pre, rear, attr, attrSec, attrThd, text, callback){
	var preObjId = null;
	var rearObjId = null;
	var attr1 = null;
	var attr2 = null;
	var attr3 = null;
	preObjId = pre;
	rearObjId = rear;
	attr1 = attr;
	attr2 = attrSec;
	attr3 = attrThd;
	$.messager.confirm("操作提示", text, function(data){
		if(data)
		{
			$.post(url, 
			{
				preObjId : preObjId,
				rearObjId : rearObjId,
				attr1 : attr1,
				attr2 : attr2,
				attr3 : attr3
		    },
			function(data){
		    	if(data.success=="error"){
		    		operationtip("您扔有解析结果未填写！", 'error');
		    		return;
		    	}
		    	else if(!data.success){
					operationtip(data.result, 'error');
					return;
				}
				else
				{
					callback();
				}
			});
		}
	});
}

/**
 * 
 * @param pickTitle
 * @param pickUrl
 */
function PopUp(pickTitle, pickUrl)
{
	var diag = new Dialog();
	diag.Width = 860;
	diag.Height = 400;
	diag.Title = pickTitle;
	diag.URL = pickUrl;
	diag.show();
}


/**
* 下拉事件
* @param obj select对象
* @param url 请求的url
*/
function selectAjax(obj,url)
{
if(obj.options.length == 0)
{
	$.ajax({
		type: "get",
		url: url,
		success: function(data, status){
			if(data.success)
			{
				var arry = data.result;
				for (var i = 0; i < arry.length; i++) {
					var op = document.createElement("OPTION");
					op.value = arry[i];
					op.text = arry[i];
					obj.options.add(op);
				}
			}
		}
	});
}
}

/**
* 判断objs是否包含obj，包含返回true,不包含返回false
* @param objs
* @param obj
*/
function isContain(objs, obj)
{
	for(var i= 0; i < objs.length; i++)
	{
		if(objs[i].id == obj)
		{
			return true;
		}
	};
	return false;
}

/**
 * 默认的初始化方法
 */
/*
$(function(){
	//修复ie8下数组没有indexOf方法
	if (!Array.prototype.indexOf)
	{
	  Array.prototype.indexOf = function(elt)
	  {
	    var len = this.length >>> 0;
	    var from = Number(arguments[1]) || 0;
	    from = (from < 0)
	         ? Math.ceil(from)
	         : Math.floor(from);
	    if (from < 0)
	      from += len;
	    for (; from < len; from++)
	    {
	      if (from in this &&
	          this[from] === elt)
	        return from;
	    }
	    return -1;
	  };
	}
});*/

/*
 *   客户端Key生成函数
 */
function clientKeyGenerate(){
    var myDate=new Date();
    return 'T-'+myDate.getTime();
}

function isClientKey(key){
	if(key == null || key ==''){
		return false;
	}
	if(typeof key === 'string' && key.length > 2){
		var start = key.substring(0,2);
		if(start == 'T-'){
			return true;
		}
	}
	return false;
}


/**
 * 公共的日期显示格式
 * 显示前10位字段
 * @param value
 * @param row
 * @param index
 */
function dateFormate(value,row,index){
	if(typeof value === 'string' && value.length > 10){
		var date = value.substring(0,10);
		return date;
	}
	return value;
}

/**
 * 公共的日期显示格式
 * 显示前19位字段
 * @param value
 * @param row
 * @param index
 * @returns
 */
function dateTimeFormate(value,row,index){
	if(typeof value === 'string' && value.length > 19){
		var date = value.substring(0,19);
		return date;
	}
	return value;
}

/**
 * 缩略显示格式
 * 当内容超过10个时显示缩略，鼠标放上之后显示全部
 * @param value
 * @param row
 * @param index
 * @returns
 */
function abbrFormate(value,row,index){
	if(value && value.length > 10){
	  var val =	value.substring(0,5) + ' ...';
	  return '<abbr title="' + value + '">' + val + '</abbr>';
	}
	return value;
}

/**
 * 人民币转换为大写
 * @param currencyDigits
 * @returns {String}
 */
function convertCurrency(currencyDigits) {
	var MAXIMUM_NUMBER = 99999999999.99;
	var CN_ZERO = "零";
	var CN_ONE = "壹";
	var CN_TWO = "贰";
	var CN_THREE = "叁";
	var CN_FOUR = "肆";
	var CN_FIVE = "伍";
	var CN_SIX = "陆";
	var CN_SEVEN = "柒";
	var CN_EIGHT = "捌";
	var CN_NINE = "玖";
	var CN_TEN = "拾";
	var CN_HUNDRED = "佰";
	var CN_THOUSAND = "仟";
	var CN_TEN_THOUSAND = "万";
	var CN_HUNDRED_MILLION = "亿";
	var CN_SYMBOL = "";
	var CN_DOLLAR = "元";
	var CN_TEN_CENT = "角";
	var CN_CENT = "分";
	var CN_INTEGER = "整";
	// Variables:
	var integral; // Represent integral part of digit number.
	var decimal; // Represent decimal part of digit number.
	var outputCharacters; // The output result.
	var parts;
	var digits, radices, bigRadices, decimals;
	var zeroCount;
	var i, p, d;
	var quotient, modulus;
	// Validate input string:
	currencyDigits = currencyDigits.toString();
	if (currencyDigits == "") {
		document.getElementById("money_flag").value = "0";
		return "还没有输入数字！";
	}
	if (currencyDigits.match(/[^,.\d]/) != null) {
		document.getElementById("money_flag").value = "0";
		return "请输入有效数字!";
	}
	if ((currencyDigits)
			.match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
		document.getElementById("money_flag").value = "0";
		return "请输入有效格式数字！";
	}
	// Normalize the format of input digits:
	currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma delimiters.
	currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the beginning.
	// Assert the number is not greater than the maximum number.
	if (Number(currencyDigits) > MAXIMUM_NUMBER) {
		document.getElementById("money_flag").value = "false";
		return "您输入的数字太大了!";
	}
	// Process the coversion from currency digits to characters:
	// Separate integral and decimal parts before processing coversion:
	parts = currencyDigits.split(".");
	if (parts.length > 1) {
		integral = parts[0];
		decimal = parts[1];
		// Cut down redundant decimal digits that are after the second.
		decimal = decimal.substr(0, 2);
	} else {
		integral = parts[0];
		decimal = "";
	}
	// Prepare the characters corresponding to the digits:
	digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE,
			CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
	radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
	bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
	decimals = new Array(CN_TEN_CENT, CN_CENT);
	// Start processing:
	outputCharacters = "";
	// Process integral part if it is larger than 0:
	if (Number(integral) > 0) {
		zeroCount = 0;
		for (i = 0; i < integral.length; i++) {
			p = integral.length - i - 1;
			d = integral.substr(i, 1);
			quotient = p / 4;
			modulus = p % 4;
			if (d == "0") {
				zeroCount++;
			} else {
				if (zeroCount > 0) {
					outputCharacters += digits[0];
				}
				zeroCount = 0;
				outputCharacters += digits[Number(d)] + radices[modulus];
			}
			if (modulus == 0 && zeroCount < 4) {
				outputCharacters += bigRadices[quotient];
			}
		}
		outputCharacters += CN_DOLLAR;
	}
	// Process decimal part if there is:
	if (decimal != "") {
		for (i = 0; i < decimal.length; i++) {
			d = decimal.substr(i, 1);
			if (d != "0") {
				outputCharacters += digits[Number(d)] + decimals[i];
			}
		}
	}
	// Confirm and return the final output string:
	if (outputCharacters == "") {
		outputCharacters = CN_ZERO + CN_DOLLAR;
	}
	if (decimal == "") {
		outputCharacters += CN_INTEGER;
	}
	outputCharacters = CN_SYMBOL + outputCharacters;
	document.getElementById("money_flag").value = "1";
	document.getElementById("UpperAmount").innerHTML = outputCharacters;
}
/**
 * 判断文件们是否包含空文件，是的话反会false,否的话返回true，其中文件的<input>标签的name='myfiles'
 */
function checkFilesSize(){
	//判断文件的大小，如果有文件大小为0kb,函数返回false，如果文件都超过0KB,返回true;
	var files=$("input[name='myfiles']");
	var flag=1;
	
	for(i=0;i<files.length;i++){
		if(files[i].files.length!=0){//判断文件是否存在
			if(files[i].files[0].name!=null){
				//先判断下文件名是否存在，存在的情况下再判断大小
				if(files[i].files[0].size==0){
					Dialog.alert(files[i].files[0].name+"文件为0KB,不支持发布！");
					flag=0;
					return false;
				}
			}
		}
	}
	
	if(flag==1){
		return true;
	}
	
}

/**
 * 格式化URL请求参数
 */
var formatRequest = function(data){
	for(var filed in data){
		if ( typeof ( data[filed]) == "object" ){
			data[filed] = JSON.stringify(data[filed]);
		}else if(typeof ( data[filed]) == "Array"){
			data[filed] = JSON.stringify(data[filed]);
		}
	}
	return data;
};


var addFilter = function (filters,filtersRaw) {
	if(filters.operator == 'in' && filters.value instanceof Array){
		var value = '[';
		for(var i=0;i<filters.value.length;i++){
			if(i == filters.value.length-1){
				value = value + filters.value[i]+']';
			}else{
				value = value + filters.value[i]+',';
			}
		};
		if(filters.value.length == 0){
			value = value +']';
		}
		filters.value = value;
	}
	for(var i = 0; i < filtersRaw.length; i++){
		var filter = filtersRaw[i];
		if(filter.id == filters.id){
			if(filters.value =='-ALL' || filters.value == null){
				filtersRaw.splice(i,1);
			}else{
				filtersRaw[i] = filters;
			}
			return;	
		}
	}
	if(filters.value !='-ALL'){
    	filtersRaw.push(filters);
	}
};

var moveMainMenuRight = function(){
	var obj=document.getElementById('caidan');
	obj.scrollLeft += 600;
}

var moveMainMenuLeft = function(){
	var obj=document.getElementById('caidan');
	obj.scrollLeft -= 600;
	if(obj.scrollLeft < 0){
		obj.scrollLeft = 0;
	}
}

var getCurrentDHM = function(){
	if(length != null){
		var time2 = new Date().Format("yyyy-MM-dd hh:mm");
		return time2;
	}
};

Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};



function setCookie(name,value)
{
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days*24*60*60*1000);
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString()+";path=/;";
}

function getCookie(name)
{
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

function gotoContentPage(url){
	window.top.$('#mainFrame').attr("src",url);
};

function GetRequest(url) {
	var theRequest = new Object();
	var index = url.indexOf("?"); 
	if (index != -1) {
		var str = url.substr(index+1);
		strs = str.split("&");
		for(var i = 0; i < strs.length; i ++) {
			theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
		}
	}
	return theRequest;
}

function getUrlParams(field){
	var url = window.top.$('#mainFrame').attr('src');
	var params = GetRequest(url);
	if(typeof field === undefined || field == null){
		return params;
	}else{
		if(params == null){
			return params;
		}else{
			return params[field];
		}
	}
}

/**
 * sortBy函数接受一个成员名字符串做为参数,并返回一个可以用来对包含该成员的对象数组进行排序的比较函数,
 * 使用例子：array.sort(sortBy("field"));
 * @param field 排序的属性名
 */
function sortBy(field) {
	return function(o, p) {
		var a, b;
		if (typeof o === "object" && typeof p === "object" && o && p) {
			a = o[field];
			b = p[field];
			if (a === b) {
				return 0;
			}
			if (typeof a === typeof b) {
				return a < b ? -1 : 1;
			}
			return typeof a < typeof b ? -1 : 1;
		} else {
			throw ("error");
		}
	}
}
/**
 * 把值列表加入页面缓存
 * @param list
 */
function addLovOfList(list){
	if(window.lovList == null){
		window.lovList = [];
	}
	if(list instanceof Array){
		for(var i=0;i < list.length;i++){
			var item = list[i];
			if(!item){
				continue;
			}
			if(checkRepeat(item.type,item.name,item.val)== false){
				window.lovList.push({type:item.type,val:item.val,name:item.name});
			}
		}
	}else{
		alert("添加的内容必须为数组!");
	}
};
/**
 * 查询后台获取值列表信息，并加入页面缓存
 * @param types
 */
function getLovOfList(types){
/*	$.post("/action/portal/basic/listOfVal/types",{types:JSON.stringify(types)},function(data){
		if(data.success){
			addLovOfList(data.rows);
		}else{
			alert("查询页面值列表信息出错，请刷新后再操作！");
		}
	});*/
	
	$.ajax({
		async:false,
		method:'POST',
		dataType:'json',
		data: {types: JSON.stringify(types)},
		url:getRootPath() + '/action/portal/basic/listOfVal/types',
		//timeout:3000,
		success:function(data){
			if(data.success){
				addLovOfList(data.rows);
			}
		}
	});
}
/**
 * 根据类型返回值列表数组[{},{},...]
 * @param type
 */
function getLovArray(type){
	if(window.lovList == null ){
		window.lovList = [];
	}
	var lovArray = [];
	for(var i=0;i<window.lovList.length;i++){
		var item = window.lovList[i];
		if(item.type == type){
			lovArray.push(item);
		}
	}
	if(lovArray.length >0){
		return lovArray;
	}
	var queryType = "["+type+"]";
	$.ajax({
		async:false,
		method:'POST',
		dataType:'json',
		data: {types: JSON.stringify(queryType)},
		url:getRootPath() + '/action/portal/basic/listOfVal/types',
		//timeout:2000,
		success:function(data){
			if(data.success){
				addLovOfList(data.rows);
			}
		}
	});
	for(var i=0;i<window.lovList.length;i++){
		var item = window.lovList[i];
		if(item.type == type){
			lovArray.push(item);
		}
	}
	
	return lovArray;
}
/**
 * 根据类型与独立源代码查询值列表显示值，无则返回独立源代码
 * @param type
 * @param value
 * @returns
 */
function getLovShowName(type,value){
	
	if(window.lovList == null ){
		window.lovList = [];
	}
	var flag = false;
	for(var i=0;i<window.lovList.length;i++){
		var item = window.lovList[i];
		if(item.type == type){
			flag = true;
			if(item.val == value){
				return item.name;
			}
		}
	}
	if(flag == true){
		return value;
	}
	if(window.errLovList == null){
		window.errLovList = [];
	}
	for(var i=0;i<window.errLovList.length;i++){
		var item = window.errLovList[i];
		if(item.type == type){
			return item.name;
		}
	}
	//console.log("GET ShowName Type = '"+type+"', val= '"+value +"'; length="+window.lovList.length);
	//console.log("Not find Type == '"+type+"' val== '"+value+"'");
	var queryType = "["+type+"]";
	$.ajax({
		async:false,
		method:'POST',
		dataType:'json',
		data: {types: JSON.stringify(queryType)},
		url:getRootPath() + '/action/portal/basic/listOfVal/types',
		//timeout:3000,
		success:function(data){
			if(data.success){
				addLovOfList(data.rows);
			}
		}
	});
	for(var i=0;i<window.lovList.length;i++){
		var item = window.lovList[i];
		if(item.type == type && item.val == value){
			return item.name;
		}
	}
	window.errLovList.push({type:type,val:value,name:value});//当查询服务器也无法找到该值列表时，把该值列表类型也加入到缓存，防止多次请求
	return value;
}

function checkRepeat(type,name,value){
	if(window.lovList == null || window.lovList.length == 0){
		return false;
	}
	for(var i=0;i<window.lovList.length;i++){
		var item = window.lovList[i];
		if(item.type == type && item.val == value && item.name == name){
			return true;
		}
	}
	return false;
}
/**
 * 工具提示，datagrid控件的formatter方法，用于显示单元格里所有内容
 */
function tooltipFormatter(val,row,index){
    if(val != null){
       var content = '';
       var content = val.replace(/\\n/g,'\n');
       var val = val.replace(/\\n/g,'; ');
    	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
    }
}

/**
 * 以金额的形式显示字符串
 * @param value 数据源
 * @param symbol 货币符号
 */
function currencyShowTool(value,symbol){
	var result = '';
	if(symbol == undefined){
		symbol = '';
	}
    if(value == null){
    	result = '0';
    } else {
    	result = parseFloat(value).toLocaleString();
    }
    return symbol + result;
}

//判断浏览器类型版本信息
function getBrowserInfo() {
    var userAgent = navigator.userAgent,
        rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
        rFirefox = /(firefox)\/([\w.]+)/,
        rOpera = /(opera).+version\/([\w.]+)/,
        rChrome = /(chrome)\/([\w.]+)/,
        rSafari = /version\/([\w.]+).*(safari)/;
    //console.info(userAgent);
    var browser;
    var version;
    var ua = userAgent.toLowerCase();
    var match = rMsie.exec(ua);
    if (match != null) {
        return { browser: "IE", version: match[2] || "0" };
    }
    var match = rFirefox.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rOpera.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rChrome.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rSafari.exec(ua);
    if (match != null) {
        return { browser: match[2] || "", version: match[1] || "0" };
    }

}

//引用上面的代码判断浏览器版本是否支持
function isBrowserSupport()
{
    var browserInfo = getBrowserInfo();
    //alert(browserInfo.browser + '--' + browserInfo.version);
    if (browserInfo.browser) {
        if (browserInfo.browser == "IE"&&browserInfo.version<9)
        {
            alert("该系统支持的IE浏览器为9.0以上的版本，您的IE浏览器版本为"+browserInfo.version+"，请升级，以免影响使用体验！");
            return false;
        }
        /*else if (browserInfo.browser == "chrome" &&  30>browserInfo.version.substring(0,browserInfo.version.indexOf(".")))
        {
           alert("浏览器版本太低，请升级，以免影响使用体验！");
            return false;
        }
        else if (browserInfo.browser == "firefox" && 40 > browserInfo.version.substring(0, browserInfo.version.indexOf("."))) {
           alert("浏览器版本太低，请升级，以免影响使用体验！");
            return false;
        }*/else{
        	return true;
        }
    }
}

function baiduProvinceFormat(province){
	var value;
	if(province=='内蒙古自治区'||province=='黑龙江省'){
		value = province.substr(0,3);
	}else{
		value = province.substr(0,2);
	}
	return value;
}

function nullFormat(value){
	if(value == null){
		value = '';
	}
	return value;
}

/**
 * 获取系统根目录
 * @returns
 */
function getRootPath(){
	if(typeof(appCtx) != 'undefined' && appCtx && appCtx.ctxPath != undefined){
		return appCtx.ctxPath;
	}
	var pathname = window.location.pathname;
	var pathArray = pathname.split("/");
	if(pathArray.length < 2 || pathArray[1] == '' || pathArray[1] == 'action' || pathArray[1] == 'portal'){
		return '';
	}
	return '/' + pathArray[1];
}

