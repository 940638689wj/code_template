<!doctype html>
<#assign ctx = request.contextPath>
<html>
<head>
    <meta charset="UTF-8">
    <title>收货地址</title>
    <script src="${ctx}/static/admin/js/Validform_v5.3.2_min.js?v=0120"></script>
</head>
<body class="page-login">
<div :controller="app" class="ms_controller">
<#include "include/header.ftl"/>
<div id="page">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>会员中心<span><em>_</em>收货地址</span></h3></div>
            <h3 class="title" :visible="@addrId =='' ">新增收货地址</h3>
            <h3 class="title" :visible="@addrId !='' ">修改收货地址</h3>
            <form id="editAddressForm" name="editAddressForm" action="${ctx}/account/userAddress/updateAddress"
                  method="post">
                <input type="hidden" id="addrId" name="addrId" ms-duplex="@addrId"/>
                <div class="mcbox">
                    <ul class="formlist form-address">
                        <li>
                            <div class="form-hd">收货人</div>
                            <div class="form-bd">
                                <input type="text" ms-duplex="@receiverName"
                                       class="textfield" id="receiverName" name="receiverName" >
                            </div>
                        </li>
                        <li>
                            <div class="form-hd">所在地区</div>
                            <div class="form-bd">
                                <select ms-duplex="@receiverProvinceId" name="receiverProvinceId" id="receiverProvinceId" >
                                </select>
                                <select ms-duplex="@receiverCityId" name="receiverCityId" id="receiverCityId" >
                                    <option value="">选择城市</option>
                                </select>
                                <select ms-duplex="@receiverCountyId" name="receiverCountyId" id="receiverCountyId" >
                                    <option value="">选择县/区</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <div class="form-hd auto">街道地址</div>
                            <div class="form-bd">
                                    <textarea ms-duplex="@receiverAddr" id="receiverAddr" name="receiverAddr"
                                              ></textarea>
                                <span class="text-grey">不需要重复填写省/市/区</span>
                            </div>
                        </li>
                        <li>
                            <div class="form-hd">手机号码</div>
                            <div class="form-bd">
                                <input type="text" ms-duplex="receiverTel"
                                       class="textfield" id="receiverTel" name="receiverTel"
                                       >
                            </div>
                        </li>
                        <li>
                            <div class="form-bd">
                                <input id="isDefault" name="isDefault"
                                       type="checkbox" ms-duplex-checked="@isDefault">
                                <label for="setdefault">设为默认</label>
                            </div>
                        </li>
                        <li>
                            <div class="form-btnbar"><a href="javascript:void(0)" :click="@saveForm" class="btn-action"
                                                        id="saveBtn">保存</a></div>
                        </li>
                    </ul>
                </div>
            </form>
            <br>


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

                    <tr :for="userReceiveAddressManage in @userReceiveAddressManageList">
                        <td>{{userReceiveAddressManage.receiverName}}</td>
                        <td>{{userReceiveAddressManage.receiverProvinceName}} {{userReceiveAddressManage.receiverCityName}} {{userReceiveAddressManage.countyName}}</td>
                        <td>{{userReceiveAddressManage.receiverAddr}}</td>
                        <td>{{userReceiveAddressManage.receiverTel}}</td>

                            <td :visible="userReceiveAddressManage.isDefaultAddr==0">
                                <a href="javascript:void(0)" :click="@setDefault(userReceiveAddressManage.addrId)">设为默认</a>
                            </td>

                            <td :visible="userReceiveAddressManage.isDefaultAddr!=0">默认地址</td>

                        <td>
                            <a href="javascript:void(0)" :click="@modify(userReceiveAddressManage.addrId)">修改</a> |
                            <a href="javascript:void(0)" :click="@delete(userReceiveAddressManage.addrId)" >删除</a>
                        </td>
                    </tr>

                </tbody>
            </table>

        </div>
    </div>
