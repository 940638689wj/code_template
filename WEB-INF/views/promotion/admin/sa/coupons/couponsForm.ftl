<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/promotion/coupons/list">优惠券</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew>新增<#else>编辑</#if>优惠券信息</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/promotion/coupons/formPost" method="post">
        <input type="hidden" name="promotionId" id="promotionId" value="${(couponFormDTO.promotionId)!}">
        <input type="hidden" id="isAuditPass" value="${isAuditPass?string("true","false")}">

        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input <#if isAuditPass>disabled</#if> value="${(couponFormDTO.promotionName)!?html}" name="promotionName"
                               data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>描述：</label>
                    <div class="controls control-row-auto">
                        <textarea <#if isAuditPass>disabled</#if> name="promotionDesc" data-rules="{required:true}"
                                  class="control-row4 input-large">${(couponFormDTO.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>优惠券类型：</label>
                <#assign promotionTypeCd=54/><#-- 抵用券 -->
                <#if couponFormDTO?? && couponFormDTO?has_content && (couponFormDTO.promotionTypeCd)?? &&
                couponFormDTO.promotionTypeCd == 55><#-- 折扣券 -->
                    <#assign promotionTypeCd=55/>
                </#if>

                    <div class="controls">
                        <input <#if !isNew>disabled</#if> type="radio" name="promotionTypeCd" value="54"
                               <#if promotionTypeCd==54>checked="checked" </#if>/>代金券
                        &nbsp;&nbsp;
                        <input <#if !isNew>disabled</#if> type="radio" name="promotionTypeCd" value="55"
                               <#if promotionTypeCd==55>checked="checked" </#if>/>折扣券
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">
                        <span class="promotionType" data-promotionType="54">面额</span>
                        <span class="promotionType" data-promotionType="55" style="display: none;">折扣额(%)</span>：
                    </label>

                    <div class="controls control-row-auto" id="couponConditionDiv">
                    <#if orderTotalConditionRuleList?? && orderTotalConditionRuleList?has_content>
                        <#list orderTotalConditionRuleList as conditionRule>
                            <div class="couponConditionPanel">
                                <input <#if !isNew>disabled</#if> value="${(conditionRule.discountValueShow)!}"
                                       name="discountValue" class="input-small control-text">
                                &nbsp;&nbsp;&nbsp;
                                使用条件：
                                <input <#if !isNew>disabled</#if> value="${(conditionRule.conditionExpressionValue)!}"
                                       name="discountCondition" class="input-small control-text">
                                &nbsp;&nbsp;&nbsp;
                            </div>
                        </#list>
                    <#else>
                        <div class="couponConditionPanel">
                            <input value="" name="discountValue" class="input-small control-text">
                            &nbsp;&nbsp;&nbsp;
                            使用条件：
                            <input value="" name="discountCondition" class="input-small control-text">

                            &nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0);" class="addCouponCondition">
                                +优惠券
                            </a>
                            <a href="javascript:void(0);" class="delCouponCondition" style="display: none;">
                                删除优惠券
                            </a>
                        </div>
                    </#if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                <#assign statusCd=0/>
                <#if couponFormDTO?? && couponFormDTO?has_content && (couponFormDTO.statusCd)?? && couponFormDTO.statusCd == 1>
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
                    <#if (couponFormDTO.enableStartTime)?has_content>
                        <input <#if isAuditPass>disabled</#if> type="text" class="calendar control-text" name="enableStartTime"
                               data-rules="{required:true}" value="${(couponFormDTO.enableStartTime)!}">
                    <#else>
                        <input type="text" class="calendar control-text" name="enableStartTime"
                               data-rules="{required:true}" value="">
                    </#if>
                        <span>至</span>
                    <#if (couponFormDTO.enableEndTime)?has_content>
                        <input <#if isAuditPass>disabled</#if> type="text" class="calendar control-text" name="enableEndTime"
                               data-rules="{required:true}" value="${(couponFormDTO.enableEndTime)!}">
                    <#else>
                        <input type="text" class="calendar control-text" name="enableEndTime"
                               data-rules="{required:true}" value="">
                    </#if>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>生成数量：</label>
                    <div class="controls">
                        <input <#if isAuditPass>disabled</#if> value="${(couponFormDTO.couponTotalNum)!}" name="couponTotalNum"
                               data-rules="{required:true,regexp:/^\d*$/}" data-messages="{regexp:'请输入整数'}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <!-- 是否预生成优惠码  -->
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>预生成优惠码：</label>
                    <div class="controls">
                        <label class="checkbox">
                            <input
                            <#if (couponFormDTO.isPreGenerate)?? && (couponFormDTO.isPreGenerate==1)>
                                    checked="checked" </#if> id="isPreGenerate" name="isPreGenerate" value='1'
                                    <#if !isNew>disabled</#if> type="checkbox">
                            (通过网站点击领取的请不要选预生成，短信等直接给优惠码的请选择预生成。此选项在编辑时不能更改。)
                        </label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>限定会员领取次数：</label>
                    <div class="controls">
                        <input <#if isAuditPass>disabled</#if> value="${(couponFormDTO.couponPersionQuotaNum)?default(1)}"
                               name="couponPersionQuotaNum" data-rules="{regexp:/^\d*$/}"
                               data-messages="{required:true,regexp:'请输入整数'}" class="input-normal control-text">
                    </div>
                </div>
            </div>

        <#assign pushTypeCd=1/>
        <#if couponFormDTO?? && couponFormDTO.pushTypeCd?has_content && (couponFormDTO.pushTypeCd)?? && couponFormDTO.pushTypeCd==2>
            <#assign pushTypeCd=2/>
        <#elseif couponFormDTO?? && couponFormDTO.pushTypeCd?has_content && (couponFormDTO.pushTypeCd)?? && couponFormDTO.pushTypeCd==3>
            <#assign pushTypeCd=3/>
        <#elseif couponFormDTO?? && couponFormDTO.pushTypeCd?has_content && (couponFormDTO.pushTypeCd)?? && couponFormDTO.pushTypeCd==4>
            <#assign pushTypeCd=4/>
        </#if>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">赠送条件：</label>
                    <div class="controls">
                        <label class="radio">
                            <input <#if isAuditPass>disabled</#if>  type="radio" name="pushTypeCd" value="1"
                            <#if pushTypeCd==1> checked="checked" </#if>/>
                            无条件
                        </label>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">&nbsp;&nbsp;</label>
                    <div class="controls">
                        <label class="radio">
                            <input <#if isAuditPass>disabled</#if> type="radio" name="pushTypeCd" value="4"
                            <#if pushTypeCd==4> checked="checked" </#if>/>
                        </label>
                        首次注册用券
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">&nbsp;&nbsp;</label>
                    <div class="controls">
                        <label class="radio">
                            <input <#if isAuditPass>disabled</#if> type="radio" name="pushTypeCd" value="2"
                            <#if pushTypeCd==2> checked="checked" </#if>/>
                        </label>
                        每笔订单完成
                        <input <#if isAuditPass>disabled</#if> value="${(couponFormDTO.couponPushOrderAmtLimit)!}"
                               name="couponPushOrderAmtLimit" data-rules="{min:0,number:true}"
                               class="input-normal control-text">
                        元
                    </div>

                    <div class="tips-wrap">
                        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                            <div class="tips-content">订单应支付金额满足条件</div>
                        </div>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">&nbsp;&nbsp;</label>
                    <div class="controls">
                        <label class="radio">
                            <input <#if isAuditPass>disabled</#if> type="radio" name="pushTypeCd" value="3"
                            <#if pushTypeCd==3> checked="checked" </#if>/>
                        </label>
                        订单支付完成分享用券
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员注册时间：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                    <#if (couponFormDTO.regStartTime)?has_content>
                        <input <#if isAuditPass>disabled</#if> type="text" class="calendar control-text" name="regStartTime"
                               data-rules="{required:true}" value="${(couponFormDTO.regStartTime)!}">
                    <#else>
                        <input type="text" class="calendar control-text" name="regStartTime"
                               data-rules="{required:true}" value="2013-01-01">
                    </#if>
                        <span>至</span>
                    <#if (couponFormDTO.regEndTime)?has_content>
                        <input <#if isAuditPass>disabled</#if> type="text" class="calendar control-text" name="regEndTime"
                               data-rules="{required:true}" value="${(couponFormDTO.regEndTime)!}">
                    <#else>
                        <input type="text" class="calendar control-text" name="regEndTime" data-rules="{required:true}"
                               value="2999-12-31">
                    </#if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>活动会员：</label>
                    <div class="controls control-row-auto">
                    <#assign isAllUser = (couponFormDTO.isAllUserJoin)?default(false)/>
                        <label class="checkbox">
                            <input <#if isAuditPass>disabled</#if> <#if isAllUser> checked="checked"</#if> id="allUser"
                                                   name="activityUsers" value='1' type="radio">
                            全选
                        </label>&nbsp;&nbsp;
                        <label class="checkbox" id="appointUserCheck">
                            <input name="activityUsers" <#if isAuditPass>disabled</#if>
                                   id="appointUser" <#if !isAllUser> checked='checked' </#if> value="0" type="radio">
                            指定会员
                        </label>
                    </div>
                </div>
            </div>
            <div class="row hide" id="userInfo">
                <ul class="toolbar">
                    <li>
                        <input type="hidden" name="selectUserIds" id="selectUserIds"
                               <#if userIds?? && userIds?has_content>value="${userIds}"</#if>>
                        <input type="hidden" name="selectOldUserIds" id="selectOldUserIds"
                               <#if userIds?? && userIds?has_content>value="${userIds}"</#if>>
                        <button <#if isAuditPass>disabled</#if> id="choiceUserBtn" type="button" class="button button-primary">
                            <i class="icon icon-white icon-envelope"></i> 选择会员
                        </button>
                    </li>
                </ul>
                <hr>
                <div class="search-grid-container">
                    <div id="userGrid"></div>
                </div>
            </div>


            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>活动产品：</label>
                    <div class="controls control-row-auto">
                    <#assign isAllProduct = (couponFormDTO.isAllProductJoin)?default(false)/>
                        <label class="checkbox">
                            <input name="activityProducts" id="allProduct"  <#if isAllProduct>checked="checked" </#if>
                                   <#if isAuditPass>disabled</#if> value='1' type="radio">
                            全选
                        </label>&nbsp;&nbsp;
                        <label class="checkbox">
                            <input name="activityProducts" id="appointProduct" <#if !isAllProduct> checked='checked' </#if>
                                   <#if isAuditPass>disabled</#if> value="0" type="radio">
                            指定产品
                        </label>
                    </div>
                </div>
            </div>
            <div class="row hide" id="productInfo">
                <ul class="toolbar">
                    <li>
                        <input type="hidden" name="selectProductIds" id="selectProductIds"
                               <#if productIds?? && productIds?has_content>value="${productIds}"</#if>>
                        <input type="hidden" name="selectOldProductIds" id="selectOldProductIds"
                               <#if productIds?? && productIds?has_content>value="${productIds}"</#if>>
                        <button <#if isAuditPass>disabled</#if> id="choiceProductBtn" type="button" class="button button-primary">
                            <i class="icon icon-white icon-envelope"></i> 选择商品
                        </button>
                    </li>
                </ul>
                <hr>
                <div class="search-grid-container">
                    <div id="productGrid"></div>
                </div>
            </div>

            <div class="actions-bar">
                <button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var choiceProductDialog = null;
    var selectProductIds = [];
    var isAuditPass = $("#isAuditPass").val();

    BUI.use('bui/overlay', function (Overlay) {
        choiceProductDialog = new Overlay.Dialog({
            title: '商品列表',
            width: 1000,
            height: 460,
            loader: {
                url: '${ctx}/admin/sa/promotion/productDialog/productList',
                autoLoad: false, //不自动加载
                lazyLoad: false //不延迟加载
            },
            buttons: [{
                text: '选 择',
                elCls: 'button button-primary',
                handler: function () {
                    this.close();
                    productChoiceEvent(getSelectedRecords());
                }
            }],
            mask: true
        });
    });

    //构建商品表格
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
        {title: '类别名称', dataIndex: 'categoryName', width: 120},
        {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
        {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
        {title: '商品库存', dataIndex: 'realStock', width: 120},
        {title: '更新时间', dataIndex: 'lastUpdateTime', width: 180, renderer: BUI.Grid.Format.datetimeRenderer},
        {
            title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
            var delStr = "";
            if(isAuditPass=="false"){
                delStr = '<span class="grid-command btn-del">删除</span>';
            }
            return delStr;
        }
        }
    ];

    var productStore;
    var productGrid;
    function buildProductGrid() {
        productStore = new Store({
            url: '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad: false, //自动加载数据
            params: { //配置初始请求的参数
                sort: 'id desc',
                "in_id": selectProductIds.join(",")
            },
            pageSize: 5
        });
        productGrid = new Grid.Grid({
            render: '#productGrid',
            columns: productColumns,
            store: productStore,
            // 底部工具栏
            bbar: {
                // pagingBar:表明包含分页栏
                pagingBar: true
            },
            loadMask: true
        });

        //监听事件，删除一条记录
        productGrid.on('cellclick', function (ev) {
            var sender = $(ev.domTarget); //点击的Dom
            if (sender.hasClass('btn-del')) {
                var record = ev.record;
                deleteProduct(record);
            }
        });

        productGrid.render();
    }

    //删除商品操作
    function deleteProduct(record){
        BUI.Message.Confirm('确认删除记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + selectProductIds.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            selectProductIds = tempArray;

            reloadProductCondition();
        },'question');
    }

    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initProductCondition() {
        var isNew = $('#promotionId').val();//如果promotionId有就是编辑操作

        if (!isNew) {
            buildProductGrid();
        } else {
            //将选择商品置灰
            //$("#choiceProductBtn").addClass('disabled');
        <#if productIds?? && productIds?has_content>
            <#assign pids = "'" +productIds+"'">
            var productIds = ${pids};
            selectProductIds = productIds.split(',');
        </#if>
            buildProductGrid();

            if (selectProductIds.length > 0) {
                productStore.load();
            }
        }
    }
    //添加新的商品时，去除重复商品
    function productChoiceEvent(selectedProduct) {
        var oldProductStr = "";
        oldProductStr = "," + selectProductIds.join(',') + ",";
        for (var i = 0; i < selectedProduct.length; i++) {
            var id = selectedProduct[i].productId;
            if (oldProductStr.indexOf("," + id + ",") < 0) {
                selectProductIds.push(id);
            }
        }

//        if ($('#selectOldProductIds').val() != '') {
//            var oldProductIdArr = $('#selectOldProductIds').val().split(',');
//            for (var i = 0; i < oldProductIdArr.length; i++) {
//                if (oldProductStr.indexOf("," + oldProductIdArr[i] + ",") < 0) {
//                    selectProductIds.push(oldProductIdArr[i]);
//                }
//            }
//        }

        reloadProductCondition();
    }
    //重新加载数据
    function reloadProductCondition() {
        if (!productStore) {
            buildProductGrid();
            if (selectProductIds.length > 0) {
                productStore.load();
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        } else {
            if (selectProductIds.length > 0) {
                var params = { //配置初始请求的参数
                    start: 0,
                    "in_id": selectProductIds.join(",")
                };
                productStore.load(params);
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        }
    }


    //会员
    var choiceUserDialog = null;
    var selectUserIds = [];

    BUI.use('bui/overlay', function (Overlay) {
        choiceUserDialog = new Overlay.Dialog({
            title: '会员列表',
            width: 1000,
            height: 460,
            loader: {
                url: '${ctx}/admin/sa/user/productDialog/list',
                autoLoad: false, //不自动加载
                lazyLoad: false //不延迟加载
            },
            buttons: [{
                text: '选 择',
                elCls: 'button button-primary',
                handler: function () {
                    this.close();
                    userChoiceEvent(getSelected());
                }
            }],
            mask: true
        });
    });

    //构建会员表格
    var userColumns = [
        {title: '会员ID', dataIndex: 'userId', width: 80},
        {
            title: '会员标签', dataIndex: 'userLabels', width: 100, renderer: function (value, rowObj) {
            if (null != value) {
                return app.grid.format.encodeHTML(value);
            } else {
                return '';
            }
        }
        },
        {
            title: '用户名', dataIndex: 'loginName', width: 100, renderer: function (value, rowObj) {
            var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>' + app.grid.format.encodeHTML(value) + '</a>';
            return editStr;
        }
        },
        {
            title: '昵称', dataIndex: 'nickName', width: 100, renderer: function (value, rowObj) {
            return app.grid.format.encodeHTML(value);
        }
        },
        {
            title: '手机', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {
            return value;
        }
        },
        {
            title: '注册平台', dataIndex: 'registerPlatformText', width: 100, renderer: function (value, rowObj) {
            return app.grid.format.encodeHTML(value);
        }
        },
        {
            title: '会员等级', dataIndex: 'userLevelName', width: 70, renderer: function (value, rowObj) {
            return app.grid.format.encodeHTML(value);
        }
        },
        {
            title: '状态', dataIndex: 'statusText', width: 60, renderer: function (value, rowObj) {
            return value;
        }
        },
        {
            title: '注册时间', dataIndex: 'registerTime', width: 140, renderer: function (value, rowObj) {
            if (value != null) {
                return BUI.Date.format(value, "yyyy-mm-dd HH:MM:ss");
            }
        }
        },
        {
            title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
            var delStr = "";
            if(isAuditPass=="false"){
                delStr = '<span class="grid-command btn-delUser">删除</span>';
            }
            return delStr;
        }
        }
    ];

    var userStore;
    var userGrid;
    function buildUserGrid() {
        userStore = new Store({
            url: '${ctx}/admin/sa/user/productDialog/grid_json',
            autoLoad: false, //自动加载数据
            params: { //配置初始请求的参数
                sort: 'id desc',
                "in_id": selectUserIds.join(",")
            },
            pageSize: 5
        });
        userGrid = new Grid.Grid({
            render: '#userGrid',
            columns: userColumns,
            store: userStore,
            // 底部工具栏
            bbar: {
                // pagingBar:表明包含分页栏
                pagingBar: true
            },
            loadMask: true
        });

        //监听事件，删除一条记录
        userGrid.on('cellclick', function (ev) {
            var sender = $(ev.domTarget); //点击的Dom
            if (sender.hasClass('btn-delUser')) {
                var record = ev.record;
                deleteUser(record);
            }
        });

        userGrid.render();
    }
    
    function remainTime(){
    	btn=document.getElementById('save');
    	btn.disabled=false;
    }

    //删除商品操作
    function deleteUser(record) {
        BUI.Message.Confirm('确认删除记录？', function () {
            var recordId = "," + record.userId + ",";
            var originUserIdStr = "," + selectUserIds.join(",") + ",";
            originUserIdStr = originUserIdStr.replace(recordId, ",");

            var tempArray = originUserIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            selectUserIds = tempArray;

            reloadUserCondition();
        }, 'question');
    }

    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initUserCondition() {
        var isNew = $('#promotionId').val();//如果promotionId有就是编辑操作

        if (!isNew) {
            buildUserGrid();
        } else {
        <#if userIds?? && userIds?has_content&&userIds!="">
            <#assign uids = "'" +userIds+"'">
            var userIds = ${uids};
            selectUserIds = userIds.split(',');
        </#if>
            buildUserGrid();
        <#if userIds?? && userIds?has_content&&userIds!="">
            if (selectUserIds.length > 0) {
                userStore.load();
            }
        </#if>
        }
    }
    //添加新的用户时，去除重复用户
    function userChoiceEvent(selectedUser) {
        var oldUserStr = "";
        oldUserStr = "," + selectUserIds.join(',') + ",";
        for (var i = 0; i < selectedUser.length; i++) {
            var id = selectedUser[i].userId;
            if (oldUserStr.indexOf("," + id + ",") < 0) {
                selectUserIds.push(id);
            }
        }

//        if ($('#selectOldUserIds').val() != '') {
//            var oldUserIdArr = $('#selectOldUserIds').val().split(',');
//            for (var i = 0; i < oldUserIdArr.length; i++) {
//                if (oldUserStr.indexOf("," + oldUserIdArr[i] + ",") < 0) {
//                    selectUserIds.push(oldUserIdArr[i]);
//                }
//            }
//        }

        reloadUserCondition();
    }
    //重新加载数据
    function reloadUserCondition() {
        if (!userStore) {
            buildUserGrid();
            if (selectUserIds.length > 0) {
                userStore.load();
            } else {
                var records = userStore.getResult();
                userStore.remove(records);
            }
        } else {
            if (selectUserIds.length > 0) {
                var params = { //配置初始请求的参数
                    start: 0,
                    "in_id": selectUserIds.join(",")
                };
                userStore.load(params);
            } else {
                var records = userStore.getResult();
                userStore.remove(records);
            }
        }
    }

    $(function () {
        // 代金券和折扣券更改时，页面显示变换
        $('input[name="promotionTypeCd"]').on('change', function () {
            showPromotionTypeCd($(this).val());
        });
        showPromotionTypeCd($($("input[name='promotionTypeCd']").filter(":checked").get(0)).attr('value'));



        $('#couponConditionDiv').on('click', '.addCouponCondition', function () {
            var parentPanel = $(this).closest(".couponConditionPanel");

            var cloneCouponCondition = parentPanel.clone(true);
            //清空复制过来的值
            var inputArr = cloneCouponCondition.find("input");
            inputArr.each(function () {
                $(this).val("");
            });
            cloneCouponCondition.find(".delCouponCondition").show();

            cloneCouponCondition.insertAfter(parentPanel);
        });
        $('#couponConditionDiv').on('click', '.delCouponCondition', function () {
            $(this).closest(".couponConditionPanel").remove();
        });

        $("#choiceUserBtn").on('click', function () {
            choiceUserDialog.get('loader').load();
            choiceUserDialog.show();
        });

        $("#choiceProductBtn").on('click', function () {
            choiceProductDialog.get('loader').load();
            choiceProductDialog.show();
        });

        initActivityRadioEvent();
    <#if !isAllUser>
        $("input[name='activityUsers']").trigger('change');
    </#if>
    <#if !isAllProduct>
        $("input[name='activityProducts']").trigger('change');
    </#if>

        // 赠送条件如果是首次注册用券是 则不能指定会员
        if($('input[name="pushTypeCd"][value="4"]').is(':checked')){
            $("#appointUserCheck").hide();
        }

        $('input[name="pushTypeCd"]').on('change', function () {
            if($(this).val()==4){
                $("#allUser").attr('checked',true);
                $("input[name='activityProducts']").trigger('change');
                $("#appointUserCheck").hide();
                $("#userInfo").hide();
            }else{
                $("#appointUserCheck").show();
            }
        });

        /* 2016.8.26 By caobr 是否预生成优惠码*/
        //$("#isPreGenerate1111").on('change', function(){
        //勾选this.checked为true, 不勾选为false
        //if(this.checked){
        /*不能添加商品，默认全场*/
        //$("#allProduct").prop("checked", true);
        //$("#productInfo").hide();
        /*不能输入推送条件(将之前输入的值清空)*/
        //$("[name=couponPushOrderAmtLimit]").val("");
        //$("[name=activityProducts],[name=couponPushOrderAmtLimit]").attr("disabled","disabled");

        //
        //var activityProducts = $($("input[name='activityProducts']").filter(":checked").get(0)).val();
        //var html = "<input name='activityProducts' value=" + activityProducts + " type='text' class='hide'>";
        //$("#allProduct").parent("label").append(html);
        //}else{
        //$("[name=activityProducts],[name=couponPushOrderAmtLimit]").removeAttr("disabled");
        //
        //$("#allProduct .hide").remove();
        //}
        //});

        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/coupons/list";
                }
            }
        });
        form.on('beforesubmit', function () {
        	btn=document.getElementById('save');
        	btn.disabled=true;
            var goOn = true;
            var numReg = new RegExp(/^([1-9]\d*|0)(\.\d*[1-9])?$/);
            $("input[name='discountValue']").each(function (i, item) {
                var discountValue = $(this).val();
                if (!discountValue || discountValue == "") {
                    $(this).focus();
                    goOn = false;
                    app.showError('面额/折扣额 不能为空!');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                if (discountValue.match(numReg) == null) {
                    $(this).focus();
                    goOn = false;
                    app.showError('面额/折扣额 输入不正确!');
                    setTimeout("remainTime()",1100);
                    return false;
                }
            })
            if (!goOn) {
                return false;
           }

            var enableEndTimeStr = $('input[name="enableEndTime"]').val();
            var enableEndTime = new Date(enableEndTimeStr.replace(/\-/g, "\/"));
//            if(enableEndTime.getTime() < couponTakeEndTime.getTime()) {
//                app.showError('有效领取结束时间不能大于有效使用结束使用时间!');
//                return false;
//            }

            $("input[name='discountCondition']").each(function () {
                var discountCondition = $(this).val();
                if (!discountCondition || discountCondition == "") {
                    $(this).focus();
                    goOn = false;
                    app.showError('使用条件 不能为空!');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                if (discountCondition.match(numReg) == null) {
                    $(this).focus();
                    goOn = false;
                    app.showError('使用条件 输入不正确!');
                    setTimeout("remainTime()",1100);
                    return false;
                }
            });
            if (!goOn) {
                return false;
           }

            if ($($("input[name='activityUsers']").filter(":checked").get(0)).attr('id') == "appointUser") {
                // 指定会员
                if (selectUserIds.length < 1) {
                    app.showError('请选择会员!');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                var selectUserIdStr = selectUserIds.join(',');
                if ($('#selectOldUserIds').val() != '') {
                    var oldUserIdArr = $('#selectOldUserIds').val().split(',');
                    var j = 0;
                    for (var i = 0; i < oldUserIdArr.length; i++) {
                        if (selectUserIdStr.indexOf(oldUserIdArr[i]) != -1) {
                            j++;
                        }
                    }
                }
                $('#selectUserIds').val(selectUserIds);
            }

            if ($($("input[name='activityProducts']").filter(":checked").get(0)).attr('id') == "appointProduct") {
                // 指定商品
                if (selectProductIds.length < 1) {
                    app.showError('请选择商品!');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                var selectProductIdStr = selectProductIds.join(',');
                if ($('#selectOldProductIds').val() != '') {
                    var oldProductIdArr = $('#selectOldProductIds').val().split(',');
                    var j = 0;
                    for (var i = 0; i < oldProductIdArr.length; i++) {
                        if (selectProductIdStr.indexOf(oldProductIdArr[i]) != -1) {
                            j++;
                        }
                    }
                }
                $('#selectProductIds').val(selectProductIds);
            }
            if (!goOn) {
                return false;
            }

            return true;
        });
        form.render();

        initUserCondition();
        initProductCondition();

        //重置按钮
        $('.actions-bar button[type="reset"]').click(function () {
            //如果是编辑操作,只重置启用状态
        <#if couponDTO??>
            $('.controls input[name="statusCd"][value="${(couponDTO.statusCd)!default(1)}"]').attr("checked", true);
            return;
        </#if>
            $('.controls input[name="statusCd"][value="1"]').attr("checked", true);
            $('.controls input[name="promotionTypeCd"][value="54"]').attr("checked", true);
        });
    });

    //全选或指定会员、商品 切换时列表隐藏或显示
    function initActivityRadioEvent() {
        $("input[name='activityProducts']").on('change', function () {
            var id = $(this).attr('id');
            if (id == "appointProduct") {
                $("#productInfo").show();
            <#if isAllProduct>
                $('#productGrid').empty();
                productColumn();
                buildProductGrid();
            </#if>

//                reloadProductCondition();
            } else {
                $("#productInfo").hide();
            }
        });
        $("input[name='activityUsers']").on('change', function () {
            var id = $(this).attr('id');
            if (id == "appointUser") {
                $("#userInfo").show();
            <#if isAllUser>
                $('#userGrid').empty();
                userColumn();
                buildUserGrid();
            </#if>
//                reloadUserCondition();
            } else {
                $("#userInfo").hide();
            }
        });
    }

    function showPromotionTypeCd(promotionTypeValue) {
        $('.promotionType').hide();
        $('span[data-promotionType="' + promotionTypeValue + '"]').show();
    }

    function productColumn() {
        productColumns = [
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
            {title: '类别名称', dataIndex: 'categoryName', width: 120},
            {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
            {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
            {title: '商品库存', dataIndex: 'defaultPrice', width: 120},
            {title: '更新时间', dataIndex: 'lastUpdateTime', width: 180, renderer: BUI.Grid.Format.datetimeRenderer},
            {
                title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
                var delStr = "";
                if(isAuditPass=="false"){
                    delStr = '<span class="grid-command btn-del">删除</span>';
                }
                return delStr;
            }
            }
        ];
    }

    function userColumn() {
        userColumns = [
            {title: '会员ID', dataIndex: 'userId', width: 80},
            {
                title: '会员标签', dataIndex: 'userLabels', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return app.grid.format.encodeHTML(value);
                } else {
                    return '';
                }
            }
            },
            {
                title: '用户名', dataIndex: 'loginName', width: 100, renderer: function (value, rowObj) {
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>' + app.grid.format.encodeHTML(value) + '</a>';
                return editStr;
            }
            },
            {
                title: '姓名', dataIndex: 'userName', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '手机', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '注册平台', dataIndex: 'registerPlatformText', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '会员等级', dataIndex: 'userLevelName', width: 70, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '状态', dataIndex: 'statusText', width: 60, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '注册时间', dataIndex: 'registerTime', width: 140, renderer: function (value, rowObj) {
                if (value != null) {
                    return BUI.Date.format(value, "yyyy-mm-dd HH:MM:ss");
                }
            }
            },
            {
                title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
                var delStr = "";
                if(isAuditPass=="false"){
                    delStr = '<span class="grid-command btn-delUser">删除</span>';
                }
                return delStr;
            }
            }
        ];
    }
</script>
</body>
</html>