<input type="hidden" name="mediaVoice" id="mediaVoice" value="">
<div class="prd-music">
    <div class="prd-upload">
        <ul class="bui-clear" style="margin-left:120px;">
            <li style="position: relative; float: left; overflow: hidden;">
                <a class="button button-primary" href="#" style="cursor: pointer">选择语音文件</a>
                <input type="file" id="voiceFileObj" name="file" onchange="javascript:doUploadVoice(this.value);" style="opacity:0;filter:alpha(opacity:0);z-index:999;cursor:pointer;position: absolute; bottom: 0; right: 0; font-size: 9999px;">
            </li>
        </ul>
        <p>支持mp3格式,大小不超过10M，在前台展示语音推荐商品</p>
    </div>
    <div class="prd-muscilist">
        <ul>
            <li style="display: none;" id="voiceContainerModel" name="voiceContainerModelName">
                <div class="music"><i class="ico-music"></i><label name="voiceName">宁夏 - 群星.mp3</label></div>
                <div class="ctrl">
                    <a href="javascript:void(0);" name="voicePlay">试听</a>
                    <a href="javascript:void(0);" name="voiceLoading" style="display: none;">加载中....</a>
                    <a href="javascript:void(0);" name="voiceStop" style="display: none;">停止</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);" name="voiceDelete">删除</a>
                </div>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/createjs/utils/Proxy.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/createjs/utils/IndexOf.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/createjs/events/Event.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/createjs/events/EventDispatcher.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/soundjs/Sound.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/soundjs/WebAudioPlugin.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/soundjs/soundjs/HTMLAudioPlugin.js"></script>
<script type="text/javascript">

    var uploadPath1 = "${ctx}/common/staticAsset/upload/product";

    var initSoundPluginSuccess = window.parent.initSoundJsSuccess;
    initVoice();

    function initVoice(){
        <#if productExtend?? && productExtend.productVideoUrl?has_content>
        	  var voiceId = '';
              var voiceUrl = '${productExtend.productVideoUrl?default('')}';
              aVoiceAdd(voiceId, voiceUrl, true);
              $("#mediaVoice").val(voiceUrl);
        </#if>
    }


    function aVoiceAdd(voiceId, voiceUrl, isMedia){
        var voiceCount = voiceArray.length + voiceMediaArray.length;
        var voiceIndex = voiceCount + 1;
        var newContainer = $("#voiceContainerModel").clone();
        newContainer.attr('id','voice_' + voiceId);
        newContainer.attr('data-voice-from-type', (isMedia ? "media" : "upload"));
        var voiceName = voiceUrl.substring(voiceUrl.lastIndexOf('/') + 1);
        $(newContainer.find('label[name="voiceName"]')[0]).html(voiceName);
        $(newContainer.find('a[name="voiceDelete"]')[0]).on('click', function(){
            deleteVoice(voiceId, voiceIndex, (isMedia ? "media" : "upload"));
        });
        if(!initSoundPluginSuccess){
            $(newContainer.find('a[name="voicePlay"]')[0]).hide();
        } else {
            $(newContainer.find('a[name="voicePlay"]')[0]).on('click', function(){
                playVoice(voiceId, voiceIndex, voiceUrl);
            });
            $(newContainer.find('a[name="voiceStop"]')[0]).on('click', function(){
                stopPlayVoice(voiceId);
            });
        }
        newContainer.insertBefore($("#voiceContainerModel"));
        newContainer.show();

        if(isMedia){
            voiceMediaArray.push(voiceId);
        } else {
            voiceArray.push(voiceId);
        }
    }

    var instance;
    createjs.Sound.addEventListener("fileload", handleLoadComplete);
    function playVoice(voiceId, voiceIndex, voiceUrl){
        if(instance && instance.playState == createjs.Sound.PLAY_FINISHED){
            playStatusShow(voiceId, "playing");
            instance.play();
        } else {
            voiceUrl = "admin" + voiceUrl;
            createjs.Sound.registerSound({id:voiceId, src:voiceUrl});
            playStatusShow(voiceId, "loading");
        }
    }

    function handleLoadComplete(event){
        playStatusShow(event.id, "playing");
        instance = createjs.Sound.play(event.src);
        if (instance == null || instance.playState == createjs.Sound.PLAY_FAILED) { playFail(event.id, event.src); return; }
        instance.addEventListener("complete", createjs.proxy(function(){
            playComplete(event.id);
        }, this));
    }

    function playStatusShow(voiceId, status){
        var targetVoiceObj = $(("#voice_" + voiceId));
        if(status == "loading"){
            targetVoiceObj.find("a[name='voicePlay']").hide();
            targetVoiceObj.find("a[name='voiceStop']").hide();
            targetVoiceObj.find("a[name='voiceLoading']").show();
        } else if (status == "playing"){
            targetVoiceObj.find("a[name='voicePlay']").hide();
            targetVoiceObj.find("a[name='voiceLoading']").hide();
            targetVoiceObj.find("a[name='voiceStop']").show();
        } else  {
            targetVoiceObj.find("a[name='voiceStop']").hide();
            targetVoiceObj.find("a[name='voiceLoading']").hide();
            targetVoiceObj.find("a[name='voicePlay']").show();
        }
    }

    function playComplete(voiceId){
        playStatusShow(voiceId, "stopping");
    }

    function playFail(voiceId, voiceSrc){
        //console.log(voiceId + "-" + voiceSrc + ": play Failed!");
        playStatusShow(voiceId, "stopping");
    }

    function stopPlayVoice(voiceId){
        if(instance){
            instance.stop();
        }
        playStatusShow(voiceId, "stopping");
    }

    function doUploadVoice(fileName){
        if(voiceMediaArray.length + voiceArray.length >= 1){
            BUI.Message.Alert("音频文件最多上传一个，若需要修改，请先删除!");
            return false;
        }

        if(fileName == null || jQuery.trim(fileName).length <= 0){
            //BUI.Message.Alert("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert(fileName + "文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);
        suffix = jQuery.trim(suffix);

        if(jQuery.trim(suffix).length <= 0 ||
                "mp3" != jQuery.trim(suffix.toLowerCase())){
            BUI.Message.Alert(suffix + "文件格式暂不支持!");
            return false;
        }

        $.ajaxFileUpload({
            url : uploadPath1,
            secureuri: false,
            fileElementId: "voiceFileObj",
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                voiceUploadSuccessHander(data);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }

    /**
     * 上传成功
     *
     * @param data
     */
    function voiceUploadSuccessHander(data){
        aVoiceAdd(data.assetId, data.assetUrl, false);
        $("#mediaVoice").val(data.assetUrl);
    }

    function deleteVoice(voiceId, voiceIndex, voiceType){
        BUI.Message.Confirm('确认要删除么？',function(){
            var targetVoice = $("#voice_" + voiceId);
            voiceType = targetVoice.attr("data-voice-from-type");
            targetVoice.remove();
            if(voiceType && voiceType == "media"){
                voiceMediaArray = [];
            } else {
                voiceArray = [];
            }
            instance = undefined;
        },'question');
    }
</script>