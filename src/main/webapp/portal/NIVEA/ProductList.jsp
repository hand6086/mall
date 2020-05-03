<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<style type="text/css">
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
	<fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">产品筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="prodGroupKeyfilter" data-toggle="keyfilter" data-title="产品系列"
				data-filter-filed="prodMatSeries" data-table-Id="prod-table">
				<li data-value="唇部护理系列">唇部护理系列</li>
				<li data-value="脸部保养系列">脸部保养系列</li>
				<li data-value="男士护肤系列">男士护肤系列</li>
				<li data-value="专业防晒系列">专业防晒系列</li>
				<li data-value="身体护理系列">身体护理系列</li>
				<li data-value="爽身香体系列">爽身香体系列</li>
				<li data-value="润肤霜系列">润肤霜系列</li>
			</ul>
		</div>
	</fieldset>

	<table id="prod-table" keyFilterDiv="keyFilter" fit="true">
		<thead>
			<tr>



				<th field="prodCode" width="100px" editor="{type:'textbox'}"
					sortable="true">产品编码</th>
				<th field="prodName" width="100px" defaultSearch="true"
					editor="{type:'textbox'}">产品名称</th>
				<th field="factoryPrice" width="100px" currency="CNY"
					editor="{type:'textbox'}">出厂价</th>
				<th field="price" width="100px" currency="CNY"
					editor="{type:'textbox'}">销售价</th>
				<th field="promoPrice" width="100px" currency="CNY"
					editor="{type:'textbox'}">促销价</th>
				<th field="Band" width="100px" editor="{type:'textbox'}">品牌</th>
				<th field="SubBand" width="100px" editor="{type:'textbox'}">子类</th>

				<th field="Tab1" width="100px"
					editor="{type:'validatebox', options:{required:false}}">标签1</th>
				<th field="Tab2" width="100px"
					editor="{type:'validatebox', options:{required:false}}">标签2</th>
				<th field="Tab3" width="100px"
					editor="{type:'validatebox', options:{required:false}}">标签3</th>
				<th field="Tab4" width="100px"
					editor="{type:'validatebox', options:{required:false}}">标签4</th>

				<th field="isEffective" lov="S_IF" width="50px"
					editor="{type:'combobox',
															options:{valueField:'val',
															textField:'name',
															data : getLovArray('S_IF'),
															editable:false,
															required:true}}"
					sortable="true">是否有效</th>
				<th field="comments" width="100px" editor="{type:'textbox'}">产品描述</th>
			</tr>
		</thead>
	</table>
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg" />
	</div>

	<script type="text/javascript">
		$datagrid = $('#prod-table');
		getLovOfList("[S_IF]");
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					buttonCopy : true,
					buttonExport : true,
					buttonImport : true,
					title : '',
					url : '${AppContext.ctxPath}/action/portal/product/queryByExamplePage',
					onAddMoreButton : function(that, addButtonFun) {
						addButtonFun(
								91,
								'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="productId" name="id"/>'
										+ "<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",
								that);
					},
					onUpdateAction : function(row, successFun, errFun, that) {
						$.post('${AppContext.ctxPath}/action/portal/product/update', {
							id : row.id,
							prodImgId : row.prodImgId,
							prodCode : row.prodCode,
							prodName : row.prodName,
							prodMatSeries : row.prodMatSeries,
							prodVolume : row.prodVolume,
							prodUnit : row.prodUnit,
							prodModelId : row.prodModelId,
							prodModelName : row.prodModelName,
							retreatFlag : row.retreatFlag,
							batteryType : row.batteryType,
							factoryPrice : row.factoryPrice,
							price : row.price,
							promoPrice : row.promoPrice,
							isEffective : row.isEffective,
							comments : row.comments

						}, function(data) {
							if (!data.success) {
								errFun(data.result, that);
							} else {
								successFun(that, data);
							}
						});
					},
					onInsertAction : function(row, successFun, errFun, that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/product/addProductExample',
										{
											prodImgId : row.prodImgId,
											prodCode : row.prodCode,
											prodName : row.prodName,
											prodMatSeries : row.prodMatSeries,
											prodVolume : row.prodVolume,
											prodUnit : row.prodUnit,
											prodModelId : row.prodModelId,
											prodModelName : row.prodModelName,
											retreatFlag : row.retreatFlag,
											batteryType : row.batteryType,
											factoryPrice : row.factoryPrice,
											price : row.price,
											promoPrice : row.promoPrice,
											isEffective : row.isEffective,
											comments : row.comments
										}, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/product/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(that, data);
																	}
																});
											}
										});
					},

					onLoadSuccess : function(data) {
						if (data.success) {
							var rows = data.rows;

							for (var i = 0; rows != null && i < rows.length; i++) {
								$datagrid.datagrid('updateRow', {
									index : i,
									row : {
										Band : '妮维雅',
										SubBand : '男士护肤系列',
										Tab1 : '男士',
										Tab2 : '面部',
										Tab3 : '高收入',
										Tab4 : '防嗮'

									}
								});
							}
						}
					}
				});
		 
		function imageFormatter(val, row) {
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\""
			var imgUrl_B = "\" /></a></div>";
			if (val) {
				return imgUrl_A + row.prodImagePath + imgUrl_B;
			}
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		function isEffectiveFormatter(val, row) {
			if (val == 'Y') {
				return '是';
			}
			return '否';
		}

		function mvgFormatter(val, row) {
			var str = getmvgstr(val, row, $datagrid, 'typeCode',
					'openMvgDialog');
			return str;
		}
		/* function prodRatioFormatter(val,row){
			var str = "<div style='font-size:18px;color:red;'>" + val + "</div>";
			return str;
		} */
		function openMvgDialog(index) {
			var row = $datagrid.datagrid('getData').rows[index];
			/* window.parent.mvgPickShow(row, "型号简码", "${AppContext.ctxPath}/action/portal/typecode/typeCodeMvg/" + row.id,'prodPickListComplete'); */
			mvg('型号简码', '${AppContext.ctxPath}/action/portal/typecode/typeCodeMvg/' + row.id,
					prodPickListComplete);
		}
		/* pickList关闭刷新 */
		function prodPickListComplete() {
			var index = $datagrid.datagrid('getRowIndex', $datagrid
					.datagrid('getSelected'));
			pickSelectedIndex = index;
			$datagrid.datagrid('reload');
		}

		/* 产品型号picklist关闭刷新 */
		function prodModelPickListComplete(selectRow) {
			var row = $datagrid.datagrid('getSelected');
			if (row.id == 'noMatchId' || row.id == null || row.id == '') {
				row.prodModelId = selectRow.id
				return selectRow.modelName;
			} else {
				$.post('${AppContext.ctxPath}/action/portal/product/prodModelUpdate', {
					preObjId : row.id,
					rearObjId : selectRow.id
				}, function(data) {
					if (!data.success) {
						window.parent.operationtip(data.result, 'error');
					}
					$datagrid.datagrid('reload');
				});
			}
		}

		/**对应只pickList*/
		function relativeFormatter(val, row, rowIndex) {
			if (val == null) {
				return datagridPickListFormatter("请选择", row, rowIndex,
						'relativePicklist');
			} else {
				return datagridPickListFormatter(val, row, rowIndex,
						'relativePicklist');
			}
		}
		function relativePicklist(rowIndex) {
			$datagrid.datagrid('selectRow', rowIndex);
			pickSelectedIndex = rowIndex;
			var row = $datagrid.datagrid('getSelected');
			picklist('对应只编码列表', '${AppContext.ctxPath}/action/portal/product/relativePicklist',
					relativePickListComplete);
		}
		function relativePickListComplete(selectRow) {
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/product/relativeUpdate', {
				id : row.id,
				relativeSimpleId : selectRow.id

			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				}
				$datagrid.datagrid('reload');
			});
		}

		/**对应销售pickList*/
		function relativeSaleFormatter(val, row, rowIndex) {
			if (val == null) {
				return datagridPickListFormatter("请选择", row, rowIndex,
						'relativeSalePicklist');
			} else {
				return datagridPickListFormatter(val, row, rowIndex,
						'relativeSalePicklist');
			}
		}
		function relativeSalePicklist(rowIndex) {
			$datagrid.datagrid('selectRow', rowIndex);
			pickSelectedIndex = rowIndex;
			var row = $datagrid.datagrid('getSelected');
			picklist('新电池编码列表', '${AppContext.ctxPath}/action/portal/product/relativeSalePicklist',
					relativeSalePickListComplete);
		}
		function relativeSalePickListComplete(selectRow) {
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/product/relativeSaleUpdate', {
				id : row.id,

				relativeSaleId : selectRow.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				}
				$datagrid.datagrid('reload');
			});
		}

		/**可包电池pickList*/
		function packageFormatter(val, row, rowIndex) {
			if (val == null) {
				return datagridPickListFormatter("请选择", row, rowIndex,
						'packagePicklist');
			} else {
				return datagridPickListFormatter(val, row, rowIndex,
						'packagePicklist');
			}
		}
		function packagePicklist(rowIndex) {
			$datagrid.datagrid('selectRow', rowIndex);
			pickSelectedIndex = rowIndex;
			var row = $datagrid.datagrid('getSelected');
			picklist('可包电池编码列表', '${AppContext.ctxPath}/action/portal/product/packagePicklist',
					packagePickListComplete);
		}
		function packagePickListComplete(selectRow) {
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/product/packageUpdate', {
				id : row.id,

				packageProdId : selectRow.id
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip(data.result, 'error');
				}
				$datagrid.datagrid('reload');
			});
		}

		//mvgNew packCode
		function mvgFormatterPack(val, row) {
			var str = getmvgstr(val, row, $datagrid, 'packMaterCode',
					'openMvgDialogPack');
			return str;
		}
		function openMvgDialogPack(index) {
			var row = $datagrid.datagrid('getData').rows[index];
			attr1 = row.packMaterCode;
			mvg('包装物料', '${AppContext.ctxPath}/action/portal/packmater/packMaterMvg/' + row.id,
					prodPickListCompletePack);
		}
		/* pickList关闭刷新 */
		function prodPickListCompletePack() {
			var index = $datagrid.datagrid('getRowIndex', $datagrid
					.datagrid('getSelected'));
			pickSelectedIndex = index;
			$datagrid.datagrid('reload');
		}

		//mvg  silkScreen 
		function mvgFormatterSilk(val, row) {
			var str = getmvgstr(val, row, $datagrid, 'silkScreenCode',
					'openMvgDialogSilk');
			return str;
		}
		function openMvgDialogSilk(index) {
			var row = $datagrid.datagrid('getData').rows[index];
			attr1 = row.packMaterCode;
			mvg('丝网', '${AppContext.ctxPath}/action/portal/silkscreen/silkScreenMvg/' + row.id,
					prodPickListCompleteSilk);
		}
		/* pickList关闭刷新 */
		function prodPickListCompleteSilk() {
			var index = $datagrid.datagrid('getRowIndex', $datagrid
					.datagrid('getSelected'));
			pickSelectedIndex = index;
			$datagrid.datagrid('reload');
		}

		//mvg  InstructionBook
		function mvgFormatterBook(val, row) {
			var str = getmvgstr(val, row, $datagrid, 'instructionBookCode',
					'openMvgDialogBook');
			return str;
		}
		function openMvgDialogBook(index) {
			var row = $datagrid.datagrid('getData').rows[index];
			attr1 = row.packMaterCode;
			mvg('说明书', '${AppContext.ctxPath}/action/portal/instructionbook/instructionBookMvg/'
					+ row.id, prodPickListCompleteBook);
		}

		/* pickList关闭刷新 */
		function prodPickListCompleteBook() {
			var index = $datagrid.datagrid('getRowIndex', $datagrid
					.datagrid('getSelected'));
			pickSelectedIndex = index;
			$datagrid.datagrid('reload');
		}

		//mvg  InstructionScrew
		function mvgFormatterScrew(val, row) {
			var str = getmvgstr(val, row, $datagrid, 'instructionBookCode',
					'openMvgDialogScrew');
			return str;
		}
		function openMvgDialogScrew(index) {
			var row = $datagrid.datagrid('getData').rows[index];
			attr1 = row.packMaterCode;
			mvg('螺丝列表', '${AppContext.ctxPath}/action/portal/screw/screwMvg/' + row.id,
					prodPickListCompleteScrew);
		}

		/* pickList关闭刷新 */
		function prodPickListCompleteScrew() {
			var index = $datagrid.datagrid('getRowIndex', $datagrid
					.datagrid('getSelected'));
			pickSelectedIndex = index;
			$datagrid.datagrid('reload');
		}

		$(".file")
				.change(
						function() {
							var row = $datagrid.datagrid('getSelected');
							$('#productId').val(row.id);
							if ($('#productId').val()) {
								var options = {
									url : '${AppContext.ctxPath}/action/portal/product/uploadImg',
									type : 'post',
									dataType : 'json',
									contentType : "application/x-www-form-urlencoded;charset=utf-8",
									success : function(data) {
										if (data.success) {
											$datagrid.datagrid('reload');
										}
									}
								};
								$('#form').ajaxSubmit(options);
							}
						})
	</script>
</body>
</html>