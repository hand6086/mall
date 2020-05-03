<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<body class="easyui-layout" data-options="fit:true" border="false">

	<div data-options="region:'north',split:true" title="" border="false"
		fit="true">

		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">消费者标签</span>

			</legend>

			<div class="row keyfilter-border">
				<ul id="accttypeKeyfilter" data-toggle="keyfilter" data-title="标签"
					data-filter-filed="acctType" data-table-Id="account-table">
					<li data-value="白领">白领</li>
					<li data-value="未婚">未婚</li>
					<li data-value="高学历">高学历</li>
					<li data-value="高收入">高收入</li>
					<li data-value="女性">女性</li>
					<li data-value="男性">男性</li>
				</ul>
			</div>

		</fieldset>

		<table id="account-table" keyFilterDiv="keyFilter" singleSelect="true"
			rownumbers="true" pagination="true" fit="true">
			<thead>
				<tr>
					<th field="id" width="80px" sortable="true">ID</th>
					<th field="acctCode" width="100px"
						editor="{type:'validatebox', options:{required:false}}">互动编号</th>
					<th field="A1" width="100px"
						editor="{type:'validatebox', options:{required:false}}">互动日期</th>
					<th field="contactName" width="130px"
						editor="{type:'validatebox', options:{required:false}}">消费者名称</th>
					<th field="mobilePhone" width="130px"
						editor="{type:'validatebox', options:{required:false}}">电话号码</th>
					<th field="gender" width="60px"
						editor="{type:'validatebox', options:{required:false}}">性别</th>
					<th field="A2" width="100px"
						editor="{type:'validatebox', options:{required:false}}">互动类型</th>
					<th field="A3" width="100px"
						editor="{type:'validatebox', options:{required:false}}">互动内容</th>
					<th field="A4" width="100px"
						editor="{type:'validatebox', options:{required:false}}">是否点击／阅读</th>
					<th field="A5" width="100px"
						editor="{type:'validatebox', options:{required:false}}">是否到店</th>
					<th field="A6" width="100px"
						editor="{type:'validatebox', options:{required:false}}">是否购买</th>
					<th field="A7" width="100px"
						editor="{type:'validatebox', options:{required:false}}">购买日期</th>
					<th field="A8" width="100px"
						editor="{type:'validatebox', options:{required:false}}">点击日期</th>
					<th field="A9" width="100px"
						editor="{type:'validatebox', options:{required:false}}">到店日期</th>
					<th field="A10" width="100px"
						editor="{type:'validatebox', options:{required:false}}">反馈信息</th>
					<th field="A11" width="100px"
						editor="{type:'validatebox', options:{required:false}}">获取标签1</th>
					<th field="A12" width="100px"
						editor="{type:'validatebox', options:{required:false}}">标签2</th>
					<th field="A13" width="100px"
						editor="{type:'validatebox', options:{required:false}}">标签3</th>

				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		$datagrid = $('#account-table');
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true, //显示工具栏
					buttonSearch : true, //搜索框功能
					buttonExport : true,
					buttonCopy : true,
					buttonImport : true,
					buttonMenu : true,
					striped : true,
					title : '',
					border : false,
					url : '${AppContext.ctxPath}/action/portal/accnt/queryListPage',
					onAddMoreButton : function(that, addButtonFun) {
 
						addButtonFun(
								21,
								'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addAccount()">新建</a>',
								that);
						addButtonFun(
								41,
								'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="accountdel()">删除</a>',
								that);
					},
					onInsertAction : function(row, successFun, errFun, that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/accnt/insert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onUpdateAction : function(row, successFun, errFun, that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/accnt/update',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
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
										A1 : '2016/3/11',
										A2 : '微信',
										A3 : '接收微信消息',
										A4 : '是',
										A5 : '是',
										A6 : '是',
										A7 : '2016/3/21',
										A8 : '2016/3/12',
										A9 : '2016/3/21',
										A10 : '价格很便宜',
										A11 : '单身',
										A12 : '高学历',
										A13 : '女性',
									}
								});
							}
						}
					}
				});

	 
	 
	 
		function addAccount() {
			//window.location.href = '${AppContext.ctxPath}/action/portal/accnt/newDealerInit';
			window.location.href = '${AppContext.ctxPath}/portal/account/AddAccount.jsp';
		}

		function accountdel() {
			var row = $datagrid.datagrid('getSelected');
			window.parent.operationconfirm($datagrid,
					'${AppContext.ctxPath}/action/portal/accnt/delById', row.id, '是否确定删除信息？');
		}

		function idFormatter(val, row) {
			//return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/action/portal/accnt/accountDetailInit/" + row.id +"\")'>" + row.id + "</a>";
			return "<a href='${AppContext.ctxPath}/portal/account/AccountDetail.jsp?attr1="
					+ row.id + "'>" + val + "</a>";
		}

		function captionFormatter(val, row) {
			if (val != null) {
				//return "<a href='###' onclick='gotoContentPage(\"${AppContext.ctxPath}/action/portal/accnt/accountDetailInit/" + row.id +"\")'>" + val + "</a>";
				return "<a href='${AppContext.ctxPath}/portal/account/AccountDetail.jsp?attr1="
						+ row.id + "'>" + val + "</a>";
			}
		}

		function orgPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}
		function postnPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
		//初始化选择城市
		function beforeSelectCity(param) {
			var province = $datagrid.hdatagrid('getCurrentRow').province;

			if (province == null || province == '') {
				param.parentAddrName = 'noMatchId';
			} else {
				param.parentAddrName = province;
			}
		}

		//初始化选择区/县
		function beforeSelectDistrict(param) {
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			var city = $datagrid.hdatagrid('getCurrentRow').city;
			if (province == null || province == '') {
				param.parentAddr2Name = 'noMatchId';
			} else {
				param.parentAddr2Name = province;
			}
			if (city == null || city == '') {
				param.parentAddrName = 'noMatchId';
			} else {
				param.parentAddrName = city;
			}
		}

		function showDetail1() {
			var row = $datagrid.hdatagrid('getSelected');
			$.messager.alert("详细信息", row.id + '\n' + row.created + '\n'
					+ row.createdBy);

			var str = '<div onclick="addTreeNode()" data-options="iconCls:\'icon-add\'">test</a>';
			alert(str.lastIndexOf('</a>'));
			var ss = '<div ' + str.substring(4);
			alert(ss);
		}
		//选择省份
		function selectedProvince(selectRow) {
			//alert(selectRow.id);
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.addrName;
			$datagrid.hdatagrid('getCurrentRow').city = '';
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').provinceId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').cityId = '';
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'city'
			}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'city'
			}).target).combobox('setValue', '');
			$($datagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'district'
			}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor', {
				index : editIndex,
				field : 'district'
			}).target).combobox('setValue', '');

		}
		function loadProvinceSuccess() {

		}
		//城市
		function selectedCity(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').city = selectRow.addrName;
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.datagrid('getEditor', {
				index : editIndex,
				field : 'district'
			}).target).combobox('reload');
			$($datagrid.datagrid('getEditor', {
				index : editIndex,
				field : 'district'
			}).target).combobox('setValue', '');
		}
		function selectedDistrict(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').districtId = selectRow.id;
		}
	</script>
</body>
</html>