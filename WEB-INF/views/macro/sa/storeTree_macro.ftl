
<#--
    加载显示 storeList
    并以树型展示

    topAgentStoreList：需要以节点展示的数据
    targetUrl:点击节点后响应的地址
    target:点击节点响应的 iframe
    showRoot:是否显示自定义根节点,默认 不显示
    rootId: 根节点的 id
    rootName:根节点名称
    fxLink:分销商 的连接 是否可以点击,默认可以点击
    suffix:标识树的后缀,可不传,默认是空
    disabledAgent:分销商是否有点击样式
-->
<#macro storeTree topAgentStoreList targetUrl target="rightFrame" showRoot="0" disabledAgent="0" rootName="全部" rootId=1 fxLink="1" suffix="">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html>
    <head>
        <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
        <script type="text/javascript">
                <#if disabledAgent=="1">
                window.onload=setLink;
                </#if>
            function setLink(){
                for(var i=0;i<=200;i++){
                    if($("#storeTree__"+i+"_a") && typeof($("#storeTree__"+i+"_a").attr("href"))=="undefined"){
                        $("#storeTree__"+i+"_a").css("text-decoration","none");
                        $("#storeTree__"+i+"_a").css("cursor","default");
                        $("#storeTree__"+i+"_a").addClass("level2");
                        if($("#storeTree__"+i+"_ico")){
                            $("#storeTree__"+i+"_ico").css("cursor","default");
                        }
                    }
                }

            }
        </script>
        <SCRIPT type="text/javascript">
            <!--
            var key, lastValue = "", nodeList = [];
            var treeObj;
            var allNodes;

            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                view :{
                    fontCss: getFontCss
                }    ,
                view: {
                    showIcon: false
                },
                callback: {
                    onClick: zTreeOnClick
                }
            };
            <#assign containerParams=false />
            <#if targetUrl?has_content && targetUrl?index_of("?")!=-1>
                <#assign containerParams=true />
            </#if>

            <#assign hasNode=false />
            var zNodes =[
                <#if showRoot=="1">
                    {
                        id:${rootId}
                        ,pId:0
                        ,name:"${rootName}"
                        ,target:"${target}"
                        <#if containerParams>
                            ,url:"${targetUrl!}&storeId=${rootId}"
                        <#else>
                            ,url:"${targetUrl!}?storeId=${rootId}"
                        </#if>
                        ,open:true
                    },

                    <#assign hasNode=true />
                </#if>

                <#if topAgentStoreList?? && topAgentStoreList?has_content && topAgentStoreList?is_sequence>
                    <#assign count=0 />
                    <#list topAgentStoreList as store>
                        {
                            id:${(store.storeId)!}
                            ,pId:<#if (store.defaultParentStore)?? && (store.defaultParentStore.storeId)??>${store.defaultParentStore.storeId}<#else>0</#if>
                            ,name:"${(store.storeName)!?html}"

                            <#if fxLink=="1">
                                ,target:"${target}"
                                <#if containerParams>
                                    ,url:"${targetUrl!}&storeId=${(store.storeId)!}"
                                <#else>
                                    ,url:"${targetUrl!}?storeId=${(store.storeId)!}"
                                </#if>
                            <#else>
                                <#if store.storeType??&&(store.storeType.type)=="AGENT">

                                <#else>
                                    ,target:"${target}"
                                    <#if containerParams>
                                        ,url:"${targetUrl!}&storeId=${(store.storeId)!}"
                                    <#else>
                                        ,url:"${targetUrl!}?storeId=${(store.storeId)!}"
                                    </#if>
                                </#if>
                            </#if>

                            ,open:true
                        }
                        <#if (count+1) != topAgentStoreList?size>
                            ,
                        </#if>
                        <#assign count=count+1/>
                    </#list>

                    <#assign hasNode=true />
                </#if>
            ];

            $(document).ready(function(){
                treeObj=$.fn.zTree.init($("#storeTree_${suffix!}"), setting, zNodes);
                allNodes = treeObj.transformToArray(treeObj.getNodes());

                key = $("#searchWord_${suffix!}");
                key.bind("change keydown cut input propertychange", searchNode);

//                var searchButton=$("#searchButton");
//                searchButton.bind("click", searchNode);
            });

            function getFontCss(treeId, treeNode) {
                return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
            }

            function zTreeOnClick(event, treeId, treeNode) {
                <#if disabledAgent=="1">
                    if($("#"+treeNode.tId+"_a") && typeof($("#" + treeNode.tId+"_a").attr("href"))=="undefined")
                        $("#"+treeNode.tId+"_a").attr("class","level1");
                </#if>
            };

            function searchNode(e) {
                // 取得输入的关键字的值
                var value = $.trim(key.get(0).value);

                // 按名字查询
                var keyType = "name";
                if (key.hasClass("empty")) {
                    value = "";
                }

                // 如果和上次一次，就退出不查了。
                if (lastValue === value) {
                    return;
                }

                // 保存最后一次
                lastValue = value;

                // 如果要查空字串，就退出不查了。
                if (value === "") {
                    var nodes = treeObj.getNodesByParam("isHidden", true);
                    treeObj.showNodes(nodes);
                    return;
                }

                updateNodes(false);
                nodeList = treeObj.getNodesByParamFuzzy(keyType, value);
                updateNodes(true);
            }
            function updateNodes(highlight) {
                <#--
                for(var i=0, l=nodeList.length; i<l; i++) {
                    nodeList[i].highlight = highlight;
                    treeObj.updateNode(nodeList[i]);
                    treeObj.expandNode(nodeList[i].getParentNode(), true, false, false);
                }
                -->
                if(highlight)
                {
                    //treeObj.showNodes(nodeList);
                    if (nodeList.length > 0)
                    {
                       for(var i=0;i<nodeList.length;i++){
                            showNodeWithParent(nodeList[i]);
                        }
                    }
                }else
                {
                    if (allNodes.length > 0)
                    {
                        for(var i=0;i<allNodes.length;i++){
                            hideNodeExcludeRoot(allNodes[i]);
                        }
                    }
                    //treeObj.hideNodes(allNodes);
                }
            }

            function showNodeWithParent(node){
                if(node.getParentNode()){
                    treeObj.showNode(node);

                    showNodeWithParent(node.getParentNode());
                }
            }

            function hideNodeExcludeRoot(node){
                if(node.getParentNode()){
                    treeObj.hideNode(node);
                }
            }

            function showNodeExcludeRoot(node){
                if(node.getParentNode()){
                    treeObj.showNode(node);
                }
            }

            function showIconForTree(treeId, treeNode) {
                return !treeNode.isParent;
            };
            $.fn.zTree.init($("#tree"), setting, zNodes);
            function resetHeight(){
                var h = $(window).height() - ($('.title-bar').outerHeight() || 0);
                $('.side-menu').height(h - 2);
                $('.side-menu-wrap').height(h -2 - $('.side-menu-search')[0].offsetHeight);
                $('.main-content').height(h);
            }
            resetHeight();
            $(window).on('resize',resetHeight);
            //-->
        </SCRIPT>
    </head>
    <body>
        <div class="side-menu-search">
            <input id="searchWord_${suffix!}" type="text"/><button>搜索</button>
        </div>
        <div class="side-menu-wrap">
            <#if hasNode>
                <ul id="storeTree_${suffix!}" class="ztree"></ul>
            <#else>
                <div>没有任何数据!</div>
            </#if>
        </div>
    </body>

