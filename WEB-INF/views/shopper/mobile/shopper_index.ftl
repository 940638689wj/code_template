<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <title>我的账户</title>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/index"></a>
	        <h1 class="mui-title">我的账户</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="welcometop mycenterbar personalaccount">
            <div class="hd" <#if (shopper.photoUrl)?has_content>style="background-image: url(${shopper.photoUrl!});"<#else>style="background-image: url(/static/mobile/images/logo.png);"</#if>><a href="${ctx}/m/shopper/personalData">个人资料</a></div>
            <div class="bd">
                <div class="info">亲爱的${shopper.shopperName}，您好！</div>
            </div>
        </div>
        <div class="borderbox">
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink" href="${ctx}/m/shopper/personalData">
                            <div class="c"><i class="icon personal"></i>个人资料</div>
                        </a>
                    </li>
                     <li>
                        <a class="itemlink" href="${ctx}/m/shopper/deliveryOrder?type=1">
                            <div class="c"><i class="icon order"></i>我的派送单</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/shopper/statements">
                            <div class="c"><i class="icon order"></i>对账单</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/shopper/change_password">
                            <div class="c"><i class="icon modify"></i>账户安全</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="javascript:logout()">
                            <div class="c"><i class="icon exit"></i>退出登录</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

    </div>
</div>
	<script>
		 function logout(){
		    	var btnArray = ['取消', '确认'];
		    		mui.confirm('', '确认退出登录吗？', btnArray, function(e) {
		    			  if (e.index == 0) {
		            		} else {
								$.post('${ctx}/m/shopper/logout',{},function(data){
						    		if(data){
						    				location.href= '${ctx}/m/shopper/login';
						    		}
						    	});
						      }
		        });
			
			}
	
	</script>

    
</body>
</html>