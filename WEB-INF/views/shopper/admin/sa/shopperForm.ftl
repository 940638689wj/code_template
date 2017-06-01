<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <#if shopper?? && shopper?has_content && shopper.shopperId?has_content>
	    <div class="title-bar">
	        <div id="tab">
	            <ul class="breadcrumb" aria-disabled="false" aria-pressed="false">
	                 <li aria-disabled="false" aria-pressed="false"><a href="${ctx}/admin/sa/shopper/toShopperList">配送员列表</a><span class="divider">&gt;&gt;</span></li>
	                 <li class="active">配送员信息</li>
	            </ul>
	        </div>
	        <ul class="bui-tab nav-tabs">
                <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">基本信息</span></li>
            </ul>
	    </div>
    <#else>
	    <div class="title-bar">
	        <div id="tab"></div>
	    </div>
    </#if>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/shopper/<#if shopper?? && shopper?has_content && shopper.shopperId?has_content>updateShopper<#else>addShopper</#if>" method="post">
    	<input type="hidden" id="shopperId" name="shopperId" value="<#if (shopper.shopperId)?has_content>${shopper.shopperId}</#if>">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>编号：</label>
                    <div class="controls">
                        <input value="${(shopper.shopperNum)!?html}" id="shopperNum" name="shopperNum" data-rules="{required:true}" class="input-normal control-text">
                        <span id="shopperNumInfo" class="x-field-error"></span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>姓名：</label>
                    <div class="controls">
                        <input value="${(shopper.shopperName)!?html}" name="shopperName" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>性别：</label>
                    <div class="controls" data-rules="{required:true}">
                        <label><input type="radio" name="sexCd" value="0" checked="checked" /> 男</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <label><input type="radio" name="sexCd" value="1" <#if shopper??&&shopper?has_content &&shopper.sexCd=1>checked="checked"</#if> /> 女</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>联系方式：</label>
                    <div class="controls">
                        <input value="${(shopper.phone)!?html}" id="phone" name="phone" data-rules="{required:true}" class="input-normal control-text">
                        <span id="phoneInfo" class="x-field-error"></span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>身份证号：</label>
                    <div class="controls">
                        <input value="${(shopper.identityNum)!?html}" id="identityNum" name="identityNum" data-rules="{required:true}" class="input-normal control-text">
                        <span id="identityNumInfo" class="x-field-error"></span>
                    </div>
                </div>
            </div>
			<div class="row mb25">
                <div class="control-group">
                    <label class="control-label">照片：</label>
                     <div class="controls control-row-auto">
                     	<div class="file-btn">
                            <button class="button button-primary">上传</button>
                            <input id="file_cardBackImage" class="inp-file" name="file" type="file" onchange="javascript:assetChange(this.value,'cardBackImage');">
                        </div>
                    		<button class="button" type="button" onclick="delItem();" >删除</button>
                    
                    <#assign a = true>
	                    <#if (shopper.photoUrl)?has_content>
	                    	<#assign a = false>
	                    </#if>
                    	<div id="imgshow" class="mt5" <#if a>style="display:none;"</#if>>
	                        <input type="hidden" id="photoUrl" name="photoUrl" value="<#if (shopper.photoUrl)?has_content>${shopper.photoUrl}</#if>" class="input-normal control-text" >
							<img id="imageView_cardBackImage" class="pull-left" width="100px" height="100px" src="<#if (shopper.photoUrl)?has_content>${shopper.photoUrl}</#if>" >
                        </div>
					</div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="color:red"><s>*</s>扣除佣金比例：</label>
                    <div class="controls">
                        <input value="${(shopper.deductCommissonRate)!?html}" name="deductCommissonRate" data-rules="{required:true,regexp:/^(0)$|^100$|^[1-9][0-9]?$/}" data-messages="{regexp:'请输入正确的佣金比例！'}" class="input-normal control-text "><s style="color:red">%</s>
                    </div>
                </div>
            </div>

            <div class="actions-bar mt5"></div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>账户：</label>
                    <div class="controls">
                        <#if shopper??&&shopper.userName?has_content>
                        	<span >&nbsp;&nbsp;${(shopper.userName)!?html}</span>
                        <#else>
                        	<input id="userName" name="userName" data-rules="{required:true,}"  class="input-normal control-text">
                        	<span id="userNameInfo" class="x-field-error"></span>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>密码：</label>
                    <div class="controls">
                        <input id="password" value="${(shopper.password)!?html}" name="password" data-rules="{required:true,regexp:/^[0-9_a-zA-Z]{6,16}$/}" data-messages="{regexp:'密码最少为6位,不应超过16位！'}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>确认密码：</label>
                    <div class="controls">
                        <input name="rePassword" data-rules="{required:true,equalTo:'#password'}"  class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <div class="controls" data-rules="{required:true}">
                        <label><input type="radio" name="statusCd" value="1" checked="checked" /> 是</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <label><input type="radio" name="statusCd" value="0" <#if shopper??&&shopper?has_content &&shopper.statusCd=0>checked="checked"</#if> /> 否</label>
                    </div>
                </div>
            </div>
            <div class="actions-bar">
                <button type="submit" id="save" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
	<#if shopper?? && shopper?has_content && shopper.shopperId?has_content><#else>
		var search;
		var grid;
	    var Tab = BUI.Tab;
	    var tab = new Tab.Tab({
	        render : '#tab',
	        elCls : 'nav-tabs',
	        autoRender: true,
	        children:[
	            {text:'配送员列表',value:'0'},
	            {text:'新增配送员',value:'1'}
	        ]
	    });
	    tab.setSelected(tab.getItemAt(1));
	    
	    tab.on('selectedchange',function (ev) {
		        var item = ev.item;
		        if(item.get('value')=="0"){
		            window.location.href = "${ctx}/admin/sa/shopper/toShopperList";
		        }
		        if(item.get('value')=="1"){
		            window.location.href = "${ctx}/admin/sa/shopper/toShopperForm";
		        }
	    });
    </#if>
	
	// BUI框架提交保存
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/shopper/toShopperList";
                }
            setTimeout("remainTime()",1200);
            }
    	}).render();
        
	    form.on('beforesubmit', function(){
			$("#save").attr('disabled',true);
	    });
    
        //点击重置的时候也把图片给重置掉
		$('button[type="reset"]').click(function() {
			<#if shopper?? && shopper?has_content && shopper.photoUrl?has_content>
				$('#photoUrl').val('${(shopper.photoUrl)!}');
				$('#imageView_cardBackImage').attr("src","${(shopper.photoUrl)!}");
				$("#imgshow").show();
			<#else>
				$('#photoUrl').val(' ');
		    	$('#imageView_cardBackImage').attr('src',"");
		    	$("#imgshow").hide();
		    </#if>
			<#if shopper?? && shopper?has_content && shopper.sexCd == 1>
				$('input[name="sexCd"][value="1"]').attr("checked",true);
			<#else>
				$('input[name="sexCd"][value="0"]').attr("checked",true);
			</#if>
			<#if shopper?? && shopper?has_content && shopper.statusCd == 1>
				$('input[name="statusCd"][value="1"]').attr("checked",true);
			<#else>
				$('input[name="statusCd"][value="0"]').attr("checked",true);
			</#if>
			$("#userNameInfo").html("");
			$("#shopperNumInfo").html("");
			$("#identityNumInfo").html("");
			setTimeout("remainTime()",1200);
		});
    });
    
    function remainTime(){
        $("#save").attr('disabled',false);
    }
    
    // 图片上传
    function assetChange(fileName,lastFlag){
        if(fileName == null || fileName.trim().length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }
        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        var suffix = fileName.substr(suffixIndex + 1);
        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim() && "jpeg" != suffix.trim() && "gif" != suffix.trim() && "bmp" != suffix.trim() &&
                "JPG" != suffix.trim() && "PNG" != suffix.trim() && "JPEG" != suffix.trim() && "GIF" != suffix.trim() && "BMP" != suffix.trim())){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        $.ajaxFileUpload({
            url:'${ctx}/common/staticAsset/upload/lastFlag',
            secureuri: false,
            fileElementId: "file_"+lastFlag,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                loadImage(data.displayAssetUrl,data.assetUrl,lastFlag);
                $("#imgshow").show();
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }
    //设置预览
    function loadImage(url,assetUrl,lastFlag) {
        $('#photoUrl').val(assetUrl);
        $("#imageView_"+lastFlag).attr("src", assetUrl);
        $("#imgPath_"+lastFlag).val(assetUrl);
        $("#imgArea_"+lastFlag).show();
    }
    //删除图片
    function delItem(){
    	$('#photoUrl').val(' ');
    	$('#imageView_cardBackImage').attr('src',"");
    	$("#imgshow").hide();
    }
    
   	//验证身份证号格式
	function validateIdCard(idCard){
		//15位和18位身份证号码的正则表达式
		var regIdCard=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;
	
		//如果通过该验证，说明身份证格式正确，但准确性还需计算
		if(regIdCard.test(idCard)){
			if(idCard.length==18){
				var idCardWi=new Array( 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ); //将前17位加权因子保存在数组里
				var idCardY=new Array( 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
				var idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
				for(var i=0;i<17;i++){
					idCardWiSum+=idCard.substring(i,i+1)*idCardWi[i];
				}
				var idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
				var idCardLast=idCard.substring(17);//得到最后一位身份证号码
	
				//如果等于2，则说明校验码是10，身份证号码最后一位应该是X
				if(idCardMod==2){
					if(idCardLast=="X"||idCardLast=="x"){
						return true;
					}else{
						return false;
					}
				}else{
					//用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
					if(idCardLast==idCardY[idCardMod]){
						return true;
					}else{
						return false;
					}
				}
			}
		}else{
			return false;
		}
	}
	
	//验证用户名是否存在
	$("#userName").blur(function(){
		var userName = $(this).val();
		var shopperId = ${(shopper.shopperId)!0};
		if(userName!=""&&userName!=null){
			var changeUrl = "${ctx}/admin/sa/shopper/checkNameOrNum?userName="+userName+"&shopperId="+shopperId;
			$.get(changeUrl,function(str){
				if(str == '0'){
					$("#userNameInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;您输入的用户名存在,请重新输入！</font>");
					$("#save").attr('disabled',true);
					return false;
				}else if(str == '1'){
					$("#userNameInfo").html("<font color=\"green\">用户名可用！</font>");
					$("#save").attr('disabled',false);
					return true;
				}
			})
		}
		return false;
	})
	//点击账户框时 提示消失
	$("#userName").focus(function(){
		$("#userNameInfo").html("");
	})
	
	//验证配送员编号是否存在
	$("#shopperNum").blur(function(){
		var shopperNum = $("#shopperNum").val();
		var shopperId = ${(shopper.shopperId)!0};
		var regShopperNum = /^([A-Za-z]|[0-9]){1,20}$/;
		if(shopperNum!=""&&shopperNum!=null){
			var changeUrl = "${ctx}/admin/sa/shopper/checkNameOrNum?shopperNum="+shopperNum+"&shopperId="+shopperId;
			if(!regShopperNum.test(shopperNum)){
				$("#shopperNumInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;请输入正确的编号！</font>");
				$("#save").attr('disabled',true);
				return false;
			}else{
				$.get(changeUrl,function(str){
					if(str == '0'){
						$("#shopperNumInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;您输入的编号存在,请重新输入！</font>");
						$("#save").attr('disabled',true);
						return false;
					}else if(str == '1'){
						$("#shopperNumInfo").html("<font color=\"green\">编号可用！</font>");
						$("#save").attr('disabled',false);
						return true;
					}
				})
			}
		}
		return false;
	})
	//点击账户框时 提示消失
	$("#shopperNum").focus(function(){
		$("#shopperNumInfo").html("");
	})
	
	//验证身份证号
	$("#identityNum").blur(function(){
		var identityNum = $(this).val();
		var shopperId = ${(shopper.shopperId)!0};
		if(identityNum!=""&&identityNum!=null){
			var changeUrl = "${ctx}/admin/sa/shopper/checkNameOrNum?identityNum="+identityNum+"&shopperId="+shopperId;
			if(!validateIdCard(identityNum)){
				$("#identityNumInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;无效的身份证号,请重新输入！</font>");
				$("#save").attr('disabled',true);
				return false;
			}else{
				$.get(changeUrl,function(str){
					if(str == '0'){
						$("#identityNumInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;您输入的编号存在,请重新输入！</font>");
						$("#save").attr('disabled',true);
						return false;
					}else if(str == '1'){
						$("#identityNumInfo").html("<font color=\"green\">身份证号可用！</font>");
						$("#save").attr('disabled',false);
						return true;
					}
				})
			}
		}
	})
	//点击账户框时 提示消失
	$("#identityNum").focus(function(){
		$("#identityNumInfo").html("");
	})
	
	//验证手机号
	$("#phone").blur(function(){
		var phone = $(this).val();
		var shopperId = ${(shopper.shopperId)!0};
		var regPhone = /^1[34578]\d{9}$/;
		if(phone!=""&&phone!=null){
			var changeUrl = "${ctx}/admin/sa/shopper/checkNameOrNum?phone="+phone+"&shopperId="+shopperId;
			if(!regPhone.test(phone)){
				$("#phoneInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;请输入正确的手机号码！</font>");
				$("#save").attr('disabled',true);
				return false;
			}else{
				$.get(changeUrl,function(str){
					if(str == '0'){
						$("#phoneInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;您输入的手机号存在,请重新输入！</font>");
						$("#save").attr('disabled',true);
						return false;
					}else if(str == '1'){
						$("#phoneInfo").html("<font color=\"green\">手机号可用！</font>");
						$("#save").attr('disabled',false);
						return true;
					}
				})
			}
		}
	})
	//点击账户框时 提示消失
	$("#phone").focus(function(){
		$("#phoneInfo").html("");
	})
	
</script>
</body>
</html>