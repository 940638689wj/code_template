<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>

</head>
<body>

<div class="container">
    <ul class="breadcrumb">
        <li class="active">素材管理</li>
    </ul>
    <div class="tips tips-large tips-notice tips-no-icon">
        <div class="tips-content">
            <p>提醒：在微信后台编辑模式下录入的素材，不能复用到第三方的商城后台，请在此页面进行录入。 </p>
        </div>
    </div>
    <br>
    <#--<div class="toolbar">
        <div class="pull-right">
            <input type="text" placeholder="输入关键字"/>
            <button class="button">查询</button>
        </div>
    </div>-->
    <div class="bui-clear"></div>
    <div class="panel">
        <div class="panel-body">
            <h4>图文列表(<#if page??>${page.content?size}</#if>条)</h4>
            <div class="wx-sucai-manage" id="J_Layout">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/bui-min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/config-min.js"></script>
<script type="text/javascript">
    BUI.use(['bui/layout'],function (Layout) {
        /**
         * 列布局中，默认状态下，一项一项的逐次放到一个列中，
         * 但是也可以通过 col : 2，这类的写法指定到某一列中
         */

        var layout = new Layout.Columns({
                    columns : '2'
                }),
                control = new BUI.Component.Controller({
                    width:'780',
                    render : '#J_Layout',
                    defaultChildCfg : {
                        xclass : 'controller',
                        tplRender : function(data){
                            if(data.type == 'menu'){


                                return  '<div class="post-sucai-box">' +
                                            '<a class="sucaibtn-single" href="${ctx}/admin/sa/wechat/mediaForm?isMul=0">+单图文消息</a> ' +
                                            '<a class="sucaibtn-multi" href="${ctx}/admin/sa/wechat/mediaForm?isMul=1">+多图文消息</a></div>'
                            }else{
                                var deleteStr="";
<@securityAuthorize ifAnyGranted="delete">
                                        deleteStr='<a class="sucaibtn-del" href="javascript:void(0);" onclick="deleteNews('+data.newsId+');">删除</a>';</@securityAuthorize>
                                return '<div class="sucai-box">' +
                                        '<div class="sucai-title">'+data.title+'</div>' +
                                        '<div class="sucai-time">'+data.time+'</div>' +
                                        '<div class="sucai-pic"><img src="'+data.pic+'" alt=""/></div>' +
                                        '<div class="sucai-toolbar">' +
                                        '<ul>' +
                                            '<li>' +
                                        '<a class="sucaibtn-edit" href="mediaForm?isMul='+data.isMul+'&id='+data.newsId+'" >编辑</a></li>' +
                                            '<li>'+deleteStr+'</li></ul></div></div>'
                            }
                        }
                    },
                    children : [
                        {
                            type : 'menu'
                        },
                        <#if page??>
                            <#assign initMsgList=page.content/>
                            <#list initMsgList as initMsg>
                                <#if !initMsg.isInit>
                                    <#assign artList = articleMap[(initMsg.id)?string]/>

                                    <#if artList?? && artList?has_content && artList?size == 1>
                                        <#--单图文-->
                                        <#assign art=artList?first/>
                                        {
                                            newsId:'${(initMsg.id)!}',
                                            title : '${(art.articleTitle)!?html}',
                                            time : '${(initMsg.createTime?string('yyyy-MM-dd'))!}',
                                            pic : '${(art.picUrl)!?html}',
                                            isMul:'0'
                                        },
                                    <#elseif artList?has_content && artList?size gt 1>
                                        <#assign art=artList?first/>
                                        {
                                            newsId:'${(initMsg.id)!}',
                                            title : '${(art.articleTitle)!?html}',
                                            time : '${(initMsg.createTime?string('yyyy-MM-dd'))!}',
                                            pic : '${(art.picUrl)!?html}',
                                            isMul:'1'
                                        },
                                    </#if>
                                </#if>
                            </#list>
                        </#if>
                    ],
                    plugins : [layout]
                });

        control.render();
    });


    var app = {};
    app.alert = function (msg, icon, options) {
        if (!msg) return false;

        var m;
        if ($.type(msg) == 'string') {
            m = msg;
        } else if ($.isArray(msg)) {
            m = '';
            for (var i = 0; i < msg.length; i++) {
                m += '<p>' + msg[i] + '</p>';
            }
        }

        var setting = $.extend({}, options);
        if (setting.callback) BUI.Message.Alert(m, setting.callback, icon);
        else BUI.Message.Alert(m, icon);

        return false;
    }
    app.showError = function (msg, options) {
        if (top.showError) {
            top.showError(msg);
        } else {
            app.alert(msg, 'error', options);
        }
    };
    app.showSuccess = function (msg, options) {
        if (top.showSuccess) {
            top.showSuccess(msg);
        } else {
            app.alert(msg, 'success', options);
        }
    };
    //删除一条图文
    function deleteNews(value){
		var r=confirm("确认要删除本图文吗?");
		if(r==true){
            $.ajax({
                url: "${ctx}/admin/sa/wechat/mediaNewsDelete?id="+value,
                type:"get",
                dataType: "text",
                success: function(data){
                    if(data=="success"){
                        app.showSuccess("删除成功!");
                        window.location.href = "${ctx}/admin/sa/wechat/showMedia";
                    }else{
                        app.showError("删除失败!");
                    }
                }
            });
		}else{
            return false;
		}
    }
</script>
<body>
</html>  