<div class="container">
	<div class="row">
	    <div class="span5">
	        <div class="panel panel-head-borded panel-small">
	            <div class="panel-header">类别列表</div>
	            <div id="categoryTree"></div>
	        </div>
	    </div>
	</div>
</div>

<script type="text/javascript">
	var categoryJson = ${categoryJson!};
    var categoryTree;
    BUI.use(['bui/tree','bui/grid','bui/data'],function (Tree,Grid,Data) {
         categoryTree = new Tree.TreeList({
            render : '#categoryTree',
            idField : 'id',
            nodes : categoryJson,
            showLine : true, //显示连接线
            checkType: 'custom', //checkType:勾选模式，提供了4中，all,onlyLeaf,none,custom
            cascadeCheckd : false, //不级联勾选
            multipleSelect : true,
            showRoot : true,
            height : 270,
            root : {
                id : '0',
                text : '全部',
                expanded : true
            }
        });
        categoryTree.render();
        
        <#--绑定单个事件-->
	    categoryTree.on('itemclick',function(ev){
	        checkChangeEvent(ev.item);
	    });
	    
	    initCheckStatus();
	    
	    function isAllItemChecked(){
            var isAllItemChecked = true;
            var rootNode = categoryTree.get('root');
            BUI.each(rootNode.children,function(subNode,index){
                isAllItemChecked = categoryTree.isChecked(subNode);
                if(!isAllItemChecked){
                    return false;
                }
                if(!subNode.leaf){
                    isAllItemChecked = isAllChildrenChecked(subNode, true);
                }
                if(!isAllItemChecked){
                    return false;
                }
            });
            return isAllItemChecked;
        }
            
	    function checkChangeEvent(targetItem){
            var isRootNode = categoryTree._isRoot(targetItem);
            if(isRootNode){
                if(categoryTree.isChecked(targetItem)){ //选中
                    setNodeAndChildrenChecked(targetItem, true);
                } else { //非选中
                    categoryTree.clearAllChecked();
                }
            } else {
                var rootNode = categoryTree.get('root');
                var tmp = isAllItemChecked();
                categoryTree.setNodeChecked(rootNode, tmp);
            }
        }
        
        function initCheckStatus(){
            <#if !(categoryIds?? && categoryIds?has_content)>
                var rootNode = categoryTree.get('root');
                setNodeAndChildrenChecked(rootNode, true);
            </#if>
        }
        
        function isAllChildrenChecked(node, containSelf){
            var tempChecked = true;
            if(node.leaf){//有叶子节点
                return categoryTree.isChecked(node);
            } else {
                if(containSelf){
                    tempChecked = categoryTree.isChecked(node);
                }
                if(tempChecked){
                    BUI.each(node.children,function(subNode,index){
                        tempChecked = isAllChildrenChecked(subNode, containSelf);
                        if(!tempChecked){
                            return false;
                        }
                    });
                }
            }
            return tempChecked;
        }
        
        <#--根据选中的节点，处理-->
        function setNodeAndChildrenChecked(node, checked){
            if(node.leaf){//有叶子节点
                categoryTree.setNodeChecked(node, "checked", checked);
            } else {
                categoryTree.setNodeChecked(node, "checked", checked);
                BUI.each(node.children,function(subNode,index){
                    setNodeAndChildrenChecked(subNode, checked);
                    categoryTree.setNodeChecked(subNode, "checked", checked);
                });
            }
        }
        
    });
    
    <#--提供获取树结构的选中值-->
    function getCheckedCategoryIds(){
        var selectedNodes = categoryTree.getCheckedNodes();
        var selectedCategoryIds = [];
        if(selectedNodes && selectedNodes.length){
            for(var i = 0; i < selectedNodes.length; i++){
                selectedCategoryIds[i] = selectedNodes[i].id;
            }
        }
        return selectedCategoryIds;
    }
    
</script>