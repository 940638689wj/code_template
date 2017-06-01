<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <div class="title-text">门店信息</div>
        <div class="userinfo-box">
            <div class="pic"><img src="<#if (store.storeLogoUrl)??>${store.storeLogoUrl}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100"></div>
            <div class="code"><img src="${ctx}/admin/network/userStore/getQrImg?storeId=${store.storeId}"  width="100" height="100"></div>
            <ul>
                <li>门店编码：${(store.storeNumber)!''}</li>
                <li>门店名称：${(store.storeName)!''}</li>
                <li>注册时间：${(store.createTime?datetime)!''}</li>
            </ul>
        </div>
    </div>
    <div class="content-body">
    <input type="file" id="storeImgFileObj" name="file" onchange="javascript:doUploadStorePic(this);" style="display: none;">
        <form id="J_Form11" class="form-horizontal" action="${ctx}/admin/network/userStore/updateStoreIndroduce" method="post">
        <input type="hidden" id="storeId" name="storeId" value="${store.storeId}">
        <input type="hidden" id="banners" name="banners" value="">
             <div id="storeBannerContainer" class="form-content">
            	<div class="control-group">
	                <label class="control-label" style="width: 210px;">
	                    广告轮播图：<a href="javascript:void(0);" id="addStoreBanner" class="button">+添加一张</a>
	                </label>
	                <div class="controls">
	                    <div class="tips-wrap">
	                        &nbsp;
	                    </div>
	                </div>
            	</div>
            
        
	           <div class="storeBannerContent">
	           		<div id="storeBannerPanel" class="control-group storeBannerPanel" style="display:none;">
	                    <label class="control-label">&nbsp;</label>
	                    <div class="controls control-row-auto">
	                        <ul class="bui-clear">
	                            <li style="position: relative; float: left; overflow: hidden;">
	                                <a class="button button-primary doUploadBanner" href="javascript:void(0);" style="cursor: pointer">上传</a>
	                                &nbsp;(建议 920*200 像素图片)
	                            </li>
	                        </ul>
	                        <img id="" assetId="" class="storeBanner" style="margin-top: 10px;display:none;width:300px;height:100px;" src="${(photo.storePhotoUrl)!}">
	                        <a href="javascript:void(0);" class="delStoreBanner">删除</a>
	                    </div>
	                </div>
	                <#if list??>
	           		<#list list as photo>
	                <div id="storeBannerPanel" class="control-group storeBannerPanel" ">
	                    <label class="control-label">&nbsp;</label>
	                    <div class="controls control-row-auto">
	                        <ul class="bui-clear">
	                            <li style="position: relative; float: left; overflow: hidden;">
	                                <a class="button button-primary doUploadBanner" href="javascript:void(0);" style="cursor: pointer">上传</a>
	                                &nbsp;(建议 920*200 像素图片)
	                            </li>
	                        </ul>
	                        <img id="" assetId="" class="storeBanner" style="margin-top: 10px;width:300px;height:100px;" src="${(photo.storePhotoUrl)!}">
	                        <a href="javascript:void(0);" class="delStoreBanner">删除</a>
	                    </div>
	                </div>
	                </#list>
	               </#if> 
	            </div>
	        </div>
        
	        <div class="control-group">
	            <label class="control-label">门店LOGO：</label>
	            <div class="controls control-row-auto">
	                <ul class="bui-clear">
	                    <li style="position: relative; float: left; overflow: hidden;">
	                        <a class="button button-primary" href="javascript:void(0);" id="addStoreLogo" style="cursor: pointer">上传</a>
	                        &nbsp;(建议 270*90 像素的png格式)
	                    </li>
	                </ul>
					<input type="hidden" id="logo" name="logo" />
	                <img id="storeLogo" assetId="" name="storeLogo" style="margin-top: 10px;width:200px;height:90px;<#if (store.storeLogoUrl)??><#else>display: none;</#if>" src="<#if (store.storeLogoUrl)??>${store.storeLogoUrl}</#if>">
	                <a href="javascript:void(0);" id="delStoreLogo">删除</a>
	            </div>
	        </div>
        
	        <div class="control-group">
	            <label class="control-label">商家介绍：</label>
	            <div class="controls control-row-auto">
	                <script type="text/plain" id="editor" name="description" ></script>
	                <input type="hidden" value="<#if (store.storeDescription)??>${store.storeDescription}</#if>" id="des"/>
	            </div>
	        </div>
            <div class="actions-bar">
            <div class="form-actions">
               
                <button type="submit" class="button button-primary">保存</button>
               <!-- <button type="reset" class="button">重置</button> -->
            </div>
        </div>
        </form>
        
    </div>
