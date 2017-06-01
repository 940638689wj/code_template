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
            <div class="content-titel"><h3>奖品详细<span><em>_</em>我的奖品</span><span><em>_</em>${(awardsDetail.name)!}</span></h3></div>
            <form id="editAddressForm" name="editAddressForm" action="#"
                  method="post">
                <input type="hidden" id="addrId" name="addrId" value="${(userReceiveAddressManage.addrId)!}"/>
                <div class="mcbox">
                    <ul class="formlist form-address">
                        <li>
                            <div class="form-hd">收货人</div>
                            <div class="form-bd">
                                <input type="text" value="${(awardsDetail.receiverName)!}"
                                       class="textfield" id="receiverName" name="receiverName" disabled="true">
                            </div>
                        </li>
                        <li>
                            <div class="form-hd">所在地区</div>
                            <div class="form-bd">
								<input type="text" value="${(awardsDetail.provinceName)!}&nbsp;--&nbsp;${(awardsDetail.cityName)!}&nbsp;--&nbsp;${(awardsDetail.countyName)!}"
                                       class="textfield" id="receiverName" name="receiverName" disabled="true">
                            </div>
                        </li>
                        <li>
                            <div class="form-hd auto">街道地址</div>
                            <div class="form-bd">
                                    <textarea id="receiverAddr" name="receiverAddr" disabled="true">${(awardsDetail.detailAddr)!}</textarea>
                            </div>
                        </li>
                        <li>
                            <div class="form-hd">手机号码</div>
                            <div class="form-bd">
                                <input type="text" value="${(awardsDetail.mobile)!}"
                                       class="textfield" id="receiverTel" name="receiverTel" disabled="true">
                            </div>
                        </li>                      
                    </ul>
                </div>
            </form>
        </div>
    </div>
</div>

	
</body>
</html>