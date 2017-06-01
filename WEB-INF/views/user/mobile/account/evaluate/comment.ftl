<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>发表评价</title>
    <script type="text/javascript" src="${staticPath}/js/rateit.js"></script>
    
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">发表评价</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
        <#if order.orderItem??>
         <#list order.orderItem as item>
            <div class="borderbox">
                <ul class="prd-list">
                    <li>
                        <div class="pic">
                            <img src="${(item.productPicUrl)!}">
                        </div>
                        <h3>${(item.productName)!}</h3>
                        <p class="price mt24"><span class="price-real">${(item.salePrice?string.currency)!}/件</span></p>
                    </li>
                </ul>
            </div>

            <div class="borderbox">
                <div class="return">
                    <h3 class="border">描述相符<p class="mui-inline">
                    <span class="rateit" id="eva${item_index}" data-rateit-value="5" data-rateit-readonly="false" data-rateit-starwidth="25" data-rateit-starheight="20">
                    </span></p></h3>
                    <div class="instructions">
                        <textarea id="commentContent${item_index}" placeholder="亲！请写下你宝贵的意见，让我们做得更好！！"></textarea>
                    </div>
                  <div class="uploadimg">
                        <ul>
                            <li>
                                <div class="upload-wrap"><input name="file" id="file_pic1_${(item.productId)!}" type="file" onchange="selectImg(this.value,'pic1','${(item.productId)!}');"></div>
                                <input type="hidden" id="pic0_${(item_index)}" value="1" name="${(item.productId)!}">
                            </li>
                            <li>
                              <div class="upload-wrap"><input name="file" id="file_pic2_${(item.productId)!}" type="file" onchange="selectImg(this.value,'pic2','${(item.productId)!}');"></div>
                            	<input type="hidden" id="pic1_${(item_index)}" value="1" name="${(item.productId)!}">
                            </li>
                            <li>
                            	<div class="upload-wrap"><input name="file" id="file_pic3_${(item.productId)!}" type="file" onchange="selectImg(this.value,'pic3','${(item.productId)!}');"></div>
                            	<input type="hidden" id="pic2_${(item_index)}" value="1" name="${(item.productId)!}">
                            </li>
                            <li>
								<div class="upload-wrap"><input name="file" id="file_pic4_${(item.productId)!}" type="file" onchange="selectImg(this.value,'pic4','${(item.productId)!}');"></div>
                            	<input type="hidden" id="pic3_${(item_index)}" value="1" name="${(item.productId)!}">
                            </li>
                            <li>
                            	<div class="upload-wrap"><input name="file" id="file_pic5_${(item.productId)!}" type="file" onchange="selectImg(this.value,'pic5','${(item.productId)!}');"></div>
                            	<input type="hidden" id="pic4_${(item_index)}" value="1" name="${(item.productId)!}">
                            </li>
                            <li class="info">上传图片,最多可以上传5张</li>
                        </ul>
                    </div>   
                </div>
            </div>
            </#list>
	    </#if>
            <div class="borderbox">
                <div class="return">
                    <h3 class="border">店铺评价</h3>
                    <ul class="comment">
                        <li><em>配送速度</em><p class="mui-inline">
                        <span id="distribution" class="rateit" data-rateit-value="5" data-rateit-readonly="false" data-rateit-starwidth="25" data-rateit-starheight="20"></span></p></li>
                        <li><em>服务评价</em><p class="mui-inline">
                        <span id="service" class="rateit" data-rateit-value="5" data-rateit-readonly="false" data-rateit-starwidth="25" data-rateit-starheight="20"></span></p></li>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap fbbwrap-total">
                <div class="ftbtnbar">
                    <div class="content-wrap">
                    </div>
                    <div class="button-wrap">
                        <a class="button" onclick="sub();">发表</a>
                    </div>
                </div>
            </div>
        </div>
        	
    </div>
 <script type="text/javascript" src="${ctx}/static/admin/js/jquery-1.8.1.min.js"></script>
 <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
 <script type="text/javascript" src="${ctx}/static/admin/js/common/page.js"></script>
 <script> 
 	function sub(){
 		var goodsCnt='${(order.orderItem?size)!'0'}';
 		var eva='';//商品符合程度
 		var imgUrls='[';
 		var commentContent='';//商品评价内容
 		var distribution=Math.round($('#distribution').attr('data-rateit-value'));//配送评价
 		var service=Math.round($('#service').attr('data-rateit-value'));//服务评价
 		for(var i=0;i<goodsCnt;i++){
 			var value=Math.round($('#eva'+i).attr('data-rateit-value'));
 			eva+=value+',';
 			
 			for(var j=0;j<5;j++){
 			var name=$('#pic'+j+'_'+i);
 				imgUrls+='{';
 				imgUrls+="goodsId:'"+name.attr('name')+"',imgUrl:'"+name.val()+"'";
 				imgUrls+='},';
 			}
 		}
 		imgUrls=imgUrls.substring(0,imgUrls.length-1);
 		imgUrls+=']';
 		for(var i=0;i<goodsCnt;i++){
 			var value=$('#commentContent'+i).val();
 			commentContent+=value+' ,';
 		}
 		$.post('${ctx}/m/account/addComment',{eva:eva,distribution:distribution,service:service,orderId:${(order.orderId)!},commentContent:commentContent,imgUrls:imgUrls},function(data){
 			if(data){
 				mui.toast('评价成功');
 				location.href="${ctx}/m/account/toEvaluation";
 			}else{
 				mui.toast('评价失败');
 			}
 		});
 	}
 
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
            fileElementId: "file_"+lastFlag+"_"+goodsId,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
            	var id=lastFlag+"_"+goodsId;
                loadImage(data.assetUrl,id);
               
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
        $('#file_'+lastFlag).parent().parent().append('<a class="delete" onclick="del(this,\''+lastFlag+'\')" style=""></a><div class="pic" id=\"'+lastFlag+'\"><img src=\"'+assetUrl+'\"></div>');
    }
    function del(obj,id){
    	obj.remove();
    	$('#'+id).remove();
    }
 </script>
</body>
</html>