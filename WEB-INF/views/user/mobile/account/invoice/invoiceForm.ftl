<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <title>管理发票</title>
    <#--
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="css/mui.css" />
    <link rel="stylesheet" type="text/css" href="css/global.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/mui.picker.min.css" />
    <link rel="stylesheet" type="text/css" href="css/mui.poppicker.css" />
    <script type="text/javascript" src="js/zepto.js"></script>
    <script type="text/javascript" src="js/mui.min.js"></script>
    <script type="text/javascript" src="js/mobile.js"></script>
    <script type="text/javascript" src="js/jquery.unveil.js"></script>
    -->
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.picker.min.css">
    <script src="${staticPath}/js/mui.picker.min.js"></script>
	<script src="${staticPath}/js/mui.poppicker.js"></script>
	<script src="${staticPath}/js/city.data-4.js"></script>
</head>
<body>
    <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a href="/m/account/invoice/chooseInvoiceList" class="mui-icon mui-icon-left-nav"></a>
            <h1 class="mui-title">发票</h1>
            <a class="mui-icon"></a>
        </header>

		<input style="display:none;" id="provinceId">
        <input style="display:none;" id="cityId">
        <input style="display:none;" id="countyId">
        <input style="display:none;" name="invoiceId" value="${invoiceId!}">
        <div class="mui-content">
            <div class="borderbox">
                <div class="return">
                    <h3>发票类型</h3>
                    <ul class="return-type">
                        <li class="selected" data-name="normal_pager">普通发票</li>
                        <li data-name="vat">增值税发票</li>
                    </ul>
                </div>
            </div>
            <div class="borderbox">
                <div class="return">
                    <h3>发票抬头</h3>
                    <div class="whether">
                        <p id="invoiceTitlePersonalLabel"><label><input type="radio" value="1" id="invoiceTitlePersonal" name="invoiceTop" value="personal" checked>个人</label></p>
                        <p><label><input type="radio" value="2" id="invoiceTitleCompany" name="invoiceTop" value="company" >单位</label></p>
                    </div>
                </div>
                <ul class="tbviewlist categorylist">
                    <li>
                        <div class="hd" id="personalOrCompanyDiv">个人姓名</div>
                        <div class="bd"><input type="text" placeholder="请输入个人姓名" class="personalOrCompanyprompt"></div>
                    </li>
                </ul>
                <ul class="tbviewlist categorylist" id="vatInvoiceDiv" style="display: none;">
                    <li>
                        <div class="hd">纳税人识别码</div>
                        <div class="bd"><input type="text" name="companyTaxpayerIdentifyCode" placeholder="请输入纳税人识别码"></div>
                        <span class="delete"></span>
                    </li>
                    <li>
                        <div class="hd">注册地址</div>
                        <div class="bd"><input type="text" name="companyRegisterAddr" placeholder="请输入注册地址"></div>
                    </li>
                    <li>
                        <div class="hd">注册电话</div>
                        <div class="bd"><input type="number" name="companyRegisterTel" placeholder="请输入注册电话"></div>
                    </li>
                    <li>
                        <div class="hd">银行帐户</div>
                        <div class="bd"><input type="number" name="companyBankAccount" placeholder="请输入银行帐户"></div>
                    </li>
                    <li>
                        <div class="hd">开户行</div>
                        <div class="bd"><input type="text" name="companyOpeningBankName" placeholder="请输入开户行"></div>
                    </li>
                    <li>
                        <div class="hd">发票抬头</div>
                        <div class="bd"><input type="text" name="invoiceTitle" placeholder="请输入发票抬头"></div>
                    </li>
                    <li>
                        <div class="hd">发票配送地址</div>
                        <div class="bd">
                            <input id="showCityPicker" type="text" placeholder="省-市-区/县">
                        </div>
                    </li>
                    <#--
                    <li>
                        <div class="hd">详细地址</div>
                        <div class="bd"><textarea placeholder="详细地址（街道/门牌号）"></textarea></div>
                    </li>
                    -->
                </ul>
            </div>
        </div>
        <div class="mui-content-padded mt30 align-center">
            <button type="button" class="mui-btn mui-btn-primary mui-btn-block mb20" id="save">确定</button>
        </div>
    </div>
