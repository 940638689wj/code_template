<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

    <script type="text/javascript">
        /*该变量设置必需在引入ueditor.all.js、ueditor.config.js之前，否则ueditor国际化文件无法记载，导致360浏览器无法显示*/
        window.UEDITOR_HOME_URL = "${ctx}/static/admin/js/ueditor/";
    </script>
</head>
<body>

<div class="container">
    <ul class="breadcrumb">
        <li class="active">素材管理</li>
    </ul>
    <form id="J_Form" action="${ctx}/admin/sa/wechat/addMediaForm1" method="post">
        <input type="hidden" name="id" value="${(wxInitMessage.id)!}">
		<#assign articleFirst=(article)! />

        <div class="wx-media-preview-area">
            <div class="wxappmsg">
                <div id="J_wxmsg_content">
                    <div class="media-msg-item <#if (articleFirst.picUrl)??>hasimg</#if>">
                        <div style="">
                            <input type="hidden" name="h_title" value="${(articleFirst.articleTitle)!}">
                            <input type="hidden" name="h_picUrl" value="${(articleFirst.picUrl)!}">
                            <input type="hidden" name="h_author" value="${(articleFirst.author)!}">
                            <input type="hidden" name="h_url" value="${(articleFirst.url)!}">
                            <input type="hidden" name="h_articleId" value="${(articleFirst.articleId)!}">
                            <textarea style="display: none" name="h_content">${(articleFirst.description)!}</textarea>
                            <#--
                                <input type="hidden" name="h_content" value="${(articleFirst.description)!}">
                            -->
                        </div>

                        <div class="wx-media-cover">
                            <div class="wxmsg-thumb-wrp">
                                <i class="wxmsg-thumb">封面图片</i>
                                    <img class="wxmsg-thumb" id="primaryPic" src="${(articleFirst.picUrl)!}" alt=""/>
                            </div>
                            <h4 class="wxmsg-title">
                                <a href="javascript:;">${(articleFirst.articleTitle)!}</a>
                            </h4>
                            <div class="wxmsg-edit-mask">
                                <a class="wxicon edit-gray" href="javascript:void(0);">编辑</a>
                            </div>
                        </div>
                    </div>

                    <#if articles?has_content && articles?size gt 1>
                        <#list articles as art>
                            <#if art.articleId?string != articleFirst.articleId?string>
                                <div class="media-msg-item <#if (art.picUrl)??>hasimg</#if>">
                                    <input type="hidden" name="h_title" value="${(art.articleTitle)!}">
                                    <input type="hidden" name="h_picUrl" value="${(art.picUrl)!}">
                                    <input type="hidden" name="h_author" value="${(art.author)!}">
                                    <input type="hidden" name="h_url" value="${(art.url)!}">
                                    <input type="hidden" name="h_articleId" value="${(art.articleId)!}">
                                    <textarea style="display: none" name="h_content">${(art.description)!}</textarea>
                                    <#--
                                    <input type="hidden" name="h_content" value="${(art.description)!}">
                                    -->

                                    <div class="wxmsg-thumb-wrp">
                                        <i class="wxmsg-thumb">缩略图</i>
                                        <img class="wxmsg-thumb" src="${(art.picUrl)!}" style="width: 75px"  alt=""/>
                                    </div>
                                    <h4 class="wxmsg-title">
                                        <a href="javascript:;">${(art.articleTitle)!}</a>
                                    </h4>
                                    <div class="wxmsg-edit-mask">
                                        <a class="wxicon edit-gray" href="javascript:void(0);" >编辑</a>
                                        <a class="wxicon del-gray" href="javascript:void(0);">删除</a>
                                    </div>
                                </div>
                            </#if>
                        </#list>
                    <#else>
                        <div class="media-msg-item">
                            <input type="hidden" name="h_title" value="">
                            <input type="hidden" name="h_picUrl" value="">
                            <input type="hidden" name="h_author" value="">
                            <input type="hidden" name="h_url" value="">
                            <input type="hidden" name="h_articleId" value="">
                            <textarea style="display: none" name="h_content"></textarea>
                            <#--
                            <input type="hidden" name="h_content" value="">
                            -->

                            <div class="wxmsg-thumb-wrp">
                                <i class="wxmsg-thumb">缩略图</i>
                                <img class="wxmsg-thumb" src="" alt=""/>
                            </div>
                            <h4 class="wxmsg-title">
                                <a href="javascript:;">标题</a>
                            </h4>
                            <div class="wxmsg-edit-mask">
                                <a class="wxicon edit-gray" href="javascript:void(0);" >编辑</a>
                                <a class="wxicon del-gray" href="javascript:void(0);">删除</a>
                            </div>
                        </div>
                    </#if>
                </div>
                <div class="wxmsg-add">
                    <a href="javascript:void(0);" onclick="increaseOne();">
                        <i class="wxicon add-gray">增加一条</i>
                    </a>
                </div>
            </div>
        </div>

        <div class="wx-media-edit-area">
            <div id="J_wxapp_editer" class="wxappmsg-editor">
                <div class="row span-width">
                    <label>标题</label></br>
                    <input class="input-large control-text" id="title" style="width: 450px" value="${(articleFirst.articleTitle)!}" type="text"/>
                    </br>
                </div>
                <div class="row span-width">
                    <label>作者<span class="auxiliary-text">（选填）</span></label></br>
                    <input class="input-large control-text" id="author" value="${(articleFirst.author)!}" style="width: 450px" type="text"/>
                    </br>
                </div>
                <div class="row span-width">
                    <span class="auxiliary-text pull-right">大图片建议尺寸：360像素 * 200像素</span><label>封面</label>
                    <div class="well well-small">
                        <ul class="bui-clear">
                            <li style="position: relative; float: left; overflow: hidden;">
                                <input type="file" id="picFileObj" name="file" value="上传" onchange="javascript:doUpload(this);" style="opacity:0;filter:alpha(opacity:0);z-index:999;cursor:pointer;position: absolute; bottom: 0; right: 0; font-size: 9999px;">
                                <a class="button button-primary" href="javascript:void(0);" style="cursor: pointer">上传</a>
                            </li>
                        </ul>
                        <br>
                        <img id="picUrl" src="${(articleFirst.picUrl)!}" style="width: 50px" <#if (articleFirst.picUrl)??><#else>style="display: none;"</#if>>
                    </div>
                </div>
                <div class="row span-width">
                    <label>正文<span class="auxiliary-text">(必填,不能超过80000个字符)</label></br>
                    <#--
                        <textarea class="input-large" id="content" style="height: 250px;width: 450px">${(articleFirst.description)!}</textarea>
                    -->
                    <textarea id="content" name="content">${(articleFirst.description)!}</textarea>
                </div>

                <#if (wxInitMessage.isInit)?? && wxInitMessage.isInit>
                    <div class="row span-width" style="display: none;">
                        <label>外链地址<span class="auxiliary-text">(设置后，点击图文消息，不会进入图文详情，而进入外链所设地址)</span></label></br>
                        <input class="input-large control-text" id="url" value="${(articleFirst.url)!}" style="width: 450px" type="text"/>
                    </div>
                <#else>
                    <div class="row span-width">
                        <label>外链地址<span class="auxiliary-text">(设置后，点击图文消息，不会进入图文详情，而进入外链所设地址)</span></label></br>
                        <input class="input-large control-text" id="url" value="${(articleFirst.url)!}" style="width: 450px" type="text"/>
                    </div>
                </#if>

                <div class="clearfix"></div>

                <div class="row actions-bar">
                    <div class="form-actions">
                        <a href="javascript:submitCheck();" class="button button-primary">保存</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/bui-min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/config-min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>

