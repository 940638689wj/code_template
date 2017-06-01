<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="content-body">
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/user/updateUserForm" method="post">
    	<input name="userId" type="hidden" value="${(userInfoDTO.userId)!}"/>

        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <!-- <th>姓名：</th> -->
                <th>昵称：</th>
                <td><div class="input-wrap"><input name="nickName" class="control-text" type="text" value="${(userInfoDTO.nickName)!}"></div></td>
            </tr>

            <tr>
                <th>性别：</th>
                <td>
                    <select class="input-small" name="sexCd">
                    <#assign sexCd=(userInfoDTO.sexCd)!2 />
                    <#if sexList?? && sexList?size gt 0>
                        <#list sexList as item>
                            <option value="${(item.codeId)?default('')}" <#if sexCd?string == item.codeId?string>selected="selected" </#if>>
                            ${item.codeCnName!''}
                            </option>
                        </#list>
                    </#if>
                    </select>
                </td>
            </tr>

            <#--<tr>
                <th>手机:</th>
                <td><div class="input-wrap"><input name="phone" class="control-text" type="text" value="${(userInfoDTO.phone)!}"></div></td>
            </tr>-->

            <tr>
                <th>身份证号：</th>
                <td>
                	<div class="input-wrap">
                		<input id="identityId" name="identityId" class="control-text" type="text"  data-messages="{regexp:'只能输入数字和字母'}" data-rules="{regexp:/^[A-Za-z0-9]+$/}" value="${(userInfoDTO.identityId)!?html}">
            		</div>
            		<div class="input-wrap">
            			<span id="identityIdInfo" class="x-field-error"></span>
            		</div>
        		</td>
            </tr>

            <tr>
                <th>出生日期:</th>
                <td>
                    <div class="input-wrap">
                   <input name="birthday" type="text" class="calendar control-text input-datelarge" data-rules="{reviewDate:true}" style="width:96%;" name="birthday" value="${((userInfoDTO.birthday)?string("yyyy-MM-dd"))!?html}">
                    </div>
                </td>
            </tr>

            <tr>
                <th>地区：</th>
                <td>
                    <select name="provinceId" id="selectProvince" class="span3">
			            <option value="">-- 选择省份 --</option>
			            <#if provinceList?? && provinceList?has_content>
			                <#list provinceList as item>
			                   <option value="${item.id}" <#if (userInfoDTO.provinceId??) && (userInfoDTO.provinceId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
			                </#list>
			            </#if>
				        </select>
				        <select name="cityId" id="selectCity" class="span3">
				            <option value="">-- 选择城市 --</option>
				            <#if cityList?? && cityList?has_content>
			                <#list cityList as item>
			                   <option value="${item.id}" <#if (userInfoDTO.cityId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
			                </#list>
			            </#if>
				        </select>
				        <select name="countyId" id="selectCountry" class="span3">
				            <option value="">-- 选择县/区 --</option>
				            <#if countyList?? && countyList?has_content>
			                <#list countyList as item>
			                   <option value="${item.id}" <#if (userInfoDTO.countyId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
			                </#list>
			            </#if>
				     </select>
                </td>
            </tr>
            <tr>
                <th>地址：</th>
                <td>
                    <div class="input-wrap"><input name="street" placeholder="请输入正确地址" class="control-text" type="text" value="${(userInfoDTO.street)!?html}"></div>
                </td>
            </tr>
            </tbody>
        </table>
    <div class="row form-actions actions-bar">
        <div class="span13">
            <button type="submit" id="save" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </div>
    </form>
    </div>
</div>
</body>

<script>
var dialog = null;

BUI.use('bui/calendar',function(Calendar){
        var datepicker = new Calendar.DatePicker({
            trigger:'.calendar',
            //delegateTrigger : true, //如果设置此参数，那么新增加的.calendar元素也会支持日历选择
            autoRender : true,
            align :{
                node: 'trigger',     // 参考元素, falsy 或 window 为可视区域, 'trigger' 为触发元素, 其他为指定元素
                points: ['tl','tl'], // ['tr', 'tl'] 表示 overlay 的 tl 与参考节点的 tr 对齐
                offset: [0, 30]    // 有效值为 [n, m]
            }
        });
    });
    
