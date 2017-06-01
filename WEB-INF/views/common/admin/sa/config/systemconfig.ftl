 <#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/static/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="/static/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="/static/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="/static/admin/css/page.css" rel="stylesheet" type="text/css"/>
    <link href="/static/admin/css/theme-01.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/static/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="/static/admin/js/bui.js"></script>
    <script type="text/javascript" src="/static/admin/js/config.js"></script>
    <script type="text/javascript" src="/static/admin/js/admin.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">系统配置</span></li>
        </ul>
    </div>

    <div id="content">
        <div id="left" class="side-menu">
            <ul id="zTree" class="ztree"></ul>
            <link href="/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
            <script type="text/javascript" src="/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
            <script type="text/javascript" src="/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
            <script type="text/javascript">
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
                    },
                    callback: {
						   onClick: zTreeOnClick
				          	
    					}
                }
                var zNodes =[
                    {
                        id:0
                        ,pId:-1
                        ,name:"订单模块"
                        ,target:"rightFrameForCustomerChildren"
                        ,url:""
                        ,open:true
                    }

                    ,{
                        id:1
                        ,pId:0
                        ,name:"自动确认收货"
                        ,target:"rightFrameForCustomerChildren"
                        ,url:""
                        ,open:true
                    }
                    ,{
                        id:2
                        ,pId:0
                        ,name:"下单条件设置"
                        ,target:"rightFrameForCustomerChildren"
                        ,url:""
                        ,open:true
                    }
                    ,{
                        id:3
                        ,pId:0
                        ,name:"自动评价"
                        ,target:"rightFrameForCustomerChildren"
                        ,url:""
                        ,open:true
                    }
                    

                ];

                $(document).ready(function(){
                    treeObj=$.fn.zTree.init($("#zTree"), setting, zNodes);
                    allNodes = treeObj.transformToArray(treeObj.getNodes());
                });

                function showIconForTree(treeId, treeNode) {
                    return !treeNode.isParent;
                }

                function getFontCss(treeId, treeNode) {
                    return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
                }
                
                function zTreeOnClick(event, treeId, treeNode) {
				    $(".cform").css("display","none");				    
				    $("#form"+treeNode.id).css("display","block");
				    		    
				}
			
            </script>
        </div>
        <div id="right" class="main-content">
        <div class="content-body">
       	<form id="J_Form" class="form-horizontal bui-form bui-form-field-container tt" method="post" action="${ctx}/admin/sa/common/config/saveConfig" aria-disabled="false" aria-pressed="false">
			<div id="form1" class="cform">
				<div class="panel">
					<div class="panel-header"><h3>自动确认收货</h3>
					</div>
					<div class="panel-body">
						<div class="control-group">
							<label class="control-label" style="width: 180px;">全部订单自动确认收货时间：</label>
							<div class="controls">
							<input class="control-text bui-form-field" data-rules="{number:true,min:1}" name="autoReceiveTime" value="${(orderAutoReceive.configValue)!}" aria-disabled="false" aria-pressed="false">   天
						</div>
					</div>
					</div>
				</div>
			
        </div>
        
            <div id="form2" class="cform">
				
				    <div class="panel" style="overflow: hidden">
				        <div id="edit-div" class="well" style="width: 100%;height: 25px">
				            <div class="row">
				                <div class="control-group">
				                    <label class="control-label" style="width: 150px">下单条件1：常规发票</label>&nbsp;&nbsp;&nbsp;&nbsp;
				                    <div class="controls control-row-auto" style="margin-left: 100px">
				                        <label>
				                            <input name="invoiceStatus" id="invoiceStatus" <#if conditionOneIsUse.configValue == "1">checked="checked"</#if> type="checkbox"  class="bui-form-field-checkbox bui-form-check-field bui-form-field" aria-disabled="false" aria-pressed="false">启用
				                        </label>&nbsp;&nbsp;&nbsp;&nbsp;
				                        <label>
				                            <input name="invoiceRequired" id="invoiceRequired" <#if conditionOneIsRequired.configValue =="1">checked="checked"</#if> type="checkbox"  class="bui-form-field-checkbox bui-form-check-field bui-form-field" aria-disabled="false">整块必填
				                        </label>
				                    </div>
				                </div>
				            </div>
				        </div>
				        <div class="row">
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">发票类型：</label>
				                <div class="controls control-row-auto">
				                    <label>
				                        <input checked="checked" name="type" value="0" type="radio" data="normal_div" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">普通发票
				                    </label>&nbsp;&nbsp;&nbsp;&nbsp;
				                    <label>
				                        <input name="type" value="1" type="radio" data="special_div" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">增值税发票
				                    </label>
				                </div>
				            </div>
				        </div>
				        <div class="row normal_div" style="display: block;">
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">发票抬头：</label>
				                <div class="controls control-row-auto">
				                    <label>
				                        <input checked="checked" name="title" value="0" type="radio" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">个人
				                    </label>&nbsp;&nbsp;&nbsp;&nbsp;
				                    <label>
				                        <input name="title" value="1" type="radio" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">单位
				                    </label>
				                </div>
				            </div>
				        </div>
				        <div class="row normal_div" style="display: block;">
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">个人姓名/单位名称：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false" aria-pressed="false">
				                </div>
				            </div>
				        </div>
				        <div class="row special_div" style="display: none;">
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">发票抬头：</label>
				                <div class="controls control-row-auto">
				                    <label>
				                        <input name="normal_11" type="radio" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">单位
				                    </label>
				                </div>
				            </div>
				        </div>
				        <div class="row special_div" style="display: none;">
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">单位名称：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">纳税人识别码：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">注册地址：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">注册电话：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">银行账户：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">开户行：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">发票抬头：</label>
				                <div class="controls control-row-auto">
				                    <input type="text" class="input-normal control-text bui-form-field" aria-disabled="false">
				                </div>
				            </div>
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">发票配送地址：</label>
				                <div class="controls control-row-auto">
				                    <select class="bui-form-field-select bui-form-field" aria-disabled="false"><option>省</option></select>&nbsp;&nbsp;
				                    <select class="bui-form-field-select bui-form-field" aria-disabled="false"><option>市</option></select>&nbsp;&nbsp;
				                    <select class="bui-form-field-select bui-form-field" aria-disabled="false"><option>区</option></select>
				                    <br>
				                    <textarea style="width: 97%" class="bui-form-field" aria-disabled="false"></textarea>
				                </div>
				            </div>
				        </div>
				    </div>
				    <div class="bui-clear"></div>
				
				    <div class="panel" style="overflow: hidden">
				        <div id="edit-div" class="well" style="width: 100%;height: 25px">
				            <div class="row">
				                <div class="control-group">
				                    <label class="control-label" style="width: 150px">下单条件2：收送货时间</label>&nbsp;&nbsp;&nbsp;&nbsp;
				                    <div class="controls control-row-auto" style="margin-left: 100px">
				                        <label>
				                            <input name="deliveryStatus" <#if conditionTwoIsUse.configValue == "1">checked="checked"</#if> id="deliveryStatus" type="checkbox" class="bui-form-field-checkbox bui-form-check-field bui-form-field" aria-disabled="false">启用
				                        </label>&nbsp;&nbsp;&nbsp;&nbsp;
				                        <label>
				                            <input name="deliveryRequired" id="deliveryRequired" <#if conditionTwoIsRequired.configValue =="1">checked="checked"</#if> type="checkbox" class="bui-form-field-checkbox bui-form-check-field bui-form-field" aria-disabled="false">整块必填
				                        </label>
				                    </div>
				                </div>
				            </div>
				        </div>
				        <div class="row">
				            <div class="control-group">
				                <label class="control-label" style="width: 150px">期望送货时间：</label>
				                <div class="controls control-row-auto">
				                    <select class="bui-form-field-select bui-form-field" aria-disabled="false">
                                        <option>时间不限</option>
										<#if dateMap?? && dateMap?has_content>
											<#list dateMap?keys as key>
                                                <option>${(dateMap[key])!}</option>
											</#list>
										</#if>
									</select>
				                </div>
				            </div>
				        </div>
				    </div>	
            </div>
            
            <div id="form3" class="cform">
				 <form id="J_Form1" action="${ctx}/admin/sa/common/config/saveAutoReceive" method="post" class="bui-form bui-form-field-container tt" aria-disabled="false" aria-pressed="false">
				        <div id="tab"></div>
				        <div class="panel">
				            <div class="panel-body">
				                <div class="control-group">
				                    <div class="control-label">
				                        <label><input  type="radio"  <#if isAutoReceive.configValue == "0">checked="checked"</#if>  name="auto" value="0" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">&nbsp;&nbsp;关闭自动评价</label>
				                    </div>
				                </div>
				                <div class="control-group">
				                    <div class="control-label">	
				                        <label><input <#if isAutoReceive.configValue == "1">checked="checked"</#if>  type="radio" name="auto" value="1" class="bui-form-field-radio bui-form-check-field bui-form-field" aria-disabled="false">&nbsp;&nbsp;开启自动评价</label>
				                    </div>
				                    <div class="controls">
				                        <div>
				                            收货后<input class="control-text bui-form-field" id="days" style="width: 30px;" name="days" value="${(goodReceiveDays.configValue)!}" data-rules="{number:true,required:true,min:1}" aria-disabled="false" aria-pressed="false">天自动五星评价
				                        </div>
				                        <div>
				                            评价文字：<input class="control-text bui-form-field" name="content" value="${(goodCommentContent.configValue)!?default("用户默认好评")}" data-rules="{required:true}" aria-disabled="false" aria-pressed="false">
				                        </div>
				                    </div>
				                </div>
				            </div>
				        </div> 

            </div>
             <div class="actions-bar-fixed">
	                   		 <div class="actions-bar">
		                         <div class="form-actions offset5">
		                            <button id="btn_submit" type="submit" class="button button-large button-primary">保存</button>
		                            <button type="reset" class="button button-large">重置更改</button>
		                         </div>
                    		</div>
                		</div>
				 </form>

               
            </div>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function(){
        resetHeight();
        $(".cform").css("display","none");
        $("#form1").css("display","block");
        
        $("input[data=special_div]").bind("click",function(){
        	$(".normal_div").css("display","none");
        	$(".special_div").css("display","block");
        });
        $("input[data=normal_div]").bind("click",function(){
        	$(".normal_div").css("display","block");
        	$(".special_div").css("display","none");
        	
        });
       
    })
    function resetHeight(){
        var h = $(window).height() - ($('.title-bar').outerHeight() || 0);
        $('.side-menu').height(h - 22);
        $('.main-content').height(h);
    }
    $(window).on('resize',resetHeight);
    
    $(function(){
  		var Form = BUI.Form
  		var form = new Form.Form({
  			srcNode:'#J_Form',
  			submitType:'ajax',
  			callback: function (data) {
  				if(app.ajaxHelper.handleAjaxMsg(data)){
  					app.showSuccess("保存成功");
  				}
  			}
  		}).render();
  		
  	$("#invoiceRequired").bind("click",function(){
  		var $in1 = $("#invoiceRequired");
  		if($in1.attr("checked")=="checked"){
  			$("#invoiceStatus").attr("checked","checked");
  		}
  	});
  	$("#invoiceStatus").bind("click",function(){
  		var $status = $("#invoiceStatus");
  		var $in1 = $("#invoiceRequired");
  		if($in1.attr("checked")=="checked"){
  			$status.removeAttr("checked");
  			$in1.removeAttr("checked");
  		}
  	});
  	$("#deliveryStatus").bind("click",function(){
  		var $status2 = $("#deliveryStatus");
  		var $in2 = $("#deliveryRequired");
  		if($in2.attr("checked")=="checked"){
  			$status2.removeAttr("checked");
  			$in2.removeAttr("checked");
  			
  		}
  	});
  	$("#deliveryRequired").bind("click",function(){
  		var $in2 = $("#deliveryRequired");
  		if($in2.attr("checked")=="checked"){
  			$("#deliveryStatus").attr("checked","checked");
  		}
  	});
  	});
</script>
</body>
</html>  