<script type="text/javascript">
    var picUploadPath = "${ctx}/admin/adminAsset/weixin/pic/uploadAssets";
	var maxNewsCount=8;//图文最大数目

	var curEditIndex=0;//当前所编辑的位置索引
    var curEditContainer;//当前所编辑的内容
    var curEditContainerJquery;//当前所编辑的内容,jquery对像

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

	//正文事件
    window.msg_editor.addListener("contentChange",function(){
        curEditContainer=$(".media-msg-item").get(curEditIndex);
        var h_content=curEditContainer.getElementsByTagName("textarea")[0];

		//alert(h_content.value);
		//alert(h_content.innerText);
        //var content=window.msg_editor.getContent();
        if(window.msg_editor.hasContents()){
            h_content.innerText=window.msg_editor.getContent();
        }else
        {
            h_content.innerText="";
        }
    });

    //提交检查
    function submitCheck(){
        var flag=true;

		//循环每一个 container,检查里面的内容........
        $(".media-msg-item").each(function(i,val){
            var tempContainer=val;

            var h_title=tempContainer.getElementsByTagName("input")[0];

            var h_content=tempContainer.getElementsByTagName("textarea")[0];

            var h_picUrl=tempContainer.getElementsByTagName("input")[1];

            //标题不能为空且长度不能超过64字
            if(h_title.value == '' || h_title.value.length >64){
                alert("第 "+(i+1)+" 条图文的标题不能为空且长度不能超过64字");
				flag=false;
                return false;
            }

            //图片不能为空
            if(h_picUrl.value == '' || h_picUrl.value.length <5){
                alert("第 "+(i+1)+" 条图文必须插入一张图片");
                flag=false;
                return false;
            }

            //正文不能为空且长度不能超过80000字
            if(h_content.innerText == '' || h_content.innerText.length >80000){
                alert("第 "+(i+1)+" 条图文的正文不能为空且长度不能超过80000字");
                flag=false;
                return false;
            }
        });

		if(flag){
            $('#J_Form').submit();
            app.showSuccess("操作成功!");
		}
    }

	//增加一条
	function increaseOne(){
		var articleContainerArray=$(".media-msg-item");
		if(articleContainerArray.length>=8){
            alert("最多只能加入8条图文信息!");
			return ;
		}

        var lastArticleContainer=articleContainerArray.last();
		var cloneArticleContainer=lastArticleContainer.clone(true);
		cloneArticleContainer.removeClass("hasimg");

		//清空复制过来的值
        var inputArr=cloneArticleContainer.find("input");
        inputArr.each(function (){
            $(this).val("");
        });

        var imgArr=cloneArticleContainer.find("img");
        imgArr.each(function (){
            $(this).attr('src','');
        });

        var aArr=cloneArticleContainer.find("a")[0];
        aArr.innerHTML='';

        var textarea=cloneArticleContainer.find("textarea")[0];
        textarea.innerText="";

        cloneArticleContainer.insertAfter(lastArticleContainer);
	}

	$(function(){
        //点击删除一条
        $('#J_wxmsg_content').on('click','.del-gray',function(){
			if($(".media-msg-item").length<3){
                alert('无法删除，多条图文至少需要2条消息!');
				return ;
			}

            var delItem = $(this).closest('.media-msg-item');
            var delIndex=$(".media-msg-item").index(delItem);

            BUI.Message.Confirm('确认要删除此消息？',function(){
                delItem.remove();
            },'question');
        });

        //点击左侧 编辑按钮 后
        $('#J_wxmsg_content').on('click','.edit-gray',function(){
            //1.右侧编辑器移动,改变 curEditIndex 值
            var editItem = $(this).closest('.media-msg-item');
            curEditContainerJquery=editItem;

            curEditIndex=$(".media-msg-item").index(editItem);
            curEditContainer=$(".media-msg-item").get(curEditIndex);

            var editor = $('#J_wxapp_editer');
            var top = editItem.position().top;
            editor.css('margin-top',top);

			//2.左侧对应 articleContainer里的值 填充回 编辑器里
            var h_title=curEditContainer.getElementsByTagName("input")[0];
            $("#title").val(h_title.value);

            var h_content=curEditContainer.getElementsByTagName("textarea")[0];
            window.msg_editor.setContent(h_content.innerText);
            //$("#content").val(h_content.value);

            var h_author=curEditContainer.getElementsByTagName("input")[2];
            $("#author").val(h_author.value);

            var h_url=curEditContainer.getElementsByTagName("input")[3];
            if(h_url.value == ""){
                $("#url").val("");
            }else{
                $("#url").val(h_url.value);
            }

            var h_picUrl=curEditContainer.getElementsByTagName("input")[1];
            if(h_picUrl.value == ""){
                $("#picUrl").hide();
            }else{
                $("#picUrl").attr("src",h_picUrl.value);
                $("#picUrl").show();
			}
        });

        //标题事件
        $('#title').on('input',function(){
           curEditContainer=$(".media-msg-item").get(curEditIndex);
            var s_title=curEditContainer.getElementsByTagName("a")[0];
            var h_title=curEditContainer.getElementsByTagName("input")[0];

            var title=$(this).val();
            if(title != ""){
                s_title.innerText=title;
                h_title.value=title;
            }else
            {
                s_title.innerText='标题';
                h_title.value="";
            }
        });

        //author事件
        $('#author').on('input',function(){
           curEditContainer=$(".media-msg-item").get(curEditIndex);
            var h_author=curEditContainer.getElementsByTagName("input")[2];

            var author=$(this).val();
            if(author != ""){
                h_author.value=author;
            }else
            {
                h_author.value="";
            }
        });

        //外链地址事件
        $('#url').on('input',function(){
           curEditContainer=$(".media-msg-item").get(curEditIndex);
            var h_url=curEditContainer.getElementsByTagName("input")[3];

            var url=$(this).val();
            if(url != ""){
                h_url.value=url;
            }else
            {
                h_url.value="";
            }
        });
	});

    //---上传图片
    function uploadPic(){
        $("#picFileObj").click();
    }

    function doUpload(obj){
        var picUploadPath = "${ctx}/common/staticAsset/upload/media";
        var validSuccess = true;

        var fileName = obj.value;
        validSuccess = validFile(fileName);
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
        for(var key in data)
        {
            //把上传成功的图片显示到页面
            var url=data[key];

			if(curEditIndex == 0)
			{//左侧封面图片
                var image_primary = $("#primaryPic");
                image_primary.attr("src", url);
                image_primary.show();
			}else
			{//左侧缩略图
                curEditContainer=$(".media-msg-item").get(curEditIndex);
                var img=curEditContainer.getElementsByTagName("img")[0];
                img.src=url;
			}

            //显示在右边输入框
            var picUrl = $("#picUrl");
            picUrl.attr("src", url);
            picUrl.css("width", "50");
            picUrl.show();

			//设置隐藏域值
            curEditContainer=$(".media-msg-item").get(curEditIndex);
            var h_picUrl=curEditContainer.getElementsByTagName("input")[1];
            h_picUrl.value=url;

			//设置样式
			if(curEditIndex != 0)
			{
                curEditContainerJquery.addClass("hasimg");
			}else
			{
                $(".media-msg-item").first().addClass("hasimg");
			}

            break;
        }
    }
</script>
<body>
</html>