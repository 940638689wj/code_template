 
 <#assign ctx = request.contextPath>
 <#include "${ctx}/includes/sa/header.ftl"/>
	<div class="content-top">
     	<div id="tab_${tabIndex!}"></div>
    </div>
	
<div class="content-body">
		 <form id="searchForm_${tabIndex!}" name="searchForm_select" class="form-horizontal search-form mb0" method="get">
			  <input name="moduleId" value="${moduleId!}" id="moduleId_${tabIndex!}" type="hidden"/>
			  <input name="orderStatus" value="${orderStatus!}" type="hidden" id="orderStatus_${tabIndex!}"/>
			  <input name="dealStatusCd" value="${dealStatusCd!}" type="hidden" id="dealStatusCd_${tabIndex!}"/>
			  <input name="isSolved" value="" type="hidden" id="isSolved_${tabIndex!}"/>
			  <input name="storeId" value="${storeId!}" type="hidden" id="storeId_${tabIndex!}"/>
			  <div class="row mb10">
                <div class="control-group">
                   		<!-- <span class="ml pull-left ">订单号：</span>
                   		<input type="text" id="orderNumber" name="orderNumber" class="control-text pull-left "> -->
                        <input type="text" id="orderNumber" name="orderNumber" class="control-text pull-left " placeholder="请输入要查询的订单号" aria-disabled="false" aria-pressed="false">
                         <div class="controls  control-row-auto ml0">
                        <button id="btnSearch_${tabIndex!}" class="button button-primary ">搜索</button>&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="button" id="print" onclick="toPrint()">打印订单</button>&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="button" id="exception" onclick="showOrderException()">订单异常</button>
						</div>
                </div>
            </div>
		</form>
    <div id="grid_${tabIndex!}"></div>
</div>

    <div id="orderSend" style="display: none">
    	  <div class="form-content">
    	  		<input type="hidden" name="orderId" id="orderId"/>
        		<div class="auditRefused" style="font-size:15px">是否愿意送货？</div>
          </div>
    </div>
    
    
    <div id="orderexception" style="display: none">
    <form class="form-horizontal">
        <div class="row">
            <div class="control-group">
                <label class="control-label control-label-auto ">原因：</label>
                &nbsp;&nbsp;&nbsp;<select name="orderProblemId" id="orderProblemId" class="input-large">
                    <#list orderProblems as e>
                            <option value="${e.id}">${e.orderProblemDesc}</option>
                     </#list>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label control-label-auto ">描述：</label>

                <div class="controls control-row4">
                    <textarea class="input-large" rows="10" cols="250" name="content"
                              id="content"></textarea>
                </div>
            </div>
        </div>
    </form>
</div>

  	<div id="orderassignment" style="display: none">
  		 <div class="form-content">
  			<input type="hidden" name="distributeOrderId" id="distributeOrderId"/>
        	<div class="auditRefused" style="font-size:15px">是否愿意配货？</div>
    </div>
    
    
    

</div>

	<div id="orderDelivery" style="display: none">
    	  <div class="form-content">
    	  		<input type="hidden" name="deliveryOrderId" id="deliveryOrderId"/>
        		<div class="auditRefused" style="font-size:15px">订单是否已送达？</div>
          </div>
    </div>

