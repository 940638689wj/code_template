<#assign ctx = request.contextPath>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>

<div class="center-aside">
    <div class="userpic">
        <div class="userpic-box">
            <a href="#">
                <img id="imageView" name="imageView" src="">
                <input name="file" id="file_Portrait" class="inp-file" type="file"
                       onchange="javascript:assetChange(this.value,'Portrait');"/>
                <span class="edit-mask" onclick="imageChange();">编辑头像</span>
            </a>
        </div>
        <span class="word" id="userName"></span>
        <a class="signbtn" href="javascript:void(0);" id="signbtn" ></a>
    </div>
    <div class="mcmenu">
        <dl>
            <dt>订单中心<b class="arr"></b></dt>
            <dd><a href="${ctx}/account/order?orderTypeCd=1" id="menu_orderHeader">普通订单</a></dd>
            <dd><a href="${ctx}/account/pickupOrder/list" id="menu_pickupOrder">提货券订单</a></dd>
            <dd><a href="/account/groupPurchaseOrder/list" id="menu_pickupOrderHeader">团购订单</a></dd>
                <dd><a href="${ctx}/account/preSaleOrder/toPreSaleOrderList">预售订单</a></dd>
            <dd><a href="/account/crowdfundingOrder/list">我的众筹</a></dd>
            <dd><a href="${ctx}/account/order?orderTypeCd=3">白鹭卡订单</a></dd>
            <dd><a href="${ctx}/account/order/deleteOrderList" id="menu_deleteOrderList">订单回收站</a></dd>
           <#-- <dd><a href="${ctx}/cart/list">购物车</a></dd>  -->
        </dl>
        <dl>
            <dt>会员中心<b class="arr"></b></dt>
            <dd><a href="${ctx}/account/userAddress" id="menu_myAddress">收货地址</a></dd>
            <dd><a href="${ctx}/account/myCollect" id="menu_myFavourite">我的收藏</a></dd>
            <dd><a href="${ctx}/account/comment" id="menu_myEvaluation">我的评价</a></dd>
            <dd><a href="${ctx}/account/myConsult" id="menu_myConsult">我的咨询</a></dd>
            <dd><a href="${ctx}/account/historyView" id="menu_history">预览历史</a></dd>
        </dl>
        <dl>
            <dt>我的钱包<b class="arr"></b></dt>
            <dd><a href="${ctx}/account/userBalanceDetail" id="menu_balanceDetail">账户余额</a></dd>
            <dd><a href="javascript:businessIsActive()" id="menu_recharge">账户充值</a></dd>
            <#--<dd><a href="${ctx}/account/userCash" id="menu_cash">账户提现</a></dd>-->
            <dd><a href="${ctx}/account/userScoreDetail" id="menu_sorceDetail">我的积分</a></dd>
            <dd><a href="${ctx}/account/userPromotion/toCoupon" id="menu_coupon">我的优惠券</a></dd>
            <dd><a href="${ctx}/account/userPromotion/toRedPacket" id="menu_redPacket">我的红包</a></dd>
            <dd><a href="${ctx}/account/pickup" id="menu_pickupCoupon">我的提货券</a></dd>
            <dd><a href="${ctx}/account/group" id="menu_groupCoupon">我的团购券</a></dd>
            <dd><a href="${ctx}/account/userPromotion/toAward" id="menu_award">我的奖品</a></dd>
            <dd id="customer"><a href="${ctx}/account/myCustomer" id="menu_customer">我的客户</a></dd>
        </dl>
        <dl>
            <dt>账户安全<b class="arr"></b></dt>
            <dd><a href="${ctx}/account/userInfo" id="menu_userInfo">个人资料</a></dd>
            <dd><a href="${ctx}/account/userChangePaw?type=1" id="menu_resetPaw">密码设置</a></dd>
        </dl>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $(".mcmenu dt").on("click", function () {
            var parentMenu = $(this).parent();
            parentMenu.toggleClass("mcmenu-closed");
            if(parentMenu.hasClass("mcmenu-closed")){
                parentMenu.animate({
                    height : 40
                },{duration:200});
            }else{
                parentMenu.animate({
                    height : parentMenu.prop("scrollHeight")
                },{duration:200});
            }
        });

        $.ajax({
            url: '${ctx}/account/getParameter',
            dataType: "json",
            method: 'GET',
            success: function (data) {
                if (data.result==true) {
                    if(data.user.mStoreStatusCd == 1){
                        $("#customer").show();
                    }else{
                        $("#customer").hide();
                    }
                    $("#imageView").attr("src",data.user.headPortraitUrl?data.user.headPortraitUrl:data.userHead);
                    $("#userName").html(data.user.nickName?data.user.nickName:data.user.phone);
                    if(data.sign==1){
                        $("#signbtn").html("已签到");
                    }else{
                        $("#signbtn").html("签到");
                        var flagTwo = false;
                        var flagPost = false;
                        $(".signbtn").on("click", function () {
                            if (!flagPost) {
                                var obj = $(this);
                                $.post("${ctx}/account/sign", function (data) {
                                    if (data.result == "success") {
                                        obj.unbind();
                                        obj.addClass("button-disabled");
                                        obj.html("已签到");
                                        layer.msg("签到成功！");
                                    } else {
                                        layer.msg("签到失败，请稍后再试");
                                    }
                                    flagPost = true;
                                });
                            } else if (flagPost) {
                                if (!flagTwo) {
                                    setTimeout("layer.msg('今日已签到');", 1000);//1000为1秒钟
                                    flagTwo = true;
                                } else if (flagTwo) {
                                    layer.msg('今日已签到');
                                }
                            }
                        });
                    }
                } else {
                    layer.msg("获取数据失败!");
                }
            }
        });

    });

    function businessIsActive() {
        $.ajax({
            url: '${ctx}/account/userRechargeDetail/businessIsActive',
            dataType: "json",
            method: 'post',
            success: function (data) {
                if (data) {
                    window.location.href = "${ctx}/account/userRechargeDetail";
                } else {
                    layer.msg("充值端口尚未启用，请联系客服！");
                }
            }
        });
    }

    //修改头像
    function imageChange() {
        $('#file_Portrait').trigger("click");
    }

    function assetChange(fileName, lastFlag) {
        if (fileName == null || fileName.trim().length <= 0) {
            layer.msg("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if (suffixIndex <= 0) {
            layer.msg("文件格式错误!");
            return false;
        }

        var ext = fileName.substr(suffixIndex + 1);

        if (!(ext && /^(jpg|png|gif|bmp|pcx|tiff|jpeg|tga|exif|fpx|svg)$/.test(ext.toLowerCase()))) {
            layer.msg("文件格式错误!");
            return false;
        }

        $.ajaxFileUpload({
            url: '${ctx}/common/staticAsset/upload/lastFlag',
            fileElementId: "file_" + lastFlag,
            dataType: "json",
            method: 'post',
            success: function (data, status) {
                loadImage(data.assetUrl, lastFlag);
            },
            error: function (data, status, e) {
                layer.msg("上传失败" + e);
            }
        });
        return false;
    }

    function loadImage(assertUrl) {
        $.ajax({
            url: '${ctx}/account/Portrait_AjaxSave',
            dataType: 'json',
            type: 'post',
            data: {imgUrl: assertUrl},
            success: function (data) {
                layer.msg("上传成功！");
                $("#imageView").attr("src", assertUrl);
            }
        });
    }

</script>
