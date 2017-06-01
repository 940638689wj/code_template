<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/validator.js?v=roma31"></script>
	
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">热销产品</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="content-top">
        <div class="row">
            <div class="control-group span20">
                设置热销推荐商品  最多只能设置20款，会在商城相关商品页面与操作之后推荐给用户
            </div>
        </div>
    </div>
    <div class="content-body">
        <form id="hotSearchForm" class="form-horizontal search-form" style="display: none;">
        
        </form>
        <div id="hotProductGrid"></div>
    </div>
</div>

<div id="content" style="display: none">
    <div class="form-horizontal">
        <div class="row">
            <div class="control-group">
                <label class="control-label">优先级：</label>
                <div class="controls">
                    <input type="hidden" class="input-normal control-text" id="hotProductId">
                    <input type="text" class="input-normal control-text" id="hotProductSortValue" data-rules="{min:0,number:true}">
                </div>
            </div>
        </div>
     </div>
    <form class="form-horizontal">
    </form>
</div>

<script type="text/javascript">
BUI.use(['common/search','common/page'],function (Search) {
    var hotProductColumns = [
        {title : '图片',dataIndex :'picUrl',width:100, renderer : function(value, rowObj){
                var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	}else{
            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	}
                return img_url;
         }},
        {title : 'ID',dataIndex : 'productId',width:80},
        {title:'商品名称',dataIndex:'productName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
         }},
        {title : '类别名称',dataIndex : 'categoryName',width:100},
        {title :'吊牌价',dataIndex : 'tagPrice',width:80},
        {title : '销售价',dataIndex : 'defaultPrice',width:80},
        {title : '库存',dataIndex : 'sum',width:100},            
		{title : '排序',dataIndex : 'displayId',width:100},            
        {title : '状态',dataIndex : 'productStatusCd',width:75,renderer : function(value, rowObj){
            	var productStatusCdName = "";
            	if(value==1){
            		productStatusCdName = "上架";
            	}else{
            		productStatusCdName = "下架";
            	}
            	return productStatusCdName;
            }},
        {title:'操作',dataIndex:'',width:200,renderer : function(value,rowObj){
            var strSort= "";
                strSort+= '<a href="#" onclick="toSortDialog('+rowObj.productId+')" >设置优先级</a>&nbsp;';
          
                strSort+='<a href="${ctx}/admin/sa/label/deleteHotProductLabel?hotProductId='+rowObj.productId+'" >移除</a>&nbsp;';
            return strSort;
        }}
    ];

    var hotProductStore = Search.createStore('${ctx}/admin/sa/label/grid_json',{
        pageSize : 20
    });

    var hotGridCfg = Search.createGridCfg(hotProductColumns,{
        width: '100%',
            tbar : {
                items : [
                    {text : '选择热销商品',btnCls : 'button button-small button-primary',handler:addFunction}
                ]
              },
    height: getContentHeight()
    });

    var  hotSearch = new Search({
        gridId:"hotProductGrid",
        formId:"hotSearchForm",
        <#--btnId:"btnSearch_${integrateStatus}",-->
        store : hotProductStore,
        gridCfg : hotGridCfg
    });
    var hotProductGrid = hotSearch.get('grid');
    function addFunction(){
        var Overlay = top.BUI.Overlay,
        dialog = new Overlay.Dialog({
            title:'商品列表',
            width: 1000,
            height: 460,
            loader : {
                url : '${ctx}/admin/sa/promotion/productDialog/listForHotProduct?productTypeCd=1',
                autoLoad : false, //不自动加载
                lazyLoad : false //不延迟加载
            },
            buttons:[{
                text:'选 择',
                elCls : 'button button-primary',
                handler : function(){
                    productChoiceEvent(top.getSelectedRecords());
                    this.close();
                }
            }],
            mask:true,
            closeAction : "destroy"
        });
        dialog.get('loader').load();
        dialog.show();
    }

    function productChoiceEvent(selectedProduct){
        var msg = "设置热销商品不能超过20条记录，请重新设置";
        if(selectedProduct && selectedProduct.length > 20){
            BUI.Message.Alert(msg);
            return;
        }

        if(selectedProduct && hotProductGrid){
            if((hotProductGrid.getItemCount()+selectedProduct.length)>20){
                BUI.Message.Alert(msg);
                return;
            }

        }
        var hotProductId = [];
        for(var i = 0; i < selectedProduct.length; i++){
            var id = selectedProduct[i].productId;
            hotProductId.push(id);
        }
        var data={"hotProductId":hotProductId.join(",")};
        $.ajax({
            url: "${ctx}/admin/sa/label/setHotProduct",
            data: data,
            type:"post",
            dataType: "text",
            success: function(data){
                if(data=="success"){
                    window.location.href="${ctx}/admin/sa/label/list";
                } else {
                    BUI.Message.Alert(data || "设置失败");
                }
            }
        });

    }

    confirmSendDialog = app.createDialog(function () {
        var  hotProductId=$('#hotProductId').val();
        var  hotProductSortValue=$('#hotProductSortValue').val();
        if(!jQuery.isNumeric(hotProductSortValue)){
            BUI.Message.Alert("请正确输入数值");
            return;
        }
        if(isNaN(hotProductSortValue)||hotProductSortValue<0){
        	BUI.Message.Alert("请正确输入数值");
        	return;
        }

        var reg_discount = /^\d+(\.\d+)?$/;
		    if(!reg_discount.test(hotProductSortValue)){
		    BUI.Message.Alert("请正确输入数值");
		    return;
		    }

        app.ajax("${ctx}/admin/sa/label/setDisplayId",{hotProductId:hotProductId,hotProductSortValue:hotProductSortValue},function(data){
            if(data=="success"){
                BUI.Message.Alert("设置成功");
                window.location.href="${ctx}/admin/sa/label/list";
            }else{
                BUI.Message.Alert("设置优先级有异常");
            }

        },{dataType: "text"})

        this.close();
    },{title:'设置优先级',height:160});

    toSortDialog=function(hotProductId){
        try{
            $("#hotProductSortValue").val("");
            $("#hotProductId").val(hotProductId);
        }catch(ex){
			//BUI.Message.Alert(ex);
        }
        confirmSendDialog.show();
    }
});
  $(function(){
     <#if deleteSuccessMessage??>
           BUI.Message.Alert("${deleteSuccessMessage!}");
     </#if>
  })
</script>
</body>
</html>