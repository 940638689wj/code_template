<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>发票列表</title>
    <#--
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="css/mui.css" />
    <link rel="stylesheet" type="text/css" href="css/global.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <script type="text/javascript" src="js/zepto.js"></script>
    <script type="text/javascript" src="js/mui.min.js"></script>
    <script type="text/javascript" src="js/mobile.js"></script>
    <script type="text/javascript" src="js/jquery.unveil.js"></script>
    -->
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">选择发票</h1>
        <a class="mui-icon" id="editinvoice"><span>编辑</span></a>
    </header>

    <div class="mui-content">
        <ul class="addresslist">
            <li>
                <div class="addr-item">
                    <address>不开具发票</address>
                </div>
            </li>
            <#--
            <li>
                <div class="addr-item">
                    <span class="name">单位发票</span>
                    <address><i>[默认发票]</i>厦门逸锐信息科技有限公司</address>
                </div>
                <div class="edit-wrap mui-hidden">
                    <div class="edit-bar">
                        <a href="#"><i class="ico ico-edit"></i>编辑</a>
                        <a href="#"><i class="ico ico-delete"></i>删除</a>
                    </div>
                </div>
            </li>
            <li>
                <div class="addr-item">
                    <span class="name">个人发票</span>
                    <address>张章章</address>
                </div>
                <div class="edit-wrap mui-hidden">
                    <div class="edit-bar">
                        <a href="#"><i class="ico ico-edit"></i>编辑</a>
                        <a href="#"><i class="ico ico-delete"></i>删除</a>
                    </div>
                </div>
            </li>
            <li>
                <div class="addr-item">
                    <span class="name">单位发票</span>
                    <address>厦门逸锐信息科技有限公司</address>
                </div>
                <div class="edit-wrap mui-hidden">
                    <div class="edit-bar">
                        <a href="#"><i class="ico ico-edit"></i>编辑</a>
                        <a href="#"><i class="ico ico-delete"></i>删除</a>
                    </div>
                </div>
            </li>
            -->
        </ul>
        <div class="fbbwrap">
            <div class="mainbtnbar"><a href="/m/account/invoice/eidt" class="address_btn">新增发票</a></div>
        </div>
    </div>
</div>
<script>
	var flag = true;
    $(function(){
        var isEdit = false,
            editBtn = $("#editinvoice");
        editBtn.on("click", function () {
            if(isEdit){
                this.innerHTML = '<span>编辑</span>';
                isEdit = false;
            }else{
                this.innerHTML = '<span>完成</span>';
                isEdit = true;
            }
            $(".edit-wrap").toggleClass("mui-hidden");
        });
        
        <#--选择发票-->
        $('.addresslist').on('click','.addr-item',function() {
        	var invoiceId = $(this).attr('data-invoiceId');
        	invoiceId = invoiceId?invoiceId:'';
        	if(getUrlParams.type && getUrlParams.type==2) {//跳转到自提订单
        		window.location.href = '/m/account/order/submitOrderTake?invoiceId='+invoiceId;
        	} else {
	        	window.location.href = '/m/account/order/submitOrder?invoiceId='+invoiceId;
        	}
        });
        
        <#--返回-->
        $('.mui-icon-left-nav').on('click',function () {
        	if(getUrlParams.type && getUrlParams.type==2) {//跳转到自提订单
        		window.location.href = '/m/account/order/submitOrderTake';
        	} else {
	        	window.location.href = '/m/account/order/submitOrder';
        	}
        });
        
        getInvoiceListData();
        
    })
    <#--发票数据的获取-->
        function getInvoiceListData(invoiceId) {
        	if(!flag) { return; }
        	$.ajax({
        		url  : '${ctx}/m/account/invoice/chooseInvoiceList/grid_json',
            	type : "GET",
    			dataType : "json",
    			beforeSend : function() {
	    			flag = false;
	    		},
    			success : function(result) {
    				flag=true;
    				if(result.result == 'success') {
						invoiceListDataHtml(result.data);
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
        
        <#--数据的填充-->
        function invoiceListDataHtml(data) {
        	var li = '';
        	var defaultStr = '';
        	var invoiceForCdStr = '';
        	li += '<li>';
        	li += '    <div class="addr-item">';
        	li += '        <address>不开具发票</address>';
        	li += '    </div>';
        	li += '</li>';
        	if(data && data.length > 0) {
        		for(i = 0; i < data.length; i++) {
		        	li += '<li>';
		        	li += '    <div class="addr-item" data-invoiceId="'+data[i].invoiceId+'">';
		        	if(data[i].invoiceForCd && data[i].invoiceForCd== 2 ) {
		        		invoiceForCdStr = '单位发票';
		        	} else {
		        		invoiceForCdStr = '个人发票';
		        	}
		        	li += '        <span class="name">'+ invoiceForCdStr +'</span>';
		        	if(data[i].isDefaultInvoice) {
		        		defaultStr = '[默认发票]';
		        	} else {
		        		defaultStr = '';
		        	}
		        	li += '        <address><i>'+ defaultStr +'</i>'+ data[i].companyName +'</address>';
		        	li += '    </div>';
	        		li += '    <div class="edit-wrap mui-hidden">';
	        		li += '        <div class="edit-bar">';
	        		li += '           <a href="javascript:icoEdit('+data[i].invoiceId+');"><i class="ico ico-edit"></i>编辑</a>';
	        		li += '           <a href="javascript:icoDelete('+data[i].invoiceId+');"><i class="ico ico-delete"></i>删除</a>';
	        		li += '        </div>';
	        		li += '    </div>';
	        		li += '</li>';
        		} 
        	} 
        	
        	$('.addresslist').html(li);
        }
        
    <#--编辑-->
    function icoEdit(invoiceId) {
    	window.location.href = "/m/account/invoice/eidt?invoiceId=" + invoiceId;
    }
    <#--删除-->
    function icoDelete(invoiceId) {
    	var btnArray = ['确认', '关闭'];
        mui.confirm('', '确认要删除所选商品吗？', btnArray, function(e) {
        	if(e.index == 0) {
        		deleteData(invoiceId);
        	}
        });
    }
    
    <#--请求删除-->
    function deleteData(invoiceId) {
    	if(!flag) { return; }
    	$.ajax({
    		url  : '${ctx}/m/account/invoice/delete',
        	type : "GET",
			dataType : "json",
			data : {'invoiceId':invoiceId},
			beforeSend : function() {
    			flag = false;
    		},
			success : function(result) {
				flag=true;
				if(result.result == 'success') {
					mui.toast('删除成功！');
					getInvoiceListData();
				} else if(result.message){
					mui.toast('删除失败！');
				}
			},
			error:function(XMLHttpResponse ){
				flag=true;
				console.log("请求未成功");
			}
    	});
    }
</script>
</body>
</html>