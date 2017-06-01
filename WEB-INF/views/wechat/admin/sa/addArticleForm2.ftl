<!DOCTYPE HTML>
<html>
<head>
    <title>选择素材</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <#assign ctx = request.contextPath>
    <#assign staticPath = ctx + "/static">

</head>
<body>

<div class="container">
    <div class="panel">
        <div class="panel-body">
            <h4>图文列表(<#if newsList??>${newsList?size}</#if>条)</h4>
            <div class="wx-sucai-manage" id="J_Layout"></div>
        </div>
    </div>

	<div style="height: 50px;"></div>
</div>
<script type="text/javascript" src="${staticPath}/admin/js/bui-min.js"></script>

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
							return '<div class="sucai-box" style="cursor: pointer;">' +
									'<div class="sucai-title">'+data.title+'</div>' +
									'<div class="sucai-time">'+data.time+'</div>' +
									'<div class="sucai-pic"><img src="'+data.pic+'" alt=""/></div>' +
									'<div class="sucai-toolbar"></div>'+
									'<div class="sucai-box-mask"><i></i></div>' +
									'<input type="hidden" name="id" value="'+data.newsId+'">' +
									'</div>'
                        }
                    },
                    children : [
                        <#if newsList??>
                            <#assign initMsgList=newsList/>
                            <#list initMsgList as initMsg>
                                <#assign artList = articleMap[(initMsg.id)?string]/>
                                <#if artList?has_content && artList?size == 1>
                                    <#--单图文-->
									<#assign art=artList?first/>
                                    {
                                        newsId:'${(initMsg.id)!}',
                                        title : '${(art.articleTitle)!}',
                                        time : '${(initMsg.createTime?string('yyyy-MM-dd'))!}',
                                        pic : '${(art.picUrl)!}',
                                        isMul:'0'
                                    },
                                <#elseif artList?has_content && artList?size gt 1>
									<#assign art=artList?first/>
                                    {
                                        newsId:'${(initMsg.id)!}',
                                        title : '${(art.articleTitle)!}',
                                        time : '${(initMsg.createTime?string('yyyy-MM-dd'))!}',
                                        pic : '${(art.picUrl)!}',
                                        isMul:'1'
                                    },
                                </#if>
                            </#list>
                        </#if>
                    ],
                    plugins : [layout]
                });

        control.render();
    });

    var beforeSelectIndex=-1;//之前所选择的位置索引
    var beforeSelectContainer;//之前所选择的区域
    var beforeSelectMsgId=-1;//之前所选择的id
    $(function(){
        $('#J_Layout').on('click','.sucai-box',function(){
            if($(this).hasClass('sucai-box-selected'))
			{

			}else
			{//当前点击的区域未选择过

				if(beforeSelectIndex == -1)
				{//第一次点击
                    beforeSelectContainer=$(this);

                    beforeSelectIndex=$(".sucai-box").index($(this));

                    beforeSelectMsgId=$(this).find("input")[0].value;

                    $(this).toggleClass('sucai-box-selected');
				}else
				{
					//之前的 移除 打勾样式
                    beforeSelectContainer.removeClass("sucai-box-selected");

					//设置当前的
                    beforeSelectContainer=$(this);

                    beforeSelectIndex=$(".sucai-box").index($(this));

                    beforeSelectMsgId=$(this).find("input")[0].value;

                    $(this).toggleClass('sucai-box-selected');
				}
			}
        });
    });

	function getSelectedId(){
		if(beforeSelectIndex != -1)
		{
            return beforeSelectMsgId;
		}else{
			alert('请选择一条图文!');
		}
	}
</script>
<body>
</html>  