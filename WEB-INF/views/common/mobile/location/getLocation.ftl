<!doctype html>
<html lang="en">
<head>
    <title>选择收货地址</title>

    <#assign ctx = request.contextPath>

    <meta charset="UTF-8">
    <title>${newTitle!}</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-title" content="${siteName!}"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telephone=no"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/global.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mobile.css"/>

    <script type="text/javascript" src="${ctx}/static/mobile/js/zepto.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mobile.js"></script>

</head>
<body>
<div id="page">
    <!--遮罩层-->
    <div class="show-abnormal-bg mui-active"></div><!--remove这个mui-active遮罩层就隐藏-->

    <!--确认 选择的收货地址-->
    <div id="confirmAddressDiv" class="mui-abnormal"><!--remove这个mui-popup-in整体就隐藏-->
        <div class="service">
            <div class="info">
                <P>选择地址后下单时将无法修改收货地址，是否确认？</P>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" onclick="confirmUseAddress();">确定</a>
                <#if targetAddress?? && targetAddress?has_content>
                    <a href="javascript:void(0);" id="goToSelectOldAddressDivFromConfirmAddressDiv" onclick="goToSelectOldAddressDivFromConfirmAddressDiv();">取消</a>
                    <a href="javascript:void(0);" id="goToSelectHistoryAddressDivFromConfirmAddressDiv" onclick="goToSelectHistoryAddressDivFromConfirmAddressDiv();">取消</a>
                <#else>
                    <a href="javascript:void(0);" onclick="goToNewAddressDiv();">取消</a>
                </#if>
            </div>
        </div>
    </div>

    <!--新增 收货地址开始-->
    <div id="newAddressDiv" class="mui-abnormal mui-popup-in"><!--remove这个mui-popup-in整体就隐藏-->
        <div class="ordercancel">
            <form id="selectAddressForm">
                <div class="info">
                    <h3>请选择收货地址：</h3>
                    <div class="selectbox">
                        <select id="selectCountyId" name="selectCountyId">
                            <option value="">-- 区/县 --</option>
                            <#if countyList?? && countyList?has_content>
                                <#list countyList as county>
                                    <option value="${county.id}">${(county.areaName)!}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>

                    <div class="selectbox">
                        <select id="selectTownId" name="selectTownId">
                            <option value="">-- 街道/镇 --</option>
                        </select>
                    </div>

                    <div class="selectbox">
                        <select id="selectVillageId" name="selectVillageId">
                            <option value="">-- 社区/村 --</option>
                        </select>
                    </div>

                    <div class="inputbox">
                        <input type="text" id="addressDetail" placeholder="输入详细地址">
                    </div>
                </div>
                <div class="refundbtn">
                    <a href="javascript:void(0);" onclick="confirmAddress();">确定</a>
                    <#if targetAddress?? && targetAddress?has_content>
                        <a href="javascript:void(0);" onclick="goToSelectOldAddressDivFromNewAddressDiv();">取消</a>
                    <#else>
                        <a href="javascript:void(0);" onclick="resetSelectAddressForm();">重置</a>
                    </#if>
                </div>
            </form>
        </div>
    </div>
    <!--请选择收货地址结束-->


    <!--是否使用历史地址开始-->
    <div id="selectOldAddressDiv" class="mui-abnormal">
        <div class="service">
            <div class="info">
                <h3>是否使用以下收货地址：</h3>
                <#if targetAddress?? && targetAddress?has_content>
                    <P>${AREA_TEMPLATE('${(targetAddress.receiverCountyId)!}')} ${AREA_TEMPLATE('${(targetAddress.receiveTownId)!}')} ${AREA_TEMPLATE('${(targetAddress.receiveVillageId)!}')}</P>
                </#if>
                <p>${(targetAddress.receiverAddr)!?html}</p>
                <div class="servicetell">
                    <#if addressList?? && addressList?has_content && addressList?size gt 1>
                        <p><a href="javascript:void(0);" class="orange" onclick="goToSelectHistoryAddressDiv();">选择历史收货地址 >></a></p>
                    </#if>

                    <p><a href="javascript:void(0);" onclick="newAddressDiv();" class="orange">新增收货地址 >></a></p>
                </div>
            </div>

            <div class="refundbtn">
                <a href="javascript:void(0);" onclick="confirmOldAddress();">确定</a>
                <#--<a href="javascript:void(0);">取消</a>-->
            </div>
        </div>
    </div>

    <!--历史地址列表-->
    <div id="historyAddressDiv" class="mui-abnormal">
        <div class="history_address">
            <h3>选择以下历史收货地址：</h3>
            <div class="spec-list-wrap">
                <ul class="tbviewlist paytypes">
                    <#if addressList?? && addressList?has_content && addressList?size gt 1>
                        <#list addressList as address>
                            <li>
                                <label>
                                    <input type="radio" data-id="${address.addrId}"
                                           data-countyId="${(address.receiverCountyId)!}"
                                           data-townId="${(address.receiveTownId)!}"
                                           data-villageId="${(address.receiveVillageId)!}"
                                           data-receiverAddr="${(address.receiverAddr)!}"
                                           name="historyAddress">
                                    <div class="c">
                                        <p>${AREA_TEMPLATE('${(address.receiverCountyId)!}')} ${AREA_TEMPLATE('${(address.receiveTownId)!}')} ${AREA_TEMPLATE('${(address.receiveVillageId)!}')}</p>
                                        <p>${(address.receiverAddr)!?html}</p>
                                    </div>
                                </label>
                            </li>
                        </#list>
                    </#if>
                </ul>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" onclick="confirmUseHistoryAddress();">确定</a>
                <a href="javascript:void(0);" onclick="goToSelectOldAddressDivFromHistoryAddressDiv();">取消</a>
            </div>
        </div>
    </div>

    <input type="hidden" id="confirmCountyId" value=""/>
    <input type="hidden" id="confirmTownId" value=""/>
    <input type="hidden" id="confirmVillageId" value=""/>
    <input type="hidden" id="confirmAddressDetail" value=""/>
