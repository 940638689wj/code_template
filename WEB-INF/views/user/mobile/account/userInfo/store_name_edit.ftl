<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<meta charset="UTF-8">
<title>微店管理</title>
<!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />-->
<style>
	.cansave{
		color:white;
	}
	.notsave{
		color:gray;
	}
</style>
</head>
<body>
    <div id="page">
	        <header class="mui-bar mui-bar-nav">
	            <span class="mui-icon" onclick="javascript:window.location.href='${ctx}/m/account/mstoreUser/toStoreManagement'" style="font-size:18px;color:white;">取消</span>
	            <h1 class="mui-title"></h1>
	            <span class="mui-icon notsave" id="savebtn"  style="font-size:18px;" onclick="save(this)">保存</span>
	        </header>


		        <div class="mui-content">
            <ul class="tbviewlist">
                <li class="input-wrap">
                    <div class="bd"><input type="text" id="username" oninput="changeName()" value="${mstore.mstoreName!}" style="font-size:18px;"></div>
                    <span class="delete"></span>
                </li>
            </ul>
        </div>

    </div>
<script>

function save(obj){
	if($(obj).hasClass("cansave")){
		var storeName = $("#username").val();
		if(storeName != ''){
			window.location.href = '${ctx}/m/account/mstoreUser/editStoreName/'+storeName; 
		}else{
			mui.toast("店铺名不能为空！");
		}
	}
}

function changeName(){
	var storeName = $("#username").val();
	if(storeName != '${mstore.mstoreName}' && storeName != ''){
		$("#savebtn").addClass("cansave");
		$("#savebtn").removeClass("notsave");
	}else{
		$("#savebtn").removeClass("cansave");
		$("#savebtn").addClass("notsave");
	}
}


</script>
</body>
</html>