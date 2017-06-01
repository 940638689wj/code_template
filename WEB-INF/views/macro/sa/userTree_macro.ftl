<#macro userRebateLevelTree availableRebateLevel targetUrl target="_self">
	<link href="${ctx}/static/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${ctx}/static/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
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
				showIcon: false,
				fontCss: getFontCss
			}
		};
			<#assign hasNode=false />
		var zNodes =[
			<#if availableRebateLevel?? && availableRebateLevel gt 0>
				{
					id:0
					,pId:-1
					,name:"全部"
					,target:"${target}"
					,url:"${targetUrl!}?rebateLevel=-1"
					,open:true
				}

				<#assign count=0 />
				<#list 1..availableRebateLevel as current>
					,{
					id:${current!}
					,pId:0
					,name:"${current!}级会员分销"
					,target:"${target}"
					,url:"${targetUrl!}?rebateLevel=${current!}"
					,open:true
				}
				</#list>

				<#assign hasNode=true />
			</#if>
		];

		$(document).ready(function(){
			treeObj=$.fn.zTree.init($("#zTree"), setting, zNodes);
			allNodes = treeObj.transformToArray(treeObj.getNodes());

			key = $("#searchWord");
			key.bind("change keydown cut input propertychange", searchNode);
		});

		function showIconForTree(treeId, treeNode) {
			return !treeNode.isParent;
		};

		function getFontCss(treeId, treeNode) {
			return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
		}

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

		//-->
	</SCRIPT>
	<div class="fmenu-search">
		<input id="searchWord" type="text"/>
	</div>
	<div class="fmenu-content" style="height: 510px;">
		<#if hasNode>
			<ul id="zTree" class="ztree"></ul>
		<#else>
			<div>没有任何数据!</div>
		</#if>
	</div>
</#macro>