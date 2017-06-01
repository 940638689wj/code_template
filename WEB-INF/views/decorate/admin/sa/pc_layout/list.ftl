<#assign ctx = request.contextPath>
<#assign indexSpecArea = Static["cn.yr.chile.common.constant.DefinedModuleKeys"].INDEX_SPEC_AREA.key>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
</head>
<body>
    <script>
        function del(id){
            BUI.Message.Confirm('确认要删除该条目吗？',function(){
                $.ajax({
                    url: "${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/delete?id="+id,
                    type:"post",
                    dataType: "json",
                    success: function(data){
                        if(data.result=="success"){
                            window.location.reload();
                        }else{
                            alert("删除失败");
                        }
                    }
                });
            },'question');
        }
    </script>

    <ul class="toolbar">
        <li><a class="button" href="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/add?moduleType=${specAreaModuleType?default(indexSpecArea)}">添加</a></li>
    </ul>

    <table cellspacing="0" class="table table-bordered">
        <thead>
        <tr>
            <th>名称</th>
            <th>图</th>
            <th>顺序</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <#if definedModule?has_content && definedModule.definedModuleItems?has_content>
        <#list definedModule.definedModuleItems as one>
        <tr>
            <td>${one.name}</td>
            <td>
                <#if itemLinkMap?has_content>
					<#assign count=0/>
                    <#assign links  = itemLinkMap[one.id+""]!""/>
                    <#if links?has_content>
                        <#list links as link>
                            <img src="${link.imgPath!}" width="50px" height="50px"/>

							<#if count gt 6>
								<#break >
							</#if>
							<#assign count=count+1 />
                        </#list>
                    </#if>
                </#if>
            </td>
            <td>
            ${one.seq?default(0)}
            </td>
            <td><a href="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/edit?id=${one.id}">修改</a>
                &nbsp;&nbsp;<a href="javascript:del('${one.id}');">删除</a>
            </td>
        </tr>
        </#list>
        </#if>
        </tbody>
    </table>
</body>
</html>