<script type="text/javascript">
	  var sel =  document.getElementById("orderProblemId");
   	  sel.style.width = ((sel.offsetWidth < 100) ? '100' : ((sel.offsetWidth > 200)? '200' : sel.offsetWidth));

	 $.fn.status=function(key){
			var Status={1:'待分配',2:'待送货',3:'待收货',4:'待评价',5:'已完成',6:'已取消',9:'订单异常'};
			return Status[key];
	}
	
	
	
	function ordersend(orderId){
		 $("#orderId").val(orderId);
		dialogordersend.show();
    }
    
     function orderdistribution(orderId,orderPayStatusCd){
     
     	if(orderPayStatusCd && orderPayStatusCd == '1'){//未支付提醒
           		BUI.Message.Confirm('订单未支付，确定分配？',function(){
					$("#distributeOrderId").val(orderId);
	        		dialogorderdistribution.show();
				},'question');
               }else{
               		$("#distributeOrderId").val(orderId);
	        		dialogorderdistribution.show();
               }
       	 	
     }
     
     
    function orderDelivery(orderId){
		 $("#deliveryOrderId").val(orderId);
		dialogorderdelivery.show();
    }
	
	
	  BUI.use('bui/overlay',function(Overlay){
           dialogordersend = new Overlay.Dialog({
            title:'送货',
            width:240,
            height:160,
            mask:true,
            buttons:[
                {
                    text:'是',
                    elCls : 'button button-primary',
                    handler : function(){
                        orderConfirmSendBatch();
                    }
                },{
                    text:'否',
                    elCls : 'button',
                    handler : function(){
                    	orderCancelSendBatch();
                        this.close();
                    }
                }
            ],
            contentId : 'orderSend'
        });
        
        dialogorderexception = new Overlay.Dialog({
            title:'订单异常',
            width:400,
            mask:true,
            buttons:[
                {
                    text:'保存',
                    elCls : 'button button-primary',
                    handler : function(){
                       var orderProblem = $('#orderProblemId').val();
				       if(orderProblem == null){
				          BUI.Message.Alert("请选择异常");
				        	return false;
				        }
                    
                       $.ajax({
                       		url : "${ctx}/admin/store/order/updateOrderExceptionInfo",
                       		type : "post",
                       		async : false,
                       		data : {orderIds : JSON.stringify(selectedIds),orderProblemId:$("#orderProblemId").val(),content:$("#content").val()},
                       		success : function(data){
                       		BUI.Message.Alert("操作成功！",function(){
                       		window.location.href = "${ctx}/admin/store/order/storeOrderList?storeId=" + data;
	    		         })
                       		}
                       });
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'orderexception'
        });
        
        dialogorderdistribution = new Overlay.Dialog({
            title:'订单分配',
            width:240,
            height:160,
            mask:true,
            buttons:[
                {
                    text:'确认',
                    elCls : 'button button-primary',
                    handler : function(){
                       distributeBatch();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'orderassignment'
        });
        
        dialogorderdelivery = new Overlay.Dialog({
            title:'订单送达',
            width:240,
            height:160,
            mask:true,
            buttons:[
                {
                    text:'确认',
                    elCls : 'button button-primary',
                    handler : function(){
                       deliveryBatch();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'orderDelivery'
        });
       
    });
    
   
	function orderConfirmSendBatch(){
	    $.ajax({
	    	url : "${ctx}/admin/store/order/orderConfirmSendBatch",
	    	type : "post",
	    	async : false,
	    	data : {orderId: $("#orderId").val()},
	    	success : function(data){
	    		BUI.Message.Alert("订单确认送货成功！",function(){
	    		   // window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=' + data;
	    		   location.reload();
	    		}
	    		);
	    	}
	    });	
	}
	
	function orderCancelSendBatch(){
	    $.ajax({
	    	url : "${ctx}/admin/store/order/orderCancelSendBatch",
	    	type : "post",
	    	async : false,
	    	data : {orderId: $("#orderId").val()},
	    	success : function(data){
	    		BUI.Message.Alert("订单已取消送货！",function(){
	    		    window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=' + data;
	    		}
	    		);
	    	}
	    });	
	}
	
	function distributeBatch(){
		$.ajax({
		    url : "${ctx}/admin/store/order/distributeOrder",
		    type : "post",
		    async : false,
		    data : {orderId: $("#distributeOrderId").val()},
		    success : function(data){
		    	 		if(data.result == "success"){
                           BUI.Message.Alert("分配成功",function(){
			        		window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=${storeId!}';
		    				});
                        }else{
                            BUI.Message.Alert(data.message);
                        }
		    	
		    }
		    
		});

	}
	
		function deliveryBatch(){
		$.ajax({
		    url : "${ctx}/admin/store/order/deliveryOrder",
		    type : "post",
		    async : false,
		    data : {orderId: $("#deliveryOrderId").val()},
		    success : function(data){
		    	BUI.Message.Alert("订单确认送达成功",function(){
			        window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=' + data;
		    	}
		    	);
		    }
		    
		});

	}

  	var orderGrid_${tabIndex!};
    var orderSearch_${tabIndex!};
    var store;
    BUI.use(['common/search','common/page'],function (Search) {
    		function newTab(all, allot, dliv, receive,complete,cancel,exception) {
	            var tab= new BUI.Tab.Tab({
	                render: '#tab_${tabIndex!}',
	                elCls: 'link-tabs',
	                autoRender: true,
	                children: [
	                    {text: '全部（' + all + '）', value: '0', href: 'javascript:void(0)'},
	                    {text: '待配货（' + allot + '）', value: '1', href: 'javascript:void(0)'},
	                    {text: '待送货（' + dliv + '）', value: '2', href: 'javascript:void(0)'},
	                    {text: '待收货（' + receive + '）', value: '3', href: 'javascript:void(0)'},
	                    {text: '已完成（' + complete + '）', value: '5', href: 'javascript:void(0)'},
	                    {text: '已取消（' + cancel + '）', value: '6', href: 'javascript:void(0)'},
	                    {text: '订单异常（' + exception + '）', value: '9', href: 'javascript:void(0)'}
	                ],
	                itemTpl: '<a href="{href}">{text}</a>'
            	});
            
		        <#if defaultSelectTab?has_content && defaultSelectTab?string=="0" >
		        		 $("#isSolved_${tabIndex!}").val("");
			            $("#dealStatusCd_${tabIndex!}").val("-1");
			            tab.setSelected(tab.getItemAt(0));
		        <#elseif defaultSelectTab?has_content && defaultSelectTab?string=="2">
		        		  $("#isSolved_${tabIndex!}").val("");
			            $("#dealStatusCd_${tabIndex!}").val("2");
			            tab.setSelected(tab.getItemAt(2));
		        <#else>
			            $("#dealStatusCd_${tabIndex!}").val("1");
			            $("#isSolved_${tabIndex!}").val("");
			            $("#moduleId_${tabIndex!}").val("${moduleId!}2");
			            tab.setSelected(tab.getItemAt(1));
		        </#if>
		        
		         tab.on('selectedchange',function (ev) {
		                var item = ev.item;
		                if(item.get('value')=="0"){
		                	  $("#isSolved_${tabIndex!}").val("");
		                    $("#dealStatusCd_${tabIndex!}").val("-1");
		                    $("#moduleId_${tabIndex!}").val("${moduleId!}1");
		                }else if(item.get('value')=="1"){
		                	  $("#isSolved_${tabIndex!}").val("");
		                    $("#dealStatusCd_${tabIndex!}").val("1");
		                    $("#moduleId_${tabIndex!}").val("${moduleId!}2");
		                }else if(item.get('value')=="2"){
		                	$("#isSolved_${tabIndex!}").val("");
		                    $("#dealStatusCd_${tabIndex!}").val("2");
		                    $("#moduleId_${tabIndex!}").val("${moduleId!}3");
		                }else if(item.get('value')=="3"){
		                	  $("#isSolved_${tabIndex!}").val("");
		                    $("#dealStatusCd_${tabIndex!}").val("3");
		                    $("#moduleId_${tabIndex!}").val("${moduleId!}4");
		                }else if(item.get('value')=="5"){
		                	$("#isSolved_${tabIndex!}").val("");
		                    $("#dealStatusCd_${tabIndex!}").val("5");
		                    $("#moduleId_${tabIndex!}").val("${moduleId!}5");
		                }else if(item.get('value')=="6"){
		                	 $("#isSolved_${tabIndex!}").val("");
		                     $("#dealStatusCd_${tabIndex!}").val("6");
		                     $("#moduleId_${tabIndex!}").val("${moduleId!}6");
		                }else if(item.get('value')=="9"){
		                	 $("#isSolved_${tabIndex!}").val("");
		                	 $("#dealStatusCd_${tabIndex!}").val("9");
		                   	 $("#moduleId_${tabIndex!}").val("${moduleId!}7");
		                }
		                orderSearch_${tabIndex!}.load();
		            });
    
    			 }
    			 newTab(${all?default(0)},${allot?default(0)},${dliv?default(0)},${receive?default(0)},${complete?default(0)},${cancel?default(0)},${exception?default(0)});
    			 store = Search.createStore('${ctx}/admin/store/order/grid_json?tabIndex=${tabIndex!}',{
            		pageSize:15
        		 });
        		  var columns = [
          
            {title: '订单号', dataIndex: 'orderNumber', width: '180px', renderer: function (val, obj) {
				          return  "<a href='${ctx}/admin/store/order/"+obj.orderId+"'>"+val+"</a>";
            	         }},
            {title: '收货人', dataIndex: 'receiveName', renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }},
            {title: '手机号', dataIndex: 'receiveTel', width: "100px"},
            {title: '商品名称', dataIndex: 'productNames', width: "450px", renderer: function (value, rowObj) {
                return "<span title='"+rowObj.productNames+"'>"+value+"</span>";
            }},
            {title: '商品金额', dataIndex: 'orderProductAmt', width: "80px", renderer: function (val, obj) {
                if (val != null) {
                    return "￥" + val;
                }
                return "-";
            }},
            {title: '下单时间', dataIndex: 'createTime',width:"150px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '订单状态', dataIndex: 'orderStatusCd', width: "80px", renderer: function (val, obj) {
                return $.fn.status(val);
            }},
            {title: '配送方', dataIndex: 'orderDistrbuteTypeCd', width: "150px", renderer: function (val, obj) {
                if (val == 1) {
                    return  "门店";
                }else if (val == 2) {
                    return  "总部";
                }
                return "-";
            }},
            {title: '订单备注', dataIndex: 'orderRemark'},
            {title: '操作', dataIndex: 'orderId',width: '170px', renderer: function (val, obj) {
                var orderStatus = obj.orderStatusCd;
                var orderDistrbuteTypeCd = obj.orderDistrbuteTypeCd;
                var orderTypeCd = obj.orderTypeCd;
                 var orderPropertyCd = obj.orderPropertyCd;
                  var orderPayStatusCd = obj.orderPayStatusCd;
                  var orderReviewStatusCd = obj.orderReviewStatusCd;
                var retReturn;
                if(orderStatus=="1"){
                    retReturn = "&nbsp;&nbsp;<a href='#' onclick='orderdistribution("+val+","+ orderPayStatusCd + ")'>配货</a>";
                }
                <#if store.storeTypeCd?? && store.storeTypeCd?has_content && store.storeTypeCd ==2>
                 if(orderStatus=="2" && orderTypeCd =="1" && orderDistrbuteTypeCd == null){
                    retReturn = "&nbsp;&nbsp;<a href='#' onclick='ordersend("+val+")'>送货</a>";
                }
                </#if>
                if(orderStatus == "3"){
                    retReturn =  "&nbsp;&nbsp;<a href='#' onclick='orderDelivery("+val+")'>订单送达</a>";
                }
                 if(orderStatus == "5"){
                    if(orderReviewStatusCd ==1){
                     	retReturn =  "&nbsp;&nbsp;<span style='color:#AAAAAA;'>订单完成,等待客户评价</span>";
                    }else{
                    	retReturn =  "&nbsp;&nbsp;<span style='color:#AAAAAA;'>订单完成,客户已评价</span>";
                    }
                    
                }
                if(orderStatus == "6" || orderStatus=="9"){
                    retReturn = "&nbsp;&nbsp;<a href='#' onclick='removeOrder("+val+")'>平台客服处理</a>";
                }
                return retReturn ;
            }}
        ];
        
        
         var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
            multiSelect: false,
            width: '100%',
            height: getContentHeight('',$('#panel > div').eq(${tabIndex!}).find('.content-top'))
        });
        
          orderSearch_${tabIndex!} = new Search({
            gridId:"grid_${tabIndex!}",
            formId:"searchForm_${tabIndex!}",
            btnId:"btnSearch_${tabIndex!}",
            store : store,
            gridCfg : gridCfg
        });
        orderGrid_${tabIndex!} = orderSearch_${tabIndex!}.get('grid');
        
       
        
          
        
    });
    var selectedIds = [];
    function showOrderException(){
	    var selected = orderGrid_${tabIndex!}.getSelection();
	    if(selected.length<1){
        	BUI.Message.Alert("请选择订单");
        	return false;
        }
	   
        var orderIds = [];
			selectedObjs = [];
			for(i=0;i<selected.length;i++){
				orderIds.push(selected[i].orderId);
				selectedObjs.push(selected[i]);
			}
			selectedIds = orderIds;
			
		dialogorderexception.show();	
		  
	}
    
    
       function toPrint(){
            var selectedContent = orderGrid_${tabIndex!}.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择订单!");
                return false;
            }

            var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].orderId);
            }
            window.open("${ctx}/admin/store/order/print?id="+selectedContentIds.join(","));
        }
        
        
       
    
     


</script>