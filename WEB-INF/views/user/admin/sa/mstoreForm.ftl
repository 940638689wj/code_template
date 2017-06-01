<#assign ctx = request.contextPath>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="userinfo-box">
        	<div class="pic">
            	<img src="<#if (mstoreDTO.headPortraitUrl)??>${(mstoreDTO.headPortraitUrl)!?html}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100">
            </div>
            <div class="code"><img src="${ctx}/admin/sa/user/getQrImg?userId=${mstoreDTO.userId}"  width="100" height="100"></div>
            <ul>
                <li>微店主手机号：${(mstoreDTO.phone)!?html}</li>
                <li>微店名称：${(mstoreDTO.mstoreName)!?html}</li>
                <li>微店等级：${(mstoreDTO.mstoreLevelName)!?html}</li>
                <li>审核通过时间：${((mstoreDTO.auditTime)?string("yyyy-MM-dd hh:mm"))!}</li>
                <li>销售总额：${(mstoreDTO.totalSalesAmt)!0}</li>
            </ul>
        </div>
    </div>
    <div class="content-top">
        <div id="tab"></div>
    </div>
    <div class="content-body">
        <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/mstore/updateMstoreForm" method="post">
        	<input type="hidden" name="userId" value="${(mstoreDTO.userId)!?html}"/>
        	<table cellspacing="0" class="table table-info">
	            <tbody>
	            <tr>
	                <th>微店名称：</th>
	                <td><div class="input-wrap"><input name="mstoreName" value="${(mstoreDTO.mstoreName)!?html}" class="control-text" type="text"></div></td>
	                <th>身份证号：</th>
	                <td><div class="input-wrap"><input name="identityId" data-messages="{regexp:'只能输入数字和字母'}" data-rules="{regexp:/^[A-Za-z0-9]+$/}" value="${(mstoreDTO.identityId)!?html}" class="control-text" type="text"></div></td>
	            </tr>
	            <tr>
	                <th>地区:</th>
	                <td>
	                    <select name="provinceId" id="selectProvince" class="span3">
				            <option value="">-- 选择省份 --</option>
				            <#if provinceList?? && provinceList?has_content>
				                <#list provinceList as item>
				                   <option value="${item.id}" <#if (mstoreDTO.provinceId??) && (mstoreDTO.provinceId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
				                </#list>
				            </#if>
					        </select>
					        <select name="cityId" id="selectCity" class="span3">
					            <option value="">-- 选择城市 --</option>
					            <#if cityList?? && cityList?has_content>
				                <#list cityList as item>
				                   <option value="${item.id}" <#if (mstoreDTO.cityId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
				                </#list>
				            </#if>
					        </select>
					        <select name="countyId" id="selectCountry" class="span3">
					            <option value="">-- 选择县/区 --</option>
					            <#if countyList?? && countyList?has_content>
				                <#list countyList as item>
				                   <option value="${item.id}" <#if (mstoreDTO.countyId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
				                </#list>
				            </#if>
					     </select>
	                </td>
	                <th>详细地址：</th>
	                <td><div class="input-wrap"><input name="street" value="${(mstoreDTO.street)!?html}" class="control-text" type="text"></div></td>
	            </tr>
	            <tr>
	                <th>微店等级：</th>
	                <td>
	                    <select name="mstoreLevelId" class="input-maxbig">
	                    	<option value="">--请选择--</option>
	                        <#if mstoreLevelList?? && mstoreLevelList?has_content>
				                <#list mstoreLevelList as item>
				                   <option value="${(item.mstoreLevelId)?default('')}" <#if (mstoreDTO.mstoreLevelId)?? && item.mstoreLevelId?? && mstoreDTO.mstoreLevelId?string == item.mstoreLevelId?string>selected="selected" </#if>>${(item.mstoreLevelName)!?html}</option>
				                </#list>
				            </#if>
	                    </select>
	                </td>
	                <th>所属大区：</th>
	                <td>
	                    <select class="span4" name="regionId" id="regionId">
	                        <option value="">-- 请选择 --</option>
				            <#if orgList?? && orgList?has_content>
				                <#list orgList as item>
				                    <option value="${(item.orgId)!}" <#if (mstoreDTO.regionId)?? && (mstoreDTO.regionId) == item.orgId>selected="selected" </#if>>${(item.orgFullName)!}</option>
				                </#list>
				            </#if>
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <th>所属分公司：</th>
	                <td>
	                    <select class="span4" name="branchId" id="branchId">
	                    	<option value="">-- 请选择 --</option>
	                    	<#if branchList?? && branchList?has_content>
				                <#list branchList as item>
				                    <option value="${(item.orgId)!}" <#if (mstoreDTO.branchId)?? && (mstoreDTO.branchId) == item.orgId>selected="selected" </#if>>${(item.orgFullName)!}</option>
				                </#list>
				            </#if>
	                    </select>
	                </td>
	                <th>所属办事处：</th>
	                <td>
	                    <select class="span4" name="officeId" id="officeId">
	                    	<option value="">-- 请选择 --</option>
	                    	<#if officeList?? && officeList?has_content>
				                <#list officeList as item>
				                    <option value="${(item.orgId)!}" <#if (mstoreDTO.officeId)?? && (mstoreDTO.officeId) == item.orgId>selected="selected" </#if>>${(item.orgFullName)!}</option>
				                </#list>
				            </#if>
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <th>微店状态：</th>
	                <td>
	                    <select name="statusCd" class="input-maxbig">
	                        <option value="1" <#if (mstoreDTO.statusCd)?? && (mstoreDTO.statusCd)==1>checked="on"</#if>>启用</option>
	                        <option value="0" <#if (mstoreDTO.statusCd)?? && (mstoreDTO.statusCd)==0>checked="on"</#if>>禁用</option>
	                    </select>
	                </td>
	                <th>上级会员手机号：</th>
	                <td>
	                    ${(mstoreDTO.parentPhone)!?html}
	                </td>
	            </tr>
	            <tr>
	                <th>微店佣金比例：</th>
	                <td>
	                	<div class="bui-form-group" data-rules="{cube : 100}">
	                    <input name="commissionRate" value="${(mstoreDTO.commissionRate)!0}" data-rules="{number:true,required : true,min:0}" class="control-text" type="text">&nbsp;&nbsp;%
	                	</div>
	                </td>
	                <th>佣金比例有效期：</th>
	                <td>
	                	<div class=" bui-form-group" data-rules="{dateRange : true}">
	                    <input name="startDate" value="${((mstoreDTO.commissionRateStartTime)?string("yyyy-MM-dd"))!}" class="control-text input-small calendar" type="text"><label>&nbsp;-&nbsp;</label>
	                    <input name="endDate" value="${((mstoreDTO.commissionRateEndTime)?string("yyyy-MM-dd"))!}" class="control-text input-small calendar" type="text">
	                	</div>
	                </td>
	            </tr>
	            </tbody>
	        </table>
		    <div class="row form-actions actions-bar">
		        <div class="span13">
		            <button type="submit" class="button button-primary">保存</button>
		            <button type="reset" class="button">重置</button>
		        </div>
		    </div>
        </form>
    </div>
