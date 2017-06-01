<!doctype html>
<#assign ctx = request.contextPath>
<html>
<head>
    <meta charset="UTF-8">
    <title>收货地址</title>
    <script src="${ctx}/static/admin/js/Validform_v5.3.2_min.js?v=0120"></script>
</head>
<body>
<#include "include/header.ftl"/>
<div id="page">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>会员中心<span><em>_</em>收货地址</span></h3></div>
            <h3 class="title"><#if userReceiveAddressManage?has_content>修改<#else>新增</#if>收货地址</h3>
            <form id="editAddressForm" name="editAddressForm" action="${ctx}/account/userAddress/updateAddress"
                  method="post">
                <input type="hidden" id="addrId" name="addrId" value="${(userReceiveAddressManage.addrId)!}"/>
                <div class="mcbox">
                    <ul class="formlist form-address">
                        <li>
                            <div class="form-hd">收货人</div>
                            <div class="form-bd">
                                <input type="text" value="${(userReceiveAddressManage.receiverName)!}"
                                       class="textfield" id="receiverName" name="receiverName" nullmsg="收货人不能为空！"
                                       datatype="*1-50" errormsg="收货人不能为空,最多50个字符！"><span class="required">*</span>
                            </div>
                        </li>
                        <li>
                            <div class="form-hd">所在地区</div>
                            <div class="form-bd">
                                <select name="receiverProvinceId" id="receiverProvinceId" datatype="n" errormsg="请选择！">
                                </select>
                                <select name="receiverCityId" id="receiverCityId" datatype="n" errormsg="请选择！">
                                    <option value="">选择城市</option>
                                </select>
                                <select name="receiverCountyId" id="receiverCountyId" datatype="n" errormsg="请选择！">
                                    <option value="">选择县/区</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <div class="form-hd auto">街道地址</div>
                            <div class="form-bd">
                                    <textarea id="receiverAddr" name="receiverAddr" nullmsg="街道地址不能为空！"
                                              datatype="*1-255"
                                              errormsg="街道地址不能为空,最多255个字符！">${(userReceiveAddressManage.receiverAddr)!}</textarea><span
                                    class="required">*</span>
                                <span class="text-grey">不需要重复填写省/市/区</span>
                            </div>
                        </li>
                        <li>
                            <div class="form-hd">手机号码</div>
                            <div class="form-bd">
                                <input type="text" value="${(userReceiveAddressManage.receiverTel)!}"
                                       class="textfield" id="receiverTel" name="receiverTel" datatype="m"
                                       maxlength="11" nullmsg="手机不能为空！"><span class="required">*</span>
                            </div>
                        </li>
                        <li>
                            <div class="form-bd">
                                <input id="isDefalut" name="isDefault"
                                       type="checkbox" <#if userReceiveAddressManage?? && userReceiveAddressManage?has_content><#if userReceiveAddressManage.isDefaultAddr==1>checked="true"</#if></#if>>
                                <label for="setdefault">设为默认</label>
                            </div>
                        </li>
                        <li>
                            <div class="form-btnbar"><a href="javascript:void(0)" class="btn-action"
                                                        id="saveBtn">保存</a></div>
                        </li>
                    </ul>
                </div>
            </form>
            <br>
        <#if userReceiveAddressManageList?has_content>
            <h3 class="title">已有地址管理</h3>
            <table class="orderdatatb">
                <tbody>
                <tr>
                    <th style="width: 50px;">收货人</th>
                    <th style="width: 120px;">所在地区</th>
                    <th>街道地址</th>
                    <th style="width: 90px;">联系方式</th>
                    <th style="width: 50px;"></th>
                    <th style="width: 70px;">操作</th>
                </tr>
                <#list userReceiveAddressManageList as userReceiveAddressManage>
                    <tr>
                        <td>${userReceiveAddressManage.receiverName!?html}</td>
                        <td>${userReceiveAddressManage.receiverProvinceName!?html} ${userReceiveAddressManage.receiverCityName!?html} ${userReceiveAddressManage.countyName!?html}</td>
                        <td>${userReceiveAddressManage.receiverAddr!?html}</td>
                        <td>${userReceiveAddressManage.receiverTel!?html}</td>
                        <#if userReceiveAddressManage.isDefaultAddr==0>
                            <td>
                                <a href="${ctx}/account/userAddress/setDefaultAddress?addressId=${userReceiveAddressManage.addrId!?html}">设为默认</a>
                            </td>
                        <#else>
                            <td>默认地址</td>
                        </#if>
                        <td>
                            <a href="${ctx}/account/userAddress?addressId=${userReceiveAddressManage.addrId!?html}">修改</a> |
                            <a href="${ctx}/account/userAddress/deleteAddress?addressId=${userReceiveAddressManage.addrId!?html}">删除</a>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>
        </div>
    </div>
</div>
<#include "include/addrSelect.ftl"/>
<script>
    $(function () {
        $("#menu_myAddress").addClass("current");
    <#if operateMessage?has_content>
        layer.msg("${operateMessage!}");
    </#if>
        $("#editAddressForm").Validform();

     $("#saveBtn").click(function(){
         $.post("${ctx}/account/userAddress/u"选择县/区"pdateAddress",{},function(data){
             if(data.result == "success");
             location.href="${ctx}/account/userAddress"
         })
     })

        addChangeEven("receiverProvinceId",["receiverCountyId"],["选择县/区"],"receiverCityId","选择城市");
        addChangeEven("receiverCityId",[],[],"receiverCountyId","选择县/区");
        findChildByParentId("receiverProvinceId", 0, "选择省");
    <#if userReceiveAddressManage?? && userReceiveAddressManage?has_content>
        findChildByParentId("receiverCityId", ${userReceiveAddressManage.receiverProvinceId!}, "选择城市");
        $("#receiverProvinceId").val("${userReceiveAddressManage.receiverProvinceId!}");
        findChildByParentId("receiverCountyId", ${userReceiveAddressManage.receiverCityId!}, "选择县/区");
        $("#receiverCityId").val("${userReceiveAddressManage.receiverCityId!}");
        $("#receiverCountyId").val("${userReceiveAddressManage.receiverCountyId!}");
    </#if>
    });

</script>
	
</body>
</html>