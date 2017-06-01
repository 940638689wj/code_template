<#assign ctx = request.contextPath>

<div id="main">
    <div class="selectpackages">
        <div class="packages-tabs">
            <ul id="pickupcouponListUl">
                <#--<li class="active" data-pickupCouponId=""><a href="javascript:void(0);">提货券1</a></li>
                <li><a href="javascript:void(0);">提货券2</a></li>
                <li><a href="javascript:void(0);">提货券3</a></li>-->
            </ul>
        </div>
		<input type="hidden" id="codeNum" value="${codeNum!}"/>
        <div id="pickupPackageDiv">
            <#--<div class="packages-list" data-pickupCouponId="">
                    <div class="packages-info">
                        <h3>提货券说明</h3>
                        心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾
                    </div>
                    <ul>
                        <li>
                            <div class="pic"><p><img src="images/pic.jpg"></p></div>
                            <div class="info">
                                <h3>套餐1</h3>
                                <p>心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾</p>
                                <a class="btn-action" href="#">选此套餐</a>
                            </div>
                        </li>
                        <li>
                            <div class="pic"><p><img src="images/pic.jpg"></p></div>
                            <div class="info">
                                <h3>套餐2</h3>
                                <p>心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾心相印抽纸 经典系列面巾纸180抽 整箱装21包纸巾</p>
                                <a class="btn-action" href="#">选此套餐</a>
                            </div>
                        </li>
                    </ul>
            </div>-->
        </div>
    </div>
</div>


<script type="text/javascript">
    var pickupcouponListUl = $('#pickupcouponListUl');
    var pickupPackageDiv = $('#pickupPackageDiv');

    $(function(){
        $("#doNext").click(function(){
            var selectPickupcouponList = pickupcouponListUl.find("input[name='pickupcouponList']:checked");
            //console.log(selectPickupcouponList.length)
            if(selectPickupcouponList.length == 0){
                layer.msg('请选择套餐!');
                return ;
            }

            var pickupCouponId = $(selectPickupcouponList.get(0)).attr('data-id');

            var selectPickupcouponPackage = $('#pickupCouponId_'+pickupCouponId).find("input[name='pickupcouponPackage']:checked");
            //console.log(selectPickupcouponPackage.length)
            if(selectPickupcouponPackage.length == 0 ){
                layer.msg('请选择套餐!');
                return ;
            }

            var pickupPackageId = $(selectPickupcouponPackage.get(0)).attr('data-id');
            console.log(pickupCouponId)
            console.log(pickupPackageId)

            if((!pickupCouponId || pickupCouponId == "") ||
                    (!pickupPackageId || pickupPackageId == "")){
                layer.msg('请选择套餐!');
                return ;
            }

            $.post("${ctx}/pickup/confirmPackage", {
                pickupCouponId : pickupCouponId,
                pickupPackageId : pickupPackageId
            }, function(data){
                if(data && data.result == "success"){
                    window.location.href = "${ctx}/account/pickupOrder/submitOrder";
                }else{
                    layer.msg(data.message || "操作失败,请稍后再试!");
                }
            }, "json");
        })

        $('#pickupcouponListUl').on('click', "li", function(){
            $("#pickupcouponListUl li").removeClass("active");
            $(this).addClass("active");

            $(".packages-list").hide();
            $("div [data-pickupCouponId="+$(this).attr('data-indexFlag')+"_"+$(this).attr('data-pickupCouponId')+"]").show();
        })
		var codeNum = $("#codeNum").val();
        $.get("/pickup/selectPackage/jsonData.html?codeNum="+codeNum, {}, function (data) {
            if(data && data.result == "success"){
                if(data.pickupcouponListArr){
                    var pickupcouponListUlAppendString = "";
                    var pickupPackageDivAppendString = "";

                    var indexFlag = 0;
                    $.each(data.pickupcouponListArr, function(i,val){
                        if(indexFlag == 0){
                            pickupcouponListUlAppendString = pickupcouponListUlAppendString + '<li class="active" data-indexFlag='+indexFlag+' data-pickupCouponId='+val.pickupCouponId+'><a href="javascript:void(0);">'+val.pickupCouponName+'</a></li>';
                        }else{
                            pickupcouponListUlAppendString = pickupcouponListUlAppendString + '<li data-indexFlag='+indexFlag+' data-pickupCouponId='+val.pickupCouponId+'><a href="javascript:void(0);">'+val.pickupCouponName+'</a></li>';
                        }

                        if(indexFlag == 0){
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<div class="packages-list" data-pickupCouponId="'+indexFlag+'_'+val.pickupCouponId+'">';
                        }else{
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<div class="packages-list" style="display:none;" data-pickupCouponId="'+indexFlag+'_'+val.pickupCouponId+'">';
                        }

                        pickupPackageDivAppendString = pickupPackageDivAppendString + '<ul>';
                        pickupPackageDivAppendString = pickupPackageDivAppendString + '<div class="packages-info">';
                        pickupPackageDivAppendString = pickupPackageDivAppendString + '<h3>提货券说明</h3>';
                        pickupPackageDivAppendString = pickupPackageDivAppendString + val.pickupCouponDesc;
                        pickupPackageDivAppendString = pickupPackageDivAppendString + '</div>';

                        var packageArr = data.packageMap[val.pickupCouponId];
                        $.each(packageArr, function(j, package){
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<li>';
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<div class="pic"><p><img src="'+package.packagePicUrl+'"></p></div>';

                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<div class="info">';
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<h3>'+package.packageName+'</h3>';
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<p>'+package.packageDesc+'</p>';
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '<a class="btn-action" href="javascript:void(0);" onclick="confirmPackage('+val.pickupCouponId+','+package.pickupCouponPackageId+');">选此套餐</a>';
                            pickupPackageDivAppendString = pickupPackageDivAppendString + '</div>';

                            pickupPackageDivAppendString = pickupPackageDivAppendString + '</li>';
                        })

                        pickupPackageDivAppendString = pickupPackageDivAppendString + '</ul>';
                        pickupPackageDivAppendString = pickupPackageDivAppendString + '</div>';

                        indexFlag = indexFlag + 1;
                    });
                }

                pickupcouponListUl.append(pickupcouponListUlAppendString);
                pickupPackageDiv.append(pickupPackageDivAppendString);
            }else{
                layer.msg(data.message || '加载数据失败!');
            }
        }, "json");
    })

    function confirmPackage(pickupCouponId, pickupPackageId){
        if((!pickupCouponId || pickupCouponId == "") ||
                (!pickupPackageId || pickupPackageId == "")){
            layer.msg('请选择套餐!');
            return ;
        }

        $.post("${ctx}/pickup/confirmPackage", {
            pickupCouponId : pickupCouponId,
            pickupPackageId : pickupPackageId
        }, function(data){
            if(data && data.result == "success"){
                window.location.href = "${ctx}/account/pickupOrder/submitOrder";
            }else{
                layer.msg(data.message || "操作失败,请稍后再试!");
            }
        }, "json");
    }
</script>