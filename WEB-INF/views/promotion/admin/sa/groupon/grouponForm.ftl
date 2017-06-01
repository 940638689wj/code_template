<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/promotion/groupon/list">团购</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if (grouponDTO.promotionId)??>编辑<#else>新增</#if>团购</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/promotion/groupon/save" method="post">
        <input type="hidden" name="promotionId" id="promotionId" value="${(grouponDTO.promotionId)!}">

        <div id="edit-div" class="form-content">
        	<div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>活动产品：</label>
                    <div class="controls control-row-auto">
                        <ul class="toolbar">
		                    <li>
		                        <input type="hidden" name="selectProductId" id="selectProductId" <#if productId?? && productId?has_content>value="${productId}"</#if>>
		                        <button id="choiceProductBtn" type="button" class="button button-info">
		                        <i class="icon icon-white icon-envelope"></i> 选择商品</button>
		                    </li>
		                </ul>
		                <hr>
                    </div>
                </div>
            </div>
            
            <div class="row">
            	<div class="search-grid-container">
                    <div id="productGrid"></div>
                </div>
            </div>
        
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购名称：</label>
                    <div class="controls">
                        <input value="${(grouponDTO.promotionName)!?html}" name="promotionName" data-rules="{required:true,maxlength:50}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>初始虚拟销售量：</label>
                    <div class="controls">
                        <input value="${(grouponDTO.grouponInitSaleNum)!}" name="grouponInitSaleNum" data-rules="{required:true,regexp:/^(([1-9][0-9]{0,10}))$/}" data-messages="{regexp:'请输入大于0的整数，且不能超过11位'}" 
                        	class="input-normal control-text" <#if (grouponDTO.promotionId)??>disabled</#if>>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购最少销售量：</label>
                    <div class="controls">
                        <input value="${(grouponDTO.grouponMinSaleNum)!}" name="grouponMinSaleNum" data-rules="{required:true,regexp:/^(([1-9][0-9]{0,10}))$/}" data-messages="{regexp:'请输入大于0的整数，且不能超过11位'}" 
                        	class="input-normal control-text" <#if (grouponDTO.promotionId)??>disabled</#if>>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购最大销售量：</label>
                    <div class="controls">
                        <input value="${(grouponDTO.grouponMaxSaleNum)!}" name="grouponMaxSaleNum" data-rules="{required:true,regexp:/^(([1-9][0-9]{0,10}))$/}" data-messages="{regexp:'请输入大于0的整数，且不能超过11位'}" 
                        	class="input-normal control-text" <#if (grouponDTO.promotionId)??>disabled</#if>>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>每人限购量：</label>
                    <div class="controls">
                        <input value="${(grouponDTO.grouponPersonQuotaNum)!}" name="grouponPersonQuotaNum" data-rules="{required:true,regexp:/^(([1-9][0-9]{0,10}))$/}" data-messages="{regexp:'请输入大于0的整数，且不能超过11位'}" 
                        	class="input-normal control-text" <#if (grouponDTO.promotionId)??>disabled</#if>>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购价格：</label>
                    <div class="controls">
                        <input value="${(grouponDTO.grouponPrice)!}" name="grouponPrice" data-rules="{required:true,regexp:/^(([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}" 
                        	class="input-normal control-text" <#if (grouponDTO.promotionId)??>disabled</#if>>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <#assign statusCd=0/>
                    <#if (grouponDTO.promotionId)?? && (grouponDTO.statusCd)?? && grouponDTO.statusCd == 1>
                        <#assign statusCd=1/>
                    </#if>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1" <#if statusCd==1>checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0" <#if statusCd==0>checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>有效使用日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (grouponDTO.enableStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="${(grouponDTO.enableStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="">
                        </#if>
                        <span>至</span>
                        <#if (grouponDTO.enableEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="${(grouponDTO.enableEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员注册时间：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (grouponDTO.regStartTime)?has_content>
                            <input type="text" class="calendar control-text" name="regStartTime" data-rules="{required:true}" value="${(grouponDTO.regStartTime)?string('yyyy-MM-dd')}" disabled>
                        <#else>
                            <input type="text" class="calendar control-text" name="regStartTime" data-rules="{required:true}" value="">
                        </#if>
                            <span>至</span>
                        <#if (grouponDTO.regEndTime)?has_content>
                            <input type="text" class="calendar control-text" name="regEndTime" data-rules="{required:true}" value="${(grouponDTO.regEndTime)?string('yyyy-MM-dd')}" disabled>
                        <#else>
                            <input type="text" class="calendar control-text" name="regEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员级别：</label>
                    <div class="controls control-row-auto">
                        <#assign isAllUserLevel = (grouponDTO.isAllUserLevelJoin)?default(false)/>
                        <label class="checkbox">
                            <input <#if (grouponDTO.promotionId)??>disabled</#if> <#if isAllUserLevel> checked="checked" </#if> id="allUserLevel" name="allUserLevel" value='1' type="checkbox">
                            全选
                        </label><br>

                        <#if userLevelList?? && (userLevelList?size > 0)>
                            <#assign temp = 1>
                            <#list userLevelList as userLevel>
                                <#assign userLevelId = (userLevel.userLevelId)?string>
                                <#assign userLevelSelect = false/>
                                <#if (userLevelXrefMap[userLevelId])??>
                                    <#assign userLevelSelect = true/>
                                </#if>

                                <label class="checkbox">
                                    <input <#if (grouponDTO.promotionId)??>disabled</#if> name="userLevel" <#if userLevelSelect> checked='checked' </#if> type="checkbox" value="${(userLevel.userLevelId)!}">
                                    ${(userLevel.userLevelName)!}
                                </label>&nbsp;&nbsp;

                                <#if temp % 6 == 0>
                                    <br>
                                </#if>
                                <#assign temp = temp + 1 >
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">活动城市：</label>
                    <div class="controls">
                        <#assign isAllAreaJoin = (grouponDTO.isAllAreaJoin)?default(false)/>

                        <a class="button" onclick="selectArea();">+选择地区</a>
                        <input type="hidden" name="isAllAreaJoin" id="isAllAreaJoin" value="<#if isAllAreaJoin>1<#else>0</#if>">
                        <input type="hidden" name="selectProvinceIds" id="selectProvinceIds" <#if provinceIds?? && provinceIds?has_content>value="${provinceIds}" </#if>>
                        <input type="hidden" name="selectCityIds" id="selectCityIds" <#if cityIds?? && cityIds?has_content>value="${cityIds}" </#if>>
                    </div>
                </div>
            </div>

            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>

