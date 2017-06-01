<#assign ctx = request.contextPath>
<#assign isArchived = (archived?? && "Y" == archived)>
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/validator.js?v=roma31"></script>
	<style>
		.x-mask-loading{position: fixed!important; left: 48%!important; top:49%!important;}
	</style>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <#--<input type="text" class="control-text" placeholder="商品名称" name="productName" id="productName">-->
                <#--<button onclick="shortcutSearch()"><i class="icon-search"></i></button>-->
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input type="hidden" name="productStatusCd" id="productStatusCd" value="${(productStatusCd)!}"/>                    
                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="button" class="button button-primary" onclick="searchProduct();">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'上架商品',value:'1'},
            {text:'下架商品',value:'2'}
        ]
    });
	tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
   	tab.on('selectedchange',function (ev) {
	         var item = ev.item;
		        if(item.get('value')=="1"){
		        	$("#productStatusCd").val("1");
		        }else if(item.get('value')=="2"){
		        	$("#productStatusCd").val("2");
		        }
        	search.load({start:0});
	    });
    var search;
    BUI.use(['common/search','common/page'],function (Search) {
        var editing = new BUI.Grid.Plugins.CellEditing({
            triggerSelected : false //触发编辑的时候不选中行
        });
        var columns = [
            {title : '图片',dataIndex :'picUrl',width:100, renderer : function(value, rowObj){
                var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	}else{
            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	}
                return img_url;
            }},
            {title : '二维码',dataIndex : 'productId',width:150, renderer : function(value, rowObj){
                return '<img data-product-item-no="' + value + '" data-product-id="'+value+'" class="qrCodeSmallImg" src="${ctx}/qrCode/generate?content=test" style="width:30px;height: 30px;cursor: pointer;" />';
            }},
            {title : 'ID',dataIndex : 'productId',width:80},
            
            {title : '商品名称',dataIndex : 'productName',width:100,renderer : function(value, rowObj){
                var str = "";
                str = "<span title="+ value +">"+value+"</span>";
                return str;
            }},
            {title : '货号',dataIndex : 'barCode',width:100},            
            {title : '库存',dataIndex : 'sum',width:100},            
            {title:'库存预警',dataIndex:'stockWarningLimit',width:70,renderer : function(value, rowObj){
                return "<span style='color: red'>"+value+"</span>"
            }},
            {title : '类别名称',dataIndex : 'categoryName',width:100},
            {title : '销售价',dataIndex : 'defaultPrice',width:80},
            {title :'吊牌价',dataIndex : 'tagPrice',width:80},
            {title : '创建时间',dataIndex : 'lastUpdateTime',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title : '是否上架',dataIndex : 'productStatusCd',width:75,renderer : function(value, rowObj){
            	var productStatusCdName = "";
            	if(value==1){
            		productStatusCdName = "是";
            	}else{
            		productStatusCdName = "否";
            	}
            	return productStatusCdName;
            }},
            {title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
                var editStr ="";
                    editStr = Search.createLink({
                        text: '编辑',
                        href: "${ctx}/admin/sa/productManage/addOrEdit?productId=" + rowObj.productId
                    });
              
                return editStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/productManage/grid_json2',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            tbar : {
                items : [
                    {
                        xclass:'bar-item-text',
                        text:'<div class="tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-volume-up"></i></span><div class="tips-content">提示:全局库存预警${stockAll!}</div></div>'
                    }
                ]
            },
            multiSelect: false,
            width: '100%',
            height: getContentHeight()-2
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });

         grid = search.get('grid');
        tab.setSelected(tab.getItemAt(0));
        tab.on('selectedchange',function (ev) {
            var item = ev.item, archived = item.get('value');
            store.load({"eq_archiveStatus.archived": archived});
        });
        
        
        var x = 5;
	    var y = 5;
	    $(".qrCodeSmallImg").live('mouseover', function (ev) {
	        var curTrigger = $(this);
	        var productId = curTrigger.attr("data-product-id");
	        var rqCodeImageGenerateUrl = "${ctx}/admin/sa/productManage/viewWxQrCode";
	        rqCodeImageGenerateUrl += "?productId=" + productId;
	        var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='" + rqCodeImageGenerateUrl + "'><\/div>"; //创建 div 元素
	        $("body").append(tooltip);	//把它追加到文档中
	        $("#tooltip").css({
	            "top": (ev.pageY + y) + "px",
	            "left": (ev.pageX + x) + "px"
	        }).show("fast");	  //设置x坐标和y坐标，并且显示
	    }).live('mouseout', function () {
	        $("#tooltip").remove();	 //移除
	    }).live('mouseover', function (e) {
	        $("#tooltip").css({
	            "top": (e.pageY + y) + "px",
	            "left": (e.pageX + x) + "px"
	        });
	    });
    });
    function deleteProduct(productId){

        if(!productId){
            return;
        }

        BUI.Message.Confirm('确定要删除该商品吗?',function(){
            $.ajax({
                url : '${ctx}/admin/adminProduct/deleteProduct',
                dataType : 'json',
                type: 'POST',
                data : {id : productId},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("商品删除成功。");
                        search.load();
                    }else{
                        app.showSuccess("商品删除失败!");
                    }
                }
            });
        },'question');
    }

</script>
</body>
</html>