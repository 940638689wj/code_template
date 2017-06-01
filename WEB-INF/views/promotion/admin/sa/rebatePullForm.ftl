<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>

    <script type="text/javascript" src="${ctx}/static/admin/js/validator.js?t=20140611"></script>
</head>
<body>
<div class="container">

    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">分销业绩点</span></li>
        </ul>
    </div>

    <div class="round-title bui-clear">
        <h2><span class="titlecircle">1</span>基础业绩点</h2>
        <div class="pull-left offset1 auxiliary-text">
            需单独设置某款商品的基础业绩点 <a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">请点击></a>
        </div>
    </div>
    <div>
        <div style="padding-left: 48px; width: 760px;">
            <label>
                <input type="radio" name="currentDefaultRebatePull" value="default_rebate_pull"
                <#if currentUseDefaultRebatePull?? && currentUseDefaultRebatePull=="default_rebate_pull">
                       checked="checked"</#if>/>&nbsp;&nbsp;
                <input class="input-small control-text" type="text" onblur="onbl(this)" name="defaultRebatePull"
                       id="defaultRebatePull"
                       value="<#if defaultRebatePull?? && defaultRebatePull?has_content>${defaultRebatePull?string("0.##")}</#if>"/>业绩点
            </label>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <label>
                <input type="radio" name="currentDefaultRebatePull" value="default_rebate_pull_percent"
                <#if currentUseDefaultRebatePull?? && currentUseDefaultRebatePull=="default_rebate_pull_percent">
                       checked="checked"</#if>/>&nbsp;&nbsp;
                商品金额 &nbsp;*&nbsp;
                <input class="input-small control-text" type="text" onblur="onbl(this)" name="defaultRebatePullPercent"
                       id="defaultRebatePullPercent"
                       value="<#if defaultRebatePullPerCent?? && defaultRebatePullPerCent?has_content>${((defaultRebatePullPerCent)*100)?string("0.##")}</#if>"/>%
            </label>
        </div>
        <br/>
        <div style="padding-left: 24px; width: 760px;">
            <label>
            </label>
        </div>
    </div>
    <hr/>

    <div class="round-title bui-clear">
        <h2><span class="titlecircle">2</span>业绩点分配比例</h2>
        <br>
        <div class="pull-left offset1 auxiliary-text">

        </div>
    </div>

    <div id="rebatePullLevelLabelPanel">
        <div style="padding-left: 48px; width: 760px;">
            <h2 class="round-title auxiliary-text">
                <input type="radio" name="rebatePullLevel" id="rdo_2" value="2"
                       <#if levelValue?? && levelValue?string=="2">checked="checked"</#if>/>&nbsp;&nbsp;
                <label for="rdo_2">模式一　两级分配</label>
            </h2>
            <div class="panel" id="pannel2"
                 style="<#if levelValue?? && levelValue?string=='2'><#else>display:none;</#if>margin-left: 20px;">
                <div class="panel-body">
                    <div class="row">
                        <div class="span7">
                            <img src="${staticPath}/admin/images/zhucefanli_1.png" alt=""/>
                        </div>
                        <div class="span9" style="font-size: 14px; padding-top: 20px;">
                            <div class="form-horizontal">
                                <div class="control-group">
                                    <div class="controls">
                                        购买者上级业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel2RebalPull2" id="pannel2RebalPull2" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel2?? && rebatePullLevel2?has_content>${((rebatePullLevel2)*100)?string("0.##")}</#if>">&nbsp; %
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        购买者本身业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel2RebalPull1" id="pannel2RebalPull1" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel1?? && rebatePullLevel1?has_content>${((rebatePullLevel1)*100)?string("0.##")}</#if>">&nbsp;%
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls" style="float:right; margin-right: 42px;">
                                        <span class="auxiliary-text">推广业绩百分百总和 <= 100%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <br/>

        <div style="padding-left: 48px; width: 760px;">
            <h2 class="round-title auxiliary-text">
                <input type="radio" name="rebatePullLevel" id="rdo_3" value="3"
                       <#if levelValue?? && levelValue?string=="3">checked="checked"</#if>/>&nbsp;&nbsp;
                <label for="rdo_3">模式二　三级分配</label>
            </h2>
            <div class="panel" id="pannel3"
                 style="<#if levelValue?? && levelValue?string=='3'><#else>display:none;</#if>margin-left: 20px;">
                <div class="panel-body">
                    <div class="row">
                        <div class="span7">
                            <img src="${staticPath}/admin/images/zhucefanli_2.png" alt=""/>
                        </div>
                        <div class="span9" style="font-size: 14px; padding-top: 20px;">
                            <div class="form-horizontal">
                                <div class="control-group">
                                    <div class="controls">
                                        购买者上上级业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel3RebalPull3" id="pannel3RebalPull3" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel3?? && rebatePullLevel3?has_content>${((rebatePullLevel3)*100)?string("0.##")}</#if>">%
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        购买者上级业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel3RebalPull2" id="pannel3RebalPull2" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel2?? && rebatePullLevel2?has_content>${((rebatePullLevel2)*100)?string("0.##")}</#if>">&nbsp; %
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        购买者本身业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel3RebalPull1" id="pannel3RebalPull1" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel1?? && rebatePullLevel1?has_content>${((rebatePullLevel1)*100)?string("0.##")}</#if>">&nbsp; %
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls" style="float:right; margin-right: 42px;">
                                        <span class="auxiliary-text">推广业绩百分百总和 <= 100%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <br/>

        <div style="padding-left: 48px; width: 760px;">
            <h2 class="round-title auxiliary-text">
                <input type="radio" name="rebatePullLevel" id="rdo_4" value="4"
                       <#if levelValue?? && levelValue?string=="4">checked="checked"</#if>/>&nbsp;&nbsp;
                <label for="rdo_4">模式三　四级分配</label>
            </h2>
            <div class="panel" id="pannel4"
                 style="<#if levelValue?? && levelValue?string=='4'><#else>display:none;</#if>margin-left: 20px;">
                <div class="panel-body">
                    <div class="row">
                        <div class="span7">
                            <img src="${staticPath}/admin/images/zhucefanli_3.png" alt=""/>
                        </div>
                        <div class="span9" style="font-size: 14px; padding-top: 20px;">
                            <div class="form-horizontal" style="width: 500px;">
                                <div class="control-group">
                                    <div class="controls">
                                        购买者上上上级业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel4RebalPull4" id="pannel4RebalPull4" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel4?? && rebatePullLevel4?has_content>${((rebatePullLevel4)*100)?string("0.##")}</#if>">&nbsp;%
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        购买者上上级业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel4RebalPull3" id="pannel4RebalPull3" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel3?? && rebatePullLevel3?has_content>${((rebatePullLevel3)*100)?string("0.##")}</#if>">&nbsp;%
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        购买者上级业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel4RebalPull2" id="pannel4RebalPull2" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel2?? && rebatePullLevel2?has_content>${((rebatePullLevel2)*100)?string("0.##")}</#if>">&nbsp;%
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        购买者本身业绩 = 基础业绩点 * &nbsp;
                                        <input name="pannel4RebalPull1" id="pannel4RebalPull1" type="text"
                                               class="input-small control-text"
                                               value="<#if rebatePullLevel1?? && rebatePullLevel1?has_content>${((rebatePullLevel1)*100)?string("0.##")}</#if>">&nbsp;%
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls" style="float:right; margin-right: 150px;">
                                        <span class="auxiliary-text">推广业绩百分百总和 <= 100%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row actions-bar">
        <div class="form-actions">
            <button type="submit" id="save" onclick="saveRebatePull();" class="button button-primary">保存</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        //分利选择
        if ($("input[name='currentDefaultRebatePull']:checked").val() == "default_rebate_pull") {
            $("#defaultRebatePullPercent").val("");
            $("#defaultRebatePull").attr('disabled', false);
            $("#defaultRebatePullPercent").attr('disabled', true);
            nextPrice();
        } else {
            $("#defaultRebatePull").val("");
            $("#defaultRebatePull").attr('disabled', true);
            $("#defaultRebatePullPercent").attr('disabled', false);
            nextPrice();
        }

        $("#rebatePullLevelLabelPanel").on('change', 'input[name="rebatePullLevel"]', function () {
            $('.panel').hide();

            var $curLab = $(this);
            var levelValue = $curLab.val();

            if (levelValue == "2") {
                $("#pannel2").show();
            } else if (levelValue == "3") {
                $("#pannel3").show();
            } else if (levelValue == "4") {
                $("#pannel4").show();
            }
        });
    });

    function saveRebatePull() {
        //商品注册推广费 业绩分配使用哪种方式
        var rebatePullValue;
        var currentUseDefaultRebatePull = "";
        $("input[name='currentDefaultRebatePull']:checked").each(function () {
            currentUseDefaultRebatePull = $(this).val();
            return false;
        });

        if (currentUseDefaultRebatePull == "default_rebate_pull") {
            rebatePullValue = $("#defaultRebatePull").val();
            if (!validData(rebatePullValue, '每款商品注册推广费')) {
                return false;
            }
        } else if (currentUseDefaultRebatePull == "default_rebate_pull_percent") {
            rebatePullValue = $("#defaultRebatePullPercent").val();
            if (!validData(rebatePullValue, '每款商品注册推广费业绩百分比')) {
                return false;
            }
        }

        var $selected;
        $("input[name='rebatePullLevel']").each(function () {
            if ($(this).attr('checked')) {
                $selected = $(this);
                return false;
            }
        });

        if (typeof $selected === 'undefined' || $selected.val() == "") {
            BUI.Message.Alert("请选择业绩分配层级!");
            return false;
        }

        var rebatePullLevel1;
        var rebatePullLevel2;
        var rebatePullLevel3;
        var rebatePullLevel4;

        var levelValue = $selected.val();

        if (levelValue == "2") {
            rebatePullLevel1 = $("#pannel" + levelValue + "RebalPull1").val();
            rebatePullLevel2 = $("#pannel" + levelValue + "RebalPull2").val();

            if (!validData(rebatePullLevel1, '第一级的业绩比例') || !validData(rebatePullLevel2, '第二级的业绩比例')) {
                return false;
            }
        } else if (levelValue == "3") {
            rebatePullLevel1 = $("#pannel" + levelValue + "RebalPull1").val();
            rebatePullLevel2 = $("#pannel" + levelValue + "RebalPull2").val();
            rebatePullLevel3 = $("#pannel" + levelValue + "RebalPull3").val();

            if (!validData(rebatePullLevel1, '第一级的业绩比例') || !validData(rebatePullLevel2, '第二级的业绩比例') || !validData(rebatePullLevel3, '第三级的业绩比例')) {
                return false;
            }
        } else if (levelValue == "4") {
            rebatePullLevel1 = $("#pannel" + levelValue + "RebalPull1").val();
            rebatePullLevel2 = $("#pannel" + levelValue + "RebalPull2").val();
            rebatePullLevel3 = $("#pannel" + levelValue + "RebalPull3").val();
            rebatePullLevel4 = $("#pannel" + levelValue + "RebalPull4").val();

            if (!validData(rebatePullLevel1, '第一级的业绩比例') || !validData(rebatePullLevel2, '第二级的业绩比例') || !validData(rebatePullLevel3, '第三级的业绩比例') || !validData(rebatePullLevel4, '第四级的业绩比例')) {
                return false;
            }
        }

        $("#save").attr('disabled',true);
        app.ajax("${ctx}/admin/sa/distributionRule/save/developDistributors", {
            levelValue: levelValue,
            rebatePullLevel1: rebatePullLevel1, rebatePullLevel2: rebatePullLevel2,
            rebatePullLevel3: rebatePullLevel3, rebatePullLevel4: rebatePullLevel4,
            currentUseDefaultRebatePull: currentUseDefaultRebatePull,
            rebatePullValue: rebatePullValue
        }, function (data) {
            if (app.ajaxHelper.handleAjaxMsg(data)) {
                app.showSuccess("保存成功!");
            }
            setTimeout("remainTime()", 1000);
        })
    }

    function remainTime(){
        $("#save").attr('disabled',false);
    }

    function validData(rebateRatioVal, msg) {
        return true;
    }
    function nextPrice() {
        $("input[type='radio'][name='currentDefaultRebatePull']").change(function () {
            if ($(this).val() == "default_rebate_pull") {
                $("#defaultRebatePull").attr('disabled', false);
                $("#defaultRebatePullPercent").val("");
                $("#defaultRebatePullPercent").attr('disabled', true);
            } else {
                $("#defaultRebatePull").val("");
                $("#defaultRebatePull").attr('disabled', true);
                $("#defaultRebatePullPercent").attr('disabled', false);
            }
        })

    }
    function onbl(tid) {
        var td = $(tid).val();
        if (td == null || td == "") {//为空判断
            return;
        }
        var reg = /^\d+(\.{0,1}\d+){0,1}$/;   ///^\+?[1-9]\d*$/;
        if (!reg.test(td)) {
            BUI.Message.Alert("输入值不合法!");
            $(tid).val("");
            return;
        }

    }

</script>
</body>
</html>