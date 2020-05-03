<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>

<style type="text/css" >
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
</style>
<body>
   <div class="easyui-layout" data-options="fit:true" border="false">
     <div data-options="region:'north'" collapsible="false" title="" border="false" style="width:100%;height:100%;padding:0px;">
     <form id="prodDetailForm" method="post">
        <fieldset>
			<legend>产品信息</legend>
			<table style="width:1100px;">
				<tr>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>产品编码 :</label></td>
								<td class="td-input">
									<input id="prodCode" name="prodCode" class="easyui-textbox td-input-input" editable="true"  />
				         			<input id="prodId" name="id" type="hidden" editable="false"></input>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>产品名称:</label></td>
								<td class="td-input">
				         			<input id="prodName" name="prodName" class="easyui-textbox td-input-input" editable="true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>产品型号 :</label></td>
								<td class="td-input">
									<input id="prodModelName" name="prodModelName" class="easyui-picklistbox td-input-input" editable="true" />
									<input id="prodModelId" hidden="true" name="prodModelId" class="easyui-mvgPick td-input-input">
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>产品系列 :</label></td>
								<td class="td-input">
			         				<input id="prodMatSeries" name="prodMatSeries" class="easyui-combobox td-input-input" 
				         				data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('PROD_MAT_SERIES')
										" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>产品类型 :</label></td>
								<td class="td-input">
			         				<input id="prodGoodType" name="prodGoodType" class="easyui-combobox td-input-input" 
				         				data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('PROD_GOOD_TYPE')
										" />
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>出厂价 :</label></td>
								<td class="td-input">
									<input id="factoryPrice" name="factoryPrice" class="easyui-textbox td-input-input" editable="true"  />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>销售价:</label></td>
								<td class="td-input">
				         			<input id="price" name="price" class="easyui-textbox td-input-input" editable="true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>促销价 :</label></td>
								<td class="td-input">
									<input id="promoPrice" name="promoPrice" class="easyui-textbox td-input-input" editable="true" />
									<!-- <input id="isFlag" type="hidden" name="isFlag"></input> -->
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>单位 :</label></td>
								<td class="td-input">
			         				<input id="prodUnit" name="prodUnit" class="easyui-combobox td-input-input" 
				         				data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('PROD_UNIT')
										" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>是否有效 :</label></td>
								<td class="td-input">
			         				<input id="isEffective" name="isEffective" class="easyui-combobox td-input-input" 
				         				data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('S_IF')
										" />
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>一级分类 :</label></td>
								<td class="td-input">
									<input id="topCate" name="topCate" class="easyui-combobox td-input-input" 
				         				data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('PRODUCT_TOP_CATEGORY'),
										method:'get',
										onSelect:selectTopCate,
										required:false
										" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>二级分类:</label></td>
								<td class="td-input">
				         			<input id="secCate" name="secCate" class="easyui-combobox td-input-input" 
				         				data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										onBeforeLoad:beforLoadSecCate,
										url:'${AppContext.ctxPath}/action/portal/product/queryProdCategory',
										editable:false,
										required:false
										" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>标签 :</label></td>
								<td class="td-input">
									<input id="tagName" name="tagName" class="easyui-mvgPick td-input-input" editable="true"/>
									<input id="tagId" hidden="true" name="tagId" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>产品描述 :</label></td>
								<td width="100" rowspan="3" class="td-input">
									<input id="comments" name="comments" class="easyui-textbox td-input-input" data-options="multiline:true" 
										style="height:90px;" />
								</td>
							</tr>
							<tr>
								<td class="td-label"></td>
								<td class="td-input">
			         				<!-- 占位符 -->
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input id="prodBrand" name="prodBrand" hidden="true"/>
			<input id="prodStandard" name="prodStandard" hidden="true"/>
			<input id="prodStyle" name="prodStyle" hidden="true"/>
			<input id="prodSpace" name="prodSpace" hidden="true"/>
			<div style="width:100%;height:30px;padding:0px;margin-top:30px;">
				<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
					plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="goBack()">取消</a>
		    	<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
		    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="prodSave()">保存</a>
		    </div>
		</fieldset>
	</form>
	
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	
		<div data-options="region:'center',split:true" border="false">
			<div class="easyui-tabs" data-options="fit:true" border="false"
				style="height: 300px; width: 100%;">
				<div title="产品展示图片">
					<table id="prod-pic-table" fit="true"
						style="height: 300px; width: 100%;">
						<thead>
							<tr>
								<th field="attachmentOriginal" width="20%" formatter="imageFormatterPic">附件名称</th>
								<th field="attachmentSize" width="20%">大小（字节）</th>
								<th field="created" width="20%">上传时间</th>
								<th field="comments" width="30%">备注</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
    </div>
   </div>



