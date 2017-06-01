<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui-min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/config-min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

    <script type="text/javascript">
        /*该变量设置必需在引入ueditor.all.js、ueditor.config.js之前，否则ueditor国际化文件无法记载，导致360浏览器无法显示*/
        window.UEDITOR_HOME_URL = "${ctx}/static/admin/js/ueditor/";
    </script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>

</head>
<body>

<div class="container">
    <ul class="breadcrumb">
        <li class="active">素材管理</li>
    </ul>
    <div class="wx-media-preview-area">
        <div class="wxappmsg">
            <div id="J_wxmsg_content">
                <div class="media-msg-item media-single-msg <#if (article.picUrl)??>hasimg</#if>">
                    <h4 class="wxmsg-title">
                        <a href="javascript:;" id="s_title"><#if (article.articleTitle)??>${article.articleTitle}<#else>标题</#if></a>
					</h4>
                    <p>
						<#if wxInitMessage?? && wxInitMessage?has_content>
						<#else>
						</#if>
					</p>
                    <div class="wxmsg-thumb-wrp">
						<i class="wxmsg-thumb">封面图片</i>
                        <img class="wxmsg-thumb" id="s_primaryPic" src="<#if (article.picUrl)??>${(article.picUrl)!}</#if>" alt=""/>
					</div>
                    <p class="wxmsg-desc" id="s_summary"><#if (article.summary)??>${article.summary}</#if></p>
                </div>
            </div>
        </div>
    </div>
    <div class="wx-media-edit-area">
        <div id="J_wxapp_editer" class="wxappmsg-editor">
            <form class="form-vertical" id="mediaForm" action="${ctx}/admin/sa/wechat/addMediaForm0" method="post">
				<input type="hidden" name="isMul" value="0">
				<input type="hidden" name="id" value="${(wxInitMessage.id)!}">
                <div class="row span-width">
                    <label>标题</label>
                    <input class="input-large control-text" name="articleTitle" value="${(article.articleTitle)!}" style="width: 450px" type="text" id="i_title"/>
                </div>
                <div class="row span-width">
                    <label>作者<span class="auxiliary-text">(选填)</span></label>
                    <input class="input-large control-text" name="author" value="${(article.author)!}" style="width: 450px" type="text"/>
                </div>
                <div class="row span-width">
                    <span class="auxiliary-text pull-right">大图片建议尺寸：360像素 * 200像素</span><label>封面</label>
                    <div class="well well-small">
                        <ul class="bui-clear">
							<li style="position: relative; float: left; overflow: hidden;">
								<input type="file" id="picFileObj" name="file" value="上传" onchange="javascript:doUpload(this);" style="opacity:0;filter:alpha(opacity:0);z-index:999;cursor:pointer;position: absolute; bottom: 0; right: 0; font-size: 9999px;">
                                <a class="button button-primary" href="#" style="cursor: pointer">上传</a>
							</li>
                        </ul>
						<br>
                        <input type="hidden" id="picUrl" value="${(article.picUrl)!}" name="picUrl">
                        <img id="i_primaryPic" src="${(article.picUrl)!}" style="width: 50px;" <#if (article.picUrl)??><#else>style="display: none;"</#if>>
                    </div>
                </div>
                <div class="row span-width">
                    <label><a href="javascript:summary();">摘要</a></label>
                    <div id="summary" <#if (article.summary)?? && article.summary?length gt 1><#else>style="display: none"</#if>>
                        <textarea class="input-large" id="i_summary" name="summary" style="height: 80px;width: 450px">${(article.summary)!}</textarea>
                    </div>
				</div>
                <div class="row span-width">
					<label>正文<span class="auxiliary-text">(必填,不能超过80000个字符)</span></label>
				<#--
				<textarea class="input-large" name="content" id="content" style="height: 200px;width: 450px">${(article.description)!}</textarea>
				-->
                    <textarea id="content" name="content">${(article.description)!}</textarea>
                </div>

                <#if (wxInitMessage.isInit)?? && wxInitMessage.isInit>
                    <div class="row span-width" style="display: none;">
                        <label>外链地址<span class="auxiliary-text">(设置后，点击图文消息，不会进入图文详情，而进入外链所设地址)</span></label>
                        <input class="input-large control-text" name="url" value="${(article.url)!}" style="width: 450px" type="text" id="i_url"/>
                    </div>
                <#else>
                    <div class="row span-width">
                        <label>外链地址<span class="auxiliary-text">(设置后，点击图文消息，不会进入图文详情，而进入外链所设地址)</span></label>
                        <input class="input-large control-text" name="url" value="${(article.url)!}" style="width: 450px" type="text" id="i_url"/>
                    </div>
                </#if>


                <div class="clearfix"></div>

                <div class="row actions-bar">
                    <div class="form-actions">
                        <a href="javascript:submitCheck();" class="button button-primary">保存</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>

