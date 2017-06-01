<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title><#if type??>申请售后<#else>申请退换货</#if></title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
    <script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">
	            <#if type??>申请售后<#else>申请退换货</#if>
	            </h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="borderbox">
                <div class="return">
                    <h3>申请类型</h3>
                    <ul class="return-type">
                        <li class="selected" value="1">退款</li>
                        <li value="2">退货</li>
                        <li value="3">换货</li>
                        <input type="hidden" name="returnType" id="returnType" value="1">
                    </ul>
                </div>
            </div>
            <div class="borderbox">
                <div class="return">
                    <h3>是否收到货</h3>
                    <div class="whether">
                        <p><label><input type="radio" id="rad1" name="rdo_addr"  value="true" <#if order.orderStatusCd!=4 && order.orderStatusCd!=5> disabled </#if> >是</label></p>
                        <p><label><input type="radio" id="rad2" name="rdo_addr" checked="checked" value="false">否</label></p>
                    </div>
                </div>
            </div>
            <div class="borderbox">
                <div class="return">
                    <h3 class="border">退款说明</h3>
                    <div class="instructions">
                        <textarea name="whyReturn" id="whyReturn" placeholder="请写下您的退款原因，以便我们更好的为您处理退款。"></textarea>
                    </div>
                    <div class="uploadimg">
                        <ul>
                            <li>
                                <div class="upload-wrap"><input name="file" id="file_pic0" type="file" onchange="selectImg(this.value,'pic0');"></div>
                                <input type="hidden" id="pic0" value="" >
                            </li>
                            <li>
                              <div class="upload-wrap"><input name="file" id="file_pic1" type="file" onchange="selectImg(this.value,'pic1');"></div>
                            	<input type="hidden" id="pic1" value="" >
                            </li>
                            <li>
                            	<div class="upload-wrap"><input name="file" id="file_pic2" type="file" onchange="selectImg(this.value,'pic2');"></div>
                            	<input type="hidden" id="pic2" value="">
                            </li>
                            <li>
								<div class="upload-wrap"><input name="file" id="file_pic3" type="file" onchange="selectImg(this.value,'pic3');"></div>
                            	<input type="hidden" id="pic3" value="" >
                            </li>
                            <li>
                            	<div class="upload-wrap"><input name="file" id="file_pic4" type="file" onchange="selectImg(this.value,'pic4');"></div>
                            	<input type="hidden" id="pic4" value="" >
                            </li>
                            <li class="info">上传图片,最多可以上传5张</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="mui-content-padded mt30 align-center">
            <button type="button" class="mui-btn mui-btn-primary mui-btn-block mb20" onclick="sub();">确定</button>
        </div>
    </div>
 <script type="text/javascript" src="${ctx}/static/admin/js/jquery-1.8.1.min.js"></script>
 <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
<script>
    $(function(){
        $(".return-type li").on("click",function(){
            var obj = $(this);
            obj.addClass("selected").siblings().removeClass("selected");
            $('#returnType').attr('value',obj.attr('value'));
        })
    })
    //提交
    function sub(){
    	var returnType=$('#returnType').val();
    	var isGoods;
	    	if($('#rad1').attr('checked')=='checked'){
				isGoods=$('#rad1').val();
			}else{
				isGoods=$('#rad2').val();
			}
    	var whyReturn=$('#whyReturn').val();
    	var imgUrls='';
    	for(var i=0;i<5;i++){
    		var value=$('#pic'+i).val();
	    		if(value!=''&&value!=null){
	    			imgUrls+=value+',';
	    		}
    	}
    	imgUrls=imgUrls.substring(0,imgUrls.length-1);
    	//字段验证
    	if(whyReturn=='' || whyReturn==null){
    		mui.alert('请写下您的退货原因');
    		return;
    	}
    	if(returnType=='' || returnType==null){
    		mui.alert('请选择退换类型');
    		return;
    	}
    	
    	$.post('${ctx}/m/account/ReturnGoods',
    	{returnType:returnType,isGoods:isGoods,whyReturn:whyReturn,imgUrls:imgUrls,orderId:${(orderId)!}},
    	function(data){
    		if(data.result){
    			mui.toast('申请成功');
    			location.href ="${ctx}/m/account/toReturnGoodsInfo";
    		}else{
    			mui.toast(data.message);
    		}
    	});
    	
    }
    
    
    //图片上传
     function selectImg(fileName,lastFlag,goodsId){
        if(fileName == null || fileName.trim().length <= 0){
            MUI.toast("请选择文件!");
            return false;
        }
        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            MUI.toast("文件格式错误!");
            return false;
        }
        var suffix = fileName.substr(suffixIndex + 1);
        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
	   $.ajaxFileUpload({
            url:'${ctx}/common/staticAsset/upload/comment',
            secureuri: false,
            fileElementId: "file_"+lastFlag,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                loadImage(data.assetUrl,lastFlag);
            },
            error: function (data, status, e) {
                mui.toast("上传失败" + e);
            }
        });
        return false;
    } 
    //设置预览
    function loadImage(assetUrl,lastFlag) {
    	$('#file_'+lastFlag).parent().next().attr('value',assetUrl);
        $('#file_'+lastFlag).parent().parent().append('<a class="delete" onclick="del(this,\''+lastFlag+'\')" style=""></a><div class="pic" id=\"'+lastFlag+'1\"><img src=\"'+assetUrl+'\"></div>');
    }
    function del(obj,id){
    	obj.remove();
    	$('#'+id+'1').remove();
    	$('#'+id).attr('value','');
    }
    
    
</script>
</body>
</html>