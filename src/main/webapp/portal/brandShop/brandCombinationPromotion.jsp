<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>
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
<!--给body指定class属性指定easy的easyui-layout样式，这样就可以 使用body创建easyui的layout -->
 <body>
<div class="easyui-layout" data-options="fit:true" >  
   <div data-options="region:'north'" style="height:100%">
      <div  border="false" style="width:100%;height:50%;">
		<table id="activity-table" split="true"fit="true" >
			<thead>
				<tr>
					<th field="buyMerchName" width="200px" >套餐主商品</th>
					<th field="brandDiscountType" width="120px" lov="PLATFORM_PRO_TYPE" >优惠类型</th>
					<th field="path" width="120px" formatter="pathFormatter">商品图片</th>
					<th field="activityName" width="200px" >套餐名称</th>
					<th field="minOrdAmount" width="160px">套餐价格</th>
					<th field="status" width="160px" lov="TB_O2O_STATUS">状态
					<th field="created" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}">创建时间</th>
				</tr>
			 </thead>
		 </table>
	   </div>
    <div  border="false" style="width:100%;height:50%;">
		<form id="activityHeaderForm" method="post">
			<table id="typeTable" style="width:100%;height:100%;">
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
				       			<input id="buyAmt" name="buyAmt" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId" id="buyMerchId" />
							</td>
						</tr>	
						<tr class="freeMerch1">	
		     				<td class="td-label"><label><span style="color: red;">*</span>搭配商品1&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName1" type="text" id="buyMerchName1" size="29" />
							</td>
							
							<td width="120" class="td-label"><label><span style="color: red;">*</span>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt1" name="buyAmt1" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId1" id="buyMerchId1" />
							</td>
						</tr>	
						<tr class="freeMerch2">	
		     				<td class="td-label"><label>搭配商品2&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName2" type="text" id="buyMerchName2" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt2" name="buyAmt2" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId2" id="buyMerchId2" />
							</td>
						</tr>	
						<tr class="freeMerch3">	
		     				<td class="td-label"><label>搭配商品3&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName3" type="text" id="buyMerchName3" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt3" name="buyAmt3" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId3" id="buyMerchId3" />
							</td>
						</tr>	
						<tr class="freeMerch4">	
		     				<td class="td-label"><label>搭配商品4&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName4" type="text" id="buyMerchName4" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt4" name="buyAmt4" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId4" id="buyMerchId4" />
							</td>
						</tr>	
						<tr class="freeMerch5">	
		     				<td class="td-label"><label>搭配商品5&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="buyMerchName5" type="text" id="buyMerchName5" size="29" />
							</td>
							
							<td width="120" class="td-label"><label>搭配数量：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="buyAmt5" name="buyAmt5" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
							<td hidden="true">
								<input name="buyMerchId5" id="buyMerchId5" />
							</td>
						</tr>	
						
						<tr>
							<td width="120" class="td-label"><label>划线价合计：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="originalPrice" name="originalPrice" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:2"/>
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
		    	  </fieldset>
		       </td>
		    </tr>
		</table>
	  </form>
    </div>
  </div>
</div>
<!-- 弹出窗1 -->
<div id="brandShopPromotionWin" class="crmWin" style="width:100%;height:100%">
	<iframe src="" id="brandShopPromotionWinFram" name="brandShopPromotionWinFram" width="100%" height="100%" frameborder="0"></iframe>