</div>
</div>
<#include "include/addrSelect.ftl"/>
<script>
    $(function () {
        $("#menu_myAddress").addClass("current");
    <#--
    <#if operateMessage?has_content>
        layer.msg("${operateMessage!}");
    </#if>
        $("#editAddressForm").Validform();

        $("#saveBtn").click(function(){
            $.post("${ctx}/account/userAddress/updateAddress",{},function(data){
                if(data.result == "success");
                location.href="${ctx}/account/userAddress"
            })
        })
        -->
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

    var vm = avalon.define({
        $id: 'app',
        addrId: '',
        receiverName:'',
        receiverProvinceId: '',
        receiverCityId: '',
        receiverCountyId: '',
        receiverAddr: '',
        receiverTel: '',
        isDefault: false,
        userReceiveAddressManageList: [],
        saveForm: function(){
            console.log(vm.receiverProvinceId);
            console.log(vm.isDefault);
            if(vm.receiverName == ""){
                layer.msg("请输入收货人姓名！");
                return false;
            } else if(vm.receiverName.length > 50){
                layer.msg("收货人姓名不能超过50！");
                return false;
            }
            if(vm.receiverProvinceId == ""){
                layer.msg("请选择省份!");
                return false;
            }
            if(vm.receiverCityId == ""){
                layer.msg("请选择城市!");
                return false;
            }
            if(vm.receiverCountyId == ""){
                layer.msg("请选择县区!");
                return false;
            }
            if(vm.receiverAddr == ""){
                layer.msg("街道地址不能为空！");
                return false;
            }else if(vm.receiverAddr.length>255){
                layer.msg("街道地址不能超过255");
                return false;
            }
            if(!checkTelephone(vm.receiverTel)){
                return false;
            }
            $.post("${ctx}/account/userAddress/updateAddress",{
                addrId: vm.addrId,
                receiverName:vm.receiverName,
                receiverProvinceId: vm.receiverProvinceId,
                receiverCityId: vm.receiverCityId,
                receiverCountyId: vm.receiverCountyId,
                receiverAddr: vm.receiverAddr,
                receiverTel: vm.receiverTel,
                isDefault: vm.isDefault
            },function(data){

                if(data.result =="success"){
                    layer.msg("保存成功！");
                    location.reload();
                }else{
                    layer.msg(data.message)
                }
            })
        },
        loadReceiveAddressList: function(){
            $.get("${ctx}/account/userAddress/findReceiveAddressList",{},function(data){
                vm.userReceiveAddressManageList = data.userReceiveAddressManageList;
            })
        },
        delete: function(addressId){
            layer.confirm("是否删除地址？",function(){
                $.post("${ctx}/account/userAddress/deleteAddress",{addressId:addressId},function(data){
                    if(data.result=="success"){
                        layer.msg("删除成功!");
                        vm.loadReceiveAddressList();
                    }else{
                        layer.msg(data.message);
                    }
                });
            })

        },
        modify: function(addressId){
            $.post("${ctx}/account/userAddress/modifyReceiveAddress",{addressId:addressId},function(data){
                if(data){
                    vm.addrId = data.userReceiveAddressManage.addrId;
                    vm.receiverName = data.userReceiveAddressManage.receiverName;
                    <#--
                    findChildByParentId("receiverCityId", data.userReceiveAddressManage.receiverProvinceId, "选择城市");
                    vm.receiverProvinceId = data.userReceiveAddressManage.receiverProvinceId;

                    findChildByParentId("receiverCountyId", data.userReceiveAddressManage.receiverCityId,"选择县/区")
                    vm.receiverCityId = data.userReceiveAddressManage.receiverCityId;
                    vm.receiverCountyId = data.userReceiveAddressManage.receiverCountyId;
                    -->
                    findChildByParentId("receiverCityId",data.userReceiveAddressManage.receiverProvinceId , "选择城市");
                    $("#receiverProvinceId").val(data.userReceiveAddressManage.receiverProvinceId);
                    vm.receiverProvinceId = data.userReceiveAddressManage.receiverProvinceId;
                    findChildByParentId("receiverCountyId", data.userReceiveAddressManage.receiverCityId, "选择县/区");
                    $("#receiverCityId").val(data.userReceiveAddressManage.receiverCityId);
                    vm.receiverCityId = data.userReceiveAddressManage.receiverCityId
                    $("#receiverCountyId").val(data.userReceiveAddressManage.receiverCountyId);
                    vm.receiverCountyId = data.userReceiveAddressManage.receiverCountyId;

                    vm.receiverAddr = data.userReceiveAddressManage.receiverAddr;
                    vm.receiverTel = data.userReceiveAddressManage.receiverTel;
                    if(data.userReceiveAddressManage.isDefaultAddr == 1){
                        vm.isDefault = true;
                    }else{
                        vm.isDefault = false;
                    }
                    document.getElementsByTagName('body')[0].scrollTop = 0;
                }
            })
        },
        setDefault: function(addressId){
            $.post("${ctx}/account/userAddress/setDefaultAddress",{addressId:addressId},function(data){
                if(data.result =="success"){
                    layer.msg("默认地址设置成功！");
                    vm.loadReceiveAddressList();
                }else{
                    layer.msg(data.message);
                }
            })

        }

    })


    vm.$watch("onReady",function(){
        vm.loadReceiveAddressList();
    })
    // 校验手机号码格式
    function checkTelephone(telephone) {
        var mobileReg = new RegExp("^(1[0-9]{10})$");
        if (!telephone) {
            layer.msg('请输入联系电话!');
            return false;
        }
        if (!mobileReg.test(telephone)) {
            layer.msg('手机号格式不正确!');
            return false;
        }
        return true;
    }

</script>

</body>
</html>