</div>
</body>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
<script type="text/javascript">
 var photoCount = 0;
    var bannerCount = ${(list?size)!'0'};
    var uploadPath = "${ctx}/common/staticAsset/upload/uploadImage";
    var currentStoreImgPanel = 0;
    var currentStoreImgId;
    var currentImgType ="insidePhoto";  //insidePhoto、logo、banner、photo(门店形象照)
    
	$(function(){
		//富文本加载
        var msg_editor = UE.getEditor("editor",{initialFrameWidth: 750, initialFrameHeight: 250});
		msg_editor.ready(function() {
		    msg_editor.setContent( $("#des").val()); 
		});
		
        <#--轮播图-->
        $('#storeBannerContainer').on('click','#addStoreBanner',function(){
            if(bannerCount >= 10){
                alert('最多只能添加10张图片哦!');
                return ;
            }

            var targetPanel = $("#storeBannerPanel").clone();
            targetPanel.removeAttr("id");

            var randomId = randomString();

            targetPanel.find("img").attr('src','');
            targetPanel.find("img").attr('id','img_'+bannerCount);
            targetPanel.find("img").hide();

            targetPanel.show();
            targetPanel.insertBefore("#storeBannerPanel");

            bannerCount++;
        });
		
		 <#--上传logo-->
        $("#addStoreLogo").click(function(){
            currentImgType ="logo";
            $("#storeImgFileObj").click();
        });

        <#--删除 轮播图-->
        $('#storeBannerContainer').on('click','.delStoreBanner',function(){
            var delItem = $(this).closest('.control-group');
            delItem.remove();
            bannerCount --;
        });
        // 删除logo
        $("#delStoreLogo").click(function(){
            var delItem = $(this).closest('.controls');
            delItem.find("img").attr('src','');
            delItem.find("img").hide();
            $('#logo').val('');
        });
        // 上传 banner 事件
        $("#storeBannerContainer").on('click',".doUploadBanner",function(){
            currentStoreImgId = $(this).closest('.storeBannerPanel').find("img").attr('id');
            currentImgType ="banner";

            $("#storeImgFileObj").click();
        });
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form11',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!")
                }
            }
        }).render();

        form.on('beforesubmit', function(){

            var banners = [];
            $('.storeBanner').each(function(i,obj){
                var src = $(this).attr('src') ? $(this).attr('src') : "";
                banners.push(src);
            });
            $('#banners').val(banners.join(","));
            return true;
        });
        
    });
    /**
     * 图片 上传
     *
     */
    function doUploadStorePic(obj){
    
        var fileName = obj.value;
        if(fileName == null || jQuery.trim(fileName).length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);
        suffix = jQuery.trim(suffix);

        if(jQuery.trim(suffix).length <= 0 ||
                ("jpg" != jQuery.trim(suffix.toLowerCase()) && "png" != jQuery.trim(suffix.toLowerCase()))){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }

        $.ajaxFileUpload({
            url : uploadPath,
            secureuri: false,
            fileElementId: obj.id,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                storePicUploadSuccessHandler(data);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }

    function storePicUploadSuccessHandler(data){
        if(currentImgType == "insidePhoto")
        {
            $('#'+currentStoreImgId).attr('src',data.displayUrl);
            $('#'+currentStoreImgId).attr('assetId',data.assetId);

            $('#'+currentStoreImgId).show();
        }else if(currentImgType == "logo"){
            $('#storeLogo').attr('src',data.displayUrl);
            $('#storeLogo').attr('assetId',data.assetId);

            $('#storeLogo').show();
            $('#logo').val(data.displayUrl);
        }else if(currentImgType == "photo"){
            $('#storePhoto').attr('src',data.displayUrl);
            $('#storePhoto').attr('assetId',data.assetId);

            $('#storePhoto').show();
            $('#photo').val(data.displayUrl);
        }else if(currentImgType == "banner"){
            $('#'+currentStoreImgId).attr('src',data.displayUrl);
            $('#'+currentStoreImgId).attr('assetId',data.assetId);

            $('#'+currentStoreImgId).show();
        }
    }

	function randomString() {
        return '' + new Date().getTime();
    }
</script>
</body>
</html>  