<script type="text/javascript">
	getLovOfList("[PROD_UNIT,PROD_MAT_SERIES,S_IF,PRODUCT_TOP_CATEGORY,PRODUCT_SEC_CATEGORY,PROD_GOOD_TYPE]");
	$prodDetailForm = $('#prodDetailForm');
	$datagridpic = $('#prod-pic-table');
	var prodId = '';
	var headId = '';
	
	/**
	* 初始化/刷新数据，若id不为空，则重新查询；
	* 若对象不为空，则加载产品对象
	* @id 产品id
	* @order 产品对象
	*/
	function prodInfoInit(id, prod){
		//若id不为空，则重新查询
		if(id){ 
			$.post("${AppContext.ctxPath}/action/portal/product/queryById", {id:id}, function(data){
				if(data.success){
					$prodDetailForm.form("load", data.result);
					prodId = $("#prodId").val();
					headId = id;
					$datagridpic.datagrid("reload");
					mvgPicFun();
				}else if(data.result){
					$.messager.alert("错误", data.result, "error");
				}else{
					$.messager.alert("错误", "加载数据失败", "error");
				}
			});
		}else if(prod){ //若对象不为空，则加载订单对象
			$prodDetailForm.form("load", prod);
			prodId = $("#prodId").val();
			headId = id;
			$datagridpic.datagrid("reload");
			mvgPicFun();
			//getProdAttachment(id);
			/* if(prodId == null || prodId == ''){
				prodId = id;
			} */
			//$itemdatagrid.datagrid("reload");
		}else{
			$.messager.alert("错误", "参数无效", "error");
		}
	}
				
	$datagridpic.hdatagrid({
		toolbarShow:true,
		buttonDelete:true,
		url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
		onBeforeLoad:function(param){
			if(prodId){
				param.headId = prodId;
			}else{
				param.headId ='noMatchId';
			}
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(39,'<div style = "width:78px;display:inline-block"> <form id="formPic" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton filePic" iconCls="icon-add" plain="true">上传图片 <input type="hidden"  id="parentProdId" name="headId"/><input type="hidden" name="moduleType" value="noType"/>'+"<input type='file' id='filePic' name='uploadAttachment'/></a></form></div>",that);
			addButtonFun(39.1,'<div style = "width:100px;display:inline-block"> <form id="formPicMulti" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton filePicMulti" iconCls="icon-add" plain="true">批量上传图片 <input type="hidden"  id="parentProdIdMulti" name="headId"/><input type="hidden" name="moduleType" value="noType"/>'+"<input type='file' id='filePicMulti' name='uploadAttachment' multiple=true/></a></form></div>",that);
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/attachment/deleteById', {
							id : row.id
					}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							} else {
								successFun(that, data);
							}
					});
				}
			});
		},
		onLoadSuccess:function(data){
			//调用图片展示组件
			$('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	   }
		
		
	});

	function imageFormatter(val,row)
	{   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A +row.prodImagePath +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
	
	function imageFormatterPic(val,row)
	{   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A +row.attachmentPath +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
	/* 
	$(".fileProdImg").change(function(){
		console.log(".fileProdImg");
		var row = $datagrid.datagrid('getSelected');
		if(row == null || row.id == null){
			$.messager.alert("没有选中任何产品信息！");
			return;
		};
		$('#productId').val(row.id);
		var options = {
   			url:'${AppContext.ctxPath}/action/portal/product/uploadImg',
   			type:'post',
   			dataType:'json',
   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
   			success : function(data) {
   					if(data.success){
   						$datagrid.datagrid('reload');
   				  	}
   			}
   		};
   		$('#form').ajaxSubmit(options);
	});
	 */
	$(".filePic").change(function(){
		var row = $("#prodId");
		if(row == null || row.val() == null){
			$.messager.alert("请选中要上传的产品信息！");
		}else{
			$('#parentProdId').val(row.val());
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/attachment/insert',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
   					if(data.success){
   						$datagridpic.datagrid('reload');
   				  	}
	   			}
	   		};
	   		$('#formPic').ajaxSubmit(options);
		}
	});

    $(".filePicMulti").change(function(){
        var row = $("#prodId");
        if(row == null || row.val() == null){
            $.messager.alert("请选中要上传的产品信息！");
        }else{
            $('#parentProdIdMulti').val(row.val());
            var options = {
                url:'${AppContext.ctxPath}/action/portal/attachment/insertWithFiles',
                type:'post',
                dataType:'json',
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                success : function(data) {
                    if(data.success){
                        $datagridpic.datagrid('reload');
                    }
                }
            };
            $('#formPicMulti').ajaxSubmit(options);
        }
    });

	function prodSave(){
		
		$.post('${AppContext.ctxPath}/action/portal/product/update', 
		{
			id					    : headId,
			
			prodCode				: $('#prodCode').val(),
			prodName				: $('#prodName').val(),
			prodModelId			    : $('#prodModelId').val(),
			//prodModelName			: $('#prodModelName').val(),
			prodMatSeries			: $('#prodMatSeries').combobox('getValue'),
			prodGoodType			: $('#prodGoodType').combobox('getValue'),
			
			factoryPrice			: $('#factoryPrice').val(),
			price					: $('#price').val(),
			promoPrice				: $('#promoPrice').val(),
			prodUnit				: $('#prodUnit').combobox('getValue'),
		    isEffective				: $('#isEffective').combobox('getValue'),	
		    
		    topCate					: $('#topCate').combobox('getValue'),
		    secCate					: $('#secCate').combobox('getValue'),
		    //tagName					: $('#tagName').mvgpickbox('getValue'),
		    tagId					: $('#tagId').val(),
			comments				: $('#comments').textbox('getValue'),
			prodBrand				: $('#prodBrand').val(),
			prodStandard			: $('#prodStandard').val(),
			prodStyle				: $('#prodStyle').val(),
			prodSpace				: $('#prodSpace').val(),
	    },
		function(data){
	    	if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				window.parent.popWinClose("UPDATE", data.newRow);
			}
		});
	}
	
	function goBack(){
		//gotoContentPage('${AppContext.ctxPath}/portal/order/SaleOrderList.jsp');
		window.parent.popWinClose("CANCEL");
    }
	
	function beforLoadSecCate(param){
		var topCate = $("#topCate").val();
		param.parentVal=topCate;
		param.cateType='PRODUCT_SEC_CATEGORY';
 	}	
 
	function selectTopCate(selectRow){
		/* alert(selectRow.val); */
		$("#secCate").val('') ;
		$("#topCate").val(selectRow.val);
		//var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
		$("#secCate").combobox('reload');
		$("#secCate").combobox('setValue','');
	}
	
	$('#prodModelName').picklist({
		title:'选择产品型号',
		completeFun:function(selectRow){
			$('#prodModelId').val(selectRow.id);
			return selectRow.modelName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/product/picklist/ProdModelPickList.jsp'
	});
	function mvgPicFun(){
		$('#tagName').mvgPick({
			title:'产品标签',
			completeFun:tagMvgPickComplete,
			mvgMapperName:'productTag',
			height: '450px',
			mvgParentId:headId,
			//tableId:'detailTd3',
			optionsLeft:{
				tableUrl:'${AppContext.ctxPath}/portal/product/mvgPick/TagLeftMvgPick.jsp',
				initParam:tagMvgPickParam
			}
		});
	}
	/**
	 * 标签mvgPick 按【确定】后执行的方法
	 */
	function tagMvgPickComplete(rightRowsMvg) {
		//var currentRow = $datagrid.hdatagrid('getCurrentRow');
		if(rightRowsMvg != null){
			$("#tagId").val(rightRowsMvg.id);
			$("#tagName").val(rightRowsMvg.tagName);
			return rightRowsMvg.tagName;
		}
	}
	/**
	 * 标签mvgPick 列表数据初始化参数
	 */
	function tagMvgPickParam(){
		return {mvgParentId:headId};
	}

</script>
</body>
</html>