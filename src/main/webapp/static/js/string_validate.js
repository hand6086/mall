/**
 * 判断是否为数字
 * */
function isNumber(s) {
	var regu = "^[0-9]+$";
	var re = new RegExp(regu);
	if (s.search(re) != -1) {
		return true;
	} else {
		return false;
	}
}

/**
 * 判断是否为数字或大写字母
 * */
function isNumberOrLetter(s) {
	var regu = "^[0-9A-Z]+$";
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	} else {
		return false;
	}
}

/**
 * 判断是否为-
 * */
function isGan(s) {
	if (s=="-") {
		return true;
	} else {
		return false;
	}
}