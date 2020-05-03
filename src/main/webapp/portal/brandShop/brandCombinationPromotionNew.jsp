<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>
<style type="text/css">
#typeTable .table-block{
	border-collapse:separate; border-spacing:10px;/*表table的tr间距 */
	width:1000px;
	margin: 20px auto;
}
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
}
.td-input{
	width:180px;
	height:20px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 16px;
}
#form {
	width: 1000px;
	margin: 30px auto;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
		<form id="goodsHeaderForm" method="post">
			<table class="form-table">
			   <tr>
				 <td>
				   <fieldset>
					 <legend>套装商品组合</legend>
					  <table class="table-block">
				       	<tr>
				       		<td width="120" class="td-label"><label><span style="color: red;">*</span>套装名称：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="activityName" name="activityName" size="25" class="easyui-validatebox td-input" data-options="min:0,precision:0"/>
				       		</td>
				       	</tr>
						<tr class="freeMerch">	
		     				<td class="td-label"><label><span style="color: red;">*</span>主商品名称&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName" type="text" id="buyMerchName" size="29" />
							</td>
							
							<td width="120" class="td-label"><label><span style="color: red;">*</span>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt" disabled name="buyAmt" size="25" class="buyAmt easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId" id="buyMerchId" />
								<input name="totalPrice" id="totalPrice" class="easyui-numberbox" data-options="min:0,precision:2"/>
								<input name="prodHistoryPrice" id="prodHistoryPrice" class="easyui-numberbox" data-options="min:0,precision:2"/>
							</td>
						</tr>	
						<tr class="freeMerch1">	
		     				<td class="td-label"><label><span style="color: red;">*</span>搭配商品1&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName1" type="text" id="buyMerchName1" size="29" />
							</td>
							
							<td width="120" class="td-label"><label><span style="color: red;">*</span>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt1" name="buyAmt1" size="25" class="buyAmt easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId1" id="buyMerchId1" />
								<input name="totalPrice1" id="totalPrice1" class="easyui-numberbox" data-options="min:0,precision:2"/>
								<input name="prodHistoryPrice1" id="prodHistoryPrice1" class="easyui-numberbox" data-options="min:0,precision:2"/>
							</td>
						</tr>	
						<tr class="freeMerch2">	
		     				<td class="td-label"><label>搭配商品2&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName2" type="text" id="buyMerchName2" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt2" name="buyAmt2" size="25" class="buyAmt easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId2" id="buyMerchId2" />
								<input name="totalPrice2" id="totalPrice2" class="easyui-numberbox" data-options="min:0,precision:2"/>
								<input name="prodHistoryPrice2" id="prodHistoryPrice2" class="easyui-numberbox" data-options="min:0,precision:2"/>
							</td>
						</tr>	
						<tr class="freeMerch3">	
		     				<td class="td-label"><label>搭配商品3&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName3" type="text" id="buyMerchName3" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt3" name="buyAmt3" size="25" class="buyAmt easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId3" id="buyMerchId3" />
								<input name="totalPrice3" id="totalPrice3" class="easyui-numberbox" data-options="min:0,precision:2"/>
								<input name="prodHistoryPrice3" id="prodHistoryPrice3" class="easyui-numberbox" data-options="min:0,precision:2"/>
							</td>
						</tr>	
						<tr class="freeMerch4">	
		     				<td class="td-label"><label>搭配商品4&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName4" type="text" id="buyMerchName4" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt4" name="buyAmt4" size="25" class="buyAmt easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId4" id="buyMerchId4" />
								<input name="totalPrice4" id="totalPrice4" class="easyui-numberbox" data-options="min:0,precision:2"/>
								<input name="prodHistoryPrice4" id="prodHistoryPrice4" class="easyui-numberbox" data-options="min:0,precision:2"/>
							</td>
						</tr>	
						<tr class="freeMerch5">	
		     				<td class="td-label"><label>搭配商品5&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName5" type="text" id="buyMerchName5" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt5" name="buyAmt5" size="25" class="buyAmt easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId5" id="buyMerchId5" />
								<input name="totalPrice5" id="totalPrice5" class="easyui-numberbox" data-options="min:0,precision:2"/>
								<input name="prodHistoryPrice5" id="prodHistoryPrice5" class="easyui-numberbox" data-options="min:0,precision:2"/>
							</td>
						</tr>	
						
						<tr>
							<td width="120" class="td-label">
								<div title="继续添加搭配商品">
									<a href="javascript:void(0)" style="width: 50px;" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addMerch()"></a>
								</div>
							</td>
						</tr>
						
						<tr>
							<td width="120" class="td-label"><label>划线价合计：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="originalPrice" name="originalPrice" size="25" class="easyui-numberbox td-input" disabled="disabled" data-options="min:0,precision:2"/>
				       		</td>
				       	</tr>
						<tr>
							<td width="120" class="td-label"><label>一口价合计：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="historyPrice" name="historyPrice" size="25" class="easyui-numberbox td-input" disabled="disabled" data-options="min:0,precision:2"/>
				       		</td>
				       	</tr>
						<tr>
							<td width="120" class="td-label"><label><span style="color: red;">*</span>套餐价：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="minOrdAmount" name="minOrdAmount" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:2"/>
				       		</td>
				       	</tr>
		   			 </table>
		   			 <div align="center" style="position:relative; left:-20px;">
	  					 <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAndPush()">保存</a>
	  					 &nbsp;&nbsp;&nbsp;
	  					 <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="javascript:window.parent.closeBrandCombinationWin()">取消</a>
				     </div>
				  </fieldset>
				</td>
			 </tr>
		  </table>
		</form>
	</div>
