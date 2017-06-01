
<#--
    加载显示 storeList
    并以树型展示

    targetRightFrame:点击节点响应的 iframe
    storeType: 门店、分销商、全部 StoreType.ALL.getType()
    chainStores：加盟店、直营店  OrderType.DIRECT_MANAGE_STORE.getType()
    targetUrl:点击节点后响应的地址
    allIsNull: 根节点的是否使用门店为1的总店
    rootName:根节点名称
    tabIndex:标识树的后缀,可不传,默认是空
-->
<#macro storeTree targetRightFrame storeType="" chainStores="" targetUrl=""  allIsNull=false  rootName="" tabIndex="">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="${ctx!}/static/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.css" >
        <script type="text/javascript" src="${ctx!}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
        <script type="text/javascript" src="${ctx!}/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
        <script type="text/javascript" src="${ctx!}/static/js/storeTree.js"></script>
        <script>
            function resetHeight(){
                var h = $(window).height() - ($('.title-bar').outerHeight() || 0);
                $('.side-menu').height(h - 2);
                $('.side-menu-wrap').height(h -2 - 2);
                $('.main-content').height(h);
            }
            resetHeight();
            $(window).on('resize',resetHeight);

            $(function() {
                var  tree = new $.fn.Tree({
                    renderTo : 'storeTree_${tabIndex!}',
                    id : 'storeTreeId',
                    callback: {
                        onClick: function (e,treeId, treeNode) {
                            if(!treeNode.isParent || treeNode.id == 0){
                                var storeId=treeNode.id;
                                if(treeNode.id == 0) {
                                    storeId = '1'; /* 为了跟会员列表查询那统一，使用1 */
                                }
                                var url= "${ctx!}${targetUrl!}&storeId="+storeId;
                                <#if allIsNull?? && allIsNull>
                                    if( treeNode.id == 0) {
                                        url= "${ctx!}${targetUrl!}";/* 点击全部，不加入门店id进行查询 */
                                    }
                                </#if>
                                var rightFrame = document.getElementById('${targetRightFrame!}');
                                rightFrame.src=url;
                            }
                            // 单击节点展开
                            tree.zTree.expandNode(treeNode, null, null, null, true);
                        }
                    },
                    view: {
                        showLine: false,
                        showIcon: false,
                        selectedMulti: false,
                        dblClickExpand: false,
                        addDiyDom: function(treeId, treeNode) {
                            var spaceWidth = 5;
                            var switchObj = $("#" + treeNode.tId + "_switch");
                            var icoObj = $("#" + treeNode.tId + "_ico");
                            switchObj.remove();
                            icoObj.before(switchObj);
                            var param = $.trim($("input[name='param']").val());
                            if (treeNode.level > 1 || (param != null && param!='')) {
                                var spaceStr = "<span style='display: inline-block;width:" + (spaceWidth * treeNode.level)+ "px'></span>";
                                switchObj.before(spaceStr);
                            }
                        }
                    },
                    data: {
                        simpleData: {
                            enable: true
                        }
                    },
                    async: {
                        enable: true,
                        type:"get",
                        url:"${ctx}/admin/sa/storeTree/findStoreTree?storeType=${storeType!}&chainStore=${chainStore!}&rootName=${rootName!}&storeStatus=${storeStatus!}",
                        autoParam:["id", "level"]
                    }
                });
                $('#searchWord_${tabIndex!}').bind('keyup', function(event) {
                    if (event.keyCode == "13") {
                        //回车执行查询
                        $('#searchBtn_${tabIndex!}').click();
                    }
                });
                $('#searchBtn_${tabIndex!}').on('click', function() {
                    var param = $.trim($('#searchWord_${tabIndex!}').val());
                    console.info(param);
                    var storeType='${storeType!}';
                    var otherParam= ["storeName", param, "level",1,"storeType",storeType];
                    if(param == null || param =='') {
                        otherParam = null;
                    }
                    tree.search(otherParam);
                });

            });
        </script>
    </head>
    <body>
        <div class="side-menu-search">
            <input id="searchWord_${tabIndex!}" type="text"/><button id="searchBtn_${tabIndex!}">搜索</button>
        </div>
        <div class="side-menu-wrap-tree-store tree-store" >
            <ul id="storeTree_${tabIndex!}" class="ztree"></ul>
        </div>
    </body>

</#macro>



