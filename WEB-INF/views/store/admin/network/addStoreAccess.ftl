<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
	<script type="text/javascript" src="${ctx}/static/js/lib/jquery.raty.min.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/userStore/toStoreAccess?storeId=${(store.storeId)!}" >门店评价管理</a > <span class="divider">&gt;&gt;</span></li>
        <li class="active">评价</li>
    </ul>
   <form id="J_Form" class="form-horizontal" action="${ctx}/admin/network/userStore/addStoreReviewForm" method="post">
                <input type="hidden" name="storeId" value=${store.storeId!}>
                <input type="hidden" name="flag" value="1">
                <input type="hidden" name="reviewDetailId" value="${(reviewDetail.id)!}">

                <div id="edit-div" class="well">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>会员手机号：</label>
                            <div class="controls">
                                <input  name="reviewerPhone" 
                                 data-rules="{required:true,regexp:/^1[3|4|5|7|8]\d{9}$/}" 
                                 data-messages="{regexp:'不是有效的手机'}"
                                class="input-normal control-text bui-form-field">
                            </div>
                     	</div>
                 	</div>
                 	
                 	<div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>会员名称：</label>
                            <div class="controls">
                                <input  name="reviewName"  data-rules="{required:true}" class="input-normal control-text bui-form-field">
                            </div>
                     	</div>
                 	</div>
                 	
                 	<div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>卖家的服务态度：</label>
                            <div class="controls">
                                <div class="reviewOpts_Dimension1" name="" itemId="${store.storeId!}"></div>
                            	<input type="hidden" name="saleServiceAttrScore" id="saleServiceAttrScore" value="5">
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>卖家的发货速度：</label>
                            <div class="controls">
                                <div class="reviewOpts_Dimension2" name="saleShipSpeedScore" itemId="${store.storeId!}"></div>
                            	<input type="hidden" name="saleShipSpeedScore" id="saleShipSpeedScore" value="5">
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>评价时间：</label>
                            <div class="controls">
                                <input type="text" class="calendar control-text input-datelarge" id="reviewDate" data-rules="{required:true}" name="reviewDate" value="">
                            </div>
                        </div>
                    </div>
                  </div>  
            
        		<div class="row form-actions actions-bar">
	            <div class="span13">
	                <button type="submit" class="button button-primary">保存</button>
	                <button type="reset" class="button">重置</button>
	            </div>
       		 	</div>
    </form>
</div>
</body>
<script>
    BUI.use('bui/calendar',function(Calendar){
        var datepicker = new Calendar.DatePicker({
            trigger:'.calendar',
            //delegateTrigger : true, //如果设置此参数，那么新增加的.calendar元素也会支持日历选择
            autoRender : true,
            align :{
                node: 'trigger',     // 参考元素, falsy 或 window 为可视区域, 'trigger' 为触发元素, 其他为指定元素
                points: ['tl','tl'], // ['tr', 'tl'] 表示 overlay 的 tl 与参考节点的 tr 对齐
                offset: [0, 30]    // 有效值为 [n, m]
            }
        });
    });

    $(function(){
    
        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!")
                    app.page.open({
                        href:"${ctx}/admin/network/userStore/toStoreAccess?storeId=${(store.storeId)!}",
                        isClose: true,
                        reload: true
                    })
                }
            }
        });
    
         $.fn.raty.defaults.path = '${ctx}/static/images';

        var starDimension1=5;
        $('.reviewOpts_Dimension1').raty({
            score: starDimension1,
            hints: ['一星', '二星', '三星', '四星', '五星'],
            width : 120,
            click: function(score, evt) {
                $('#saleServiceAttrScore').attr('value',score);
            }
        });

        var starDimension2=5;
        $('.reviewOpts_Dimension2').raty({
            score: starDimension2,
            hints: ['一星', '二星', '三星', '四星', '五星'],
            width : 120,
            click: function(score, evt) {
                $("#saleShipSpeedScore").attr('value',score);
            }
        });
        
        form.render();
    })
</script>
</body>
</html>  