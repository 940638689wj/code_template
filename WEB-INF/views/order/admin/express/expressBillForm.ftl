<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
	
	<script src="${ctx}/static/admin/js/uploadPreview.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
		<div class="row">
		<ul class="breadcrumb">
	        <li><a href="${ctx }/admin/sa/order/orderReturnReasonList">配送方式</a><span class="divider">&gt;&gt;</span></li>
	        <li class="active">新加物流</li>
		</ul>
			<form id="J_Form" class="form-horizontal span24" action="${ctx}/admin/sa/order/express/AddOrEditExpressBill" method="post">
				
				<input type="hidden" name="id"  value="${(expressTemplatePrint.printId)!}" >
                <textarea style="display: none;" name="source" id="source">${(expressTemplatePrint.printSource)!}</textarea>
                <!--
		   -->
                <div class="control-group">
                    <label class="control-label">快递公司：</label>
                    <div class="controls">
                        <select id="printType" name="printType">
                        <#if expressValues?has_content>
                            <#list expressValues as e>
                                <option value="${e.valueId!}"
                                        <#if valueId?has_content && e.valueId == valueId?number>selected</#if>
                                        <#if expressTemplatePrint?has_content && e.valueId == expressTemplatePrint.printType>selected</#if>
                                >${e.valueLabel!}</option>
                            </#list>
                        </#if>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">默认布局：</label>
                    <div class="controls">
                        <select id="printId" name="printId">
                        <#if systemTypes?has_content>
                            <#list systemTypes as s>
                                <option value="${s.printId!}"
                                        <#if printId?has_content && printId == s.printId?string>selected</#if>
                                        <#if expressTemplatePrint?has_content && s.printId == expressTemplatePrint.printId>selected</#if>
                                >${s.printName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">模板名称：</label>
                    <div class="controls">
                        <input type="text" name="printName" <#if printName?has_content>value="${printName!}" <#else>value="${(expressTemplatePrint.printName)!}" </#if>   data-rules="{required : true}" class="input-normal control-text">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" style="width: 120px;">远程图片：</label>
                    <div class="controls">
                        <input type="file" id="up_img" />
                        <a id="btn_apply" href="javascript:;"><span>应用到模板中</span></a>
                    </div>
                </div>

                <input id="imgPath_bk" value="" name="backImage" type="hidden" />
                <div id="imgdiv" ><img id="imgShow" width="100" name="imgShow" height="100" src="${(expressTemplatePrint.backImage)!}"/></div>

                    <div class="control-group">
                        <label class="control-label"><s>*</s>模板：</label>
                        <div class="controls control-row-auto">
                            <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=900 height=660>
                                <embed id="LODOP_EM" type="application/x-print-lodop" width=900 height=660></embed>
                            </object>
                        </div>
                    </div>

             	<div class="row form-actions actions-bar">
					<div class="span13 offset3">
						<button type="submit" class="button button-primary">保存</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<script src="${ctx!}/static/js/lodop/LodopFuncs_new.js"></script>
<script src="${ctx!}/static/js/lodop/print.js"></script>
<script type="text/javascript">
    window.onload = function () {
        new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
    }


    (function(w){
        var bind = function(obj, type, callback) {
            if (!callback || typeof callback !== "function") return;
            if (obj.addEventListener) {
                obj.addEventListener(type, callback);
            } else if (obj.attachEvent) {
                obj.attachEvent("on" + type, callback);
            }
            return obj;
        };
        var _$ = function(id) {
            return window.document.getElementById(id);
        };
        bind(w, "load", function(){
            var print = new self.PRINT().init();
            var Form = BUI.Form;
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("保存成功！")
                        window.location.href = "/admin/orderCurier/template/list";
                    }
                }
            }).render();
            form.on("beforesubmit", function() {
                var code = print ? print.getCode() : "";
                _$("source").value = code;
                return true;
            });
            $("#layoutType").change(function(){
                var id = $(this).find(":selected").attr("layoutId");
                $.post("/admin/orderCurier/thermal/batchPrint", {id : id}, function(data) {
                    if (!data || !data.data) return;
                    print.clear();
                    PRINT.eval(print, data.data);
                    print.design();
                });
            });
            var code = _$("source").value;
            if (code) PRINT.eval(print, code);
            print.design();
            $("#btn_apply").click(function() {
                var path = $("[name='backImage']").val();
                if (!path) {
                    return BUI.Message.Alert("并未选择图片！");
                }
                print.setBackImage(path);
            });
        });
    }(window));
</script>
<script type="text/javascript">
  	 		BUI.use('bui/form',function (Form) {
			var form = new Form.HForm({
				srcNode : '#J_Form',
				submitType: 'ajax',
				dataType : 'json',
				callback: function (data) { 
				    if (data) {
 				    	BUI.Message.Alert('操作成功!',function(){
                             window.location.href='${ctx }/admin/sa/order/express/expressBillList';
                        });
				    }else{
				    	BUI.Message.Alert('操作失败！','error');
				    }
				}
			});
		
		
			form.render();
		});


	
		  
</script>
</body>
</html>  