</div>

<script type="text/javascript">

	$buyMerchNamePicklist = $('#buyMerchName');
	$buyMerchNamePicklist1 = $('#buyMerchName1');
	$buyMerchNamePicklist2 = $('#buyMerchName2');
	$buyMerchNamePicklist3 = $('#buyMerchName3');
	$buyMerchNamePicklist4 = $('#buyMerchName4');
	$buyMerchNamePicklist5 = $('#buyMerchName5');
	
	function saveAndPush(){
		var activityName = $('#activityName').val();
		
		var buyMerchName = $('#buyMerchName').val();
		var buyMerchName1 = $('#buyMerchName1').val();
		var buyMerchName2 = $('#buyMerchName2').val();
		var buyMerchName3 = $('#buyMerchName3').val();
		var buyMerchName4 = $('#buyMerchName4').val();
		var buyMerchName5 = $('#buyMerchName5').val();
		
		var buyMerchId = $('#buyMerchId').val();
		var buyMerchId1 = $('#buyMerchId1').val();
		var buyMerchId2 = $('#buyMerchId2').val();
		var buyMerchId3 = $('#buyMerchId3').val();
		var buyMerchId4 = $('#buyMerchId4').val();
		var buyMerchId5 = $('#buyMerchId5').val();
		
		var buyAmt = $('#buyAmt').val();
		var buyAmt1 = $('#buyAmt1').val();
		var buyAmt2 = $('#buyAmt2').val();
		var buyAmt3 = $('#buyAmt3').val();
		var buyAmt4 = $('#buyAmt4').val();
		var buyAmt5 = $('#buyAmt5').val();
		
		// 商品一口价
		var prodHistoryPrice = $('#prodHistoryPrice').val();
		var prodHistoryPrice1 = $('#prodHistoryPrice1').val();
		var prodHistoryPrice2 = $('#prodHistoryPrice2').val();
		var prodHistoryPrice3 = $('#prodHistoryPrice3').val();
		var prodHistoryPrice4 = $('#prodHistoryPrice4').val();
		var prodHistoryPrice5 = $('#prodHistoryPrice5').val();
		
		// 一口价总价
		var historyPrice = $('#historyPrice').val();
		
		var minOrdAmount = $('#minOrdAmount').val();
		
		// 商品数组
		var buyMerchIds = new Array(0);
		// 购买数量数组
		var buyAmts = new Array(0);
		// 套餐优惠后平摊价数组
		var pmoPrices = new Array(0);
		// 套餐商品各商品搭配说明
		var comments = '';
		// 总的优惠比例
		var priceScale = minOrdAmount / historyPrice;
		if(activityName == '' || activityName == null){
			$.messager.alert("错误", '套餐名称不能为空', "error");
			return false;
		}
		if(buyMerchName == '' || buyMerchName == null){
			$.messager.alert("错误", '主商品不能为空', "error");
			return false;
		} else{
			if(buyAmt == '' || buyAmt == null){
				$.messager.alert("错误", '主商品的搭配数量不能为空', "error");
				return false;
			} else{
				if( buyAmt <= 1){
					comments = comments.concat(buyMerchName);
				} else{
					comments = comments.concat(buyMerchName,'*',buyAmt);
				}
				buyMerchIds.push(buyMerchId);
				buyAmts.push(buyAmt);
				// 计算主商品平摊价
				var pmoPrice = priceScale * prodHistoryPrice * buyAmt;
				pmoPrices.push(pmoPrice.toFixed(2));
			}
		}

		if(buyMerchName1 == '' || buyMerchName1 == null){
			$.messager.alert("错误", '搭配商品1不能为空', "error");
			return false;
		} else{
			if(buyAmt1 == '' || buyAmt1 == null){
				$.messager.alert("错误", '搭配商品1搭配数量不能为空', "error");
				return false;
			} else{
				if( buyAmt1 <= 1){
					comments = comments.concat('+',buyMerchName1);
				} else{
					comments = comments.concat('+',buyMerchName1,'*',buyAmt1);
				}
				buyMerchIds.push(buyMerchId1);
				buyAmts.push(buyAmt1);
				// 计算搭配商品1平摊价
				var pmoPrice1 = priceScale * prodHistoryPrice1 * buyAmt1;
				pmoPrices.push(pmoPrice1.toFixed(2));
			}
		}
		if(buyMerchName2 != '' && buyMerchName2 != null){
			if(buyAmt2 == '' || buyAmt2 == null){
				$.messager.alert("错误", '搭配商品2的搭配数量不能为空', "error");
				return false;
			} else{
				if( buyAmt2 <= 1){
					comments = comments.concat('+',buyMerchName2);
				} else{
					comments = comments.concat('+',buyMerchName2,'*',buyAmt2);
				}
				buyMerchIds.push(buyMerchId2);
				buyAmts.push(buyAmt2);
				// 计算搭配商品2平摊价
				var pmoPrice2 = priceScale * prodHistoryPrice2 * buyAmt2;
				pmoPrices.push(pmoPrice2.toFixed(2));
			}
		}
		if(buyMerchName3 != '' && buyMerchName3 != null){
			if(buyAmt3 == '' || buyAmt3 == null){
				$.messager.alert("错误", '搭配商品3的搭配数量不能为空', "error");
				return false;
			} else{
				if( buyAmt3 <= 1){
					comments = comments.concat('+',buyMerchName3);
				} else{
					comments = comments.concat('+',buyMerchName3,'*',buyAmt3);
				}
				buyMerchIds.push(buyMerchId3);
				buyAmts.push(buyAmt3);
				// 计算搭配商品3平摊价
				var pmoPrice3 = priceScale * prodHistoryPrice3 * buyAmt3;
				pmoPrices.push(pmoPrice3.toFixed(2));
			}
		}
		if(buyMerchName4 != '' && buyMerchName4 != null){
			if(buyAmt4 == '' || buyAmt4 == null){
				$.messager.alert("错误", '搭配商品4的搭配数量不能为空', "error");
				return false;
			} else{
				if( buyAmt4 <= 1){
					comments = comments.concat('+',buyMerchName4);
				} else{
					comments = comments.concat('+',buyMerchName4,'*',buyAmt4);
				}
				buyMerchIds.push(buyMerchId4);
				buyAmts.push(buyAmt4);
				// 计算搭配商品4平摊价
				var pmoPrice4 = priceScale * prodHistoryPrice4 * buyAmt4;
				pmoPrices.push(pmoPrice4.toFixed(2));
			}
		}
		if(buyMerchName5 != '' && buyMerchName5 != null){
			if(buyAmt5 == '' || buyAmt5 == null){
				$.messager.alert("错误", '搭配商品5的搭配数量不能为空', "error");
				return false;
			} else{
				if( buyAmt5 <= 1){
					comments = comments.concat('+',buyMerchName5);
				} else{
					comments = comments.concat('+',buyMerchName5,'*',buyAmt5);
				}
				buyMerchIds.push(buyMerchId5);
				buyAmts.push(buyAmt5);
				// 计算搭配商品5平摊价
				var pmoPrice5 = priceScale * prodHistoryPrice5 * buyAmt5;
				pmoPrices.push(pmoPrice5.toFixed(2));
			}
		}
		if(minOrdAmount == '' || minOrdAmount == null){
			$.messager.alert("错误", '套餐价不能为空', "error");
			return false;
		}
		
		var buyMerchIds = buyMerchIds.join(",");
		var buyAmts = buyAmts.join(",");
		var pmoPrices = pmoPrices.join(",");
		
		$.messager.confirm("操作提示", '创建之后不能修改,确认要创建活动？', function(data) {
			if(data){
				$.post("${AppContext.ctxPath}/action/portal/promotion/brandInsertCampaign",{
					activityName      :  activityName,
					brandDiscountType :  'Combination',
					comments          :  comments,
					buyMerchIds       :  buyMerchIds,
					buyAmts           :  buyAmts,
					pmoPrices         :  pmoPrices,
				 	status            :  'Active',
				 	minOrdAmount      :  minOrdAmount
				},function(data){
					if(data.success){
						window.parent.closeBrandCombinationWin();
					}else{
						$.messager.alert("错误", data.result, "error");
						return false;
					}
				});
			}
		});
	}
	function brandShopPromotionInit(param){
		
	}
	
	var arr = new Array(6);
	$buyMerchNamePicklist.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		completeFun : function(selectRow) {
			$('#buyAmt').numberbox('setValue','1');
			$('#buyMerchId').val(selectRow.id);
			if(arr.indexOf($('#buyMerchId').val()) >= 0){
				$.messager.alert("错误", "该商品已是搭配商品,不能作为主商品", "error");
				return false;
			}
			arr[0] = selectRow.id;
			$('#totalPrice').numberbox('setValue',selectRow.originalPrice);
			$('#prodHistoryPrice').numberbox('setValue',selectRow.historyPrice);
			return selectRow.o2oDisplayName;
		}
	});
	$buyMerchNamePicklist1.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		completeFun : function(selectRow) {
			$('#buyAmt1').numberbox('setValue','');
			$('#buyMerchId1').val(selectRow.id);
			if($('#buyMerchId').val() != '' && $('#buyMerchId').val() != null){
				if(arr.indexOf($('#buyMerchId1').val()) >= 0){
					$.messager.alert("错误", "不能再次添加该商品作为搭配商品", "error");
					return false;
				}
				arr[1] = selectRow.id;
				$('#totalPrice1').numberbox('setValue',selectRow.originalPrice);
				$('#prodHistoryPrice1').numberbox('setValue',selectRow.historyPrice);
				return selectRow.o2oDisplayName;
			} else{
				$.messager.alert("错误", "请先选择主商品", "error");
				return false;
			}
		}
	});
		$buyMerchNamePicklist2.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		completeFun : function(selectRow) {
			$('#buyAmt2').numberbox('setValue','');
			$('#buyMerchId2').val(selectRow.id);
			if(arr.indexOf($('#buyMerchId2').val()) >= 0){
				$.messager.alert("错误", "不能再次添加该商品作为搭配商品", "error");
				return false;
			}
			arr[2] = selectRow.id;
			$('#totalPrice2').textbox('setValue',selectRow.originalPrice);
			$('#prodHistoryPrice2').textbox('setValue',selectRow.historyPrice);
			return selectRow.o2oDisplayName;
		}
	});
		$buyMerchNamePicklist3.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		completeFun : function(selectRow) {
			$('#buyAmt3').numberbox('setValue','');
			$('#buyMerchId3').val(selectRow.id);
			if(arr.indexOf($('#buyMerchId3').val()) >= 0){
				$.messager.alert("错误", "不能再次添加该商品作为搭配商品", "error");
				return false;
			}
			arr[3] = selectRow.id;
			$('#totalPrice3').textbox('setValue',selectRow.originalPrice);
			$('#prodHistoryPrice3').textbox('setValue',selectRow.historyPrice);
			return selectRow.o2oDisplayName;
		}
	});
		$buyMerchNamePicklist4.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		completeFun : function(selectRow) {
			$('#buyAmt4').numberbox('setValue','');
			$('#buyMerchId4').val(selectRow.id);
			if(arr.indexOf($('#buyMerchId4').val()) >= 0){
				$.messager.alert("错误", "不能再次添加该商品作为搭配商品", "error");
				return false;
			}
			arr[4] = selectRow.id;
			$('#totalPrice4').textbox('setValue',selectRow.originalPrice);
			$('#prodHistoryPrice4').textbox('setValue',selectRow.historyPrice);
			return selectRow.o2oDisplayName;
		}
	});
		$buyMerchNamePicklist5.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		completeFun : function(selectRow) {
			$('#buyAmt5').numberbox('setValue','');
			$('#buyMerchId5').val(selectRow.id);
			if(arr.indexOf($('#buyMerchId5').val()) >= 0){
				$.messager.alert("错误", "不能再次添加该商品作为搭配商品", "error");
				return false;
			}
			arr[5] = selectRow.id;
			$('#totalPrice5').textbox('setValue',selectRow.originalPrice);
			$('#prodHistoryPrice5').textbox('setValue',selectRow.historyPrice);
			return selectRow.o2oDisplayName;
		}
	});
		
	$('.freeMerch2').hide();	
	$('.freeMerch3').hide();	
	$('.freeMerch4').hide();	
	$('.freeMerch5').hide();	
	
		
	//输入商品数量后 一口价、市场价自动计算出来
	$('.buyAmt').numberbox({'onChange':function(){
			totalPrice = $('#totalPrice').val();
			buyAmt = $('#buyAmt').val();
			totalPrice1 = $('#totalPrice1').val();
			buyAmt1 = $('#buyAmt1').val();
			totalPrice2 = $('#totalPrice2').val();
			buyAmt2 = $('#buyAmt2').val();
			totalPrice3 = $('#totalPrice3').val();
			buyAmt3 = $('#buyAmt3').val();
			totalPrice4 = $('#totalPrice4').val();
			buyAmt4 = $('#buyAmt4').val();
			totalPrice5 = $('#totalPrice5').val();
			buyAmt5 = $('#buyAmt5').val();
			// 计算市场价（划线价）
			$('#originalPrice').numberbox('setValue',totalPrice * buyAmt + totalPrice1 * buyAmt1 + totalPrice2 * buyAmt2
					+ totalPrice3 * buyAmt3 + totalPrice4 * buyAmt4 + totalPrice5 * buyAmt5);
			
			prodHistoryPrice = $('#prodHistoryPrice').val();
			prodHistoryPrice1 = $('#prodHistoryPrice1').val();
			prodHistoryPrice2 = $('#prodHistoryPrice2').val();
			prodHistoryPrice3 = $('#prodHistoryPrice3').val();
			prodHistoryPrice4 = $('#prodHistoryPrice4').val();
			prodHistoryPrice5 = $('#prodHistoryPrice5').val();
			// 计算一口价
			$('#historyPrice').numberbox('setValue',prodHistoryPrice * buyAmt + prodHistoryPrice1 * buyAmt1 + prodHistoryPrice2 * buyAmt2
					+ prodHistoryPrice3 * buyAmt3 + prodHistoryPrice4 * buyAmt4 + prodHistoryPrice5 * buyAmt5);
			
		}
	});
	
	function addMerch(){
		if( $('#buyMerchId').val() != '' && $('#buyMerchId').val() != null 
				&& $('#buyMerchId1').val() != '' && $('#buyMerchId1').val() != null ){
			if($('.freeMerch2').is(":hidden")){
				$('.freeMerch2').show();
				return false;
			} else if($('.freeMerch3').is(":hidden")){
				$('.freeMerch3').show();
				return false;
			} else if($('.freeMerch4').is(":hidden")){
				$('.freeMerch4').show();
				return false;
			} else if($('.freeMerch5').is(":hidden")){
				$('.freeMerch5').show();
				return false;
			} else{
				$.messager.alert("错误", '最多只能添加5个搭配商品，不能继续添加了', "error");
			}
		} else{
			$.messager.alert("错误", '请先填写主商品和搭配商品1', "error");
		}
	}
</script>
</body>
</html>