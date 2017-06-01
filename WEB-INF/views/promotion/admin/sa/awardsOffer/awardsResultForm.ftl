<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
   	<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
    <#--<script type="text/javascript" src="${ctx}/static/admin/js/jquery.regionMgr.js"></script>-->
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list">奖励</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">编辑奖励信息</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="edit" method="post">
        <input type="hidden" name="id" value="${(awardsResult.id)!}"/>
        <input type="hidden" name="awardsItemId" value="${(awardsResult.awardsItemId)!}"/>
        <input type="hidden" name="userId" value="${(awardsResult.userId)!}"/>
        <#assign statusCdValue="1"/>
         	<#if awardsResult?has_content && !(awardsResult.status)>
                    <#assign statusCdValue="0"/>
             </#if>
        <input type="hidden" name="statusCd" value="${(statusCdValue)!}"/>
         <input type="hidden" name="createTimeStr" value="${(awardsResult.createTime)?string('yyyy-MM-dd HH:mm:ss')}"/>
        <div class="form-content">
           	<div class="row">
                <div class="control-group">
                    <label class="control-label">中奖人手机号：</label>
                    <div class="controls control-row-auto">
                        <label>${(awardsResult.phone)!}</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">中奖人姓名：</label>
                    <div class="controls">
                        <label>${(awardsResult.userName)!?html}</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">中奖时间：</label>
                    <div class="controls">
                        <#if (awardsResult.createTime)??><label>${(awardsResult.createTime)?string("yyyy-MM-dd HH:mm:ss")}</label></#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">中奖奖品：</label>
                    <div class="controls">
                        <label>${(awardsResult.awardsItemName)!?html}</label>
                    </div>
                </div>
            </div>
            
        </div>
        <div class="well">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">姓名：</label>
                    <div class="controls">
                        <input value="${(awardsResult.receiverName)!?html}" name="receiverName" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">配送地区：</label>
                    <div class="controls">
                        <select name="provinceId" id="provinceId">
				            <option value="">-- 选择省份 --</option>
				            <#if provinceList?? && provinceList?has_content>
				                <#list provinceList as province>
				                    <option value="${(province.id)!}">${(province.areaName)!}</option>
				                </#list>
				            </#if>
				        </select>
				        <select name="cityId" id="cityId">
				            <option value="">-- 选择城市 --</option>
				        </select>
				        <select name="countyId" id="countyId">
				            <option value="">-- 选择县/区 --</option>
				        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">详细地址：</label>
                    <div class="controls control-row-auto">
                        <textarea name="address" class="control-row4 input-large">${(awardsResult.address)!?html}</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">手机号码：</label>
                    <div class="controls">
                        <input value="${(awardsResult.mobile)!}" id="mobile" name="mobile" data-rules="{mobile:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">邮编号码：</label>
                    <div class="controls">
                        <input value="${(awardsResult.postCode)!}" name="postCode" data-rules="{postCode:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            
             <div class="row">
                <div class="control-group">
                    <label class="control-label">备注：</label>
                    <div class="controls control-row-auto">
                        <textarea name="remark" class="control-row4 input-large">${(awardsResult.remark)!?html}</textarea>
                    </div>
                </div>
            </div>
          
        </div>
        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
</div>
<script>
    $(function(){
    	$("#provinceId").on('change', function(){
            var selectProvince = $(this).val();
            if(selectProvince && selectProvince != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/common/area/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectProvince},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("cityId", "-- 选择城市 --");
                            cleanSelectContent("countyId", "-- 选择县/区 --");

                            $.each(data.rows, function(i, row){
                                $("#cityId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                            <#if awardsResult?has_content && awardsResult.cityId?has_content>
                            $("#cityId").val(${awardsResult.cityId});
                            $("#cityId").trigger('change');
                            </#if>
                        }else{
                            cleanSelectContent("cityId", "-- 选择城市 --");
                            cleanSelectContent("countyId", "-- 选择县/区 --");
                        }
                    }
                });
            }else{
                $('#cityId').empty();
                cleanSelectContent("cityId", "-- 选择城市 --");
                cleanSelectContent("countyId", "-- 选择县/区 --");
            }
        });

        $("#cityId").on('change', function(){
            var selectCity = $(this).val();
            if(selectCity && selectCity != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/common/area/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectCity},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("countyId", "-- 选择县/区 --");

                            $.each(data.rows, function(i, row){
                                $("#countyId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                            <#if awardsResult?has_content && awardsResult.countyId?has_content>
                            $("#countyId").val(${(awardsResult.countyId)!});
                            </#if>
                        }else{
                            cleanSelectContent("countyId", "-- 选择县/区 --");
                        }
                    }
                });
            }else{
                $('#countyId').empty();
                cleanSelectContent("countyId", "-- 选择县/区 --");
            }
        });

    
        //var region = new Region('#province', '#city', '#county');
       
        <#if awardsResult?has_content && awardsResult.provinceId?has_content>
            $("#provinceId").val(${awardsResult.provinceId});
            $("#provinceId").trigger('change');
        </#if>

        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (data.result == "success") {
                    location.href = "list";
                }
            }
        });

        Form.Rules.add({
            name : 'mobile',
            msg : '不是有效的手机号码！',
            validator : function(value,baseValue,formatMsg){
                var regexp = new RegExp("^(1[0-9][0-9]{9})$")
                if(value && !regexp.test(value)){
                    return formatMsg;
                }
            }
        });

        Form.Rules.add({
            name : 'postCode',
            msg : '不是有效的邮编号码！',
            validator : function(value,baseValue,formatMsg){
                var regexp = new RegExp("^[1-9]\\d{5}$");
                if(value && !regexp.test(value)){
                    return formatMsg;
                }
            }
        });

        form.on("beforesubmit", function(){
            return true;
        });

        form.render();
    });
    
    function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    }
</script>
</body>
</html>