<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改收货地址</title>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1);"></a>
	        <h1 class="mui-title">修改收货地址</h1>
	        <a class="mui-icon"></a>
	    </header>
	</#if>
    <div class="mui-content">
        <div class="toptip">
            <div>提示：只能修改电话号码及姓名</div>
        </div>

        <form id="modifyAddressForm" action="${ctx}/m/account/order/modifyAddress" method="POST">
            <div class="loginform">
                <ul>
                    <li>
                        <div class="hd w3">收货人</div>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap"><input type="text" id="receiverName" name="receiverName" value="${(userReceiveAddressDTO.receiverName)!}"><span class="delete"></span></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="hd">手机号码</div>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap"><input type="number" id="receiverTel" name="receiverTel" value="${(userReceiveAddressDTO.receiverTel)!}"><span
                                        class="delete"></span></div>
                            </div>
                        </div>
                    </li>
                <#--<li>
                    <div class="hd w3">验证码</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="number" placeholder="请输入短信验证码"><span
                                    class="delete"></span></div>
                            <div class="toobtain disabled">重新获取58s</div>
                        </div>
                    </div>
                </li>-->
                    <li>
                        <div class="hd">所在地区</div>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap"><input type="text" value="${(userReceiveAddressDTO.addressFullIdName)!}" disabled></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="hd">详细地址</div>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap"><input type="text" value="${(userReceiveAddressDTO.receiverAddr)!}" disabled></div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="btnbar">
                <a class="mui-btn mui-btn-block mui-btn-primary" id="confirmModifyAddress">确定</a>
            </div>
        </form>
    </div>

</div>

<script>
    $(function(){
        $('#confirmModifyAddress').on('click', function(){
            var receiverName = $('#receiverName').val();
            var receiverTel = $('#receiverTel').val();

            if(!receiverName || $.trim(receiverName) == ""){
                mui.toast("收货人不能为空!");
                return ;
            }
            if(receiverName.length > 20){
                mui.toast("收货人不能超过20个长度!");
                return ;
            }

            if(!receiverTel || $.trim(receiverTel) == ""){
                mui.toast("手机号码不能为空!");
                return ;
            }
            if(!(/^1[34578]\d{9}$/.test(receiverTel))) {
                mui.toast("手机号码输入不正确！");
                return;
            }

            $('#modifyAddressForm').submit();
        });
    })
</script>
</body>
</html>