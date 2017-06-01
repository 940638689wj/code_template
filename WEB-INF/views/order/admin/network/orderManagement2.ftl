<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery.regionMgr.js" xmlns:form="http://www.w3.org/1999/html"></script>
</head>
<body>

    <div class="title-bar">
        <div id="tab"></div>
    </div>

	<div id="content" class="hide">
      <form class="form-horizontal" >
         <div class="row">
            <div class="control-group span8">
                <label class="control-label">所属大区：</label>
                <div class="controls">
                    <select class="span4" name="regionId1" id="regionId1">
                        <option value="">-- 请选择 --</option>
			            <#if orgList?? && orgList?has_content>
			                <#list orgList as item>
			                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
			                </#list>
			            </#if>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group span8">
                <label class="control-label">所属分公司：</label>
                <div class="controls">
                    <select class="span4" name="branchId1" id="branchId1">
                    	<option value="">-- 请选择 --</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group span8">
                <label class="control-label">所属办事处：</label>
                <div class="controls">
                    <select class="span4" name="officeId1" id="officeId1">
                    	<option value="">-- 请选择 --</option>
                    </select>
                </div>
            </div>
        </div>
      </form>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" class="control-text" placeholder="门店名称" id="shortcut_storeName"/><button onclick="shortSearch()"><i class="icon-search"></i></button>
            </div>
            <div class="search-content">
                 <form id="searchForm" name="searchForm" class="form-horizontal search-form">
                    <div class="row">
                        <div class="control-group span">
                            <label class="control-label">微店主名称：</label>
                            <div class="controls">
                                <input type="text" id="mStoreName" name="mStoreName" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span">
                            <label class="control-label">微店主手机：</label>
                            <div class="controls">
                                <input type="text" name="phone" id="phone" class="control-text">
                            </div>
                        </div>
                    </div>
              <div class="row">
                <div class="control-group span10">
                    <label class="control-label">所属大区：</label>
                    <div class="controls">
                  <select name="regionId" id="regionId" class="span4" <#if org.orgLevelCd gt 0>disabled</#if> >
		            <option value="">-- 大区选择 --</option>
		            <#if org.orgLevelCd==3>
		            <option value="${(parent1.orgId)!}" selected="selected" >${(parent1.orgFullName)!}</option>
		            <#elseif org.orgLevelCd==2>
		            <option value="${(parent.orgId)!}" selected="selected" >${(parent.orgFullName)!}</option>
		            <#elseif org.orgLevelCd==1>
		            <option value="${(org.orgId)!}" selected="selected" >${(org.orgFullName)!}</option>
		            <#else>
		            <#if orgList?? && orgList?has_content>
		                <#list orgList as item>
		                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
		                </#list>
		            </#if>
		            </#if>
		        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span10">
                    <label class="control-label">所属分公司：</label>
                    <div class="controls">
                         <select name="branchId" id="branchId" class="span4" <#if org.orgLevelCd gt 1>disabled</#if> >
		            <option value="">-- 分公司选择 --</option>
		            <#if org.orgLevelCd == 1>
		            <#list list as item>
		             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
		            </#list>
		            <#elseif org.orgLevelCd == 2>
		             <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
		           	 <#elseif org.orgLevelCd == 3>
		           	 <option value="${(parent.orgId)!}" selected="selected"  >${(parent.orgFullName)!}</option>
		            </#if>
		        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span10">
                    <label class="control-label">所属办事处：</label>
                    <div class="controls">
                        <select name="officeId" id="officeId" class="span4" <#if org.orgLevelCd gt 2>disabled</#if>>
				            <option value="">-- 办事处选择 --</option>
				            <#if org.orgLevelCd == 2>
				            <#list list as item>
				             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
				            </#list>
				            <#elseif org.orgLevelCd == 3>
				            <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
				            </#if>
		       			 </select>
                    </div>
                </div>
            </div>
                    <div class="row">
                        <div class="control-group span">
                            <label class="control-label">订单号：</label>
                            <div class="controls">
                                <input type="text" name="orderNumber" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row" style="    width: 450px;">
                        <div class="control-group span">
                            <label class="control-label">下单时间：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input name="beginTime" class="control-text input-small calendar" type="text"><label>&nbsp;-&nbsp;</label>
                                <input name="endTime" class="control-text input-small calendar" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="grid"></div>
    </div>

    <div>
        <input type="hidden"  name="storeIds" value=""/>

        <div id="storeTypeContent" class="well" style="display: none;">
            <label>选择门店类型：</label>
            <select name="storeTypeId" id="storeTypeId">
                <#if storeOtherTypeList?has_content>
                    <#list storeOtherTypeList as storeType>
                        <option value="${storeType.id}">${(storeType.name)!?html}</option>
                    </#list>
                </#if>
            </select>
        </div>
    </div>

    <div id="rqCodeLargeImageContainer" style="display: none">
        <div class="panel-body">
            <div><img src="<#--/rqCode/generate?content=test-->"></div>
        </div>
    </div>
