<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>

    <#assign staticPath = ctx + "/static">
    <link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>

    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>
</head>

<#macro showMenuTree menu level subMenusMap>
    <#if subMenusMap?? && subMenusMap?has_content>
        <#local subMenuList = (subMenusMap[(menu.menuId)?string])!/>
    </#if>

	<#if menu?has_content>
        <tr>
            <td width="60%" style="cursor: pointer">
                <input type="hidden" name="id" value="${menu.menuId}">
                <#if level gt 0>
                    <#list 0..level*4 as one>&nbsp;</#list>
                </#if>

                <#if (level == 0)>
                    ${(menu.menuName)!?html}
                <#else>
                    <em style="display: inline-block;margin-left: 1em;color: #a67c52;font-weight: 400;font-style: normal;"><i>●</i></em>${(menu.menuName)!?html}
                </#if>
            </td>
            <td>
                <#if (level == 0)>
                    <#if subMenuList?? && (subMenuList?size gte 5)>
                        <@securityAuthorize ifAnyGranted="delete">
                            <a href="javascript:deleteBtn('${(menu.menuId)!}');">删除</a>&nbsp;&nbsp;&nbsp;
                        </@securityAuthorize>
                    <#else>
                        <@securityAuthorize ifAnyGranted="delete">
                            <a href="javascript:deleteBtn('${(menu.menuId)!}');">删除</a>&nbsp;&nbsp;&nbsp;
                        </@securityAuthorize>
                            <a href="${ctx}/admin/sa/wechat/menuRight?parentId=${(menu.menuId)!}" target="mainFrame">添加</a>
                    </#if>
                <#else>
                    <@securityAuthorize ifAnyGranted="delete">
                        <a href="javascript:deleteBtn('${(menu.menuId)!}');">删除</a>&nbsp;&nbsp;&nbsp;
                    </@securityAuthorize>
                </#if>
            </td>
        </tr>
	</#if>

	<#if menu?has_content && subMenuList?has_content>
		<#list subMenuList as subMenu>
			<@showMenuTree subMenu level+1 subMenusMap/>
		</#list>
	</#if>
</#macro>

<body>
    <div class="container">
       <div id="tab">
         <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">自定义菜单设置</span></li>
         </ul>
       </div>

        <div class="tips tips-small tips-notice">
            <span class="x-icon x-icon-small x-icon-warning">
                <i class="icon icon-white icon-volume-up"></i>
            </span>
            <div class="tips-content">
                1. 使用本模块，必须在微信公众平台申请自定义菜单使用的AppId和AppSecret，请在 菜单授权 中设置。</br>
                2. 最多创建3 个一级菜单，每个一级菜单下最多可以创建 5 个二级菜单，菜单最多支持两层。
            </div>
        </div>
                    <ul class="toolbar">
                        <li><a class="button button-small button-primary" href="${ctx}/admin/sa/wechat/menuRight?parentId=1" target="mainFrame">添加菜单</a></li>
                        <li><a class="button button-small" href="#" onclick="menuSync();">发布菜单</a></li>
                    </ul>
        <div>
			<table width="100%">
				<tr>
					<td style="width: 25%;vertical-align: top">
                        <table id="tab" cellspacing="0" class="table table-bordered" style="width: 100%">
							<#if menuList??>
								<#list  menuList as menu>
										<@showMenuTree  menu 0 subMenusMap/>
									</#list>
							</#if>
						</table>
					</td>
                    <td style="width: 70%;vertical-align: top">
                        <iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;"
                                scrolling="yes" frameborder="no" width="100%" height="600">
                        </iframe>
					</td>
				</tr>
			</table>
        </div>
    </div>
    <!-- script start-->
    <script type="text/javascript">
        $("#tab tr td:first-child").click(function() {
            var ids=$(this).find("input[name='id']");
            ids.each(function (i) {
                document.getElementById("mainFrame").src="${ctx}/admin/sa/wechat/menuRight?id="+$(this).val()
                return ;
            });
        });

        //删除一条菜单项
        function deleteBtn(value){
            BUI.Message.Confirm('确认要删除该条目吗？',function(){
                $.ajax({
                    url: "${ctx}/admin/sa/wechat/menuDelete?id="+value,
                    type:"get",
                    dataType: "text",
                    success: function(data){
                        if(data=="success"){
                            //删除后重新刷新页面
                            app.showSuccess("删除成功!");
                            location.reload(false);
                        }else{
                            app.showError("删除失败!");
                        }
                    }
                });
            },'question');
        }

        //同步菜单到微信
        function menuSync(){
            $.ajax({
                url : '${ctx}/admin/sa/wechat/menuSync',
                dataType : 'json',
                type: 'POST',
                data : {method : "menuSync"},
                success : function(data){
                    if(data.result == "true"){
                        BUI.Message.Alert('发布菜单成功!');
                    }else{
                        BUI.Message.Alert('发步菜单失败!'+data.error);
                    }
                }
            });
        }

        //删除菜单
        function menuDelete(){
            $.ajax({
                url : '${ctx}/admin/sa/wechat/menuDelete',
                dataType : 'json',
                type: 'POST',
                data : {method : "menuDelete"},
                success : function(data){
                    if(data.result == "true"){
                        BUI.Message.Alert('删除菜单成功!');
                    }else{
                        BUI.Message.Alert('删除菜单失败!'+data.error);
                    }
                }
            });
        }         
    </script>
    <!-- script end-->
<body>
</html>  