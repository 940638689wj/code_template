<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>个人中心</title>
</head>
<body>
<#include "include/header.ftl"/>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="center-pro-wrap">
                <div class="center-property">
                    <h3>可用金额</h3>
                    <div class="v-cash">
                        <p class="v-much"><span>${userConsumeCalc.userBalance!0}</span>元</p>
                        <a class="v-button" href="javascript:businessIsActive()">充值</a>
                    <#--<a class="v-button" href="#">提现</a>-->
                    </div>
                </div>
                <div class="privileges">
                    <ul>
                        <li>
                            <span class="integral-bg">积分</span>
                            <p><em>${userConsumeCalc.totalScore!0}</em>分</p>
                        </li>
                        <li>
                            <span class="coupons-bg">优惠券</span>
                            <p><em>${couponCount!0}</em>张</p>
                        </li>
                        <li>
                            <span class="envelope-bg">红包</span>
                            <p><em>${redCount!0}</em>个</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="center-list">
                <h3><a href="${ctx}/account/orderHeader?type=0">查看全部订单&gt;</a>最近订单</h3>
                <table class="datatb">
                    <thead>
                    <tr>
                        <th class="col-1 tal">商品</th>
                        <th class="col-2">状态</th>
                        <th class="col-3">总金额</th>
                        <th class="col-4">操作</th>
                    </tr>
                    </thead>
                <#if recentOrderHeaderList?has_content>
                    <#list recentOrderHeaderList as recentOrderHeader>
                        <tbody>
                        <tr>
                            <td>
                                <div class="first-column">
                                    <div class="img"><a href="${ctx}/product/${recentOrderHeader.masterProductId!}"><img
                                            src="${recentOrderHeader.firstPic!}" alt=""/></a>
                                    </div>
                                    <div class="info">
                                        <div class="name">共${recentOrderHeader.productNum!}件
                                        </div>
                                    <#--<div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>-->
                                    <#--</div>-->
                                    </div>
                                </div>
                            </td>
                            <td>
                                <#if recentOrderHeader.type==1>
                                    待付款
                                <#elseif recentOrderHeader.type==2>
                                    待发货
                                <#elseif recentOrderHeader.type==3>
                                    待确认收货
                                <#elseif recentOrderHeader.type==4 || recentOrderHeader.type==0>
                                    已完成
                                <#elseif recentOrderHeader.type==5>
                                    已取消
                                </#if>
                            </td>
                            <td>¥${recentOrderHeader.orderPayAmt!}</td>
                            <td>
                                <a href="${ctx}/account/orderHeader/orderHeaderDetail?orderId=${recentOrderHeader.orderId!}">查看详情</a>
                            </td>
                        </tr>
                        </tbody>
                    </#list>
                <#else>
                    <tbody>
                    <tr>
                        <td colspan="4" class="nodata">
                            近期都没有订单，赶快<a href="${ctx}" class="red">去购物</a>吧！
                        </td>
                    </tr>
                    </tbody>
                </#if>
                </table>
            </div>
            <div class="center-list">
                <h3>
                    <#--<a href="#" class="in">换一组</a>-->
                    猜你喜欢</h3>
                <div class="section">
                    <ul>
                    <#list hotProductList as hotProduct>
                        <#if (hotProduct_index < 4)>
                            <li>
                                <div class="pic"><a href="${ctx}/product/${hotProduct.productId!}/"><img src="${hotProduct.picUrl!}"/></a></div>
                                <p class="name"><a href="${ctx}/product/${hotProduct.productId!}/">${hotProduct.productName!}</a></p>
                                <p class="money">
                                    <span>¥<strong>${hotProduct.defaultPrice!}</strong></span>
                                    <del>¥${hotProduct.tagPrice!}</del>
                                </p>
                            </li>
                        </#if>
                    </#list>
                    </ul>
                </div>
            </div>
        </div>
    </div>

<script src="../js/lib/jquery-1.8.3.min.js"></script>
<script src="../js/jquery.switchable.min.js"></script>
<script>
    $(function () {
        $('.goodslist-wrap').switchable({
            panels: 'li',
            triggers: '&bull;',
            effect: 'scrollLeft',
            steps: 5
        });

        //签到
        var sign = "${sign}";
        var flagTwo = false;
        var flagPost = false;
        if (sign == 0) {
            $(".past").on("click", function () {
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
    });

    //修改头像
    function imageChange() {
        $('#file_Portrait').trigger("click");
        ;
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

        var suffix = fileName.substr(suffixIndex + 1);

        if (suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim() && "jpeg" != suffix.trim() && "gif" != suffix.trim() && "bmp" != suffix.trim() &&
                "JPG" != suffix.trim() && "PNG" != suffix.trim() && "JPEG" != suffix.trim() && "GIF" != suffix.trim() && "BMP" != suffix.trim())) {
            layer.msg("文件格式错误!");
            return false;
        }

        $.ajaxFileUpload({
            url: '${ctx}/common/staticAsset/upload/lastFlag',
            secureuri: false,
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

    function loadImage(assertUrl, lastFlag) {
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
</body>
</html>