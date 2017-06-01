<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">运费模板</span></li>
        </ul>
    </div>
    <div class="content-top">
        <!--<div class="tips tips-small tips-notice">
            <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-volume-up"></i></span>
            <div class="tips-content">
                关联运费模板后，运费计算以模版为准;<br>
                每个运费模板为每个区域范围的中心点，“运送到”可选多个区域范围。<br>
                晚上时间超过22:00,运费在原来测算结果的基础上翻倍计算，直到隔天早上6:00恢复。<br>
                续重的配送费不满1KG时同样以1KG计算。
            </div>
        </div>-->
        <ul class="toolbar mb10">
            <li><a class="button button-primary" href="${ctx}/admin/sa/brand/addExpressTemplate?parentAreaId=0">新增运费模板</a></li>
        </ul>
    </div>
    <div class="content-body">
    	<#list expressTemplateList as expressTemplate>
        <table cellspacing="0" class="table table-bordered">
            <caption>${expressTemplate.templateName!}
                <div class="thead-toolbar"><a href="${ctx}/admin/sa/brand/updateExpressTemplate?TemplateId=${expressTemplate.templateId!}&parentAreaId=0">编辑</a>
            <@securityAuthorize ifAnyGranted="delete">
                    <a  style="cursor:pointer" onclick = "deleteTemplate('${expressTemplate.templateId!}',this);" >删除</a>
            </@securityAuthorize>
                </div>
            </caption>
            <tbody>
            <tr class="trbgcolor">
                <th  colspan="2" width="100">运送到</th>
                <div style="display:inline-block; " width="20%"></div>
                <th>首重(克)</th>
                <th>首价(元)</th>
                <th>续重(克)</th>
            	<th>续价(元)</th>
            </tr>
            <tr>
            	<td colspan="2" width="100">
            		<div style="display:inline-block; " width="20%">默认</div>
            	</td>
                <td>${expressTemplate.firstValue!}</td>
                <td>${expressTemplate.firstPrice!}</td>
                <td>${expressTemplate.continueValue!}</td>
                <td>${expressTemplate.continuePrice!}</td>
            </tr>
            <#if expressTemplate.expressTemplateDestinationAreaList?has_content>
            <#list expressTemplate.expressTemplateDestinationAreaList as areaList>
            <tr>
            	<td colspan="2" width="100">
            	<#list areaList.areaNameList as areaName>
            		<div style="display:inline-block; " width="20%">${areaName_index + 1}.${areaName}</div><#if areaName_has_next>,</#if> 
            	</#list>
            	</td>
                <td>${areaList.firstValue!}</td>
                <td>${areaList.firstPrice!}</td>
                <td>${areaList.continueValue!}</td>
                <td>${areaList.continuePrice!}</td>
            </tr>
            </#list>
            </#if>
            </tbody>
        </table>
		</#list>
    </div>
</div>
<script type="text/javascript">
	function deleteTemplate(Delete,remve){
		BUI.Message.Confirm('确认要删除么？',function(){
			$.ajax({ url: "${ctx}/admin/sa/brand/deleteExpressTemplate?TemplateId="+Delete, success: function(data){
				if(data.result == "1"){
					app.showError(data.error);
				}else{
					app.showSuccess("删除成功！");
					$(remve).closest("table").remove();
					//window.location.href = "${ctx}/admin/sa/brand/express_list";
				}
      		}});
		 	//window.location.href="${ctx}/admin/sa/brand/deleteExpressTemplate?TemplateId="+Delete;
        });
   	}
</script>
</body>
</html>  