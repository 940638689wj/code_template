<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<#include "../../../includes/sa/header.ftl"/>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
        
        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>
                        <div class="pull-left">
                            <select name="categoryId">
                            	<option value="" selected>所有分类</option>
                                <#if productCategoryList?? && productCategoryList?has_content>
	                                <#list productCategoryList as list>
	                                    <option value="${list.categoryId}">${list.categoryName}</option>
	                                </#list>
	                            </#if>
                            </select>
                        </div>
                        <div class="pull-left">
                            <label class="control-label">商品名称：</label>
                            <input type="text" id="productName" name="productName" class="control-text" value="">
                        </div>
                        <div class="steps steps-small pull-left">
                            <ul>
                                <li class="step-first" id="thisWeek">
                                    <b class="stepline"></b>
                                    <div class="stepind">本周</div>
                                </li>
                                <li id="lastWeek">
                                    <b class="stepline"></b>
                                    <div class="stepind">上周</div>
                                </li>
                                <li id="thisMonth">
                                    <b class="stepline"></b>
                                    <div class="stepind">本月</div>
                                </li>
                                <li class="step-last" id="lastMonth">
                                    <b class="stepline"></b>
                                    <div class="stepind">上月</div>
                                </li>
                            </ul>
                        </div>
                        <div class="pull-left">
                        	<button id="user_search" name="user_search" type="button" class="button button-primary ml">搜索</button>
                            <button id="export" type="button" class="button button-primary">导出全部报表</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
            	<div class="pull-left">
                    <label id="saleCntTotal" class="control-label control-label-auto mr30">商品销售量：<span class="red"><#if productSaleRankTotal??>${productSaleRankTotal.saleCnt!''}</#if></span></label>
                    <label id="saleAmtTotal" class="control-label control-label-auto mr30">商品销售额：<span class="red"><#if productSaleRankTotal??>${productSaleRankTotal.saleAmt!''} 元</#if></span></label>
                    <label id="changeReturnCntTotal" class="control-label control-label-auto mr30">待发货量：<span class="red"><#if productSaleRankTotal??>${productSaleRankTotal.unshipedCnt!''}</#if></span></label>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
	//导出
	$("#export").click(function(){
		var params=$("#searchForm_select").serialize();
		//alert(params0);
		//var params=encodeURI(decodeURIComponent($("#searchForm_select").serialize(),true));
		location.href ="${ctx}/report/productSaleRank/exportProductSaleRankReport?"+params;
    	BUI.Message.Alert("导出成功");
    	<#--
    	$.ajax({  
                type : "post",  
                async : false, //同步执行  
                url : "${ctx}/report/productSaleRank/exportProductSaleRankReport?"+params,  
                data : {},  
                //dataType : "json", //返回数据形式为json  
                success : function(data) {  
	                   BUI.Message.Alert("导出成功");
	            },
                error : function(errorMsg) {  
                   BUI.Message.Alert("导出失败");
                }  
            });
            -->
	});
</script>
<script type="text/javascript">
	//更新页面数据
	$("#user_search").click(function(){
		//var params=encodeURI(decodeURIComponent($("#searchForm_select").serialize(),true));
		var params=$("#searchForm_select").serialize();
		var bTime=$("#beginTime").val();
    	var eTime=$("#endTime").val(); 
    	if( bTime&&eTime ){
    		bTime=new Date(bTime);
    		eTime=new Date(eTime);
    		if(bTime.getTime()>eTime.getTime()){
        		return ;
    		}
    	}
    	getTotalData(params);
	});
	
	function getTotalData(params) {  
            //通过Ajax获取数据  
            $.ajax({  
                type : "post",  
                async : false, //同步执行  
                url : "${ctx}/report/productSaleRank/getTotalData?"+params,  
                data : {},  
                dataType : "json", //返回数据形式为json  
                success : function(data) {  
                if(data) {  
                   $("#saleCntTotal").html("商品销售量：<span class='red'>"+data.map1.saleCntTotal+"</span>");
                   $("#saleAmtTotal").html("商品销售额：<span class='red'>"+data.map1.saleAmtTotal+" 元"+"</span>");
                   
                   $("#changeReturnCntTotal").html("待发货量：<span class='red'>"+data.map1.unshipedCntTotal+"</span>");
                   }
                },  
                error : function(errorMsg) {  
                    
                }  
            });
        }  
	
	
</script>
<script type="text/javascript">
	var grid;
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'商品销售排行',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '商品销售排名',dataIndex :'rank',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '商品编码',dataIndex :'productId',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '商品名称',dataIndex :'productName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '系列分类',dataIndex :'categoryName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '商品条码',dataIndex :'barCode',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '图片',dataIndex :'productPics',width:100, renderer:function(value,rowObj){
				var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	}else{
            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	}
                return img_url;
			}},
			{title : '退换率',dataIndex :'changeReturnRate',width:100, renderer:function(value,rowObj){
				var str=(value*100).toFixed(2);
				str+='%';
				return str;
			}},
			{title : '销售额',dataIndex :'saleAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '销售量',dataIndex :'saleCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '待发货量',dataIndex :'unshipedCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '退换量',dataIndex :'changeReturnCnt',width:100, renderer:function(value,rowObj){
				return value;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/report/productSaleRank/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
				width: '100%',
				height:getContentHeight(),
	            // 底部工具栏
	            bbar:{
	                // pagingBar:表明包含分页栏
	                pagingBar:true
	            }
			});
	
		var search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            btnId:'user_search'
		});
			grid = search.get('grid');
		});
		
	// 初始化
    $(function(){
    	var t = $(".container").find("li");
   		$(t).each(function(i,item){
        	$(this).click(function(){
                // 有颜色就删掉
                $("li").removeClass('step-active');
        		// 改变颜色
        		$(this).addClass("step-active");
        		// 请求处理
        		var bTime;
        		var eTime;
        		if(this.id=="thisWeek"){ 
        		  	bTime=getCurrentWeek()[0];
        		  	eTime=getCurrentWeek()[1];
        		}else if(this.id=="lastWeek"){
        			bTime=getPreviousWeek()[0];
        			eTime=getPreviousWeek()[1]; 
        		}else if(this.id=="thisMonth"){
        			bTime=getCurrentMonth()[0];
        			eTime=getCurrentMonth()[1]; 
        		} else{
        			bTime=getPreviousMonth()[0];
        			eTime=getPreviousMonth()[1];
        		}
        		
        		$("#beginTime").attr("value",bTime);
        		$("#endTime").attr("value",eTime); 
        		//refeshData(bTime,eTime);
        	});
    	});
    });	
</script>
</body>
</html>  