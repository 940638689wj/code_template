<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<#assign  adminRealName = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getAdminRealName()?default("")/>


<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
	<title>管理收货地址</title>
</head>
<body>

 <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href='${ctx}/m/account/info/personalData'></a><!--${ctx}/m/account"-->
		            <h1 class="mui-title">管理收货地址</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
  <div class="mui-content">
          <#if userAddressList?? && userAddressList?has_content> 
              <ul class="addresslist">
                <#list userAddressList as one>
	             <li>
		          <div class="addr-item">
                        <span class="name">${one.receiverName!?html}</span>
			           <span class="phone"><#if one.receiverTel??>${one.receiverTel!}</#if></span>
			           <address>${one.provinceName!?html} ${one.cityName!?html} ${one.countyName!?html} ${one.receiverAddr!?html}</address>
		          </div>
			      <div class="edit-wrap">
                        <label><input type="radio" data-value="${(one.addrId)!}" name="rdo_addr" <#if (one.isDefaultAddr)==1>checked="checked"</#if>/>默认地址</label>                       
                        <div class="edit-bar">                               
                            <a href="${ctx}/m/account/address/${one.addrId!}"><i class="ico ico-edit"></i>编辑</a>
                            <a href="javascript:void(0)" id="J_ButtonDel" class="button-wrap" data-value="${one.addrId!}"><i class="ico ico-delete"></i>删除</a>
                        </div>
                   </div>
                </li>
			  </#list>
			  <#else>
	           <div class="mui-content">
            <div class="iconinfo">
                <i class="ico ico-addempty"></i>
                <strong>还没设置收货地址</strong>
                <p>会收不到商品哦！</p>
            </div>
        </div>
	          </#if>
	      </ul>
    </div>
        <div class="fbbwrap">
            <div class="mainbtnbar"><a href="${ctx}/m/account/address/addUserAddress" class="address_btn">新增收货地址</a></div>
        </div>
    </div>

 
  <script type="text/javascript">
$(document).ready(function() {
   //设置默认
 $("input[type='radio']").change(function() {
       var obj=$(this);
              var addrId=$(obj).attr("data-value");
                  $.post('${ctx}/m/account/address/setDefault',{'addrId':addrId},function(data){
	               	if(data){
                   		mui.toast('设置成功！');
                   		window.location.href="${ctx}/m/account/address/userAddressManage";
	               	}else{
	               		mui.toast('设置失败！');
	               		window.location.href="${ctx}/m/account/invoice/userAddressManage";
	               	}
               });
             });
//删除
        $(".button-wrap").on("click",function(){
         if($(this).hasClass("ico ico-delete")) return;
            var obj = $(this);
            var btnArray = ['确认', '取消'];
            mui.confirm('', '是否确认删除？', btnArray, function(e) {
               if (e.index == 0) {
               var addrId=$(obj).attr("data-value");
               $.post('${ctx}/m/account/address/delete',{'addrId':addrId},function(data){
	               	if(data){
                   		mui.toast('成功删除！');
                   		window.location.href="${ctx}/m/account/address/userAddressManage";
	               	}else{
	               		mui.toast('删除失败！');
	               	}
               });
                   
               }
            })
          });
 })
    
</script>
    
    
</body>
</html>