<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <title>选择套餐</title>
</head>

<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">选择套餐</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <div class="package">
            <ul id="pickupList">
                <#--<li>
                    <div class="tit">
                        <label><input type="radio" name="paytype">提货券1</label>
                    </div>

                    <div class="items">
                        <label>
                            <input type="radio" name="chk_item">
                        </label>
                        <div class="pic">
                            <img src="images/goodspic.jpg" alt=""/>
                        </div>
                        <div class="r">
                            <p class="name">套餐1</p>
                            <p class="det">心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾</p>
                        </div>
                    </div>
                    <div class="items">
                        <label>
                            <input type="radio" name="chk_item">
                        </label>
                        <div class="pic">
                            <img src="images/goodspic.jpg" alt=""/>
                        </div>
                        <div class="r">
                            <p class="name">套餐1</p>
                            <p class="det">心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾</p>
                        </div>
                    </div>

                    <div class="describe toggled">
                        <div class="togglebtn"></div>
                        套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，
                        套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，
                        套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，
                        套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述套餐礼包描述文本，套餐礼包描述…
                    </div>
                </li>-->
            </ul>
        </div>

        <div class="btnbar">
            <a class="mui-btn mui-btn-block mui-btn-primary" id="doNext">下一步</a>
        </div>

    </div>
</div>

<script type="text/javascript">
    var pickupListObj = $('#pickupList');

    $(function(){
        $("#doNext").click(function(){
            var selectPickupcouponList = pickupListObj.find("input[name='pickupcouponList']:checked");
            //console.log(selectPickupcouponList.length)
            if(selectPickupcouponList.length == 0){
                mui.toast('请选择套餐!');
                return ;
            }

            var pickupCouponId = $(selectPickupcouponList.get(0)).attr('data-id');

            var selectPickupcouponPackage = $('#pickupCouponId_'+pickupCouponId).find("input[name='pickupcouponPackage']:checked");
            //console.log(selectPickupcouponPackage.length)
            if(selectPickupcouponPackage.length == 0 ){
                mui.toast('请选择套餐!');
                return ;
            }

            var pickupPackageId = $(selectPickupcouponPackage.get(0)).attr('data-id');
            console.log(pickupCouponId)
            console.log(pickupPackageId)

            if((!pickupCouponId || pickupCouponId == "") ||
                    (!pickupPackageId || pickupPackageId == "")){
                mui.toast('请选择套餐!');
                return ;
            }

            $.post("${ctx}/m/pickup/confirmPackage", {
                pickupCouponId : pickupCouponId,
                pickupPackageId : pickupPackageId
            }, function(data){
                if(data && data.result == "success"){
                    window.location.href = "${ctx}/m/account/pickupOrder/submitOrder";
                }else{
                    mui.toast(data.message || "操作失败,请稍后再试!");
                }
            }, "json");
        })

        $.get("/m/pickup/selectPackage/jsonData.html", {}, function (data) {
            if(data && data.result == "success"){
                console.log(data)
                console.log("-----")

                var appendString = "";
                if(data.pickupcouponListArr){
                    $.each(data.pickupcouponListArr, function(i,val){
                        console.log(val)

                        appendString = appendString + '<li id="pickupCouponId_'+val.pickupCouponId+'">';
                        appendString = appendString + '<div class="tit">';
                        appendString = appendString + '<label><input type="radio" data-id="'+val.pickupCouponId+'" name="pickupcouponList">'+val.pickupCouponName+'</label>';
                        appendString = appendString + '</div>';

                            var packageArr = data.packageMap[val.pickupCouponId];
                            $.each(packageArr, function(j, package){
                                console.log(package)

                                appendString = appendString + '<div class="items">';
                                    appendString = appendString + '<label>';
                                        appendString = appendString + '<input type="radio" class="chk_item" data-id="'+package.pickupCouponPackageId+'" name="pickupcouponPackage" disabled>';
                                    appendString = appendString + '</label>';
                                    appendString = appendString + '<div class="pic">';
                                        appendString = appendString + '<img src="'+package.packagePicUrl+'" alt=""/>';
                                    appendString = appendString + '</div>';
                                    appendString = appendString + '<div class="r">';
                                        appendString = appendString + '<p class="name">'+package.packageName+'</p>';
                                        appendString = appendString + '<p class="det">'+package.packageDesc+'</p>';
                                    appendString = appendString + '</div>';
                                appendString = appendString + '</div>';
                            })

                            appendString = appendString + '<div class="describe toggled">';
                                appendString = appendString + '<div class="togglebtn"></div>';
                                appendString = appendString + val.pickupCouponDesc;
                            appendString = appendString + '</div>';

                        appendString = appendString + '</li>';
                    });
                }else{
                    appendString = "<div style='text-align: center;margin-top: 10px;'>没有可用的提货券!</div>"
                }

                pickupListObj.append(appendString);
            }else{
                mui.toast(data.message || '加载数据失败!');
            }

        }, "json");

        var describebox = $(".describe"),openheight,
                closeheight = describebox.height();
        describebox.height(closeheight);
        $('#pickupList').on('click', '.describe .togglebtn', function(){
            var item  = $(this).parent();
            if(item.hasClass("toggled")){
                openheight =  item [0].scrollHeight;
                item.animate({
                    height : openheight
                },{
                    duration : 200,
                    easing : 'ease-in-out',
                    complete: function(){
                        item.removeClass("toggled");
                    }
                });
            }else{
                item.animate({
                    height : closeheight
                },{
                    duration : 200,
                    easing : 'ease-in-out',
                    complete: function(){
                        item.addClass("toggled");
                    }
                });
            }
        });

        $('#pickupList').on('change', "input[type='radio'][name='pickupcouponList']", function(){
            $(".chk_item").attr('disabled', true);
            var _this = $(this),
                    len = _this.parent().parent().siblings().find("input[type='radio']");
            len.removeAttr('disabled');
        })
    })
</script>
</body>
</html>