$(function(){
	var Form = BUI.Form
	var form = new Form.Form({
	    srcNode: '#J_Form',
	    submitType: 'ajax',
	    callback: function (data) {
	        if (app.ajaxHelper.handleAjaxMsg(data)) {
	            app.showSuccess("保存成功！");
	            //location.href="${ctx}/admin/sa/user/userList";
	        }
	    }
	}).render();  
	
	
	$("#selectProvince").on('change', function(){
        var selectProvince = $(this).val();
        if(selectProvince && selectProvince != ""){
            $.ajax({
                url : '${ctx}/common/area/findChildByParentId',
                dataType : 'json',
                type: 'GET',
                data : {parentId: selectProvince},
                success : function(data){
                    if(data.rowCount && data.rowCount >0){
                        cleanSelectContent("selectCity", "-- 选择城市 --");
                        cleanSelectContent("selectCountry", "-- 选择县/区 --");

                        $.each(data.rows, function(i, row){
                            $("#selectCity").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                        });
                    }else{
                        cleanSelectContent("selectCity", "-- 选择城市 --");
                        cleanSelectContent("selectCountry", "-- 选择县/区 --");
                    }
                }
            });
        }else{
            $('#selectCity').empty();
            cleanSelectContent("selectCity", "-- 选择城市 --");
            cleanSelectContent("selectCountry", "-- 选择县/区 --");
        }
    });

    $("#selectCity").on('change', function(){
        var selectCity = $(this).val();
        if(selectCity && selectCity != ""){
            $.ajax({
                url : '${ctx}/common/area/findChildByParentId',
                dataType : 'json',
                type: 'GET',
                data : {parentId: selectCity},
                success : function(data){
                    if(data.rowCount && data.rowCount >0){
                        cleanSelectContent("selectCountry", "-- 选择县/区 --");

                        $.each(data.rows, function(i, row){
                            $("#selectCountry").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                        });
                    }else{
                        cleanSelectContent("selectCountry", "-- 选择县/区 --");
                    }
                }
            });
        }else{
            $('#selectCountry').empty();
            cleanSelectContent("selectCountry", "-- 选择县/区 --");
        }
    });
});

  function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    } 
	
    //验证身份证号
	$("#identityId").blur(function(){
		var identityId = $(this).val();
		if(!validateIdCard(identityId)){
			$("#identityIdInfo").html("<span class='x-icon x-icon-mini x-icon-error'>!</span><font color=\"red\">&nbsp;无效的身份证号,请重新输入！</font>");
			$("#save").attr('disabled',true);
		}else{
			$("#identityNumInfo").html("<font color=\"green\">身份证号可用！</font>");
			$("#save").attr('disabled',false);
		}
	})
	//点击账户框时 提示消失
	$("#identityId").focus(function(){
		$("#identityIdInfo").html("");
	})
    
    /*验证身份证号格式*/
	function validateIdCard(idCard){
		//15位和18位身份证号码的正则表达式
		var regIdCard=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;
	
		//如果通过该验证，说明身份证格式正确，但准确性还需计算
		if(regIdCard.test(idCard)){
			if(idCard.length==18){
				var idCardWi=new Array( 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ); //将前17位加权因子保存在数组里
				var idCardY=new Array( 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
				var idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
				for(var i=0;i<17;i++){
					idCardWiSum+=idCard.substring(i,i+1)*idCardWi[i];
				}
				var idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
				var idCardLast=idCard.substring(17);//得到最后一位身份证号码
	
				//如果等于2，则说明校验码是10，身份证号码最后一位应该是X
				if(idCardMod==2){
					if(idCardLast=="X"||idCardLast=="x"){
						return true;
					}else{
						return false;
					}
				}else{
					//用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
					if(idCardLast==idCardY[idCardMod]){
						return true;
					}else{
						return false;
					}
				}
			}
		}else{
			return false;
		}
	}
</script>
</body>
</html>  