<div id="areaContent" class="hide">
    <div class="area-list">
        <div class="item">
            <div class="hd">
                <label class="checkbox" for="isAllCountry">
                	<input type="checkbox" id="isAllCountry" <#if isAllAreaJoin>checked</#if> <#if (grouponDTO.promotionId)??>disabled</#if> />全国
                </label>
            </div>
            <div class="bd">
                <#if provinceList?? && provinceList?has_content>
                    <ul>
                        <#list provinceList as province>
                            <#assign provinceSelect = false/>
                            <#if (provinceXrefMap[province.id?string])??>
                                <#assign provinceSelect = true/>
                            </#if>
                            <li>
                                <#assign cityList = cityMap[province.id?string]?default("")/>
                                <label class="checkbox" for="province_${province_index}">
                                    <input type="checkbox" name="province_" data-province="${province_index}"  value="${province.id}" <#if provinceSelect> checked='checked' </#if>  
                                    <#if (grouponDTO.promotionId)??> disabled </#if> id="province_${province_index}" />${(province.areaName)!}
                                    <#if cityList?is_sequence && cityList?size gt 0><em>(${cityList?size})</em><i class="x-caret x-caret-down"></i></#if>
                                </label>

                                <#if cityList?is_sequence && cityList?size gt 0>
                                    <div class="area-droplist">
                                        <#list cityList as city>
                                        	<#assign citySelect = false/>
                                            <#if (cityXrefMap[city.id?string])??>
                                                <#assign citySelect = true/>
                                            </#if>
                                            <label class="checkbox" for="city_${province_index}_${city_index}">
                                                <input type="checkbox" name="city_" data-province="${province_index}" data-city="${city_index}" value="${city.id}" <#if citySelect> checked='checked' </#if>
                                                id="city_${province_index}_${city_index}" <#if (grouponDTO.promotionId)??> disabled </#if>/>${(city.areaName)!}
                                            </label>
                                        </#list>
                                    </div>
                                </#if>
                            </li>
                        </#list>
                    </ul>
                </#if>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var dialogregion = null;
    var choiceProductDialog = null;
    var selectProductId = '';

    BUI.use('bui/overlay',function(Overlay){
        $(".area-list .bd li").each(function(){
            var li = $(this),
                    labelbox = li.find(".checkbox").eq(0),
                    droplist = li.find(".area-droplist");
            if(droplist[0]){
                li.hover(function(){
                    labelbox.addClass("current");
                    droplist.show();
                },function(){
                    labelbox.removeClass("current");
                    droplist.hide();
                })
            }
        });

        dialogregion = new Overlay.Dialog({
            title:'选择地区',
            width:680,
            height:400,
            mask:true,
            buttons:[
                {
                    text:'确定',
                    elCls : 'button button-primary',
                    handler : function(){
                        var selectProvinceIds = [];
                        var selectCityIds = [];
                        $("input[name='province_']").filter(":checked").each(function(){
                            selectProvinceIds.push($(this).val());
                        });
                        $("input[name='city_']").filter(":checked").each(function(){
                            selectCityIds.push($(this).val());
                        });

                        $("#selectProvinceIds").val(selectProvinceIds.join(','));
                        $("#selectCityIds").val(selectCityIds.join(','));

                        this.close();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'areaContent'
        });

        choiceProductDialog = new Overlay.Dialog({
            title:'商品列表',
            width: 1000,
            height: 460,
            loader : {
                url : '${ctx}/admin/sa/label/productDialog?single=1',
                autoLoad : false, //不自动加载
                lazyLoad : false //不延迟加载
            },
            buttons:[{
                text:'选 择',
                elCls : 'button button-primary',
                handler : function(){
                    this.close();
                    productChoiceEvent(getSelectedRecords());
                }
            }],
            mask:true
        });
        
    });
    
    
    
    /**
     * 构建商品表格
     *
     */
    var Grid = BUI.Grid,
            Data = BUI.Data,
            Store = Data.Store;
    var productColumns = [
        {title: '商品ID', dataIndex: 'productId', width: 80},
        {
            title: '商品名称',
            dataIndex: 'productName',
            width: 120,
            renderer: function (value) {
                return app.grid.format.encodeHTML(value);
            }
        },
        {title: '品牌名称', dataIndex: 'brandName', width: 120},
        {title: '分类名称', dataIndex: 'categoryName', width: 120},
        {title: '商品挂牌价', dataIndex: 'tagPrice', width: 150},
        {title: '商品零售价', dataIndex: 'defaultPrice', width: 150},
        <#if (grouponDTO.promotionId)??>
        	{title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
	            var delStr = '<span title="删除商品信息">删除</span>';
	            return delStr;
	        }}
        <#else>
	        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
	            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
	            return delStr;
	        }}
        </#if>
    ];
    
    var productStore;
    var productGrid;
    function buildProductGrid(){
        productStore = new Store({
        	url : '${ctx}/admin/sa/label/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : selectProductId,
                promotionId:$('#promotionId').val()
            },
            pageSize : 5
        });
        productGrid = new Grid.Grid({
            render:'#productGrid',
            columns : productColumns,
            store: productStore,
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:true
            },
            loadMask:true,
        });

        //监听事件，删除一条记录
        productGrid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                deleteProduct(record,productGrid,productStore);
                
            }
        });

        productGrid.render();
    }
    
    //删除商品操作
    function deleteProduct(record,productGrid,productStore){
    	//如果是编辑操作，则该操作禁止
        <#if (grouponDTO.promotionId)??>
        	return;
        </#if>
        BUI.Message.Confirm('确认删除记录？',function(){
            selectProductId = '';
            
            //删除商品时，不重新加载数据
          	productStore.remove(record);

        },'question');
    }
    /**
    * 初始化
    *
    * @type {Array}
    */
    
    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initProductCondition(){
	    var isNew = $('#promotionId').val();//如果promotionId有就是编辑操作
	    
	    if(!isNew){
	       buildProductGrid();
	    }else {
            <#if productId?? && productId?has_content>
            	selectProductId = ${productId};
            </#if>
            buildProductGrid();

            if(selectProductId != ''){
                productStore.load();
            }
        }
	}
	//添加新的商品时，去除重复商品
	function productChoiceEvent(selectedPid){
        selectProductId = selectedPid[0].productId;
        reloadProductCondition();
    }
	//重新加载数据
    function reloadProductCondition(){
        if(!productStore){
            buildProductGrid();
            if(selectProductId != ''){
                productStore.load();
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        } else {
            if(selectProductId != ''){
                var params = { //配置初始请求的参数
                    start : 0,
                    "in_id" : selectProductId
                };
                productStore.load(params);
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        }
    }
    
	
    $(function(){
    	//会员操作
        $("#allUserLevel").on('change', function(){
            $("input[name='userLevel']").prop("checked", this.checked);
        });
        <#if isAllUserLevel>
            $("#allUserLevel").trigger('change');
        </#if>
        
        $("input[name='userLevel']").on('change', function(){
            var $subs = $("input[name='userLevel']");
            $("#allUserLevel").prop("checked", $subs.length == $subs.filter(":checked").length ? true :false);
        });
		//全国操作
        $("#isAllCountry").on('change', function(){
            $("input[name='province_']").prop("checked", this.checked);
            $("input[name='city_']").prop("checked", this.checked);
            if(this.checked){
                $('#isAllAreaJoin').val("1");
            }else{
                $('#isAllAreaJoin').val("0");
            }
        });
        <#if isAllAreaJoin>
            $("#isAllCountry").trigger('change');
        </#if>
		//省、市操作
        $("input[name='province_']").on('change', function(){
            var province = $(this).attr("data-province");
            $("input[name='city_'][data-province='"+province+"']").prop("checked", this.checked);
        });

        $("input[name='city_']").on('change', function(){
            var province = $(this).attr("data-province");
            var $subs = $("input[name='city_'][data-province='"+province+"']");
            $("input[name='province_'][data-province='"+province+"']").prop("checked" , $subs.length == $subs.filter(":checked").length ? true :false);
        });
        
        //添加时间段的操作
        $('#ConditionDiv').on('click', '.addCondition', function(){
            var parentPanel = $(this).closest(".ConditionPanel");

            var cloneCondition = parentPanel.clone(true);
            //清空复制过来的值
            var inputArr=cloneCondition.find("input");
            inputArr.each(function (){
                $(this).val("");
            });
            cloneCondition.find(".delCondition").show();

            cloneCondition.insertAfter(parentPanel);
        });
        //删除时间段的操作
        $('#ConditionDiv').on('click', '.delCondition', function(){
            $(this).closest(".ConditionPanel").remove();
        });
        

		//点击选择商品显示商品列表窗口
        $("#choiceProductBtn").on('click', function(){
        	//如果是编辑操作，则该操作禁止
            <#if (grouponDTO.promotionId)??>
            	return;
            </#if>
            choiceProductDialog.get('loader').load();
            choiceProductDialog.show();
        });   

		//表单提交
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/groupon/list";
                }
            }
        });
        
        //提交表单之前，检查：如果选择的是指定商品，却没有选择商品则给提示
        form.on('beforesubmit', function(){
        	var selectUserLevelCount=$("input[name='userLevel']").filter(":checked").length;
            if(selectUserLevelCount <1){
                app.showError('请选择会员级别!');
                return false;
            }
                
            if(selectProductId == ''){
                app.showError('请选择商品!');
                return false;
            }
            
            $('#selectProductId').val(selectProductId);
            return true;
        })
        
        form.render();
        
        initProductCondition();
        
        //重置按钮
        $('.actions-bar button[type="reset"]').click(function() {
        	//如果是编辑操作,只重置启用状态
            <#if (grouponDTO.promotionId)??>
            	$('.controls input[name="statusCd"][value="${(grouponDTO.statusCd)!default(1)}"]').attr("checked",true);
            	return;
            </#if>
            $('.controls input[name="statusCd"][value="1"]').attr("checked",true);
        });
    });

	//显示选择地区的窗口
    function selectArea(){
        dialogregion.show();
    }
    
</script>
</body>
</html>