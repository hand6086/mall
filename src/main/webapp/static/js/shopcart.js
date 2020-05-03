/**
 * 全选按钮
 * @param obj
 */
function checkAllOrNot(obj){
	var flag = $(obj).is(':checked');
	$("#product_list input[type=checkbox]").each(function () {
		if(flag){
			$('.allselect').prop('checked',true);
			$(this).prop('checked',true);
			$("#product_list").find("ul").attr("class", "get_bg");
		}else{
			$('.allselect').prop('checked',false);
			$(this).prop('checked',false);
			$("#product_list").find("ul").attr("class", "");
		}
	});
	GetCount();
}

/**
 * 选择行
 * @param obj
 */
function checkLineOrNot(obj){
	// 选择一个订单类型下所有的产品并改变其样式
	var flag = $(obj).is(':checked');
	$(obj).parent().next().find("input[type=checkbox]").each(function () {
		if(flag){
			$(this).prop('checked',true);
			$(this).parent().parent().attr("class", "get_bg");
		}else{
			$(this).prop('checked',false);
			$(this).parent().parent().attr("class", "");
		}
	});
	
	// 判断是否此类型下是否全部选中
	var x = 0;
	$(obj).parent().parent().find(".check_line").each(function () {
		if ($(this).is(':checked')) {
			x++;
		}
	});
	if(x == shopcartprodcount){
		$('.allselect').prop('checked',true);
	}else{
		$('.allselect').prop('checked',false);
	}
	GetCount();
}

/**
 * 选择单个产品
 * @param obj
 */
function checCpOrNot(obj){
	// 修改背景颜色
	var flag = $(obj).is(':checked');
	if(flag){
		$(obj).parent().parent().attr("class", "get_bg");
	}else{
		$(obj).parent().parent().attr("class", "");
	}
	// 判断是否此类型下是否全部选中
	var x = 0;
	var y = 0;
	var z = 0;
	$(obj).parent().parent().parent().find(".check_cp").each(function () {
		x++;
		if ($(this).is(':checked')) {
			y++;
		}
	});
	if(x == y){
		$(obj).parent().parent().parent().prev().find('.check_line').prop('checked',true);
	}else{
		$(obj).parent().parent().parent().prev().find('.check_line').prop('checked', false);
	}
	// 判断是否全部选中
	$('.check_cp').each(function () {
		if ($(this).is(':checked')) {
			z++;
		}
	});
	if(shopcartprodcount == z){
		$('.allselect').prop('checked',true);
	}else{
		$('.allselect').prop('checked',false);
	}
	GetCount();
}


function updateProductCount(obj,newValue,oldValue){
	// 更新数据库
	var prodId = $(obj).parent().prevAll().find('.shopcartid').val();
	$.post('/action/portal/shopcart/update',{
		id: prodId,
		qty:newValue
	},function(data){
		if(!data.success){
			window.parent.operationtip(data.result, 'error');
		}else{
			// 修改数据库数量成功后，修改页面数量，金额
			var cash = 0;
			var cp_price = $(obj).parent().prev().find('.cp_price').html();
			if(newValue){
				cash = newValue * cp_price;
			}else{
				newValue = 1;
			}
			$(obj).parent().next().find('.cp_total').html(cash);
			GetCount();
		}
	});
}
function GetCount() {
	var cashs = 0;
	var counts = 0;
	$(".cp_listare input[type=checkbox]").each(function () {
		if ($(this).is(':checked')) {
			for (var i = 0; i < $(this).length; i++) {
				cashs += parseInt($(this).parent().parent().find('.allcode span').html());
				counts += 1;
			}
		}
	});
	$("#selectedNum").text(counts);
	$("#selectCash").html((cashs).toFixed(2));
}

