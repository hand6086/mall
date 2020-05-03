<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/ichart.latest.min.js"></script>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
    <div id="report-tabs" class="easyui-tabs"
         style="width: '$(window).width() - 18'; height: 100%;" data-options="border:false">
        <div title="商机">
            <div id="opty-tabs" class="easyui-tabs"
                 style="width: '$(window).width() - 18'; height: 100%;" data-options="border:false">
                <div title="本周商机数量汇总">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>本周商机数量汇总分析，商机数量（单位：个）</label>
                    </div>
                    <div id='optyNum' style="margin-top: 15px;height: 240px;">
                    </div>

                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>本周商机金额汇总分析，商机金额（单位：元）</label>
                    </div>
                    <div id='optybudget' style="margin-top: 15px;height: 240px;">

                    </div>

                </div>
                <div title="商机阶段汇总分析">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>商机数量（单位：个）</label>
                    </div>
                    <div id='optyStageNum' style="margin-top: 15px;height: 300px;">
                    </div>
                </div>
                <div title="进行中的商机TOP10">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>商机预算（单位：万元）</label>
                    </div>
                    <div id='qd_report12' style="margin-top: 15px;height: 400px;">
                    </div>
                </div>
            </div>
        </div>
        <div title="订单">
            <div id="order-tabs" class="easyui-tabs"
                 style="width: '$(window).width() - 18'; height: 100%;" data-options="border:false">
                <div title="本周销售订单分析表">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>本周销售金额，已成交订单（单位：万元）</label>
                    </div>
                    <div id='thisWeekSalesAmountCanvas' style="margin-top: 15px;height: 240px;"></div>
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>本周订单数量，已成交订单（单位：万元）</label>
                    </div>
                    <div id='orderNumReport' style="margin-top: 15px;height: 240px;"></div>
                </div>
                <div title="销售订单状态分析">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>订单数量（单位：个）</label>
                    </div>
                    <div id='qd_report13' style="margin-top: 15px;height: 300px;">
                    </div>
                </div>
            </div>
        </div>
        <div title="客户">
            <div id="customer-tabs" class="easyui-tabs"
                 style="width: '$(window).width() - 18'; height: 100%;" data-options="border:false">
                <div title="本周客户连接分析表">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>本周C端发起，客户数量（单位：个）</label>
                    </div>
                    <div id='accntCDuan' style="margin-top: 15px;height: 240px;">
                    </div>
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>本周B端发起，客户数量（单位：个）</label>
                    </div>
                    <div id='accntBDuan' style="margin-top: 15px;height: 240px;">
                    </div>
                </div>
                <div title="客户标签分析表">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>客户数量（单位：个）</label>
                    </div>
                    <div id='TagReport' style="margin-top: 15px;height: 240px;">
                    </div>

                    <div id='TagItemReport' style="margin-top: 15px;height: 240px;">
                    </div>
                </div>
                <div title="企点客户接待统计">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>客户数量（单位：个）</label>
                    </div>
                    <div id='qd_report14' style="margin-top: 15px;height: 300px;"></div>
                </div>
                <div title="客户状态类型汇总分析">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>客户数量（单位：个）</label>
                    </div>
                    <div id='accntStatusTotal' style="margin-top: 15px;height: 300px;"></div>

                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>客户数量（单位：个）</label>
                    </div>
                    <div id='accntTypeTotal' style="margin-top: 15px;height: 300px;"></div>

                </div>
                <div title="客户行为数据分析">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <span class="radioSpan">
                             <input type="radio" name="customerBehavior_selectModel"
                                    id="customerBehavior_selectModel_day"
                                    onclick="customerBehaviorDataAnalysis('day')"><label
                                for="customerBehavior_selectModel_day">日</label></input>
                            <input type="radio" name="customerBehavior_selectModel"
                                   id="customerBehavior_selectModel_week"
                                   onclick="customerBehaviorDataAnalysis('week')"><label
                                for="customerBehavior_selectModel_week">周</label></input>
                            <input type="radio" name="customerBehavior_selectModel"
                                   id="customerBehavior_selectModel_month"
                                   onclick="customerBehaviorDataAnalysis('month')"><label
                                for="customerBehavior_selectModel_month">月</label></input>
                            <input type="radio" name="customerBehavior_selectModel"
                                   id="customerBehavior_selectModel_year"
                                   onclick="customerBehaviorDataAnalysis('year')"><label
                                for="customerBehavior_selectModel_year">年</label></input>
                        </span>
                        <label style="margin-left: 100px">客户数量（单位：个）</label>
                    </div>


                    <div id='accntKeyNum' style="margin-top: 15px;height: 240px;"></div>
                </div>
            </div>
        </div>

        <div title="其他">
            <div id="other-tabs" class="easyui-tabs"
                 style="width: '$(window).width() - 18'; height: 100%;" data-options="border:false">
                <div title="月度运营数据简报">
                    <div style="text-align: center;width: 100%;margin-top: 15px">
                        <form id="operativeDataReportOnThisMonthForm">
                            <table class="table-block" style="margin: auto auto">
                                <tr>
                                    <td class="td-label"><label>新建客户：</label></td>
                                    <td class="td-content"><input id="acctcount"
                                                                  name="acctcount" class="easyui-validatebox" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>新建联系人：</label></td>
                                    <td class="td-content"><input id="contcount"
                                                                  name="contcount" class="easyui-validatebox" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>新建线索：</label></td>
                                    <td class="td-content"><input id="cluecount"
                                                                  name="cluecount" class="easyui-validatebox" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>新建商机：</label></td>
                                    <td class="td-content"><input id="optycount"
                                                                  name="optycount" class="easyui-validatebox" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>商机跟进：</label></td>
                                    <td class="td-content"><input id="actioncount"
                                                                  name="actioncount" class="easyui-validatebox"
                                                                  disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>新增订单：</label></td>
                                    <td class="td-content"><input id="ordercount"
                                                                  name="ordercount" class="easyui-validatebox"
                                                                  disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>累计登陆次数：</label></td>
                                    <td class="td-content"><input id="logincount"
                                                                  name="logincount" class="easyui-validatebox"
                                                                  disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-label"><label>今日登陆次数：</label></td>
                                    <td class="td-content"><input id="logintdcount"
                                                                  name="logintdcount" class="easyui-validatebox"
                                                                  disabled/>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div title="产品">
            <div id="prod-tabs" class="easyui-tabs"
                 style="width: '$(window).width() - 18'; height: 100%;" data-options="border:false">
                <div title="产品销售情况分析">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>产品销售分析，销售金额（单位：元）</label>
                    </div>
                    <div id='callidusReport3' style="margin-top: 15px;height: 300px;">
                    </div>
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>产品销售分析，订单数量（单位：个）</label>
                    </div>
                    <div id='callidusReport4' style="margin-top: 15px;height: 300px;">
                    </div>

                </div>
                <div title="热卖产品收藏TOP10">
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>热卖产品收藏TOP10，产品数量（单位：个）</label>
                    </div>
                    <div id='ProductCollTop10' style="margin-top: 15px;height: 240px;"></div>
                    <div style="width: 100%;text-align: center;margin-top: 15px">
                        <label>销售产品TOP10，产品数量（单位：个）</label>
                    </div>
                    <div id='SalesProductTop10' style="margin-top: 15px;height: 240px;">
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<script>
    /*----------------------------------------------客户 start-------------------------------------------------*/
    $('#customer-tabs').tabs({
        onSelect: function (title, index) {
            switch (title) {
                case '本周客户连接分析表':
                    customerConnectAnalysisOnThisWeek();
                    break;
                case '客户标签分析表':
                    customerTagAnalysis();
                    break;
                case '企点客户接待统计':
                    qidianCustomerReceptionTotalAnalysis();
                    break;
                case '客户状态类型汇总分析':
                    customerStatusCategoryTotalAnalysis();
                    customerCategoryTotalAnalysis();
                    break;
                case '客户行为数据分析':
                    $("#customerBehavior_selectModel_week").click();
                    break;
            }
        }
    });
    /*客户行为数据分析*/
    function customerBehaviorDataAnalysis(selectMoudle) {
        if (selectMoudle == null || selectMoudle == '') selectMoudle = 'week';
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryAccntKeyNum', {
            security: 'all',
            searchText: selectMoudle
        }, function (result) {
            if (result.success) {
                customerBehaviorDataAnalysis_chartDraw(result.result);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function customerBehaviorDataAnalysis_chartDraw(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        var chart = new iChart.Column2D({
            render: 'accntKeyNum',
            data: data,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 300,
            label: {
                fontsize: 15,
                color: '#666666'
            },
            background_color: '#ffffff',
            shadow: true,
            shadow_blur: 2,
            align: "center",
            shadow_color: '#aaaaaa',
            shadow_offsetx: 1,
            shadow_offsety: 0,
            //column_width : 62,
            column_width: "35%",
            sub_option: {
                listeners: {
                    parseText: function (r, t) {
                        return t;
                    }
                },
                label: {
                    fontsize: 15,
                    color: '#B9996F'
                }
            },
            coordinate: {
                height: "75%"
            }

        });
        chart.draw();
    }
    /*客户状态类型汇总分析*/
    function customerStatusCategoryTotalAnalysis() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryAccntStatusNum', {
            security: 'all',
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                customerStatusCategoryTotalAnalysis_chartDraw(result.result);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function customerStatusCategoryTotalAnalysis_chartDraw(result) {
        var data = [];
        for (var i = 0; i < result.length; i++) {
            data.push({
                name: result[i].name,
                value: result[i].value,
                color: aPieChartColor[i]
            });
        }

        var chart = new iChart.Pie2D({
            render: "accntStatusTotal",//客户状态类型汇总分析
            data: data,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 250,
            label: {
                fontsize: 11,
                color: '#666666'
            },
            background_color: '#ffffff',
            gradient: false,
            border: {
                color: "#BCBCBC",
                width: 0
            },
            sub_option: {
                border: {
                    color: "#BCBCBC",
                    width: 2
                },
                label: {
                    fontsize: 15,
                    color: "#B9996F",
                    sign: "",
                    sign_size: 12,
                    border: {
                        color: "#BCBCBC",
                        width: 0
                    },
                    background_color: null
                }
            },
            showpercent: false,
            decimalsnum: 2
        });
        chart.draw();
    }
    function customerCategoryTotalAnalysis() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryAccntTypeReport', {
            security: 'all',
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                customerCategoryTotalAnalysis_chartDraw(result.result);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function customerCategoryTotalAnalysis_chartDraw(result) {
        var data = [];
        for (var i = 0; i < result.length; i++) {
            data.push({
                name: result[i].name,
                value: result[i].value,
                color: aPieChartColor.shift()
            });
        }
        var chart = new iChart.Pie2D({
            render: "accntTypeTotal",//客户状态类型汇总分析
            data: data,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 250,
            label: {
                fontsize: 11,
                color: '#666666'
            },
            background_color: '#ffffff',
            gradient: false,
            border: {
                color: "#BCBCBC",
                width: 0
            },
            sub_option: {
                border: {
                    color: "#BCBCBC",
                    width: 2
                },
                label: {
                    fontsize: 15,
                    color: "#B9996F",
                    sign: "",
                    sign_size: 12,
                    border: {
                        color: "#BCBCBC",
                        width: 0
                    },
                    background_color: null
                }
            },
            showpercent: false,
            decimalsnum: 2
        });
        chart.draw();
    }
    /*企点客户接待统计*/
    function qidianCustomerReceptionTotalAnalysis() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryAccountPeopleNum', {
            security: 'all',
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                qidianCustomerReceptionTotalAnalysis_chartDraw(result.result);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function qidianCustomerReceptionTotalAnalysis_chartDraw(result) {
        var labels = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
        var list1 = [];
        var list2 = [];

        for (var index = 0; index < result.length; index++) {
            var item = result[index];

            if (item.lable == 'CRM') {
                if (isEmpty(item.value) || item.value == 0) list1.push(null);
                else {
                    list1.push(Number(item.value));
                }
            } else if (item.lable == 'QD') {
                if (isEmpty(item.value) || item.value == 0) list2.push(null);
                else {
                    list2.push(Number(item.value));
                }
            }
        }
        var data = [];
        data.push(
            {
                name: 'CRM客户数',
                value: list1,
                color: '#ee8534'
            },
            {
                name: '企点客户数',
                value: list2,
                color: '#fdd139'
            }
        );
        var chart = new iChart.ColumnStacked2D({
            render: 'qd_report14',
            data: data,
            labels: labels,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 300,
            shadow: true,//激活阴影
            offsetx: -30,
            shadow_color: '#c7c7c7',//设置阴影颜色
            label: {
                fontsize: 15,
                color: '#666666'
            },
            legend: {
                enable: true,
                background_color: null,
                line_height: 25,
                color: '#dcd6cb',
                fontsize: 15,
                font: '微软雅黑',
                align: "right",
                fontweight: 600,
                border: {
                    enable: false
                }
            },
            sub_option: {
                listeners: {
                    click: function (e, param, d) {
                    }
                },
                label: {color: '#f9f9f9', fontsize: 12, fontweight: 600}
            },
            coordinate: {
                height: '80%',
                width: "80%"
            }
        });
        //开始画图
        chart.draw();
    }
    /*客户标签分析表*/
    var rows1 = {};
    var rows2 = {};
    function customerTagAnalysis() {
        /*请求标签组数据*/
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryAccnttagReport', {
            security: 'my',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                rows1 = result.result;
                /*请求标签组详细信息数据*/
                $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryAccnttagItemReport', {
                    security: 'my',
                    createdBy: appCtx.userId,
                    usercorpid: appCtx.corpId
                }, function (result) {
                    if (result.success) {
                        rows2 = result.result;
                        customerTagAnalysis_chartDraw(rows1);
                    } else {
                        $.messager.alert("提示", "数据请求失败！");
                    }
                });

            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function customerTagAnalysis_chartDraw(result) {
        var data = [];
        var labels = [];
        var labels1 = [];
        var labels2 = [];
        var crmtempList = [];
        var qdtempList = [];
        for (var index = 0; index < result.length; index++) {
            var item = result[index];
            if (item.source == 'CRM') crmtempList.push(item);
            else if (item.source == 'QIDIAN') qdtempList.push(item);
        }
        for (var i = 0; i < crmtempList.length; i++) {
            labels1.push(crmtempList[i].lable)
        }
        for (var j = 0; j < qdtempList.length; j++) {
            labels2.push(qdtempList[j].lable)
        }

        labels = union(labels1, labels2);
        var mess = [];
        for (var i = 0; i < labels.length; i++) {
            mess.push({
                label: labels[i],
                crm: '',
                qd: ''
            });
        }
        for (var i = 0; i < mess.length; i++) {
            for (var k = 0; k < crmtempList.length; k++) {
                if (mess[i].label == crmtempList[k].lable) {
                    mess[i].crm = crmtempList[k].value;
                }
            }
            for (var j = 0; j < qdtempList.length; j++) {
                if (mess[i].label == qdtempList[j].lable) {
                    mess[i].qd = qdtempList[j].value;
                }
            }
        }
        var list1 = [];
        var list2 = [];
        for (var i = 0; i < mess.length; i++) {
            if (isEmpty(mess[i].crm)) {
                list1.push(null);
            } else {
                list1.push(Number(mess[i].crm));
            }
            if (isEmpty(mess[i].qd)) {
                list2.push(null);
            } else {
                list2.push(Number(mess[i].qd));
            }
        }
        data.push(
            {
                name: 'CRM标签',
                value: list1,
                color: '#ee8534'
            },
            {
                name: '企点标签',
                value: list2,
                color: '#fdd139'
            }
        );
        var chart = new iChart.ColumnStacked2D({
            render: 'TagReport',
            data: data,
            labels: labels,
            offsetx: -30,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 240,
            shadow: true,//激活阴影
            shadow_color: '#c7c7c7',//设置阴影颜色
            label: {
                fontsize: 15,
                color: '#666666'
            },
            legend: {
                enable: true,
                background_color: null,
                line_height: 25,
                color: '#dcd6cb',
                fontsize: 15,
                font: '微软雅黑',
                align: "right",
                fontweight: 600,
                border: {
                    enable: false
                }
            },
            sub_option: {
                listeners: {
                    click: function (r, e, m) {
                        var source = '';
                        if (r.get('name') == 'CRM标签') {
                            source = 'CRM';
                        } else {
                            source = 'QIDIAN';
                        }
                        var id = r.get('id').substr(0, r.get('id').indexOf('_'));
                        var lable = labels[Number(id)];
//                        $scope.title = r.get('name') + "—" + lable;
//                        $scope.$apply();
//                        $scope.drawChartMore(source, lable);
                        customerTagAnalysis_chartDrawMore(rows2, source, lable);
                    }
                },
                label: {color: '#f9f9f9', fontsize: 12, fontweight: 600}
            },
            coordinate: {
                height: '80%',
                width: "80%"
            }
        });

        chart.draw();
    }
    function customerTagAnalysis_chartDrawMore(rows, source, lable) {
        var aPieChartColor = [
            '#f18e63', '#f3d46a', '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534',
            '#f18e63', '#f3d46a', '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534',
            '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#f18e63', '#f3d46a',
            '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#f18e63', '#f3d46a',
            '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#f18e63', '#f3d46a'
        ];
        var data = [];
        var results = [];
        for (var index = 0; index < rows.length; index++) {
            var item = rows[index];
            if (item.source == source && item.lable == lable) results.push(item);
        }
        for (var i = 0; i < results.length; i++) {
            data.push({
                name: results[i].name,
                value: results[i].value,
                color: aPieChartColor[i]
            });
        }
        var chart = new iChart.Pie2D({
            render: "TagItemReport",//客户状态类型汇总分析
            data: data,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 250,
            label: {
                fontsize: 11,
                color: '#666666'
            },
            background_color: '#ffffff',
            gradient: false,
            border: {
                color: "#BCBCBC",
                width: 0
            },
            sub_option: {
                border: {
                    color: "#BCBCBC",
                    width: 2
                },
                label: {
                    fontsize: 15,
                    color: "#B9996F",
                    sign: "",
                    sign_size: 12,
                    border: {
                        color: "#BCBCBC",
                        width: 0
                    },
                    background_color: null
                }
            },
            showpercent: false,
            decimalsnum: 2
        });
        chart.draw();
    }
    function uniquelize(a) {
        var ra = [];
        for (var i = 0; i < a.length; i++) {
            if (!ra.contains(a[i])) {
                ra.push(a[i]);
            }
        }
        return ra;
    }
    function union(a, b) {
        return uniquelize(a.concat(b));
    }
    Array.prototype.contains = function (obj) {
        var index = this.length;
        while (index--) {
            if (this[index] === obj) {
                return true;
            }
        }
        return false;
    }
    /*本周客户连接分析表*/
    function customerConnectAnalysisOnThisWeek() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryContonectAccntReport', {
            security: 'my',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                var rowsB = [];
                var rowsC = [];
                var totalRows = result.result;
                for (var index = 0; index < totalRows.length; index++) {
                    var item = totalRows[index];
                    if (item.lable == 'B端') rowsB.push(item);
                    else if (item.lable == 'C端') rowsC.push(item);
                }
                customerConnectAnalysisOnThisWeek_chartDrawC(rowsC);
                customerConnectAnalysisOnThisWeek_chartDrawB(rowsB);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function customerConnectAnalysisOnThisWeek_chartDrawC(rows) {
        var flow = [];
        var labels = [];
        for (var i = 0; i < rows.length; i++) {
            flow.push(rows[i].value);
            labels.push(rows[i].name);
        }

        var data = [
            {
                name: 'C端客户数：',
                value: flow,
                color: '#f1ce55',
                line_width: 2
            }
        ];
        var chart = new iChart.LineBasic2D({
            render: "accntCDuan",
            data: data,
            align: 'center',
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 240,
            strokeStyle: '#ffffff',
            background_color: "#ffffff",
            tip: {
                enable: true,
                shadow: true
            },
            crosshair: {
                enable: true,
                line_color: '#62bce9'
            },
            coordinate: {
                /*width: '80%',
                 height: '76%',*/
                axis: {
                    color: '#666666',
                    width: [0, 0, 1, 1]
                },
                scale: [{
                    position: 'left',
                    label: {color: '#666666'},
                    scale_color: '#9f9f9f'
                }, {
                    position: 'bottom',
                    label: {color: '#666666', fontsize: 15},
                    labels: labels
                }]
            },
            legend: {
                background_color: null,//设置透明背景
                border: true,
                enable: false
            },
            sub_option: {
                //hollow:true,
                //hollow_inside:true,//设置一个点的亮色在外环的效果
                //hollow_color:"#ffffff",
                point_size: 15,
                label: {
                    fontsize: 15,
                    color: '#B9996F'
                }
            }
        });

        //开始画图
        chart.draw();
    }
    function customerConnectAnalysisOnThisWeek_chartDrawB(rows) {
        var flow = [];
        var labels = [];
        for (var i = 0; i < rows.length; i++) {
            flow.push(rows[i].value);
            labels.push(rows[i].name);
        }
        var data = [
            {
                name: 'B端客户数：',
                value: flow,
                color: '#f1ce55',
                line_width: 2
            }
        ];
        var chart = new iChart.LineBasic2D({
            render: 'accntBDuan',
            data: data,
            align: 'center',
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 240,
            strokeStyle: '#ffffff',
            background_color: "#ffffff",
            tip: {
                enable: true,
                shadow: true
            },
            crosshair: {
                enable: true,
                line_color: '#62bce9'
            },
            coordinate: {
                /*width: '80%',
                 height: '76%',*/
                axis: {
                    color: '#666666',
                    width: [0, 0, 1, 1]
                },
                scale: [{
                    position: 'left',
                    label: {color: '#666666'},
                    scale_color: '#9f9f9f'
                }, {
                    position: 'bottom',
                    label: {color: '#666666', fontsize: 15},
                    labels: labels
                }]
            },
            legend: {
                background_color: null,//设置透明背景
                border: true,
                enable: false
            },
            sub_option: {
                //hollow:true,
                //hollow_inside:true,//设置一个点的亮色在外环的效果
                //hollow_color:"#ffffff",
                point_size: 15,
                label: {
                    fontsize: 15,
                    color: '#B9996F'
                }
            }
        });

        //开始画图
        chart.draw();
    }

    /*----------------------------------------------商机 start-------------------------------------------------*/
    $('#opty-tabs').tabs({
        onSelect: function (title, index) {
            switch (title) {
                case '商机阶段汇总分析':
                    optyStageSummaryAnalysis();
                    break;
                case '本周商机数量汇总':
                    optyAmountSummaryAnalysisOnThisWeek();
                    break;
                case '进行中的商机TOP10':
                    optyInOperationTOP10();
                    break;
            }
        }
    });
    /*商机阶段汇总分析*/
    function optyStageSummaryAnalysis() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryOptyStageNum', {
            security: 'all',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                optyStageSummaryAnalysis_chartDraw(result.result);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function optyStageSummaryAnalysis_chartDraw(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "optyStageNum",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 300,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        } else {
            var chart = new iChart.Column2D({
                render: "optyStageNum",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 300,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }

        chart.draw();
    }
    /*本周商机数量汇总*/
    function optyAmountSummaryAnalysisOnThisWeek() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryOptyStudyReport', {
            security: 'all',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                var resultNum = [];
                var resultbudget = [];
                var totalRows = result.result;
                for (var index = 0; index < totalRows.length; index++) {
                    var item = totalRows[index];
                    if (item.lable == 'num') resultNum.push(item);
                    else if (item.lable = 'budget') resultbudget.push(item);
                }
                optyAmountSummaryAnalysisOnThisWeek_chartDraw_num(resultNum);
                optyAmountSummaryAnalysisOnThisWeek_chartDraw_budget(resultbudget);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function optyAmountSummaryAnalysisOnThisWeek_chartDraw_num(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "optyNum",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        } else {
            var chart = new iChart.Column2D({
                render: "optyNum",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }

        chart.draw();
    }
    function optyAmountSummaryAnalysisOnThisWeek_chartDraw_budget(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "optybudget",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        } else {
            var chart = new iChart.Column2D({
                render: "optybudget",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }
        chart.draw();
    }
    /*进行中的商机TOP10*/
    function optyInOperationTOP10() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryOptyBudgtTop10', {
            security: 'all',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                optyInOperationTOP10_chartDraw(result.result);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    function optyInOperationTOP10_chartDraw(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "qd_report12",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 350,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        } else {
            var chart = new iChart.Column2D({
                render: "qd_report12",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 350,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }

        chart.draw();
    }

    /*----------------------------------------------其他 start-------------------------------------------------*/
    $('#other-tabs').tabs({
        onSelect: function (title, index) {
            switch (title) {
                case '月度运营数据简报':
                    operativeDataReportOnThisMonth();
                    break;

            }
        }
    });
    /*近三月销售预测（舍弃）*/
    /*月度运营数据简报*/
    function operativeDataReportOnThisMonth() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/operativeDataReportOnThisMonth', {
            security: 'all',
            accntId: appCtx.userId,
            corpid: appCtx.corpId
        }, function (result) {
            if (result.success) {
                formLoadData('operativeDataReportOnThisMonthForm', result.result[0]);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });
    }
    /*将数据加载到表单*/
    function formLoadData(formId, data) {
        var inputList = $("#" + formId + " input");
        for (var index = 0; index < inputList.length; index++) {
            var name = $(inputList[index]).attr("name");
            if (name != null) {
                $(inputList[index]).val(data[name]);
            }
        }
    }

    /*----------------------------------------------产品 start-------------------------------------------------*/
    $('#prod-tabs').tabs({
        onSelect: function (title, index) {
            switch (title) {
                case '产品销售情况分析':
                    prodSalesSituationAnalysis();
                    break;
                case '热卖产品收藏TOP10':
                    hotSaleProdTOP10();
                    break;
            }
        }
    });
    /*产品销售情况分析*/
    var chart;
    function prodSalesSituationAnalysis() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryProOrderSalesMoney', {
            security: 'all',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (data) {
            if (data.success) {
                var result = data.result;
                var color = aPieChartColor;
                var rows = [];
                for (var i = 0; i < result.length; i++) {
                    rows.push({
                        name: result[i].name,
                        value: result[i].value,
                        color: aPieChartColor[i]
                    });
                }
                prodSalesSituationAnalysis_chartDraw(rows);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });

        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryProOrderSalesNum', {
            security: 'all',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (data) {
            if (data.success) {
                var result = data.result;
                var color = aPieChartColor;
                var rows = [];
                for (var i = 0; i < result.length; i++) {
                    rows.push({
                        name: result[i].name,
                        value: result[i].value,
                        color: aPieChartColor[i]
                    });
                }
                prodSalesSituationAnalysis_chartDraw2(rows);
            } else {
                $.messager.alert("提示", "数据请求失败！");
            }
        });

    }
    function prodSalesSituationAnalysis_chartDraw(data) {
        chart = new iChart.Pie2D({
            render: 'callidusReport3',
            data: data,
            // title : '客户分类统计',
            animation: true,
            background_color: '#ffffff',
            turn_off_touchmove: true,
            legend: {
                enable: false
            },
            gradient: false,
            border: {
                color: "#BCBCBC",
                width: 0
            },
            sub_option: {
                border: {
                    color: "#BCBCBC",
                    width: 2
                },
                label: {
                    fontsize: 15,
                    color: "#B9996F",
                    sign: "",
                    sign_size: 12,
                    border: {
                        color: "#BCBCBC",
                        width: 0
                    },
                    background_color: null
                }
            },
            showpercent: false,
            decimalsnum: 2,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 300,
            radius: 440
        });
        chart.draw();
    }
    function prodSalesSituationAnalysis_chartDraw2(data) {
        chart = new iChart.Pie2D({
            render: 'callidusReport4',
            data: data,
            // title : '客户分类统计',
            animation: true,
            background_color: '#ffffff',
            turn_off_touchmove: true,
            legend: {
                enable: false
            },
            gradient: false,
            border: {
                color: "#BCBCBC",
                width: 0
            },
            /*title : {
             text : '产品销售分析（销售额）',
             color : '#3e576f'
             },*/
            sub_option: {
                border: {
                    color: "#BCBCBC",
                    width: 2
                },
                label: {
                    fontsize: 15,
                    color: "#B9996F",
                    sign: "",
                    sign_size: 12,
                    border: {
                        color: "#BCBCBC",
                        width: 0
                    },
                    background_color: null
                }
            },
            showpercent: false,
            decimalsnum: 2,
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 300,
            radius: 440
        });
        chart.draw();
    }
    /*热卖产品收藏Top10*/
    function hotSaleProdTOP10() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryProductCollTop10', {
            security: 'all'
        }, function (result) {
            if (!result.success) {
                $.messager.alert("提示", "请求数据失败");
            } else {
                hotSaleProdTOP10_chartDraw(result.result);
            }
        });

        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/querySalesProductTop10Report', {
            security: 'all'
        }, function (result) {
            if (!result.success) {
                $.messager.alert("提示", "请求数据失败");
            } else {
                saleProdTio10_chartDraw(result.result);
            }
        });
    }
    function hotSaleProdTOP10_chartDraw(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "ProductCollTop10",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        }
        else {
            var chart = new iChart.Column2D({
                render: "ProductCollTop10",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }
        chart.draw();
    }
    function saleProdTio10_chartDraw(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "SalesProductTop10",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        } else {
            var chart = new iChart.Column2D({
                render: "SalesProductTop10",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }

        chart.draw();
    }

    /*----------------------------------------------订单 start-------------------------------------------------*/
    $('#order-tabs').tabs({
        onSelect: function (title, index) {
            switch (title) {
                case '销售订单状态分析':
                    orderStatusAnalysis();
                    break;
                case '本周销售订单分析表':
                    orderStatusAnalysisOnThisWeek();
                    break;
            }
        }
    });
    /*销售订单状态分析*/
    function orderStatusAnalysis() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/querySalesOrderStatusNum', {
            security: 'all'
        }, function (result) {
            if (!result.success) {
                $.messager.alert("提示", "请求数据失败");
            } else {
                orderStatusAnalysis_chartDraw(result.result);
            }
        });
    }
    function orderStatusAnalysis_chartDraw(rows) {
        var data = [];
        for (var i = 0; i < rows.length; i++) {
            data.push({
                name: rows[i].name,
                value: rows[i].value,
                color: '#f1ce55'
            });
        }
        data = get2DBarMaxDateColor(data);
        if (data.length > 9) {
            var chart = new iChart.Column2D({
                render: "qd_report13",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 300,
                offsety: -15,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 12,
                    //line_height:12
                    textAlign: 'right',
                    textBaseline: 'middle',
                    rotate: -45
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '78%'
                }
            });
        } else {
            var chart = new iChart.Column2D({
                render: "qd_report13",
                data: data,
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 300,
                shadow: true,//激活阴影
                shadow_color: '#c7c7c7',//设置阴影颜色
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                sub_option: {
                    listeners: {
                        parseText: function (r, t) {
                            return t;
                        }
                    },
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    },
                    shadow: true,
                    shadow_blur: 1,
                    shadow_color: '#ff0000',
                    shadow_offsetx: 20,
                    shadow_offsety: 100
                },
                coordinate: {
                    height: '80%'
                }
            });
        }

        chart.draw();
    }
    /*本周销售订单分析表*/
    function orderStatusAnalysisOnThisWeek() {
        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/querySalesAmountReport', {
            security: 'my',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (!result.success) {
                $.messager.alert("提示", "请求数据失败");
            } else {
                saleAmountOfMoneyOnThisWeek_chartDraw(result.result);
            }
        });

        $.get('${AppContext.ctxPath}/action/qidian/qidianReport/queryOrderNumReport', {
            security: 'my',
            createdBy: appCtx.userId,
            usercorpid: appCtx.corpId
        }, function (result) {
            if (!result.success) {
                $.messager.alert("提示", "请求数据失败");
            } else {
                saleOrderNumberOnThisWeek_chartDraw(result.result);
            }
        });
    }
    function saleAmountOfMoneyOnThisWeek_chartDraw(rows) {
        var chart;
        var flow = [0, 0, 0, 0, 0, 0, 0];
        var MAX = 1;
        if (rows != null) {
            for (var i = 0; i < rows.length; i++) {
                rows[i].amount = parseFloat(rows[i].amount / 10000).toFixed(2);
                if (rows[i].type == 'T') {
                    if (parseInt(rows[i].amount) > parseInt(MAX)) {
                        MAX = rows[i].amount;
                    }
                }
                if (rows[i].type == 'T' && rows[i].dt == "星期一") {
                    flow[0] = rows[i].amount;
                }
                else if (rows[i].type == 'T' && rows[i].dt == "星期二") {
                    flow[1] = rows[i].amount;
                }
                else if (rows[i].type == 'T' && rows[i].dt == "星期三") {
                    flow[2] = rows[i].amount;
                }
                else if (rows[i].type == 'T' && rows[i].dt == "星期四") {
                    flow[3] = rows[i].amount;
                }
                else if (rows[i].type == 'T' && rows[i].dt == "星期五") {
                    flow[4] = rows[i].amount;
                }
                else if (rows[i].type == 'T' && rows[i].dt == "星期六") {
                    flow[5] = rows[i].amount;
                }
                else if (rows[i].type == 'T' && rows[i].dt == "星期日") {
                    flow[6] = rows[i].amount;
                }
            }
            var P_MAX = getMaxValueForReport(MAX, 5);
            var data1 = [
                {
                    name: '销售金额：',
                    value: flow,
                    color: '#f1ce55',
                    line_width: 2
                }
            ];
            var labels = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
            chart = new iChart.LineBasic2D({
                render: 'thisWeekSalesAmountCanvas',
                /*turn_off_touchmove: true,*/
                data: data1,
                align: 'center',
                animation: false,
                background_color: '#ffffff',
                tip: {
                    enable: true,
                    shadow: true
                },
                width: Math.floor(document.body.clientWidth * 0.70),
                height: 240,
                sub_option: {
                    hollow_inside: false,//设置一个点的亮色在外环的效果
                    point_size: 16,
                    label: {
                        fontsize: 15,
                        color: '#B9996F'
                    }
                },
                label: {
                    fontsize: 15,
                    color: '#666666'
                },
                legend: {
                    enable: false
                },
                crosshair: {
                    enable: true,
                    line_color: '#62bce9'
                },

                coordinate: {
                    height: '75%',
                    axis: {
                        color: '#666666',
                        width: [0, 0, 1, 1]
                    },

                    scale: [{
                        position: 'left',
                        start_scale: 0,
                        end_scale: P_MAX,
                        scale_color: '#666666'
                    }, {
                        position: 'bottom',
                        labels: labels,
                        label: {color: '#666666', fontsize: 15}
                    }]
                }
            });
            //开始画图
            chart.draw();
        }
    }
    function saleOrderNumberOnThisWeek_chartDraw(rows) {
        var flow = [];
        var labels = [];
        for (var i = 0; i < rows.length; i++) {
            flow.push(rows[i].value);
            labels.push(rows[i].name);
        }

        var data = [
            {
                name: '订单数量：',
                value: flow,
                color: '#f1ce55',
                line_width: 2
            }
        ];
        var chart = new iChart.LineBasic2D({
            render: "orderNumReport",
            data: data,
            align: 'center',
            width: Math.floor(document.body.clientWidth * 0.70),
            height: 240,
            strokeStyle: '#ffffff',
            background_color: "#ffffff",
            tip: {
                enable: true,
                shadow: true
            },
            crosshair: {
                enable: true,
                line_color: '#62bce9'
            },
            coordinate: {
                /*width: '80%',
                 height: '76%',*/
                axis: {
                    color: '#666666',
                    width: [0, 0, 1, 1]
                },
                scale: [{
                    position: 'left',
                    label: {color: '#666666'},
                    scale_color: '#9f9f9f'
                }, {
                    position: 'bottom',
                    label: {color: '#666666', fontsize: 15},
                    labels: labels
                }]
            },
            legend: {
                background_color: null,//设置透明背景
                border: true,
                enable: false
            },
            sub_option: {
                //hollow:true,
                //hollow_inside:true,//设置一个点的亮色在外环的效果
                //hollow_color:"#ffffff",
                point_size: 15,
                label: {
                    fontsize: 15,
                    color: '#B9996F'
                }
            }
        });

        //开始画图
        chart.draw();
    }
    function getMaxValueForReport(MAX, N) {
        MAX = parseFloat(MAX);
        var P_MAX;
        if (MAX == 0) {
            return 10;
        }
        if (MAX > 10 || MAX == 10) {
            P_MAX = Math.ceil(MAX / N / 10) * 10 * N;
        }
        else if (MAX > 1.1 && MAX < 10) {
            P_MAX = Math.ceil(MAX / N) * N;
        }
        else if (MAX < 1) {
            var temp = MAX.toString();
            var f = 0;//小数位数
            if (temp.toLowerCase().indexOf("e") != -1) {
                f = temp.charAt(temp.length - 1);
            } else {
                f = temp.search(/[1-9]/i) - 1;
            }
            P_MAX = Math.ceil(MAX * Math.pow(10, f) / N) / Math.pow(10, f) * N;
        }
        return P_MAX;
    }

    /*公共方法*/
    var ROOT = {};
    ROOT.CLIENT_TYPE = 'iphone';
    //修改2D条形图最大值的条住的颜色
    function get2DBarMaxDateColor(data) {
        if (data.length > 1) {
            var max = Number(data[0].value);
            var maxNum = 0;
            for (var i = 0; i < data.length; i++) {
                if (Number(data[i].value) > max) {
                    max = Number(data[i].value);
                    maxNum = i;
                }
            }
            if (ROOT.CLIENT_TYPE == 'iphone' || ROOT.CLIENT_TYPE == 'android') {
                data[maxNum].color = '#72DCFF';
            } else {
                data[maxNum].color = '#f1ac28';
            }
            ;
        } else if (data.length == 1) {
            if (ROOT.CLIENT_TYPE == 'iphone' || ROOT.CLIENT_TYPE == 'android') {
                data[maxNum].color = '#72DCFF';
            } else {
                data[maxNum].color = '#f1ac28';
            }
            ;
        }
        return data;
    }

    function isEmpty(v) {
        if (v == null) {
            return true;
        }
        if (v == undefined) {
            return true;
        }
        if (v == "") {
            return true;
        }
        if (typeof v == "undefined") {
            return true;
        }
        switch (typeof v) {
            case 'date':
                return true;
            case 'undefined' :
                return true;
            case 'string' :
                if (v.trim().length === 0)
                    return true;
                break;
            case 'boolean' :
                if (!v)
                    return true;
                break;
            case 'number' :
                if (0 === v)
                    return true;
                break;
            case 'object' :
                if (null === v) {
                    return true;
                }
                else if (undefined !== v.length && v.length === 0) {
                    return true;
                }
                else {
                    return false;
                }
                break;
        }
        return false;
    }

    var aPieChartColor = [
        '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#fdd139', '#f86828',
        '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#fdd139', '#f86828',
        '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#fdd139', '#f86828',
        '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#fdd139', '#f86828',
        '#a78560', '#f4ebcc', '#843c24', '#db9649', '#ee8534', '#fdd139', '#f86828'
    ];//pad报表色彩
    var mobilePieChartColor = [
        '#6f83a5', '#ADFF2F', '#7FFFAA', '#76a871', '#6495ED', '#a56f8f', '#20A6FC',
        '#6f83a5', '#ADFF2F', '#7FFFAA', '#76a871', '#6495ED', '#a56f8f', '#20A6FC',
        '#6f83a5', '#ADFF2F', '#7FFFAA', '#76a871', '#6495ED', '#a56f8f', '#20A6FC',
        '#6f83a5', '#ADFF2F', '#7FFFAA', '#76a871', '#6495ED', '#a56f8f', '#20A6FC',
        '#6f83a5', '#ADFF2F', '#7FFFAA', '#76a871', '#6495ED', '#a56f8f', '#20A6FC'
    ];//移动端报表色彩
</script>
</body>
</html>