<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title>核对预售信息</title>
</head>
<body>
    <div id="main">
        <div class="checkout">
            <div class="checkout-tit">核对预售信息</div>
            <div class="checkout-steps">
                <div class="step-wrap noborder">
                    <div class="step-tit">
                        <h3>商品信息</h3>
                    </div>
                    <div class="shoptb">
                        <div class="shoptb-hd">
                            <table>
                                <tbody>
                                <tr>
                                    <td class="td-product">商品</td>
                                    <td class="td-price">单价</td>
                                    <td class="td-amount">数量</td>
                                    <td class="td-total">小计</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="shoptb-row">
                            <table>
                                <tbody id="productData">
                                <!--<tr>
                                    <td class="td-product">
                                        <div class="first-column">
                                            <div class="img"><a href="#"><img src="images/awardsGame.jpg"></a></div>
                                            <div class="info">
                                                <div class="name"><a href="../goods_detail.html" target="_blank">Genanx格男仕春季新款时尚潮流男士修身小西装</a></div>
                                                <div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="td-price">￥127</td>
                                    <td class="td-amount">1</td>
                                    <td class="td-total"><em>￥127 </em></td>
                                </tr>-->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="step-wrap">
                    <div class="order-ft">
                    	<div class="order-extra">
                            <div class="formList order-extra">
                                <div class="item">
                                    <div class="hd">余额支付</div>
                                    <div class="bd">
                                        <input id="balancePay" type="checkbox" name="integral" ><span class="infotext">当前余额￥<span id="userBalance">00.00</span>，是否使用</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="order-total">
                            <div class="row">
                                <div class="tit">应付订金：</div>
                                <div class="con" id="preAmt">￥373</div>
                            </div>
                            <div class="row">
                                <div class="tit">尾款：</div>
                                <div class="con" id="remainAmt">￥30</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="trade-foot">
            <div class="trade-foot-detail">
                <div class="fc-price-info">
                    <span class="price-tit">应付订金：</span>
                   	 ￥<span class="price-num" id="payAmt">373.00</span>
                </div>
            </div>
            <div class="inner">
                <button id="btnBuy">支付订金</button>
            </div>
        </div>
    </div>
	<input type="hidden" id="promotionId" value="${promotionId!}">
	<input type="hidden" id="productId" value="${productId!}">
	<input type="hidden" id="quantity" value="${quantity!}">
	<input type="hidden" id="nowBalance" value="0">
    <div id="payment" class="hidden">
        <div class="paytypes">
        	<ul>
            <#if onlinePayTypeList?? && onlinePayTypeList?has_content>
                <#list onlinePayTypeList?keys as key>
                    <#if key="config_alipay_pc">
                        <li><a href="#" id="alipay">支付宝支付</a></li>
                    <#elseif key="config_unionpay_pc">
                    	<li><a href="#" id="unionpay">银联支付</a></li>
                    <#elseif key="weixin_pay_config">
                        <li><a href="#" id="wxpay">微信支付</a></li>
                    </#if>
                </#list>
            </#if>
        </ul>
        
            <#--<ul>
                <li><a href="#" id="alipay">支付宝支付</a></li>
                <#--<li><a href="#">银联支付</a></li>
            </ul> -->
        </div>
    </div>
    <div id="payPassword"  class="hidden">
        <div class="formList paypassword">
            <div class="item">
                <div class="hd">输入支付密码：</div>
                <div class="bd">
                    <input type="password" class="textfield">
                </div>
            </div>
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <a class="v-btn" href="#">确定</a>
                </div>
            </div>
        </div>
    </div>

    <div id="newddress" class="hidden">
        <div class="reg-form">
            <ul>
                <li>
                    <div class="hd">姓名</div>
                    <div class="bd">
                        <div class="item"><input type="text" class="textfield"></div>
                    </div>
                </li>
                <li>
                    <div class="hd">所在地区</div>
                    <div class="bd">
                        <select><option value="">福建省</option></select>
                        <select><option value="">厦门市</option></select>
                        <select><option value="">思明区</option></select>
                    </div>
                </li>
                <li>
                    <div class="hd">街道</div>
                    <div class="bd">
                        <textarea></textarea>
                    </div>
                </li>
                <li>
                    <div class="hd">手机号码</div>
                    <div class="bd">
                        <div class="item"><input type="text" class="textfield"></div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <a href="#" class="btn-action">新增</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>    
