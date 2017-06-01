<#assign ctx = request.contextPath>
<#assign indexSpecArea = Static["cn.yr.chile.common.constant.DefinedModuleKeys"].INDEX_SPEC_AREA.key>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>

    <script>
        function del(id){
            BUI.Message.Confirm('确认要删除该条目吗？',function(){
                $.ajax({
                    url: '${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/deleteLink?linkId='+id,
                    type:'post',
                    dataType: 'json',
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

    <style type="text/css">
        .tb-toolbar {
            height: 30px;
            padding: 0 10px;
            text-align: right;
            line-height: 30px;
        }
    </style>
</head>
<body>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/save" method="post">
        <input type="hidden" name="id" value="${(moduleItem.id)!}"/>
        <input type="hidden" name="moduleType" value="${specAreaModuleType?default(indexSpecArea)}">
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input value="${(moduleItem.name)!?html}" name="name" data-rules="{required:true}" class="input-large control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>顺序：</label>
                    <div class="controls"><input value="${(moduleItem.seq)?default(1)}" name="seq" data-rules="{required:true,number:true}" class="input-large control-text">
                    </div>
                </div>
            </div>
        </div>

        <table cellspacing="0" class="table table-bordered">
            <thead>
				<tr>
					<th>图</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
            </thead>
            <tbody>
				<#if links?? && links?has_content>
					<#list links as one>
						<tr>
							<td>
								<input type="hidden" value="${one.id}" name="linkIdArr">
                            	<img id="imageView_${one_index}" style="width: 50px;height: 30px;" src="${(one.imgPath)!}">
							</td>
							<td>
								<input type="text" class="control-text" value="${one.seq?default(0)}" name="linkSeqArr" data-rules="{required:true,number:true}">
							</td>
							<td>
								<a href="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/linkForm?itemId=${(moduleItem.id)!}&linkId=${one.id}">修改</a>
								&nbsp;&nbsp;<a href="javascript:del('${one.id}');">删除</a>
							</td>
						</tr>
					</#list>
				</#if>
            </tbody>
        </table>
        <div class="tb-toolbar">
            <a href="javaScript:addLink('${(moduleItem.id)!}');" class="button button-primary" >新增</a>
        </div>

        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("保存成功！")
                    }
                }
            }).render();
        });

        function addLink(itemId){
            if(itemId)
            {
                window.location.href="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/linkForm?itemId="+itemId;
            }else{
                BUI.Message.Alert("请先保存当前列表再进行图片新增!");
            }
        }
    </script>
</body>
</html>