</div>
</body>

<script type="text/javascript">
    BUI.use('common/page');
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
	            location.href='${ctx}/admin/sa/mstore/mstoreManage';
	        }
	    }
	}).render();  
	
	form.on('beforesubmit', function(){
			if(!validateIdCard($("input[name='identityId']").val())){
					app.showError("无效的身份证号!")
					return false;
			}else{
				return true;
			}
        });
	
	BUI.use('bui/form',function(Form){
      
      //添加分组
      Form.Rules.add({
        name : 'cube',  //规则名称
        msg : '佣金比例不能大于{0}。',//默认显示的错误信息
        validator : function(value,baseValue,formatMsg,group){ //验证函数，验证值、基准值、格式化后的错误信息、goup控件
          var fields = group.getFields(),
            cube = 1;
          BUI.each(fields,function(field){
            cube *= field.get('value');
          });
          if(cube > baseValue){
            return formatMsg;
          }
        }
      }); 
 
 
     /*  new Form.Form({
        srcNode : '#J_Form'
      }).render();
       */
  }); 
    
    $("#selectProvince").on('change', function(){
            var selectProvince = $(this).val();
            $("#provinceId").val(selectProvince);
            if(selectProvince && selectProvince != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/userStore/findChildByParentId',
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
            $("#cityId").val(selectCity);
            if(selectCity && selectCity != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/common/area/findChildByParentId',
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

        $("#selectCountry").on('change', function(){
            $("#countryId").val($(this).val());
        });
	
});

  function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    } 
	    
	    //大区选择
	    $("#regionId").on('change',function(){
	    		var regionId = $(this).val();
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					$('#branchId').empty();
	    					$("#branchId").append("<option value=''>-- 请选择 --</option>");
	    					if(data.rowCount && data.rowCount >0){
	                            $.each(data.rows, function(i, row){
	                                $("#branchId").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
	                            });
	                        }
	    				}
	    			});
	    		}
	    	});
	    	
	    //分公司选择
	    $("#branchId").on('change',function(){
    		var branchId = $('#branchId').val();
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					$('#officeId').empty();
	    				$("#officeId").append("<option value=''>-- 请选择 --</option>");
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
    	
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