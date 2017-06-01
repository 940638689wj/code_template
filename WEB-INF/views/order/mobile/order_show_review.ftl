<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>评价订单</title> 
	<script src="${ctx}/static/js/ajaxupload.js" type="text/javascript"></script>
	<!-- <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script> -->
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="javascript:history.back()"></a>
	        <h1 class="mui-title">评价订单</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
        <input type="hidden" name="orderId" id="orderId" value="${orderId}" />
        <div class="mui-content">
    	<#list orderItemList as orderItem>
            <div class="borderbox">
                <ul class="prd-list">
                	<li>
	                    <div class="pic">
	                        <img class="lazyload" src="${ctx}/static/mobile/images/blank.gif" data-src="${orderItem.productPicUrl!}" alt=""/>
	                    </div>
	                    <h3>${orderItem.productName!}</h3>
                    <p class="price mt18"><span class="price-real">￥<em>${orderItem.salePrice}</em><!--￥<em>1290.00</em>--></span></p>
                	</li>
            	</ul>
       		 </div>

            <div class="borderbox">
            <div class="return">
                <input type="hidden" name="productId" value="${orderItem.productId!}" />
                <h3 class="border">评价<p class="mui-inline">
                    <span name="score" class="rateit" data-rateit-value="0" data-rateit-readonly="false" data-rateit-starwidth="25" data-rateit-starheight="20" data-rateit-step="1"></span>
                </p></h3>
                <div class="instructions">
                    <textarea name="reviewContent" placeholder="请写下您的评价。"></textarea>
                </div>
            </div>
        </div>
        </#list>

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in">
                        <!--<div class="l"><label><input type="checkbox">匿名评价</label></div>-->
                    </div>
                </div>
                <div class="button-wrap">
                    <a class="button">评论</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
	$(function(){
//    	//初始化节点，绑定上传图片插件的方法
//    	$("div[name^='file_mPortrait_']").each(function(){
//    		initializeImg($(this)[0]);
//    	});
//	    function initializeImg(filemPortrait){
//	    	//find返回的是数据，这里估计默认是第一个
//	    	var imageViewmPortrait = $(filemPortrait).find('div');
//	    	var photoUrl = $(filemPortrait).find('input');
//	    	//初始化图片上传模块
//	    	init(filemPortrait,imageViewmPortrait,photoUrl,'');
//	    	//$(filemPortrait).trigger("click");
//	    }
	    
//	   function init(btnName,imgName,hidName,linkId) {
//	        //初始化图片上传
//	        g_AjxUploadImg(btnName, imgName, hidName,linkId);
//	    }
	    
	    
	    $(".button").click(function () {
        	var param = {};
            param.orderId = $("#orderId").val();
            param.productId = getList("input", "productId");
            param.reviewContent = getList("textarea", "reviewContent");
            var reviewContent = getList("textarea", "reviewContent");
            for(var i = 0; i < reviewContent.length; i++){
            	if(reviewContent[i] == ""){
            		mui.toast("评价内容为空!");
            		return;
            	}
            }
            var scoreIsNull =  $("span[name='score']");
            for(var j = 0; j < scoreIsNull.length; j++){
            	if($(scoreIsNull[j]).attr('data-rateit-value') == 0){
            		mui.toast("评分为空!");
            		return;
            	}
            }
            var score = [];
            $("span[name='score']").each(function () {
                score.push($(this).attr('data-rateit-value'));
            });
            param.score = score;
//            //将图片打包成数组中的数据
//            var reviewPic = [];
//            $("div[class = 'uploadimg']").each(function (index) {
//                var pic = [];
//                var aryPic = $(this).find('input');
//                aryPic.each(function () {
//                    pic.push($(this).val());
//                });
//                reviewPic[index] = pic;
//            });
//            param.reviewPic = reviewPic;
            $.ajax({
                type: "POST",
                url: "${ctx}/account/orderHeader/saveReview",
                data: JSON.stringify(param),//将对象序列化成JSON字符串
                dataType: "json",
                contentType: 'application/json;charset=utf-8', //设置请求头信息
                success: function (data) {
                    if (data && data.result == "success") {
                        mui.toast("评价成功！");
                        window.location.href = "${ctx}/m/account/groupOrder?type=0";
                    } else {
                        mui.toast("不可重复评价");
                    }
                }
            });
   		 });
        function getList(type,name) {
            var list = [];
            $(type+ "[name='"+name+"']").each(function () {
                list.push($(this).val());
            });
            return list;
        }
	});
//        //图片删除按钮
//	    function delBtn(del) {
//	        $(del).closest('div').find('img').attr('src','');
//	    }
        
    <#--//图片上传-->
    <#--function g_AjxUploadImg(btn, img, hidPut,linkId) {-->
        <#--new AjaxUpload(btn, {-->
           <#--action: '${ctx}/common/staticAsset/upload/user/',-->
            <#--data: {},-->
            <#--name: 'file',-->
            <#--onSubmit: function(file, ext) {-->
                <#--if (!(ext && /^(jpg|JPG|png|PNG|gif|GIF)$/.test(ext))) {-->
                    <#--alert("您上传的图片格式不对，请重新选择！");-->
                    <#--return false;-->
                <#--}-->
            <#--},-->
            <#--onComplete: function(file, response) {-->
                <#--var data = JSON.parse(response);-->
                <#--if (data) {-->
                	<#--/*$.ajax({-->
			              <#--url : '${ctx}/m/account/orderHeader/saveMobileReview',-->
			              <#--dataType : 'json',-->
			              <#--type: 'post',-->
			              <#--data : {imgUrl: data.assetUrl},-->
			              <#--success : function(data){-->
			              <#--}-->
       				<#--});*/-->
			        <#--mui.toast("上传成功！");-->
       				<#--//1.预览图片信息-->
                    <#--hidPut.value = data.assetUrl;-->
                    <#--$(btn).find("img").attr("src",data.assetUrl);-->
                    <#--$(btn).find("input").attr("value",data.assetUrl);-->
                <#--}else{-->
                    <#--alert("头像上传失败！");-->
                <#--}-->
            <#--}-->
        <#--});-->
    <#--}-->
</script>
</body>
</html>