<script type="text/javascript">
 $.fn.status=function(key){
			var Status={10:'待分配',11:'待送货',20:'待发货',21:'已传输',22:'传输失败',3:'待收货',4:'待评价',5:'已完成',6:'已取消'};
			return Status[key];
	}
		$.fn.orderPayStatus=function(key){
			var Status={1:'未支付',2:'已支付'};
			return Status[key];
		}
		$.fn.storeTypeCd=function(key){
			var Status={1:'直营店',2:'渠道店',3:'加盟店'};
			return Status[key];
		}
		
		Date.prototype.Format = function (fmt) { //author: meizz 
		    var o = {
		        "M+": this.getMonth() + 1, //月份 
		        "d+": this.getDate(), //日 
		        "h+": this.getHours(), //小时 
		        "m+": this.getMinutes(), //分 
		        "s+": this.getSeconds(), //秒 
		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		        "S": this.getMilliseconds() //毫秒 
		    };
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var k in o)
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		    return fmt;
		}
    var search;
    var grid;
    var Overlay = BUI.Overlay;
    var setStoreTypeDialog;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'门店',value:'0'},
            {text:'微店',value:'1'},
           
        ]
    });
    tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
    
	tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/network/order/storeOrderList?type=1";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/network/order/storeOrderList?type=2";
	        }
	    });
	    
    BUI.use(['common/search','common/page'],function (Search) {
       columns = [
       	{
            title : '微店名称',
            dataIndex :'mstoreName',
            width:100,
            renderer : function(value, rowObj){
                return value;
        }},{
            title : '微店主手机号',
            dataIndex :'phone',
            width:150,
             renderer : function(value, rowObj){
                var detailStr='<a href="${ctx}/admin/network/mstore/toMstoreIndex?userId='+rowObj.userId+'">'+value+'</a>';
                return detailStr;
        }
        },
        {
            title : '订单号',
            dataIndex : 'orderNumber',
            width:200,
            renderer : function(value, rowObj){
	            value='<a href="${ctx}/admin/network/order/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
	            return value;
        }},{
            title : '订单状态',
            dataIndex : 'orderStatusCd',
            width:100,
            renderer : function(value, rowObj){
            	return $.fn.status(value);
        }},{
            title : '订单支付状态',
            dataIndex : 'orderPayStatusCd',
            width:100,
            renderer : function(value, rowObj){
           		return  $.fn.orderPayStatus(value);
         }},{
            title : '下单时间',
            dataIndex : 'createTime',
            width:150,
            renderer : function(value, rowObj){
            return new Date(value).Format('yyyy-MM-dd hh:mm:ss');
        }},{
            title : '下单人',
            dataIndex : 'userName',
            width:100
        },{
            title : '下单人手机号码',
            dataIndex : 'userPhone',
            width:100
        },
        {
            title : '订单应支付金额',
            dataIndex : 'orderTotalAmt',
            width:120
        },
        {
            title : '收货人',
            dataIndex : 'receiveName',
            width:100
        },{
            title : '收货人联系方式',
            dataIndex : 'receiveTel',
            width:100
        },{
            title : '收货人地址',
            dataIndex : 'receiveAddrCombo',
            width:150
        },{
            title : '是否首单',
            dataIndex : 'isMstoreFirstOrder',
            width:150,
            renderer : function(value, rowObj){
            	if(value){
            		value="是";
            	}else{
            		value="否";
            	}
               return value;
            }}
        ];
        BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
        BUI.Picker.Picker.ATTRS.align.value.offset = [0, -200];
        
        var store = Search.createStore("${ctx}/admin/network/order/grid_json2");
        
        var gridCfg = Search.createGridCfg(columns,{
            tbar : {
                items : [
                    {text : '导出',btnCls : 'button button-small button-primary',handler:batchExport}
                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格和拖拉列的大小
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();

        

        function batchExportStoreRqCodes(){
            var formSerialize = $("#searchForm").serialize();
            var paramArray = [];
            paramArray.push("start=0");
            paramArray.push("limit=100000");
            paramArray.push("pageIndex=0");

            window.open("${ctx}/admin/storeManager/exportStoreRqCode" + (paramArray.length ? ("?" + paramArray.join("&")) : "")+"&"+formSerialize);
        }
       
        //导出门店
        function batchExport(){
        	var a=$('#searchForm').serialize();
    			location.href ="${ctx}/admin/network/order/mStoreExportOrder?"+a;
    			BUI.Message.Alert("导出成功");
        }
	
        function batchOpenStoreBalance(){
            var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择门店!");
                return false;
            }

            if(confirm("确认开启门店余额支付？")){
                var selectedContentIds = [];
                for(var i = 0; i < selectedContent.length ; i++){
                    selectedContentIds.push(selectedContent[i].storeId);
                }
                alert(selectedContentIds.join(","));
                app.ajax("${ctx}/admin/storeManager/batchOpenStoreBalance", 
                {storeIds: selectedContentIds.join(",")}, function (data) {
                    if(data.result=="true"){
                        app.showSuccess("设置成功！")
                        search.load();
                    }else if(data.result=="audit"){
                        app.showSuccess("设置成功,请等待管理员审核..");
                        search.load();
                    }
                })

            }
        }

        function batchCancelStoreBalance(){
            var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择门店!");
                return false;
            }

            if(confirm("确认取消门店余额支付？")){
                var selectedContentIds = [];
                for(var i = 0; i < selectedContent.length ; i++){
                    selectedContentIds.push(selectedContent[i].storeId);
                }
                app.ajax("${ctx}/admin/storeManager/batchCancelStoreBalance", {storeIds: selectedContentIds.join(",")}, function (data) {
                    if(data.result=="true"){
                        app.showSuccess("设置成功！");
                        search.load();
                    }else if(data.result=="audit"){
                        app.showSuccess("设置成功,请等待管理员审核..");
                        search.load();
                    }
                })

            }
        }

        <#--设门店 类型-->
        setStoreTypeDialog = new Overlay.Dialog({
            title:'设置门店类型',
            width:300,
            height:200,
            contentId:'storeTypeContent',
            success:function () {
                var dialogObj = this;

                var storeTypeId = $("#storeTypeId").val();
                if(storeTypeId == "-1"){
                    BUI.Message.Alert("请选择门店类型!");
                    return false;
                }

                var storeIds = $("input[name='storeIds']").val();
                var selectedStoreIds = storeIds.split(",");

                if(selectedStoreIds.length <= 0){
                    BUI.Message.Alert("请选择门店!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/storeManager/setStoreOtherType',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedStoreIds,storeTypeId:storeTypeId},
                    success : function(data){
                        if(data.result == "success"){
                            dialogObj.close();
                            app.showSuccess('设置成功！');
                            search.load();
                        }else{
                            BUI.Message.Alert('设置失败！');
                        }
                    }
                });
            }
        });
    });

    function setStoreType(){
        var selectedStore = grid.getSelection();
        if(selectedStore.length <= 0){
            BUI.Message.Alert("请选择门店!");
            return false;
        }

        var selectedStoreIds = [];
        for(var i = 0; i < selectedStore.length ; i++){
            selectedStoreIds.push(selectedStore[i].storeId);
        }

        $("input[name='storeIds']").val(selectedStoreIds.join(","));
        setStoreTypeDialog.show();
    }

    function conformCancel(value){
        BUI.Message.Confirm('确认要删除该条目吗？',function(){
            $.ajax({
                url: "${ctx}/admin/storeManager/storeInvalid?storeId="+value,
                type:"get",
                dataType: "text",
                error: function(data){
                    app.showSuccess("删除失败!");
                },
                success: function(data){
                    if(data=="success"){
                        app.showSuccess("删除成功!");
                        window.location.href="${ctx}/admin/storeManager/storeList?storeId=${parentId?default('1')}";
                    }else{
                        app.showSuccess("删除失败!");
                    }
                }
            });
        },'question');
    }

    $(function(){
    	//大区选择
	    $("#regionId").on('change',function(){
	    		var regionId = $(this).val();
	    		$('#branchId').empty();
	    		$("#branchId").append("<option value=''>-- 请选择 --</option>");
	    		$('#officeId').empty();
	    		$("#officeId").append("<option value=''>-- 请选择 --</option>");
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					if(data.rowCount && data.rowCount >0){
	                            $.each(data.rows, function(i, row){
	                                $("#branchId").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
	                            });
	                        }
	    				}
	    			});
	    		}
	    	});
	    	
	    //分公司选择
	    $("#branchId").on('change',function(){
    		var branchId = $('#branchId').val();
    		$('#officeId').empty();
	    	$("#officeId").append("<option value=''>-- 请选择 --</option>");
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
	    
	    //大区选择1
	    $("#regionId1").on('change',function(){
	    		var regionId = $(this).val();
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					$('#branchId1').empty();
	    					$("#branchId1").append("<option value=''>-- 请选择 --</option>");
	    					if(data.rowCount && data.rowCount >0){
	                            $.each(data.rows, function(i, row){
	                                $("#branchId1").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
	                            });
	                        }
	    				}
	    			});
	    		}
	    	});
	    	
	    //分公司选择1
	    $("#branchId1").on('change',function(){
    		var branchId = $(this).val();
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					$('#officeId1').empty();
	    				$("#officeId1").append("<option value=''>-- 请选择 --</option>");
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId1').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
	    
	    
	        $("#shortcut_storeName").on('keyup',function(){
	            $("#storeName").val($("#shortcut_storeName").val());
	            if(event.keyCode ==13){
	                $('#btnSearch').click();
	            }
	        });

        $("#shortcut_storeName").on('click',function(){
            $("#storeName").val($("#shortcut_storeName").val());
        });

        $("#storeName").on('keyup',function(){
            $("#shortcut_storeName").val($("#storeName").val());
        });

        $("#storeName").on('click',function(){
            $("#shortcut_storeName").val($("#storeName").val());
        });

        //点击 右上角搜索框
        var mask;
        $('.title-bar-side .search-bar input').on('focus',function(){
            var $this = $(this);
            var searchCon = $this.closest('.title-bar-side').find('.search-content');
            $this.addClass("focused");
            if(!mask)
                mask = $('<div></div>').css({
                    'position':'absolute',
                    'left':0,
                    'top':0,
                    'width':'100%',
                    'height':'100%'
                }).appendTo(document.body);
            searchCon.show(400);
            mask.on('click',function(){
                $this.removeClass("focused");
                mask.remove();
                mask = null;
                searchCon.hide(400);
            });
        });
    })

    function shortSearch(){
        $('#btnSearch').click();
    }

    var x = 20;
    var y = -150;
    $(".storeRqCodeSmallImg").live('mouseover', function(ev){
        var curTrigger = $(this);
        <#--
        var curStoreId = curTrigger.attr("data-store-id");
        var curStoreName = curTrigger.attr("data-store-name");
        var curStoreNo = curTrigger.attr("data-store-no");
        var rqCodeImageGenerateUrl = "/rqCode/generate";
        rqCodeImageGenerateUrl += "?title=" + ((curStoreNo && curStoreNo != "") ? ("StoreNo_" + curStoreNo) : curStoreName);
        var content = "${mobileUrl}/store/"+curStoreId+"/show.html?f=qr";
        content = encodeURIComponent(content);
        rqCodeImageGenerateUrl += "&content=" + content;
        -->

        var curStoreId = curTrigger.attr("data-store-id");
        var rqCodeImageGenerateUrl = "${ctx}/admin/storeManager/viewWxQrCode";
        rqCodeImageGenerateUrl += "?storeId=" + curStoreId;
        var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='"+ rqCodeImageGenerateUrl +"'><\/div>"; //创建 div 元素
        $("body").append(tooltip);	//把它追加到文档中
        $("#tooltip")
                .css({
                    "top": (ev.pageY+y) + "px",
                    "left":  (ev.pageX+x)  + "px"
                }).show("fast");	  //设置x坐标和y坐标，并且显示
    }).live('mouseout',function(){
        $("#tooltip").remove();	 //移除
    }).live('mouseover', function(e){
        $("#tooltip")
                .css({
                    "top": (e.pageY+y) + "px",
                    "left":  (e.pageX+x)  + "px"
                });
    });
</script>
</body>
</html>