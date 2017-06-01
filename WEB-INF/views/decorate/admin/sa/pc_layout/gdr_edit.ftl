<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
		//验证一些格式  ajax上传数据
        function assetChange(fileName, targetFileId){
            if(fileName == null || fileName.trim().length <= 0){
                BUI.Message.Alert("请选择文件!");
                return false;
            }

            var suffixIndex = fileName.lastIndexOf('.');
            if(suffixIndex <= 0){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            var suffix = fileName.substr(suffixIndex + 1);

            if(suffix.trim().length <= 0 ||
                    ("jpg" != suffix.trim().toLowerCase() && "png" != suffix.trim().toLowerCase())){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            $.ajaxFileUpload({
                url:'${ctx}/common/staticAsset/upload/gdr',
                secureuri: false,
                fileElementId: targetFileId,
                dataType: "json",
                method : 'post',
                success: function (data, status) {
                    loadImage(data.assetUrl, targetFileId);
                },
                error: function (data, status, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }
		//将图片加载到   class为gdrImg的<img>标签中
        function loadImage(assertUrl,targetFileId) {
            var targetFileDom = $("#"+ targetFileId);
            var targetFileType = $(targetFileDom).attr("data-file-type");
            var imageDom = "<img src='"+assertUrl+"' alt=''/>";
            $(targetFileDom).parents(".gdrContent").find(("." + targetFileType)).html(imageDom);
        }
    </script>
</head>
<body>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">详情页右侧广告</span></li>
        </ul>
    </div>
    <div class="prdbasic-s">
        <div class="prd-colside">
            <div class="wrap">
                <div class="img-detailtop"></div>
                <div class="zx-detail-main"><b>产品详情</b></div>
                <div class="zx-detail-side"><b>右侧广告</b></div>
            </div>
        </div>
        <div class="prd-colmain">
            <div class="wrap">
                <form class="form-horizontal" id="gdrContainerForm" method="POST" action="edit">
                    <input type="hidden" name="gdrJson" value="">
                    <div class="gdrModel" style="display: none;" >
                        <div class="clearfix">
                            <h3 class="pull-left">第<span name="gdrCountSpan"></span>张</h3>
                            <a name="gdrDelHref" class="pull-left offset1" href="javascript:void(0)">删除</a>
                        </div>
                        <div class="control-group">
                            <div class="control-label control-label-auto">
                                <div class="file-btn">
                                    <button style="width: 100px;" class="button">广告图片</button>
                                    <input type="file" class="inp-file" name="file" data-file-type="gdrImg"/>
                                </div>
                            </div>
                            <div class="controls control-row1">
                                <input type="text" data-id="gdrImgLinkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                            </div>
                            <div class="bui-clear"></div>
                            <p class="auxiliary-text">建议图片大小：宽 360 像素</p>
                        </div>
                        <div class="zx-banner zx-banner-detail-side gdrImg">
                            <img src="${ctx}/static/admin/images/wxsucai.jpg" alt=""/>
                        </div>
                        <hr>
                    </div>

                    <div class="btn-add"><a href="javascript:void(0);" id="addHref">+亲，新增一张</a></div>
                    <div class="actions-bar">
                        <div class="form-action">
                            <button class="button button-large button-primary" id="save">保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
BUI.use('common/page');
    $(function(){

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#gdrContainerForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("右侧详情广告保存成功!");
                }
                setTimeout("remainTime()",1000);
            }
        });
        form.on('beforesubmit', function(){
        	btn=document.getElementById('save');
			btn.disabled=true;
            return collectData(); //收集数据，以JSON字符串的形式传输
        });
        form.render();

        $(".btn-add").bind('click', function(){
            addGdrContainer();
        })

        initGoodsDetailRightContent();
    });

    //初始化  取list集合中的数据在页面显示
    function initGoodsDetailRightContent(){
        <#if goodsDetailRightCustomTemplates?has_content>
            <#list goodsDetailRightCustomTemplates as gdrTemplate>
                var gdrContent = addGdrContainer();
                var gdrContentImgId = $(gdrContent).find("input[data-file-type='gdrImg']").attr("id");
                loadImage('${(gdrTemplate.picUrl)?default("")}', gdrContentImgId);
                $(gdrContent).find("input[data-id='gdrImgLinkUrl']").val('${(gdrTemplate.linkUrl)?default("")}');
            </#list>
        </#if>
    }
	//克隆出一个添加的DIV，并显示
    function addGdrContainer(){
        var gdrContent = $(".gdrModel").clone();
        gdrContent.removeClass("gdrModel");
        gdrContent.addClass("gdrContent");
        var currentGdrContentIndex = (getCurrentGdrContentCount() + 1);
        gdrContent.attr("data-edit-index", currentGdrContentIndex);   
        gdrContent.find("span[name='gdrCountSpan']").html("【" + currentGdrContentIndex + "】");
        gdrContent.find("a[name='gdrDelHref']").bind('click', function(){
            deleteGdrContent(gdrContent);
        });
        gdrContent.find("input[name='file']").each(function(){
            var fileType = $(this).attr("data-file-type");   
            $(this).attr("id", (fileType + "_" + currentGdrContentIndex));
        });
        gdrContent.find("input[name='file']").live('change', function(){
           assetChange($(this).val(), $(this).attr("id"));
        });
        gdrContent.insertBefore($(".gdrModel"));
        gdrContent.show();
        resetAddBtnTip();
        return gdrContent;
    }
	// 获取数据。。。存入数组中，并将数据转换成字符串，提交到控制器
    function collectData(){

        var gdrContentArray = [];
        $(".gdrContent").each(function(){
            var gdrContentObj = {};
            var editIndex = $(this).attr("data-edit-index");
            if(editIndex){
                gdrContentObj["index"] = editIndex;
                var gdrImgUrl = $(this).find(".gdrImg").find("img").attr("src");
                gdrContentObj["picUrl"] = gdrImgUrl;
                var gdrImgLinkUrl = $(this).find("input[data-id='gdrImgLinkUrl']").val();
                gdrContentObj["linkUrl"] = gdrImgLinkUrl;

                gdrContentArray.push(gdrContentObj);
            }
        });

        $("input[name='gdrJson']").val(JSON.stringify(gdrContentArray));
        return true;
    }
	//获取当前的一个添加个数
    function getCurrentGdrContentCount(){
        return $(".gdrContent").length;
    }
	//删除
    function deleteGdrContent(obj){
        var deleteGdrContentIndex = $(obj).attr("data-edit-index");
        $(obj).remove();
        $(".gdrContent").each(function(){
            var index = $(this).attr("data-edit-index");
            if(parseInt(index) > parseInt(deleteGdrContentIndex)){
                var newIndex = (parseInt(index) - 1);
                $(this).attr("data-edit-index", newIndex);
                $(this).find("span[name='gdrCountSpan']").html("【" + newIndex + "】");
                $(this).find("input[type='file']").each(function(){
                    var fileType = $(this).attr("data-file-type");
                    $(this).attr("id", (fileType + "_" + newIndex));
                });
            }
        });
        resetAddBtnTip();
    }
	
    function resetAddBtnTip(){
        var tip = "+亲，再来一张";
        if(getCurrentGdrContentCount() == 0){
            tip = "+亲，新增一张"
        }
        $("#addHref").html(tip);
    }
    //延时启用保存按钮
    function remainTime(){
        	var btn=document.getElementById('save');
			btn.disabled=false;
    }

</script>
<body>
</html>