<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" onclick="couponList();" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">优惠券列表</span>
                </li>
                <li class="bui-tab-item" aria-disabled="false" onclick="couponUsedDetailList();" aria-pressed="false">
                    <span class="bui-tab-item-text">优惠券使用明细</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="content-body">
        <form id="searchForm" class="form-horizontal search-form">
            <input name="statusCd" value="1" type="hidden"/>
            <input name="isEnableTime" value="1" type="hidden"/>
        </form>
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var basicFormDialog = null;
    var search = null;

    var Overlay = BUI.Overlay


    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'link-tabs',
        autoRender: true,
        children: [
            {text: '有效', value: '1', href: 'javascript:void(0)'},
            {text: '过期', value: '2', href: 'javascript:void(0)'},
            {text: '禁用', value: '3', href: 'javascript:void(0)'}
        ],
        itemTpl: '<a href="{href}">{text}</a>'
    });
    //默认选择lab的第一个选项
    tab.setSelected(tab.getItemAt(0));
    //点击lab中对应项的操作
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="1"){
            $("input[name='statusCd']").val('1');
            $("input[name='isEnableTime']").val('1');
        }else if(item.get('value')=="2"){
            $("input[name='statusCd']").val('1');
            $("input[name='isEnableTime']").val('2');
        }else if(item.get('value')=="3"){
            $("input[name='statusCd']").val('0');
            $("input[name='isEnableTime']").val('');
        }
        //重新加载数据
        search.load({pageIndex:1});
    });

    function couponList(){
        window.location.href="${ctx}/admin/sa/promotion/coupon/list";
    }
    function couponUsedDetailList(){
        window.location.href="${ctx}/admin/sa/promotion/coupon/useDetail/list";
    }

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'编号',dataIndex:'promotionId',width:70, renderer : function(value, rowObj){
                var str = "";
                str = "<a href='${ctx}/admin/sa/promotion/coupon/form?promotionId="+value+"'>"+value+"</a>";
                return str;
            }},
            {title:'名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                var str = "";
                str = "<a href='${ctx}/admin/sa/promotion/coupon/form?promotionId="+rowObj.promotionId+"'>"+value+"</a>";
                return str;
            }},
            {title:'描述',dataIndex:'promotionDesc',width:200,renderer : function(value, rowObj){
                var str = "";
                str = "<span title="+ value.replace(/\s+/g,"") +">"+value+"</span>";
                return str;
            }},
            {title:'数量',dataIndex:'couponTotalNum',width:120},
            {title:'领取数量',dataIndex:'doleCount',width:120,renderer : function(value, rowObj){
            		/* 2016.8.31 By caobr 如果设置了预生成优惠码的优惠券领取数量=已使用数量;*/
	                if(rowObj.isPreGenerate == 1){
	                    return rowObj.useCount;
	                }else{
	                    return value;
	                }
	            }
            },
            {title:'已使用数量',dataIndex:'useCount',width:120},
            {title:'使用起始时间',dataIndex:'enableStartTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'使用结束时间',dataIndex:'enableEndTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            //{title:'领取地址',dataIndex:'promotionId',width:150},
            {title:'状态',dataIndex:'statusCd',width:70, renderer : function(value, rowObj){
                if(value == "0"){
                    return "禁用";
                }else{
                    return "启用";
                }
            }},
            {title:'操作',dataIndex:'promotionId',width:150, renderer : function(value, rowObj){
                var str = "";
                str = str + "<a href='${ctx}/admin/sa/promotion/coupon/form?promotionId="+rowObj.promotionId+"'>编辑</a>&nbsp;&nbsp;";

                if(rowObj.isPreGenerate == 1){
                	str = str + "<a href='javascript:getCouponDetail(\""+rowObj.promotionId+"\");'>查看</a>&nbsp;&nbsp;";
                }else{
                	str = str + "<a href='javascript:sentOut(\""+rowObj.promotionId+"\");'>发放</a>&nbsp;&nbsp;";
                }

                return str;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/coupon/grid_json');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新增优惠券',btnCls : 'button button-small button-primary',handler:addNew}
                ]
            }
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });

    $(function(){
        //点击 右上角搜索框
        var mask;
        $('.title-bar-side .search-bar input').on('focus',function(){
            var $this = $(this);
            $this.addClass("focused");
            if(!mask)
                mask = $('<div></div>').css({
                    'position':'absolute',
                    'left':0,
                    'top':0,
                    'width':'100%',
                    'height':'100%'
                }).appendTo(document.body);
            mask.on('click',function(){
                $this.removeClass("focused");
                mask.remove();
                mask = null;
            });
        });
    })


    function addNew(){
        window.location.href = "${ctx}/admin/sa/promotion/coupon/form";
    }

    function editRecord(orgId, orgNum, orgFullName, contactName, contactPhone){
        $('#orgId').val(orgId);
        $('#orgNum').val(orgNum);
        $('#orgFullName').val(orgFullName);
        $('#contactName').val(contactName);
        $('#contactPhone').val(contactPhone);
        basicFormDialog.show();
    }

    function sentOut(promotionId){
        BUI.Message.Confirm('确认要发放么？',function(){
            $.ajax({
                url: "${ctx}/admin/sa/promotion/coupon/sentOutCoupon",
                type:"post",
                dataType: "json",
                data:{promotionId:promotionId},
                success: function(data){
                    if(data.result=="success"){
                        app.showSuccess(data.message);
                        search.load();
                    }else{
                        app.showError(data.message);
                    }
                }
            });
        },'question');
    }



    var dialog = null;
    BUI.use('bui/overlay',function(Overlay){
			dialog = new Overlay.Dialog({
			title:'优惠劵信息',
			width:500,
			height:480,
			buttons:[],
// 			closeAction : 'destroy', //每次关闭dialog释放
			loader : {
				url : '${ctx}/admin/sa/promotion/coupon/preCouponDialog',
				autoLoad : false, //不自动加载
	              lazyLoad : false, //不延迟加载
			},
		})
	})
	function getCouponDetail(promotionId) {
    	dialog.get('loader').load({promotionId:promotionId});
    	dialog.show();
	}
</script>
</body>
</html>