<script>
    (function($, doc) {
        $.init();
        $.ready(function() {
            var cityPicker = new $.PopPicker({
                layer: 3
            });
            cityPicker.setData(cityData4);
            var showCityPickerButton = doc.getElementById('showCityPicker');
            
            showCityPickerButton.addEventListener('tap', function(event) {
                var obj = this;
                var provinceId = doc.getElementById('provinceId');
	            var cityId = doc.getElementById('cityId');
	            var countyId = doc.getElementById('countyId');
                cityPicker.show(function(items) {
                    obj.value = (items[0] || {}).text + " - " + (items[1] || {}).text + " - " + (items[2] || {}).text;
                    provinceId.value = (items[0] || {}).value;
                    cityId.value = (items[1] || {}).value;
                    countyId.value = (items[2] || {}).value;
                });
            }, false);
        });
    })(mui, document);

    $(function(){
    	var flag = true;
        $(".return-type li").on("click",function(){
            var obj = $(this);
            obj.addClass("selected").siblings().removeClass("selected");
            if(obj.attr("data-name")=="vat"){
                $('#invoiceTitlePersonalLabel').hide();
                $('#vatInvoiceDiv').show();
                $('#invoiceTitleCompany').prop("checked", true);
                $('#personalOrCompanyDiv').html('单位名称');
                $(".personalOrCompanyprompt").attr('placeholder','请输入单位名称');
            }else{
                $('#invoiceTitlePersonalLabel').show();
                $('#vatInvoiceDiv').hide();
            }
        });
        initInvoiceTitleChangeEvent();
        
        var invoiceId =$("input[name='invoiceId']").val();
        if(invoiceId && flag) {
        	getInvoiceData(invoiceId);
        }
        <#--编辑时获取数据-->
        function getInvoiceData(invoiceId) {
        	$.ajax({
        		url  : '${ctx}/m/account/invoice/eidt/grid_json',
            	type : "GET",
    			dataType : "json",
    			data : {"invoiceId":invoiceId},
    			beforeSend : function() {
	    			flag = false;
	    		},
    			success : function(result) {
    				flag=true;
    				if(result.result == 'success') {
						fillInvoice(result.data);
    				} else if(result.message){
    					mui.toast(result.message);
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flag=true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        <#--编辑时填充数据-->
        function fillInvoice(data) {
    		$(".personalOrCompanyprompt").val(data.companyName);
        	if(data.invoiceForCd && data.invoiceForCd == 2) {
				$('#invoiceTitleCompany').attr("checked",true);
			}
			if(data.invoiceTypeCd && data.invoiceTypeCd == 2) {
				$('.return-type li').removeClass('selected');
				$('.return-type li').eq(1).addClass('selected');
				$("input[name='companyTaxpayerIdentifyCode']").val(data.companyTaxpayerIdentifyCode);
				$("input[name='companyRegisterAddr']").val(data.companyRegisterAddr);
				$("input[name='companyRegisterTel']").val(data.companyRegisterTel);
				$("input[name='companyBankAccount']").val(data.companyBankAccount);
				$("input[name='companyOpeningBankName']").val(data.companyOpeningBankName);
				$("input[name='invoiceTitle']").val(data.invoiceTitle);
				$('#provinceId').val(data.invoiceProvinceId);
				$('#cityId').val(data.invoiceCityId);
				$('#countyId').val(data.invoiceCountyId);
				var invoiceAreaStr = '';
				if(data.invoiceProvinceName && data.invoiceCityName) {
					invoiceAreaStr += data.invoiceProvinceName + '-' + data.invoiceCityName;
				}
				if(data.invoiceCountyName) {
					invoiceAreaStr += '-' + data.invoiceCountyName;
				}
				$('#showCityPicker').val(invoiceAreaStr);
				$('#invoiceTitleCompany').trigger('change');
				$(".return-type li").trigger('click');
			}
        }
        <#--保存-->
        $("#save").on("click",function(){
	         var invoiceForCd =$("input[type='radio']:checked").val();
		     var invoiceTypeCd =$(".return-type li.selected");
	         var companyName = $(".personalOrCompanyprompt").val();
	         var companyTaxpayerIdentifyCode = $("input[name='companyTaxpayerIdentifyCode']").val();
	         var companyRegisterAddr = $("input[name='companyRegisterAddr']").val();
			 var companyRegisterTel = $("input[name='companyRegisterTel']").val();
			 var companyBankAccount = $("input[name='companyBankAccount']").val();
			 var companyOpeningBankName = $("input[name='companyOpeningBankName']").val();
			 var invoiceTitle = $("input[name='invoiceTitle']").val();
		     var provinceId = $('#provinceId').val();
		     var cityId = $('#cityId').val();
		     var countyId = $('#countyId').val();
		     
		     var chooseInvoiceUrl = getUrlParams['chooseInvoiceUrl'];// 从地址中获取：选择地址列表URL
	         if(invoiceTypeCd.length != 1){
	                mui.toast('请选择一种发票类型!');
	                return false;
	         }      
		     if(invoiceTypeCd.attr('data-name') == 'normal_pager') {
		     	invoiceTypeCd = 1;
		     } else {
		     	invoiceTypeCd = 2;
		     }
	         
		     if(invoiceForCd == 1 && companyName == ""){
	                mui.toast('请输入个人姓名!');
	                return false;
	         }else if(invoiceForCd == 1 && companyName != "" && companyName.length > 100){
	         		mui.toast('个人姓名长度不能超过100!');
	                return false;
	         }
	         
		     if(invoiceForCd == 2 && companyName == ""){
	                mui.toast('请输入单位名!');
	                return false;
	         } else if(invoiceForCd == 2 && companyName != "" && companyName.length > 100){
	         		mui.toast('单位名长度不能超过100!');
	                return false;
	         }
	         if(invoiceTypeCd == 2) {
		         if(!companyTaxpayerIdentifyCode || companyTaxpayerIdentifyCode.trim() == '') {
		         		mui.toast('纳税人识别码不能为空！');
		                return false;
		         } else if(companyTaxpayerIdentifyCode.length > 100) {
		         		mui.toast('纳税人识别码长度不能超过100!');
		                return false;
		         }
		         
		         if(!companyRegisterAddr || companyRegisterAddr.trim() == '') {
		         		mui.toast('注册地址不能为空!');
		                return false;
		         } else if(companyRegisterAddr.length > 255) {
		         		mui.toast('注册地址长度不能超过255!');
		                return false;
		         }
		         
		         if(!companyRegisterTel || companyRegisterTel.trim() == '') {
		         		mui.toast('注册电话不能为空!');
		                return false;
		         } else if(companyRegisterTel.length > 20) {
		         		mui.toast('注册电话长度不能超过20!');
		                return false;
		         }
		         
		         if(!companyBankAccount || companyBankAccount.trim() == '') {
		         		mui.toast('银行账户不能为空!');
		                return false;
		         } else if(companyBankAccount.length > 100) {
		         		mui.toast('银行账户长度不能超过100!');
		                return false;
		         }
		         
		         if(!companyOpeningBankName || companyOpeningBankName.trim() == '') {
		         		mui.toast('开户行不能为空!');
		                return false;
		         } else if(companyOpeningBankName.length > 50) {
		         		mui.toast('开户行长度不能超过50!');
		                return false;
		         }
		         
		         if(!invoiceTitle || invoiceTitle.trim() == '') {
		         		mui.toast('发票抬头不能为空!');
		                return false;
		         } else if(invoiceTitle.length > 100) {
		         		mui.toast('发票抬头长度不能超过100!');
		                return false;
		         }
		         
		         if(!provinceId) {
		         		mui.toast('请选择省');
		                return false;
		         }
		         
		         if(!cityId) {
		         		mui.toast('请选择市');
		                return false;
		         }
	         }
	         var data = {};
	         data.invoiceForCd = invoiceForCd;
	         data.invoiceTypeCd = invoiceTypeCd;
	         data.companyName = companyName;
	         data.companyTaxpayerIdentifyCode = companyTaxpayerIdentifyCode;
	         data.companyRegisterAddr = companyRegisterAddr;
	         data.companyRegisterTel = companyRegisterTel;
	         data.companyBankAccount = companyBankAccount;
	         data.companyOpeningBankName = companyOpeningBankName;
	         data.invoiceTitle = invoiceTitle;
	         data.invoiceId = invoiceId;
	         data.invoiceProvinceId = provinceId;
	         data.invoiceCityId = cityId;
	         data.invoiceCountyId = countyId;
	         if(!flag) {
	         	return;
	         }
	         saveOrEdit(data);
         });
         
         <#--数据保存-->
         function saveOrEdit(data) {
         	$.ajax({
        		url  : '${ctx}/m/account/invoice/addInvoice/save',
            	type : "POST",
    			dataType : "json",
    			data : data,
    			beforeSend : function() {
	    			flag = false;
	    		},
    			success : function(result) {
    				flag=true;
    				if(result.result == 'success') {
						mui.toast('成功保存！');
						window.location.href = "${ctx}/m/account/invoice/chooseInvoiceList";
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flag=true;
    				console.log("请求未成功");
    			}
        	});
         }
    })

    function initInvoiceTitleChangeEvent(){
        $("input[type='radio'][name='invoiceTop']").change(function(){
            $('#companyName').val('');
            if($(this).val() == "2"){
                $('#personalOrCompanyDiv').html('单位名称');
                $(".personalOrCompanyprompt").attr('placeholder','请输入单位名称');
            }else{
                $('#personalOrCompanyDiv').html('个人姓名');
                $(".personalOrCompanyprompt").attr('placeholder','请输入个人姓名');
            }
        });
    }
</script>
</body>
</html>