</div>
	<script type="text/javascript">
		$brandShopPromotionWin = $("#brandShopPromotionWin");
		$brandShopPromotionWinFram = $("#brandShopPromotionWinFram");
		
		$buyMerchNamePicklist = $('#buyMerchName');
		$buyMerchNamePicklist1 = $('#buyMerchName1');
		$buyMerchNamePicklist2 = $('#buyMerchName2');
		$buyMerchNamePicklist3 = $('#buyMerchName3');
		$buyMerchNamePicklist4 = $('#buyMerchName4');
		$buyMerchNamePicklist5 = $('#buyMerchName5');
		
	    $datagrid=$('#activity-table');
		$datagrid.hdatagrid({
			updateable:false,
			pagination:true,
			buttonNew:false,
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
		    onBeforeLoad:function(param){
		    	//店铺优惠 brandDiscountType类型为store
		    	param.brandDiscountType = 'Combination';
			},
			onChangeSelectedItem:function(row,that){
				disabledEdit();
				if(row.status == 'Active'){
					$("#btn_Invalid").linkbutton({text:'无效'});
					$("#btn_Invalid").linkbutton({iconCls:'icon-cancel'});
					$("#btn_remove").linkbutton('disable');
				} else{
					$("#btn_Invalid").linkbutton({text:'有效'});
					$("#btn_Invalid").linkbutton({iconCls:'icon-ok'});
					$("#btn_remove").linkbutton('enable');
				}
				row = $datagrid.datagrid('getSelected');
				if( row != '' && row != null){
					// 为行的form表单赋值
					$("#activityHeaderForm").form("clear");
					$("#activityHeaderForm").form("load", row);
					for (key in row) {
						value = row[key];
						$("[name='" + key + "'][type='checkbox']", 
								$("#activityHeaderForm")).each(function() {
									$(this).prop("checked", value=="Y" ? true : false);
								});
					} 
					
					// 为表单的搭配商品赋值
					$.post("${AppContext.ctxPath}/action/portal/promotionGoods/brandQueryCombinationPromotion",{
						headId   :  row.id,
					},function(data){
						if(data.success){
							var result = data.rows;
							var originalPrice = 0;
							var historyPrice = 0;
							for (var i = 0; i < result.length; i++ ){
								originalPrice += result[i].originalPrice * result[i].buyAmt;
								historyPrice += result[i].historyPrice * result[i].buyAmt;
								if( i == 0 ){
									$('.freeMerch').show();
									$('#buyMerchName').textbox('setValue',result[i].buyMerchName);
									$('#buyAmt').textbox('setValue',result[i].buyAmt);
								} else{
									$('.freeMerch' + i).show();
									$('#buyMerchName' + i).textbox('setValue',result[i].buyMerchName);
									$('#buyAmt' + i).textbox('setValue',result[i].buyAmt);
								}
							}
							$('#originalPrice').textbox( 'setValue', originalPrice.toFixed(2) );
							$('#historyPrice').textbox( 'setValue', historyPrice.toFixed(2) );
						}else{
							$.messager.alert("错误", data.result, "error");
							return false;
						}
					});
				}
			},
			/**
			 * 加载数据成功后，触发事件
			 */
			onLoadSuccess:function(data){
				var row = $datagrid.datagrid('getSelected');
				if( row == '' || row == null){
					disabledEdit();
				}
			},
			readOnlyCondition: function(row, that){
				if( row.brandStatus != 'PAUSE' ){
					return true;
				}
				return false;
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="campaignAdd()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="campaignDel()">删除</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_Invalid" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="Invalid()">有效</a>',that);
			},
		});

		//删除记录
		function campaignDel(){
			var row = $datagrid.datagrid('getSelected');
			if(row != null && row != ''){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						row.deleteFlg = 'Y';
						row.status = 'Inactive';
						row.attr1 = 'delete';
						$.post('${AppContext.ctxPath}/action/portal/promotion/update', row, function(data) {
							if (!data.success) {
								$.messager.alert("错误", data.result, "error");
								 return false;
							} else {
								$.messager.alert("成功", "删除成功", "info");
								$datagrid.hdatagrid("reload");
							}
						})
					}
				});
			}
		}
		
	   function campaignAdd(){
			$brandShopPromotionWinFram.attr("src","");
				$brandShopPromotionWinFram.attr("src", "${AppContext.ctxPath}/portal/brandShop/brandCombinationPromotionNew.jsp");
				$brandShopPromotionWinFram[0].onload = function() {
					$brandShopPromotionWinFram[0].contentWindow.brandShopPromotionInit("reload");//等待窗口加载完毕
				}
			$brandShopPromotionWin.css("display", "block");
		}
	   function closeBrandCombinationWin(){
			$brandShopPromotionWin.css("display", "none");
			$datagrid.datagrid('reload');
		}
	   
 		$buyMerchNamePicklist.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#buyMerchId').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		$buyMerchNamePicklist1.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#buyMerchId1').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		$buyMerchNamePicklist2.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#buyMerchId2').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		$buyMerchNamePicklist3.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#buyMerchId3').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		$buyMerchNamePicklist4.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#buyMerchId4').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		$buyMerchNamePicklist5.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#buyMerchId5').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		
 		function disabledEdit(){
		    $(":enabled",$("#activityHeaderForm")).attr("disabled", true);
		    $('#buyMerchName').textbox('disable');
		    $('#buyMerchName1').textbox('disable');
		    $('#buyMerchName2').textbox('disable');
		    $('#buyMerchName3').textbox('disable');
		    $('#buyMerchName4').textbox('disable');
		    $('#buyMerchName5').textbox('disable');
		    $('.textbox').css('background-color','#ddd');
		    $('#btn_submit').removeAttr("onclick");
		    $('#btn_submit').css('opacity','0.5');
		    $('#btn_cancel').removeAttr("onclick");
		    $('#btn_cancel').css('opacity','0.5');
		    
			$('.freeMerch2').hide();
			$('.freeMerch3').hide();
			$('.freeMerch4').hide();
			$('.freeMerch5').hide();
			$('#originalPrice').textbox('setValue','');
 		}
 		
 		function enabledEdit(){
			 $(":disabled", $("#activityHeaderForm")).removeAttr("disabled");
			 $('#buyMerchName').textbox('enable');
			 $('#buyMerchName1').textbox('enable');
			 $('#buyMerchName2').textbox('enable');
			 $('#buyMerchName3').textbox('enable');
			 $('#buyMerchName4').textbox('enable');
			 $('#buyMerchName5').textbox('enable');
		     $('#btn_submit').attr('onclick', 'saveAndPush()');
		     $('#btn_submit').css('opacity','1');
		     $('#btn_cancel').attr('onclick', 'closeBrandCombinationWin()');
		     $('#btn_cancel').css('opacity','1');
		     $('.textbox').css('background-color','white');
 		}
 		
		//方案图片
		function pathFormatter(val,row){   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.path +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		//失效、有效
		function Invalid(){
			var row = $datagrid.datagrid('getSelected');
			var warningMessage = '';
			if(row.status == 'Active'){
				row.status = 'Inactive';
				warningMessage = '该操作将使活动失效,确定要执行该操作？';
			} else{
				row.status = 'Active';
				warningMessage = '该操作将使活动生效,确定要执行该操作？';
			}
			$.messager.confirm("操作提示", warningMessage, function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/promotion/update', 
						{
							id:row.id,
							status:row.status
						}, function(data) {
						if (!data.success) {
							$.messager.alert("错误", data.result, "error");
							 return false;
						} else {
							$.messager.alert("成功", "操作成功", "info");
							var index = $datagrid.hdatagrid('getRowIndex', row);
							$datagrid.hdatagrid("refreshRow", index);
							$datagrid.datagrid('selectRow', index);
						}
					});
				}
			});
		}
	</script>
</body>
</html>