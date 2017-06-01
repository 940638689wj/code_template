<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
   <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=QQrTioIKwTyMP2CihUoKbEbU"></script>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>

    <style>
        #map{
            width: 580px;
            height: 300px;
            margin-top: 40px;
            margin-left: 100px;
        }
    </style>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <#--<li>
            <a href="javascript:void(0);" onclick="history.go(-1)">返回列表</a>
            <span class="divider">&gt;&gt;</span>
        </li>-->
        <li class="active">新增门店</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/network/userStore/saveStoreForm" method="post">
        <input type="hidden" name="archived" value="N">
        <input type="hidden" name="storeId" value="${(storeForm.storeId)!}"/>
        <input type="hidden" name="storeAccountId" value="${(storeForm.storeAccountId)!}"/>
        <#--<input type="hidden" name="defaultParentStoreId" value="${parentId!}"/>-->

        <div id="edit_store_detail_div" class="form-content">
            <div class="row">
 				
 				<div class="control-group">
                    <label class="control-label">门店类型：</label>
                    <div class="controls">
                        <select name="storeOtherType" id="storeOtherType" >
                            <#if storeTypeList??>
                                <#list storeTypeList as storeTypeList>
                                	<#if storeTypeList.codeId!='1'>
                                    <option value="${storeTypeList.codeId}">${(storeTypeList.codeCnName)!?html}</option>
                                	</#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">门店属性：</label>
                    <div class="controls">
                        <select name="storePropertyCd" id="storePropertyCd" >
                            <#if storeAttrList??>
                                <#list storeAttrList as storeAttrList>
                                    <option value="${storeAttrList.codeId}">${(storeAttrList.codeCnName)!?html}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label"><s>*</s>门店编号：</label>
                    <div class="controls">
                        <input value="${(storeForm.storeNumber)!?html}" name="storeNumber" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
 				
 				
                <div class="control-group">
                    <label class="control-label"><s>*</s>门店名称：</label>
                    <div class="controls">
                        <input value="${(storeForm.storeName)!?html}" name="storeName" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"><s>*</s>联系人：</label>
                    <div class="controls">
                        <input value="${(storeForm.storeContact)!}" name="storeContact" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>门店电话：</label>
                    <div class="controls">
                        <input value="${(storeForm.telephone)!}" name="telephone" data-rules="{required:true,mobile:true}" class="input-normal control-text">
                    </div>
                    <label class="control-label">备用电话：</label>
                    <div class="controls">
                        <input value="${(storeForm.spareTelephone)!}" name="spareTelephone"  class="input-normal control-text">
                    </div>
                </div>
                
         <div class="control-group">
                    <label class="control-label">所属大区：</label>&nbsp;&nbsp;
              <select name="regionId" id="regionId" class="span4" <#if org.orgLevelCd gt 0>disabled</#if> >
	            <option value="">-- 大区选择 --</option>
	            <#if org.orgLevelCd==3>
	            <option value="${(parent1.orgId)!}" selected="selected" >${(parent1.orgFullName)!}</option>
	            <#elseif org.orgLevelCd==2>
	            <option value="${(parent.orgId)!}" selected="selected" >${(parent.orgFullName)!}</option>
	            <#elseif org.orgLevelCd==1>
	            <option value="${(org.orgId)!}" selected="selected" >${(org.orgFullName)!}</option>
	            <#else>
	            <#if orgList?? && orgList?has_content>
	                <#list orgList as item>
	                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
	                </#list>
	            </#if>
	            </#if>
	        </select>
                </div>
                
                 <div class="control-group">
                    <label class="control-label">所属分公司：</label>&nbsp;&nbsp;
              <select name="branchId" id="branchId" class="span4" <#if org.orgLevelCd gt 1>disabled</#if> >
	            <option value="">-- 分公司选择 --</option>
	            <#if org.orgLevelCd == 1>
	            <#list list as item>
	             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
	            </#list>
	            <#elseif org.orgLevelCd == 2>
	             <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
	           	 <#elseif org.orgLevelCd == 3>
	           	 <option value="${(parent.orgId)!}" selected="selected"  >${(parent.orgFullName)!}</option>
	            </#if>
	        </select>
                 </div>
                 
                 <div class="control-group">
                    <label class="control-label">所属办事处：</label>&nbsp;&nbsp;
                    <select name="officeId" id="officeId" class="span4" <#if org.orgLevelCd gt 2>disabled</#if>>
			            <option value="">-- 办事处选择 --</option>
			            <#if org.orgLevelCd == 2>
			            <#list list as item>
			             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
			            </#list>
			            <#elseif org.orgLevelCd == 3>
			            <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
			            </#if>
	       			 </select>
                </div> 
                
                <div class="control-group">
                    <label class="control-label">备注：</label>
                    <div class="controls control-row-auto">
                        <textarea name="remark" style="width:370px;height: 60px;">${(storeForm.remark)!}</textarea>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">开户行：</label>
                    <div class="controls">
                        <input value="${(storeForm.bank)!}" name="bank" class="input-normal control-text">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">开户名：</label>
                    <div class="controls">
                        <input value="${(storeForm.accountName)!}" name="accountName" class="input-normal control-text">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">银行账号：</label>
                    <div class="controls">
                        <input value="${(storeForm.accountNo)!}" name="accountNo" class="input-normal control-text">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">经销商编码：</label>
                    <div class="controls">
                        <input value="${(storeForm.dealerNum)!}" name="dealerNum" class="input-normal control-text">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">经销商名称：</label>
                    <div class="controls">
                        <input value="${(storeForm.dealerName)!}" name="dealerName" class="input-normal control-text">
                    </div>
                </div>
                
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">门店状态：</label>
                        <div class="controls">
                            <label class="radio">
                                <input type="radio"  name="storeState" value="1"/>启用
                            </label>
                            &nbsp;&nbsp;
                            <label class="radio">
                                <input type="radio" name="storeState" value="0"/>冻结
                            </label>
                        </div>
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">允许自提：</label>
                        <div class="controls">
                            <label class="radio">
                                <input type="radio"  name="isSelf" value="1"/>是
                            </label>
                            &nbsp;&nbsp;
                            <label class="radio">
                                <input type="radio" name="isSelf" value="0" checked/>否
                            </label>
                        </div>
                    </div>
                </div>
                
               	<div class="control-group">
                 	<label class="control-label"><s>*</s>门店所在地区：</label>&nbsp;&nbsp;
			        <select name="selectProvince" id="selectProvince"  class="span3">
			            <option value="">-- 选择省份 --</option>
			            <#if provinceList?? && provinceList?has_content>
			                <#list provinceList as province>
			                    <option value="${(province.id)!}">${(province.areaName)!}</option>
			                </#list>
			            </#if>
			        </select>
			        <select name="selectCity" id="selectCity"  class="span3">
			            <option value="">-- 选择城市 --</option>
			        </select>
			        <select name="selectCountry" id="selectCountry" data-rules="{required:true}" class="span3">
			            <option value="">-- 选择县/区 --</option>
			        </select>
		   		 </div>

                <div class="control-group">
                    <label class="control-label">详细地址：</label>
                    <div class="controls">
                        <input value="${(storeForm.detailAddress)!}" data-rules="{required:true}" name="detailAddress" class="input-large control-text">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label"><s>*</s>经度：</label>
                    <div class="controls">
                        <input value="${(storeForm.mapLng)!?html}" name="mapLng" id="mapLng" data-rules="{required:true}" type="text" class="input-normal control-text">
                    </div>
                    <label class="control-label"><s>*</s>纬度：</label>
                    <div class="controls">
                        <input value="${(storeForm.mapLat)!?html}" name="mapLat" id="mapLat" data-rules="{required:true}" type="text" class="input-normal control-text">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">定位：</label>
                    <div class="controls">
                        <input value="${(storeForm.detailAddress)!?html}" name="locationAddress" id="locationAddress" type="text" class="input-large control-text">
                        <a id="locate-btn" class="button">定位</a>
                        <p style="padding:1px;margin: 1px">输入地址后，点击“自动定位”按钮可以在地图上定位。</p>
                        <p style="padding:1px;margin: 1px">（如果输入地址后无法定位，请在地图上直接点击选择地点）</p>
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls control-row-auto">
                        <div id="map">

                        </div>
                    </div>
                </div>

            </div>
        </div>

        <hr/>
            
        <div class="actions-bar">
            <div class="form-actions">
               
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">

    var normalStoreCountStr='${normalStoreCountStr!}';
    var chainStoreCountStr='${chainStoreCountStr!}';

    //定位坐标
    var destPoint = new BMap.Point(<#if (storeForm.lng)??>${storeForm.lng}<#else>102.877656</#if>,<#if (storeForm.lat)??>${storeForm.lat}<#else>35.179464</#if>);

    $(function(){
    
    	 $("#selectProvince").on('change', function(){
            var selectProvince = $(this).val();
            $("#provinceId").val(selectProvince);
            if(selectProvince && selectProvince != ""){
                $.ajax({
                    url : '${ctx}/admin/network/userStore/findChildByParentId',
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
                    url : '${ctx}/admin/network/userStore/findChildByParentId',
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
        
       //大区选择
	    $("#regionId").on('change',function(){
	    		var regionId = $(this).val();
	    		$('#branchId').empty();
	    		$("#branchId").append("<option value=''>-- 请选择 --</option>");
	    		$('#officeId').empty();
	    		$("#officeId").append("<option value=''>-- 请选择 --</option>");
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
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
    		$('#officeId').empty();
	    	$("#officeId").append("<option value=''>-- 请选择 --</option>");
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
    	
        $('#chainStore').click(function(){
//            if($(this).attr("checked")){
                $('#no').val(chainStoreCountStr);
                $('#storeAccount').val(chainStoreCountStr);
//            }else{
//                $('#no').val(normalStoreCountStr);
//            }
        });

        $('#normalStore').click(function(){
            $('#no').val(normalStoreCountStr);
            $('#storeAccount').val(normalStoreCountStr);
        });


        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!")
                    app.page.open({
                        href:"${ctx}/admin/network/userStore/storeManageList?storeType="+data,
                        isClose: true,
                        reload: true
                    })
                }
            }
        });

        form.on('beforesubmit', function(){
            if($("#defaultParentStoreId").val() == "-1"){
                BUI.Message.Alert("请选择所属上级");
                return false;
            }

            <#--门店所在地区:省市-->
            var province=$('#province').val();
            var city=$('#city').val();
            if(province == "-1"){
                BUI.Message.Alert("请选择门店所在省份");
                return false;
            }
            if(city == "-1"){
                BUI.Message.Alert("请选择门店所在城市");
                return false;
            }

            $('#lat').val(destPoint.lat);
            $('#lng').val(destPoint.lng);
            return true;
        });

        form.render();

        /**开始处理百度地图**/
        var locationAddress = "${(storeForm.detailAddress)!}";
        var map = new BMap.Map("map");
        map.centerAndZoom(destPoint, <#if (storeForm.lat)?? && (storeForm.lng)??>15<#else>5</#if>);//初始化地图
        map.enableScrollWheelZoom();
        map.addControl(new BMap.NavigationControl());
        var marker = new BMap.Marker(destPoint);
        map.addOverlay(marker);//添加标注

        map.addEventListener("click", function(e){
            if(confirm("确认选择这个位置？")){
                destPoint = e.point;
                
                $('#mapLng').val(destPoint.lng);
                $('#mapLat').val(destPoint.lat);
                map.clearOverlays();
                var marker1 = new BMap.Marker(destPoint);  // 创建标注
                map.addOverlay(marker1);
            }
        });

        var ac = new BMap.Autocomplete(//建立一个自动完成的对象
                {"input" : "locationAddress"
                    ,"location" : map
                });
        ac.addEventListener("onhighlight", function(e) {
            ac.setInputValue(e.toitem.value.business);
        });
        var myValue;
        ac.addEventListener("onconfirm", function(e) {//鼠标点击下拉列表后的事件
            var _value = e.item.value;
            myValue = _value.business;
            ac.setInputValue(myValue);
            setPlace();
        });
        ac.setInputValue(locationAddress);
        var local;
        function setPlace(){
            map.clearOverlays();    //清除地图上所有覆盖物
            local = new BMap.LocalSearch(map, { //智能搜索
                renderOptions:{map: map}
            });
            local.setMarkersSetCallback(callback);
            local.search(myValue);
        }

        function addEventListener(marker){
            marker.addEventListener("click", function(data){
                alert("marker click");
                destPoint = data.target.getPosition(0);
            });
        }
        function callback(posi){
            $("#locate-btn").removeAttr("disabled");
            for(var i=0;i<posi.length;i++){
                if(i==0){
                    destPoint = posi[0].point;
                }
                posi[i].marker.addEventListener("click", function(data){
                    destPoint = data.target.getPosition(0);
                });
            }
        }
        $("#locationAddress").keyup(function(event){
            if(event.which == 13){
                $("#locate-btn").click();
            }
        });
        $("#locate-btn").click(function(){
            if($("#locationAddress").val() == ""){
                alert("请输入门店地址!");
                return ;
            }
            $("#locate-btn").attr("disabled","disabled");
            local = new BMap.LocalSearch(map, { //智能搜索
                renderOptions:{map: map}
            });
            local.setMarkersSetCallback(callback);
            local.search($("#locationAddress").val());
            return false;
        });
        /**结束百度地图处理**/
    });
	
    function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    }
</script>
</body>
</html>