<script type="text/javascript">
    var initMsgId = '${(wxInitMessage.id)!"null"}';
    window.msg_editor = new UE.ui.Editor({
        initialFrameWidth: 450,
        initialFrameHeight: 200,
        elementPathEnabled:false,
        maximumWords:80000,
        imageUrl: window.UEDITOR_HOME_URL +"jsp/imageUp.jsp?entity=weixin&id=" + initMsgId + "&platform=admin",
		imagePath: "",
        contextMenu:[]
    });
    window.msg_editor.render("content");

	//提交检查
	function submitCheck(){
        var flag=true;

		var i_title=$("#i_title").val();
		var picUrl=$("#picUrl").val();
		//var content=$("#content").val();
		var content=window.msg_editor.getContentTxt();

        //标题不能为空且长度不能超过64字
        if(i_title == '' || i_title.length >64){
            alert("标题不能为空且长度不能超过64字");
            flag=false;
            return;
        }

		//图片不能为空
        if(picUrl == '' || picUrl.length <5){
            alert("必须插入一张图片");
            flag=false;
            return;
        }

		//正文不能为空且长度不能超过80000字
        if(content == '' || content.length >80000){
            alert("正文不能为空且长度不能超过80000字");
            flag=false;
            return;
        }

        if(flag){
            $('#mediaForm').submit();
            app.showSuccess("操作成功!");
		}
	}

	$(function(){
		//标题事件
        $('#i_title').on('input',function(){

			var title=$(this).val();
			if(IsNull(title))
            	$("#s_title").html('标题');
			else
                $("#s_title").html(title);
        })

		//摘要事件
		$("#i_summary").on('input',function(){

            var summary=$(this).val();
            if(IsNull(summary))
                $("#s_summary").html('');
            else
                $("#s_summary").html(summary);
        })
	});

	//摘要
	function summary(){
		$("#summary").show();
	}

    function doUpload(obj){
        var picUploadPath = "${ctx}/common/staticAsset/upload/media";
        var validSuccess = true;

        var fileName = obj.value;
        validSuccess = validFile(fileName);
        if(validSuccess){
        $.ajaxFileUpload({
            url : picUploadPath,
            secureuri: false,
            fileElementId: "picFileObj",
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                picUploadSuccessHander(data);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        }
        return false;
    }

    function validFile(fileName){
        if(fileName == null || jQuery.trim(fileName).length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }
        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert(fileName + "文件格式错误!");
            return false;
        }
        var suffix = fileName.substr(suffixIndex + 1);
        suffix = jQuery.trim(suffix).toLowerCase();
        if(suffix.length <= 0 ||
                ("jpg" != suffix && "png" != suffix && "jpeg" != suffix)){
            BUI.Message.Alert(suffix + "文件格式暂不支持!");
            return false;
        }
        return true;
    }

    function picUploadSuccessHander(data){
		var flag=false;
        for(var key in data)
        {
            //把上传成功的图片显示到页面
			var url=data[key];
			//显示在左边封面
            var image_s = $("#s_primaryPic");
            image_s.attr("src", url);
            image_s.attr("data-image-form-type", 'upload');
            image_s.show();

			//显示在右边输入框
            var image_i = $("#i_primaryPic");
            image_i.attr("src", url);
            image_i.css("width", "50");
            image_i.attr("data-image-form-type", 'upload');
            image_i.show();

			//把图片地址存入隐藏域
            $("#picUrl").val(url);

            //设置样式
            $(".media-msg-item").first().addClass("hasimg");

			flag=true;
            break;
        }

    }

	//tools
    //判断字符串是否为空
    function IsNull(str) {
        return (Trim(str) == "") ? true : false;
    }

    //过滤 字符串 中的空格
    function Trim(str) {
        return str.replace(/(^\s*)|(\s*$)/g, "");
    }
</script>
<body>
</html>