</div>

<script>
    // mui.toast
    function goToSelectOldAddressDivFromHistoryAddressDiv(){
        $('#historyAddressDiv').removeClass('mui-active');
        $('#historyAddressDiv').removeClass('mui-popup-in');

        $('#selectOldAddressDiv').addClass('mui-active');
        $('#selectOldAddressDiv').addClass('mui-popup-in');
    }
    <#-- 选择历史收货地址 -->
    function goToSelectHistoryAddressDiv(){
        $('#selectOldAddressDiv').removeClass('mui-active');
        $('#selectOldAddressDiv').removeClass('mui-popup-in');

        $('#historyAddressDiv').addClass('mui-active');
        $('#historyAddressDiv').addClass('mui-popup-in');
    }
    function goToSelectHistoryAddressDivFromConfirmAddressDiv(){
        $('#confirmAddressDiv').removeClass('mui-active');
        $('#confirmAddressDiv').removeClass('mui-popup-in');

        $('#historyAddressDiv').addClass('mui-active');
        $('#historyAddressDiv').addClass('mui-popup-in');
    }


    function newAddressDiv(){
        $('#selectOldAddressDiv').removeClass('mui-active');
        $('#selectOldAddressDiv').removeClass('mui-popup-in');

        $('#newAddressDiv').addClass('mui-active');
        $('#newAddressDiv').addClass('mui-popup-in');
    }

    function goToSelectOldAddressDivFromConfirmAddressDiv(){
        $('#confirmAddressDiv').removeClass('mui-active');
        $('#confirmAddressDiv').removeClass('mui-popup-in');

        $('#selectOldAddressDiv').addClass('mui-active');
        $('#selectOldAddressDiv').addClass('mui-popup-in');
    }

    function goToSelectOldAddressDivFromNewAddressDiv(){
        $('#newAddressDiv').removeClass('mui-active');
        $('#newAddressDiv').removeClass('mui-popup-in');

        $('#selectOldAddressDiv').addClass('mui-active');
        $('#selectOldAddressDiv').addClass('mui-popup-in');
    }

    function confirmUseAddress(){
        var selectCountyId = $('#confirmCountyId').val();
        var selectTownId = $('#confirmTownId').val();
        var selectVillageId = $('#confirmVillageId').val();
        var addressDetail = $('#confirmAddressDetail').val();

        // 8号楼第五大道
        window.location.href="${ctx}/m/getLocation/confirmAddress?successUrl=${successUrl!}"
        +"&selectCountyId="+selectCountyId
        +"&selectTownId="+selectTownId
        +"&selectVillageId="+selectVillageId
        +"&addressDetail="+addressDetail;
    }

    function goToNewAddressDiv(){
        $('#confirmAddressDiv').removeClass('mui-active');
        $('#confirmAddressDiv').removeClass('mui-popup-in');

        $('#newAddressDiv').addClass('mui-active');
        $('#newAddressDiv').addClass('mui-popup-in');
    }

    function resetSelectAddressForm(){
        document.getElementById("selectAddressForm").reset();
        cleanSelectContent("selectTownId", "-- 街道/镇 --");
        cleanSelectContent("selectVillageId", "-- 社区/村 --");
    }

    function confirmUseHistoryAddress(){
        if($("input[name='historyAddress']").filter(":checked").length == 0){
            mui.toast("请选择一个收货地址!");
            return ;
        }

        var obj = $($("input[name='historyAddress']").filter(":checked").get(0));

        /*console.log(obj.attr('data-countyId'))
        console.log(obj.attr('data-townId'))
        console.log(obj.attr('data-villageId'))
        console.log(obj.attr('data-receiverAddr'))*/
        var receiverCountyId = obj.attr('data-countyId');
        var receiveTownId = obj.attr('data-townId');
        var receiveVillageId = obj.attr('data-villageId');
        var receiverAddr = obj.attr('data-receiverAddr');

        $('#confirmCountyId').val(receiverCountyId);
        $('#confirmTownId').val(receiveTownId);
        $('#confirmVillageId').val(receiveVillageId);
        $('#confirmAddressDetail').val(receiverAddr);

        $('#historyAddressDiv').removeClass('mui-active');
        $('#historyAddressDiv').removeClass('mui-popup-in');

        $('#confirmAddressDiv').addClass('mui-active');
        $('#confirmAddressDiv').addClass('mui-popup-in');

        $('#goToSelectHistoryAddressDivFromConfirmAddressDiv').show();
        $('#goToSelectOldAddressDivFromConfirmAddressDiv').hide();
    }

    function confirmOldAddress(){
        $('#goToSelectOldAddressDivFromConfirmAddressDiv').show();
        $('#goToSelectHistoryAddressDivFromConfirmAddressDiv').hide();

        $('#confirmCountyId').val(${(targetAddress.receiverCountyId)!});
        $('#confirmTownId').val(${(targetAddress.receiveTownId)!});
        $('#confirmVillageId').val(${(targetAddress.receiveVillageId)!});
        $('#confirmAddressDetail').val('${(targetAddress.receiverAddr)!?html}');


        $('#selectOldAddressDiv').removeClass('mui-active');
        $('#selectOldAddressDiv').removeClass('mui-popup-in');

        $('#confirmAddressDiv').addClass('mui-active');
        $('#confirmAddressDiv').addClass('mui-popup-in');
    }

    function confirmAddress(){
        var selectCountyId = $('#selectCountyId').val();
        //console.log(selectCountyId);
        if(!selectCountyId || selectCountyId == ""){
            mui.toast("请选择区/县!");
            return ;
        }

        var selectTownId = $('#selectTownId').val();
        //console.log(selectTownId);
        if(!selectTownId || selectTownId == ""){
            mui.toast("请选择街道/镇!");
            return ;
        }

        var selectVillageId = $('#selectVillageId').val();
        //console.log(selectVillageId);
        if(!selectVillageId || selectVillageId == ""){
            mui.toast("请选择社区/村!");
            return ;
        }

        var addressDetail = $('#addressDetail').val();
        if(!addressDetail || $.trim(addressDetail) == ""){
            mui.toast("请输入详细地址!");
            return ;
        }
        if(addressDetail.length > 20){
            mui.toast("详细地址不能超过20个字符!");
            $('#addressDetail').focus();
            return ;
        }

        $('#confirmCountyId').val(selectCountyId);
        $('#confirmTownId').val(selectTownId);
        $('#confirmVillageId').val(selectVillageId);
        $('#confirmAddressDetail').val(addressDetail);


        $('#newAddressDiv').removeClass('mui-active');
        $('#newAddressDiv').removeClass('mui-popup-in');

        $('#confirmAddressDiv').addClass('mui-active');
        $('#confirmAddressDiv').addClass('mui-popup-in');

        $('#goToSelectOldAddressDivFromConfirmAddressDiv').show();
        $('#goToSelectHistoryAddressDivFromConfirmAddressDiv').hide();
    }

    $(function(){
        <#if errorMsg?? && errorMsg?has_content>
            mui.toast('${errorMsg}');
        </#if>

        <#if targetAddress?? && targetAddress?has_content>
            // 选择旧的收货地址
            goToSelectOldAddressDivFromNewAddressDiv();
        </#if>

        disabledSelect();

       $('#selectCountyId').on('change', function(){

           $('#selectTownId').removeAttr('disabled');

           var selectCounty = $(this).val();
           if(selectCounty && selectCounty != ""){
               $.ajax({
                   url : '${ctx}/common/area/findChildByParentId',
                   dataType : 'json',
                   type: 'GET',
                   data : {parentId: selectCounty},
                   success : function(data){
                       if(data.rowCount && data.rowCount >0){
                           cleanSelectContent("selectTownId", "-- 街道/镇 --");
                           cleanSelectContent("selectVillageId", "-- 社区/村 --");

                           $.each(data.rows, function(i, row){
                               $("#selectTownId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                           });
                       }else{
                           cleanSelectContent("selectTownId", "-- 街道/镇 --");
                           cleanSelectContent("selectVillageId", "-- 社区/村 --");
                       }
                   }
               });
           }else{
               $('#selectTownId').empty();
               cleanSelectContent("selectTownId", "-- 街道/镇 --");
               cleanSelectContent("selectVillageId", "-- 社区/村 --");
               disabledSelect();
           }
       });

        $('#selectTownId').on('change', function(){
            $('#selectVillageId').removeAttr('disabled');

            var selectTownId = $(this).val();
            if(selectTownId && selectTownId != ""){
                $.ajax({
                    url : '${ctx}/common/area/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectTownId},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectVillageId", "-- 社区/村 --");

                            $.each(data.rows, function(i, row){
                                $("#selectVillageId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectVillageId", "-- 社区/村 --");
                        }
                    }
                });
            }else{
                $('#selectVillageId').empty();
                cleanSelectContent("selectVillageId", "-- 社区/村 --");
                $('#selectVillageId').attr('disabled', true);
            }
        })
    });

    function disabledSelect(){
        $('#selectTownId').attr('disabled', true);
        $('#selectVillageId').attr('disabled', true);
    }

    function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    }

</script>
</body>
</html>