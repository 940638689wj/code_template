<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
	<form id="J_Form" class="form-horizontal" method="post" action="${ctx}/admin/sa/userPromotion/save">
		<div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">发展会员奖励</span></li>
        </ul>
    	</div>
    	<div class="form-content">
        	<div class="row">
	            <div class="control-group">
	                <label class="control-label" style="width: 180px;">发展一个会员返利金额:</label>
	                <div class="controls">
	                      <input value="${rebateMoney?default("0.00")}" name="developUserRebate" id="developUserRebate" data-rules="{required:true,regexp:/^\d+(\.\d+)?$/}" data-messages="{regexp:'金额输入不正确'}" class="input-small control-text">&nbsp;&nbsp;元
	                </div>
	            </div>
	            <div class="control-group">
	                <label class="control-label" style="width: 180px;">发展一个会员送:</label>
	                <div class="controls">
	                      <input value="${point?default("0")}" name="developUserPoint" id="developUserPoint" data-rules="{required:true,regexp:/^\d*$/}" data-messages="{regexp:'必须为正整数'}" class="input-small control-text">&nbsp;&nbsp;积分
	                </div>
	            </div>
        	</div>
        </div>
        
         <div class="actions-bar"></div>
         <div class="form-content">
	         <div class="row">
	            <div class="span13 offset2 ">
	                <button id="save" type="submit" class="button button-primary">保存</button>
	                <#--<button type="reset" class="button">重置</button>-->
	            </div>
	        </div>
       </div>
</form>
	

<script>
    (function($) {
        $(function() {
        	var Form = BUI.Form;
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("保存成功！")
                    }
                    setTimeout("remainTime()",1000);
                }
            });
            form.render();
            
            top.configSubmit = function() {
                form.submit();
            };
            top.configReset = function() {
                $("#J_Form").find(":input").not(":button,:submit,:reset,:hidden").val("").removeAttr("checked").removeAttr("selected");
            }; 
            //禁用保存按钮
            form.on('beforesubmit', function(){
	    		btn=document.getElementById('save');
				btn.disabled=true;
			});
            //回车保存   
            document.onkeydown=function(){
				if (event.keyCode == 13){
					$("#save").trigger('click');
				}	
	    	}
	    	
		});
		
    } (jQuery));
    
    function remainTime(){
    		btn=document.getElementById('save');
			btn.disabled=false;
	}
    
</script>
 </body>
 </html>