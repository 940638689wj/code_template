<#assign ctx = request.contextPath>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<#assign mixed1Control = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MIXED_1_TYPE.type>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/validator.js?t=20140611"></script>
    <title></title>
    <script type="text/javascript">

        function assetChange(fileName, lastFlag, isFileId){
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
                    ("jpg" != suffix.trim().toLowerCase() && "png" != suffix.trim().toLowerCase())){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            $.ajaxFileUpload({
                url:'${ctx}/common/staticAsset/upload/decorateControl',
                secureuri: false,
                fileElementId: "file_" + lastFlag,
                dataType: "json",
                method : 'post',
                success: function (data, statusCd) {
                    loadImage(data.assetUrl, lastFlag);
                },
                error: function (data, statusCd, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(assertUrl,lastFlag) {
            var width = $(("#imgArea_" + lastFlag)).width();
            $("#imgPath_"+lastFlag).val(assertUrl);
            var imgDom = "<img style='width: "+width+"px' src='"+assertUrl+"'/>";
            if(lastFlag == "adImg"){
                imgDom = "<img style='width: "+width+"px' src='"+assertUrl+"'/>";
            }
            $("#imgArea_"+lastFlag).html(imgDom);
        }

        function deletePic(targetContent, targetHref, previewTip){
            var deletePicType = $(targetHref).attr("data-file-type");
            if(!previewTip){
                previewTip = "图片预览";
            }
            if(!targetContent){
                $("#imgPath_"+deletePicType).val("");
                $("#imgArea_"+deletePicType).html("<b style='line-height: 50px;'>"+previewTip+"</b>");
            } else {
                $(targetContent).find("." + deletePicType).html("<b style='line-height: 50px;'>"+previewTip+"</b>");
            }
        }
    </script>
</head>
<body>
<form class="form-horizontal" id="controlContainerForm" method="POST" action="edit">
    <input type="hidden" name="id" value="${(control.id)!}"/>
    <input type="hidden" name="type" value="${type?default(productControlType)}">
    <input type="hidden" name="showType" value="${(showType)?default(mixed1Control)}">
    <!-- 标题信息 -->
    <div class="control-group">
        <label class="control-label"><s>*</s>控件标题：</label>
        <div class="controls"><input class="control-text input-large" type="text" value="${(control.name)!?html}" name="name" data-rules="{required:true}"/></div>
    </div>
    <div class="control-group" style="display: none;">
        <label class="control-label"><s>*</s>是否显示标题：</label>
        <#assign nameStatus = "1">
        <#if (control.showName)??>
            <#assign nameStatus = (control.showName)?string("1","0")>
        </#if>
        <div class="controls">
            <label class="radio" for="showNameRadio"><input  <#if nameStatus == "1">checked="checked"</#if> id="showNameRadio" type="radio" value="1" name="showName">显示</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="hideNameRadio"><input  <#if nameStatus == "0">checked="checked"</#if> id="hideNameRadio" type="radio" value="0" name="showName">隐藏</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>控件排序：</label>
        <div class="controls">
            <input value="${(control.sort)?default('0')}" name="sort" data-rules="{required:true,min:0,number:true}" class="input-normal control-text">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>是否启用：</label>
        <#assign status = (control.statusCd)?default(1)>
        <input type="hidden" name="statusCd" value="${(control.statusCd)!?default(1)}">
        <div class="controls" name="statusCd">
            <label class="radio" for="usedRadio"><input <#if status == 1>checked="checked"</#if> id="usedRadio" type="radio" value="1" name="statusRadio">启用</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="disabledRadio"><input <#if status == 0>checked="checked"</#if> id="disabledRadio" type="radio" value="0" name="statusRadio">禁用</label>
        </div>
    </div>
    <!-- 标题信息 END -->

    <div class="control-group">
        <label class="control-label">横幅链接：</label>
        <div class="controls">
            <input class="control-text input-large" type="text" name="adLink" value="${(controlDTO.adLink)!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">横幅图片：</label>
        <div class="controls control-row-auto">
            <div class="file-btn">
                <button style="width: 130px;" class="button">选择横幅图</button>
                <input id="file_adImg" type="file" class="inp-file" name="file" onchange="javascript:assetChange(this.value,'adImg', false);"/>
                <input id="imgPath_adImg" value="${(controlDTO.adImg)!}" name="adImg" type="hidden" />
            </div>
            &nbsp;<span class="auxiliary-text">图片建议尺寸：940x250像素，视当前主题而定</span>
            <a onclick="javascript:deletePic(undefined, this, '控件横幅图预览')" data-file-type="adImg" style="padding-left: 5px;cursor: pointer;">删除</a>
            <div id="imgArea_adImg" class="zx-banner" style="width: 470px;margin-top: 10px;margin-bottom: 0px;">
                <#if (controlDTO.adImg)?has_content>
                    <img src="${controlDTO.adImg}" style="width: 470px;" alt=""/>
                <#else>
                    <b style="line-height: 50px;">控件横幅图预览</b>
                </#if>
            </div>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">热门搜索：</label>
        <div class="controls" style="height: auto;">
            <div class="spec-box" style="width: 680px;">
                <div style="display: none;"> <!--Model-->
                    <input type="hidden" data-pass-param data-param-obj-name="others" data-param-attr-name="index" value="">
                    <div class="spec-title">
                        <h3>搜索名称： <input type="text" data-pass-param data-param-obj-name="others" data-param-attr-name="name"/>
                            <span style="padding-left: 15px;">搜索链接： <input type="text" data-pass-param data-param-obj-name="others" data-param-attr-name="linkUrl"/></span>
                        </h3><a href="javascript:void(0)" onclick="javascript:deleteHotSearch(this);">×</a></div>
                    <hr/>
                </div>
                <button name="addHotSearch" type="button" class="button button-primary">+新增热门搜索</button>
            </div>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">选择商品：</label>
        <div class="controls" style="height: auto;">
            <div class="spec-box" style="width: 680px;">
                <button name="addProductBtn" type="button" class="button button-primary">+新增商品</button>
                <div id="productGrid" style="padding-left: 10px;padding-top:10px;"></div>
            </div>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">设置热销商品：</label>
        <div class="controls" style="height: auto;">
            <div class="spec-box" style="width: 680px;">
                <button name="addHotProductBtn" type="button" class="button button-primary">+新增热销商品</button>
                <div id="hotProductGrid" style="padding-left: 10px;padding-top:10px;"></div>
            </div>
        </div>
    </div>
    <div class="actions-bar" style="padding-left: 45px;">
        <div class="form-action">
            <button class="button button-large button-primary">保存</button>
        </div>
    </div>
</form>
<script type="text/javascript">

    //产品表格
    var productColumns = [
        {title: '商品ID', dataIndex: 'productId', width: "20%"},
        {
            title: '商品名称',
            dataIndex: 'productName',
            width: 120,
            renderer: function (value) {
                return app.grid.format.encodeHTML(value);
            }
        },
        {title: '商品挂牌价', dataIndex: 'tagPrice', width: "20%"},
        {title: '商品零售价', dataIndex: 'defaultPrice', width: "20%"},
        {title: '库存', dataIndex: 'realStock', width: "20%"},
        {title: '操作',dataIndex:'',width:"20%",renderer : function(value,obj){
            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
            return delStr;
        }}
    ];

    var hotProductColumns = [
        {title:'图片',dataIndex:'defaultSku.skuMedia',width:"12%",renderer : function(value,rowObj){
            if(value['primary']){
                var url=value['primary'].url;
                return '<img src="/admin/'+url+'?thumbnail" style="width:60px;height: 60px;" />';
            }
        }},
        {title:'编号',dataIndex:'id',width:'8%'},
        {title:'产品名称',dataIndex:'defaultSku.name',width:'18%',renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }},
        {title:'类别名称',dataIndex:'defaultCategory.name',width:'14%',renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }},
        {title:'吊牌价格',dataIndex:'defaultSku.retailPrice',width:'10%',renderer:app.grid.format.renderMoney},
        {title:'销售价格',dataIndex:'defaultSku.salePrice',width:'10%',renderer:app.grid.format.renderMoney},
        {title:'产品库存',dataIndex:'defaultSku.quantityAvailable',width:'10%',renderer:function (value, rowObj) {
            if(rowObj.haveOption){
                return  rowObj.totalStockQuantity;
            }else{
                return  rowObj["defaultSku.quantityAvailable"];
            }
        }},
        {title:'热销排行', dataIndex:'index', width:'10%', renderer : function(value,obj){
            value = value || '';
            return '<input type="text" class="control-text" style="width:30px;" id="index_'+obj.id+'"  data-rules="{required : true}" value="' + value + '"/>'
        }},
        {title:'操作',dataIndex:'',width:'8%',renderer : function(value,obj){
            var delStr = '<span class="grid-command btn-del" title="删除产品信息">移除</span>';
            return delStr;
        }}
    ];

    var productStore = undefined, hotProductStore = undefined;
    var productGrid = undefined, hotProductGrid = undefined;
    var productConditionIdArray = [], hotProductConditionIdArray = [];
    var Grid = BUI.Grid,HotGrid = BUI.Grid,
            Data = BUI.Data,HotData = BUI.Data,
            Store = Data.Store, HotStore = HotData.Store;

    $(function(){

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#controlContainerForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("控件保存成功!");
                    var controlId = data['data']["id"];
                    var controlName = data['data']["name"];
                    var controlType = data['data']["type"];
                    var controlShowType = data['data']['showType'];
                <#if isNew?? && isNew>
                    window.parent.parent.fillControlContent(controlId, controlName, controlType, controlShowType);
                    window.parent.location.href = window.parent.parent.toChildIFrameRefresh();
                <#else>
                    window.parent.fillControlContent(controlId, controlName, controlType, controlShowType);
                    window.location.reload();
                </#if>
                }
            }
        });
        form.on('beforesubmit', function(){
            return collectData(); //收集数据，以JSON字符串的形式传输
        });
        form.render();

        $("button[name='addHotSearch']").on('click', function(){
            addHotSearch($(this));
        });

        $("button[name='addProductBtn']").on('click', function(){
            var Overlay = BUI.Overlay;
            var dialog = new Overlay.Dialog({
                title:'产品列表',
                width: 700,
                height: 430,
                closeAction: 'destroy',
                loader : {
                    url : '${ctx}/admin/sa/promotion/productDialog/list',
                    autoLoad : false, //不自动加载
                    lazyLoad : false //不延迟加载
                },
                buttons:[{
                    text:'选 择',
                    elCls : 'button button-primary',
                    handler : function(){
                        var selectedProducts = getSelectedRecords();
                        this.close();
                        productChoiceEvent(selectedProducts);
                    }
                }],
                mask:true
            });
            dialog.get('loader').load();
            dialog.show();
        });

        $("button[name='addHotProductBtn']").on('click', function(){
            var Overlay = BUI.Overlay;
            var dialog = new Overlay.Dialog({
                title:'产品列表',
                width: 700,
                height: 430,
                closeAction: 'destroy',
                loader : {
                    url : '${ctx}/admin/sa/promotion/productDialog/list',
                    autoLoad : false, //不自动加载
                    lazyLoad : false //不延迟加载
                },
                buttons:[{
                    text:'选 择',
                    elCls : 'button button-primary',
                    handler : function(){
                        var selectedProducts = getSelectedRecords();
                        this.close();
                        hotProductChoiceEvent(selectedProducts);
                    }
                }],
                mask:true
            });
            dialog.get('loader').load();
            dialog.show();
        });
        initHotSearch();
        initProductCondition();
        initHotProductCondition();
    });

    function initProductCondition(){
        var isNew = ${isNew?default(true)?string("true","false")};
        if(isNew){
            buildProductGrid();
        } else {
            <#if controlDTO?? && controlDTO.products?? && controlDTO.products?has_content>
                <#list controlDTO.products as product>
                    <#if (product.productId)?? && (product.productId)?has_content>
                        productConditionIdArray.push('${(product.productId)}');
                    </#if>
                </#list>
            </#if>
            buildProductGrid();
            if(productConditionIdArray.length > 0){
                productStore.load();
            }
        }
    }

    function initHotProductCondition(){
        var isNew = ${isNew?default(true)?string("true","false")};
        if(isNew){
            buildHotProductGrid();
        } else {
            <#if controlDTO?? && controlDTO.hotProducts?? && controlDTO.hotProducts?has_content>
                <#list controlDTO.hotProducts as hotProduct>
                    <#if (hotProduct.productId)?? && (hotProduct.productId)?has_content>
                        hotProductConditionIdArray.push('${(hotProduct.productId)}');
                    </#if>
                </#list>
            </#if>
            buildHotProductGrid();
            hotProductStore.on('load', function(ev){
                <#if controlDTO?? && controlDTO.hotProducts?? && controlDTO.hotProducts?has_content>
                    <#list (controlDTO.hotProducts) as hotProductDTO>
                        var productId = '${(hotProductDTO.productId)!}';
                        var productIndex = '${(hotProductDTO.index)!}';
                        if(productIndex && productIndex != ""){
                            var productResults = hotProductStore.getResult();
                            for(var i = 0; i < productResults.length; i++){
                                if(productResults[i]["id"] == productId){
                                    $("#index_" + productId).val(productIndex);
                                }
                            }
                        }
                    </#list>
                </#if>
            });
            if(hotProductConditionIdArray.length > 0){
                hotProductStore.load();
            }
        }
    }

    function initHotSearch(){
        <#if controlDTO?? && (controlDTO.others)?? && (controlDTO.others)?has_content>
            <#list controlDTO.others as other>
                var hotSearchContent = addHotSearch($("button[name='addHotSearch']"));
                hotSearchContent.find("input[data-param-attr-name='name']").val('${(other.name)!}');
                hotSearchContent.find("input[data-param-attr-name='linkUrl']").val('${(other.linkUrl)!}');
                <#if (other.openNewWin)?? && (other.openNewWin)>
                    hotSearchContent.find("input[data-param-attr-name='openNewWin']").attr("checked", "checked");
                </#if>
            </#list>
        </#if>
    }

    function collectData(){
        var selectStatus = $("div[name='statusCd']").find("input[type='radio']:checked");
        if(!selectStatus || !selectStatus.length){
            BUI.Message.Alert("请选择控件状态!");
            return false;
        }
        $("input[name='statusCd']").val(selectStatus.val());

        var index = 0;
        $(".hotSearchContent").each(function(){
            $(this).find("input[data-param-attr-name='index']").val(index);
            $(this).find("input[data-pass-param]").each(function(){
                var name = $(this).attr("data-param-attr-name");
                var objName = $(this).attr("data-param-obj-name");
                if(objName){
                    name = objName +"[" + (index) + "]." + name;
                }
                $(this).attr("name", name);
            });
            index = index + 1;
        });

        $("input[data-param-name='products']").remove();
        if(productStore && productStore.getResult() && productStore.getResult().length){
            if(productStore.getResult().length > 4){
                BUI.Message.Alert("最多只能显示4条商品!");
                return false;
            }
            for(var i = 0; i < productStore.getResult().length; i++){
                var paramIdDom = "<input data-param-name='products' type='hidden' value='" +productStore.getResult()[i].id +"' name='products["+i+"].productId'>";
                var paramIndexDom = "<input data-param-name='products' type='hidden' value='" +i+"' name='products["+i+"].index'>";
                $(paramIdDom).appendTo($("#controlContainerForm"));
                $(paramIndexDom).appendTo($("#controlContainerForm"));
            }
        }

        var validResult = true;
        $("input[data-param-name='hotProducts']").remove();
        if(hotProductStore && hotProductStore.getResult() && hotProductStore.getResult().length){
            for(var i = 0; i < hotProductStore.getResult().length; i++){
                var hotProductIndex = $("#index_" + hotProductStore.getResult()[i].id).val();
                hotProductIndex = YrValidator.replaceAllSpace(hotProductIndex);
                if(!YrValidator.isNotNegativeInteger(hotProductIndex)){
                    validResult = false;
                    break;
                }
                var paramIdDom = "<input data-param-name='hotProducts' type='hidden' value='" +hotProductStore.getResult()[i].id +"' name='hotProducts["+i+"].productId'>";
                var paramIndexDom = "<input data-param-name='hotProducts' type='hidden' value='" +hotProductIndex+"' name='hotProducts["+i+"].index'>";
                $(paramIdDom).appendTo($("#controlContainerForm"));
                $(paramIndexDom).appendTo($("#controlContainerForm"));
            }
        }

        if(!validResult){
            BUI.Message.Alert("热销商品顺序设置格式错误!");
            return false;
        }
        return true;
    }

    function addHotSearch(obj){
        var targetDom = $(obj).prev("div");
        var targetDomContent = targetDom.clone();
        targetDomContent.addClass("hotSearchContent");
        var otherContentId = generateUniqueIdForDom("hotSearchContent", "data-hot-search-id");
        targetDomContent.attr("data-hot-search-id", otherContentId);
        targetDomContent.find("*[cascade-container]").each(function(){
            var cascadeTarget = $(this).attr("cascade-container");
            var cascadeType = $(this).attr("cascade-type");
            var fileType = $(this).attr("data-file-type");
            var id = cascadeType + "_" + fileType + "_" + otherContentId;
            $(this).attr("id", id);
            $(this).nextAll(cascadeTarget).attr("for", id);
        });
        targetDomContent.insertBefore(targetDom);
        targetDomContent.show();
        return targetDomContent;
    }

    function generateUniqueIdForDom(domClass, idAttr) {
        var returnTabId = null;
        while(returnTabId == null){
            var tabId = parseInt(Math.random() * (600 - 10) + 10);
            var isRepeat = false;
            $("." + domClass).each(function(){
                var pId = $(this).attr(idAttr);
                if(pId && pId != ""){
                    pId = parseInt(pId);
                    if(tabId == pId){
                        isRepeat = true;
                        return false;
                    }
                }
            });
            if(!isRepeat){
                returnTabId = tabId;
            }
        }
        return returnTabId;
    }

    function deleteHotSearch(obj){
        $(obj).parent().parent().remove();
    }

    function productChoiceEvent(selectedProduct){
        var oldProductStr = "";
        oldProductStr = "," + productConditionIdArray.join(',') + ",";
        BUI.each(selectedProduct, function(selectedP){
            var id = selectedP.productId;
            if(oldProductStr.indexOf("," + id + ",") < 0){
                productConditionIdArray.push(id);
            }
            var count = productStore.getCount();
            //添加记录到倒数第二个，同时防止添加重复的记录
            productStore.addAt(selectedP, count, true, function(obj1,obj2){
                return obj1.id == obj2.id;
            });
        });
    }

    function hotProductChoiceEvent(selectedProduct){
        var oldProductStr = "";
        oldProductStr = "," + hotProductConditionIdArray.join(',') + ",";
        BUI.each(selectedProduct, function(selectedP){
            var id = selectedP.productId;
            if(oldProductStr.indexOf("," + id + ",") < 0){
                hotProductConditionIdArray.push(id);
            }
            var count = hotProductStore.getCount();
            //添加记录到倒数第二个，同时防止添加重复的记录
            hotProductStore.addAt(selectedP, count, true, function(obj1,obj2){
                return obj1.id == obj2.id;
            });
        });
    }

    function buildProductGrid(){
        productStore = new Store({
            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : productConditionIdArray.join(",")
            },
            pageSize : 5
        });
        productGrid = new Grid.Grid({
            render:'#productGrid',
            columns : productColumns,
            store: productStore,
            width: '100%',
            loadMask:true
        });

        //监听事件，删除一条记录
        productGrid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                deleteProduct(record);
            }
        });

        productGrid.render();
    }

    function buildHotProductGrid(){
        hotProductStore = new HotStore({
            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : hotProductConditionIdArray.join(",")
            },
            pageSize : 5
        });
        hotProductGrid = new HotGrid.Grid({
            render:'#hotProductGrid',
            columns : hotProductColumns,
            store: hotProductStore,
            width: '100%',
            loadMask:true
        });

        //监听事件，删除一条记录
        hotProductGrid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                deleteHotProduct(record);
            }
        });

        hotProductGrid.render();
    }

    function deleteProduct(record){
        BUI.Message.Confirm('确认移除记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + productConditionIdArray.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            productConditionIdArray = tempArray;

            productStore.remove(record);
        },'question');
    }

    function deleteHotProduct(record){
        BUI.Message.Confirm('确认热销记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + hotProductConditionIdArray.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            hotProductConditionIdArray = tempArray;

            hotProductStore.remove(record);
        },'question');
    }
</script>
</body>
</html>