<script>
	var isInTime = false;
	var hasPwd = false;
	$(function(){
		getPreSaleOrderInfo();
		
		$("#alipay").click(function () {
            var balancePay = $("#balancePay").is(':checked');
            var userBalance = $("#userBalance").html();
        	if(balancePay && (eval(userBalance)>0)){//判断是否余额参与支付
        		toPay("alipay_balance");
        	}else{
        		toPay("alipay");
        	}
        });
        $("#unionpay").click(function () {
            var balancePay = $("#balancePay").is(':checked');
            var userBalance = $("#userBalance").html();
        	if(balancePay && (eval(userBalance)>0)){//判断是否余额参与支付
        		toPay("unionpay_balance");
        	}else{
        		toPay("unionpay");
        	}
        });
        $("#wxpay").click(function () {
            var balancePay = $("#balancePay").is(':checked');
            var userBalance = $("#userBalance").html();
        	if(balancePay && (eval(userBalance)>0)){//判断是否余额参与支付
        		toPay("wechatpay_balance");
        	}else{
        		toPay("wechatpay");
        	}
        });
	})
	
	function getPreSaleOrderInfo(){
		var promotionId = $("#promotionId").val();
		var productId = $("#productId").val();
		var quantity = $("#quantity").val();
		$.ajax({
				url : '${ctx}/account/preSaleOrder/getPreSaleOrderInfo?productId='+productId+'&promotionId='+promotionId,
				type : 'get',
				success : function(data){
					if(data!=null){
						isInTime = data.isInTime;
						if(data.payPassword!=null && data.payPassword!=''){
							hasPwd=data.payPassword;
						}
						$("#userBalance").html(data.userBalance);
						if(eval(data.userBalance)<=0){
							$("#balancePay").attr("disabled","true");
						}
						$("#nowBalance").html(data.userBalance);
						var totalAmt = eval(quantity)*eval(data.product.defaultPrice);
						var preAmt = eval(quantity)*eval(data.preSaleInfo.price);
						var remainAmt = eval(quantity)*(eval(data.product.defaultPrice)-eval(data.preSaleInfo.price));
						var htmlStr='<tr><td class="td-product"><div class="first-column">'+
	                                '<div class="img"><a href="#"><img src="${ctx}'+data.preSaleInfo.productPicUrl+'"></a></div>'+
	                                '<div class="info">'+
	                                '<div class="name"><a href="../goods_detail.html" target="_blank">'+data.product.productName+'</a></div>';
	                    if(data.skuDesc!=null && data.skuDecs!=""){
	                       htmlStr+='<div class="prop"><span>'+data.skuDesc+'</span></div>';
	                    }
	                       htmlStr+='</div></div></td>'+
	                                '<td class="td-price">￥'+(data.product.defaultPrice).toFixed(2)+'</td>'+
	                                '<td class="td-amount">'+quantity+'</td>'+
	                                '<td class="td-total"><em>￥'+totalAmt.toFixed(2)+'</em></td></tr>';
	                    $("#productData").append(htmlStr);
	                    $("#preAmt").html("￥"+preAmt.toFixed(2));
	                    $("#remainAmt").html("￥"+remainAmt.toFixed(2));
	                    $("#payAmt").html(preAmt.toFixed(2));
					}
				}
		});
	}

	//处理支付
    function toPay(payWay) {
    	var promotionId = $("#promotionId").val();
		var productId = $("#productId").val();
		var quantity = $("#quantity").val();
        $.ajax({
            url: '/account/preSaleOrder/dealPreSaleOrder',
            type: 'post',
            data: {
                "promotionId":promotionId,
				"quantity":quantity,
				"productId":productId,
				"payWay":payWay,
				"remark":"--",
				"type":"downPayment",
				"originPlatformCd":"0"
            },
            dataType: 'json',
            success: function (data) {
                if (data.result == 'success') {
                    if (payWay == 'balancePay') {
                        layer.alert('支付成功！', function () {
                             window.location.href ='/account/preSaleOrder/toPreSaleOrderList';
                        });
                    } else {
                        window.location.href = '/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
                    }
                } else {
                    layer.alert(data.message);
                }
            },
            error: function () {
                layer.alert('网络出错，请稍后再试！');
            }
        });
    }

    //校验密码
    $('#payPassword .v-btn').click(function () {
        layer.close(payPassword);
        var reg = /^\d{6}$/;
        var payPwd = $("#payPassword input").val();
        if (reg.test(payPwd)) {
            //SHA1加密
            var payPwd = CryptoJS.SHA1(payPwd).toString();
            //执行其他操作
            $.post('/account/preSaleOrder/check_PayPwd', {payPwd: payPwd}, function (data) {
                if (data.result == 'success') {
                	var nowUserBalance = $("#userBalance").html();
                	var payAmt = $("#payAmt").html();
                	if(eval(nowUserBalance) < eval(payAmt)){
                		layer.msg("当前余额不足,请选择其他支付方式!");
	        			setTimeout("payment()",500);
                	}else{
                		toPay("balancePay");
                	}
                } else {
                    layer.msg('支付密码错误！');
                }
            })
        } else {
            layer.close(payPassword);
            layer.msg('密码错误！');
        }
    })

    $(function(){
        $(".topshopcart").hover(getCartContent, removeCartContent);

        $("#newaddressBtn").on("click",function(){
            newaddress();
        })

        $("#btnBuy").on("click",function(){
        	if(!isInTime){
				layer.alert("不在预售定金期内!");
				return;
			}
        	var balancePay = $("#balancePay").is(':checked');
        	if(balancePay){
        		if(!hasPwd){
        			layer.confirm('请先设置支付密码',function(){
                        setPayPwd();
                    });
        		}else{
        			paypassword();
        		}
        	}else{
        		payment();
        	}
        })

    })
    function getCartContent(){
        $(".topshopcart").addClass("cart-hover");
    }
    function removeCartContent(){
        $(".topshopcart").removeClass("cart-hover");
    }
	//跳转到设置支付密码页面
    function setPayPwd() {
        var _url = '/account/userChangePaw?type=2&successUrl=' + encodeURIComponent(window.location.href);
        window.location.href = _url;
    }
    var newAddress;
    function newaddress(){
        newAddress = layer.open({
            type: 1,
            title: '新增地址',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['720px'],
            content: $("#newddress")
        });
    }

    function payment(){
        layer.open({
            type: 1,
            title: '选择支付方式',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px'],
            content: $("#payment")
        });
    }

    var payPassword;
    function paypassword(){
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px','200px'],
            content: $("#payPassword")
        });
    }
</script>
</body>
</html>