</#macro>


<#--
    加载显示 storeDTOList
    并以树型展示

    storeDTOList：需要以节点展示的数据
    targetUrl:点击节点后响应的地址
    target:点击节点响应的 iframe
    showRoot:是否显示自定义根节点,默认 不显示
    rootId: 根节点的 id
    rootName:根节点名称
    fxLink:分销商 的连接 是否可以点击,默认可以点击
    suffix:标识树的后缀,可不传,默认是空
    disabledAgent:分销商是否有点击样式
-->
<#macro storeDTOTree storeDTOList targetUrl target="rightFrame" showRoot="0" disabledAgent="0" rootName="全部" rootId=1 fxLink="1" suffix="">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html>
    <head>
        <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
        <script type="text/javascript">
            <#if disabledAgent=="1">
                window.onload=setLink;
            </#if>
            function setLink(){
                for(var i=0;i<=200;i++){
                    if($("#storeTree__"+i+"_a") && typeof($("#storeTree__"+i+"_a").attr("href"))=="undefined"){
                        $("#storeTree__"+i+"_a").css("text-decoration","none");
                        $("#storeTree__"+i+"_a").css("cursor","default");
                        $("#storeTree__"+i+"_a").addClass("level2");
                        if($("#storeTree__"+i+"_ico")){
                            $("#storeTree__"+i+"_ico").css("cursor","default");
                        }
                    }
                }
            }
        </script>
        <SCRIPT type="text/javascript">
            <!--
            var key, lastValue = "", nodeList = [];
            var treeObj;
            var allNodes;

            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                view :{
                    fontCss: getFontCss
                }    ,
                view: {
                    showIcon: false
                },
                callback: {
                    onClick: zTreeOnClick
                }
            };
            <#assign containerParams=false />
            <#if targetUrl?has_content && targetUrl?index_of("?")!=-1>
                <#assign containerParams=true />
            </#if>

            <#assign hasNode=false />
            var zNodes =[
                <#if showRoot=="1">
                    {
                        id:${rootId}
                        ,pId:0
                        ,name:"${rootName}"
                        ,target:"${target}"
                        <#if containerParams>
                            ,url:"${targetUrl!}&storeId=${rootId}"
                        <#else>
                            ,url:"${targetUrl!}?storeId=${rootId}"
                        </#if>
                        ,open:true
                    },

                    <#assign hasNode=true />
                </#if>

                <#if storeDTOList?? && storeDTOList?has_content && storeDTOList?is_sequence>
                    <#assign count=0 />
                    <#list storeDTOList as storeDTO>
                        {
                            id:${(storeDTO.storeId)!}
                            ,pId:${storeDTO.defaultParentId?default(0)}
                            ,name:"${(storeDTO.storeName)!?html}"

                            <#if fxLink=="1">
                                ,target:"${target}"
                                <#if containerParams>
                                    ,url:"${targetUrl!}&storeId=${(storeDTO.storeId)!}"
                                <#else>
                                    ,url:"${targetUrl!}?storeId=${(storeDTO.storeId)!}"
                                </#if>
                            <#else>
                                <#if storeDTO.storeType?? && storeDTO.storeType=="AGENT">

                                <#else>
                                    ,target:"${target}"
                                    <#if containerParams>
                                        ,url:"${targetUrl!}&storeId=${(storeDTO.storeId)!}"
                                    <#else>
                                        ,url:"${targetUrl!}?storeId=${(storeDTO.storeId)!}"
                                    </#if>
                                </#if>
                            </#if>

                            ,open:true
                        }
                        <#if (count+1) != storeDTOList?size>
                            ,
                        </#if>
                        <#assign count=count+1/>
                    </#list>

                    <#assign hasNode=true />
                </#if>
            ];

            $(document).ready(function(){
                treeObj=$.fn.zTree.init($("#storeTree_${suffix!}"), setting, zNodes);
                allNodes = treeObj.transformToArray(treeObj.getNodes());

                key = $("#searchWord_${suffix!}");
                key.bind("change keydown cut input propertychange", searchNode);

//                var searchButton=$("#searchButton");
//                searchButton.bind("click", searchNode);
            });

            function getFontCss(treeId, treeNode) {
                return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
            }

            function zTreeOnClick(event, treeId, treeNode) {
                <#if disabledAgent=="1">
                    if($("#"+treeNode.tId+"_a") && typeof($("#" + treeNode.tId+"_a").attr("href"))=="undefined")
                        $("#"+treeNode.tId+"_a").attr("class","level1");
                </#if>
            };

            function searchNode(e) {
                // 取得输入的关键字的值
                var value = $.trim(key.get(0).value);

                // 按名字查询
                var keyType = "name";
                if (key.hasClass("empty")) {
                    value = "";
                }

                // 如果和上次一次，就退出不查了。
                if (lastValue === value) {
                    return;
                }

                // 保存最后一次
                lastValue = value;

                // 如果要查空字串，就退出不查了。
                if (value === "") {
                    var nodes = treeObj.getNodesByParam("isHidden", true);
                    treeObj.showNodes(nodes);
                    return;
                }

                updateNodes(false);
                nodeList = treeObj.getNodesByParamFuzzy(keyType, value);
                updateNodes(true);
            }
            function updateNodes(highlight) {
                <#--
                for(var i=0, l=nodeList.length; i<l; i++) {
                    nodeList[i].highlight = highlight;
                    treeObj.updateNode(nodeList[i]);
                    treeObj.expandNode(nodeList[i].getParentNode(), true, false, false);
                }
                -->
                if(highlight)
                {
                    //treeObj.showNodes(nodeList);
                    if (nodeList.length > 0)
                    {
                       for(var i=0;i<nodeList.length;i++){
                            showNodeWithParent(nodeList[i]);
                        }
                    }
                }else
                {
                    if (allNodes.length > 0)
                    {
                        for(var i=0;i<allNodes.length;i++){
                            hideNodeExcludeRoot(allNodes[i]);
                        }
                    }
                    //treeObj.hideNodes(allNodes);
                }
            }

            function showNodeWithParent(node){
                if(node.getParentNode()){
                    treeObj.showNode(node);

                    showNodeWithParent(node.getParentNode());
                }
            }

            function hideNodeExcludeRoot(node){
                if(node.getParentNode()){
                    treeObj.hideNode(node);
                }
            }

            function showNodeExcludeRoot(node){
                if(node.getParentNode()){
                    treeObj.showNode(node);
                }
            }

            function showIconForTree(treeId, treeNode) {
                return !treeNode.isParent;
            };
            $.fn.zTree.init($("#tree"), setting, zNodes);
            function resetHeight(){
                var h = $(window).height() - ($('.title-bar').outerHeight() || 0);
                $('.side-menu').height(h - 2);
                $('.side-menu-wrap').height(h -2 - $('.side-menu-search')[0].offsetHeight);
                $('.main-content').height(h);
            }
            resetHeight();
            $(window).on('resize',resetHeight);
            //-->
        </SCRIPT>
    </head>
    <body>
        <div class="side-menu-search">
            <input id="searchWord_${suffix!}" type="text"/><button>搜索</button>
        </div>
        <div class="side-menu-wrap">
            <#if hasNode>
                <ul id="storeTree_${suffix!}" class="ztree"></ul>
            <#else>
                <div>没有任何数据!</div>
            </#if>
        </div>
    </body>

</#macro>