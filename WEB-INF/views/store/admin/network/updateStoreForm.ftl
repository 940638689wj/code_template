<#assign ctx = request.contextPath>

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <style>
        #map{
            width: 580px;
            height: 300px;
            margin-top: 40px;
            margin-left: 50px;
        }
    </style>
   
</head>
<body>
	<div class="container">
	    <div class="title-bar">
	        <div id="tab"></div>
	    </div>
	    <div class="content-top">
        <div class="title-text">门店信息</div>
        <div class="userinfo-box">
            <div class="pic"><img src="<#if (store.storeLogoUrl)??>${store.storeLogoUrl}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100"></div>
            <div class="code"><img src="${ctx}/admin/network/userStore/getQrImg?storeId=${store.storeId}"  width="100" height="100"></div>
            <ul>
                <li>门店编码：${(store.storeNumber)!?html}</li>
                <li>门店名称：${(store.storeName)!?html}</li>
                <li>注册时间：${(store.createTime)?string("yyyy-MM-dd HH:mm:ss ")}</li>
            </ul>
        </div>
    </div>
    <div class="content-body">
        <form id="J_Form" class="form-horizontal" action="${ctx}/admin/network/userStore/updateStoreForm" method="post">
            <table cellspacing="0" class="table table-info">
                <tbody>
                <input type="hidden" value="${(store.storeId)!?html}" name="storeId" class="input-normal control-text">
                <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>门店名称： </th>
                    <td>
                        <input value="${(store.storeName)!?html}" name="storeName" data-rules="{required:true}" class="input-normal control-text">
                    </td>
                    <th>外部编码：</th>
                    <td>
                        <input value="${(store.outId)!?html}" name="outId"  class="input-small control-text">
                    </td>
                </tr>
                <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>门店类型： </th>
                    <td>
                        <label><input type="radio" name="storeTypeCd" value="2" data-rules="{required:true}" <#if (store.storeTypeCd)?? && store.storeTypeCd==2>checked="on"</#if>>渠道店</label>
                        <label><input type="radio" name="storeTypeCd" value="3" data-rules="{required:true}" <#if (store.storeTypeCd)?? && store.storeTypeCd==3>checked="on"</#if>>加盟店</label>
                    </td>
                    <th>门店属性：</th>
                    <td>
                        <select name="storePropertyCd" id="storePropertyCd" >
                            <#if storeAttrList??>
                            <#assign selectedStoreOtherTypeId = (store.storePropertyCd)?default(-1)/>
                                <#list storeAttrList as item>
                                <#assign selectedStoreOtherTypeId = item.codeId/>
                                    <option value="${item.codeId}" <#if item.codeId == selectedStoreOtherTypeId>selected="selected" </#if>>${(item.codeCnName)!?html}</option>
                                </#list>
                            </#if>
                        </select>
                    </td>
                </tr>
				<tr>
                    <th><s style="color: red;padding-right: 5px;">*</s>联系人： </th>
                    <td>
                        <input value="${(store.contacts)!?html}" name="contacts" data-rules="{required:true}" class="input-normal control-text">
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>门店电话：</th>
                    <td>
                        <input value="${(store.telephone)!?html}" name="telephone" data-rules="{required:true}  class="input-small control-text">
                    </td>
                </tr>
                
                <tr>
                    <th>备用联系电话： </th>
                    <td>
                        <input value="${(store.spareTelephone)!?html}" name="spareTelephone"  class="input-normal control-text">
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>门店状态：</th>
                    <td>
                   		<label><input type="radio" name="statusCd" <#if (store.statusCd)?? && (store.statusCd)==1>checked</#if> value="1">启用</label>
                        <label><input type="radio" name="statusCd" <#if (store.statusCd)?? && (store.statusCd)==0>checked</#if> value="0">冻结</label>
                    </td>
                </tr>
             	
             	<tr>
                    <th>开户行： </th>
                    <td>
                        <input value="${(store.bank)!?html}" name="bank" class="input-normal control-text">
                    </td>
                    <th>开户名：</th>
                    <td>
                        <input value="${(store.accountName)!?html}" name="accountName"  class="input-small control-text">
                    </td>
                </tr>
                <tr>
                    <th>银行账号： </th>
                    <td>
                        <input value="${(store.accountNo)!?html}" name="accountNo" class="input-normal control-text">
                    </td>
                    <th>经销商编码：</th>
                    <td>
                        <input value="${(store.dealerNum)!?html}" name="dealerNum"  class="input-small control-text">
                    </td>
                </tr>
                
                <tr>
                
                <th>累计配送金额： </th>
                    <td>
                        <input value="${(store.serviceTotal)!}" name="" disabled="disabled" class="input-normal control-text">
                    </td>
                
                 <!--   <th>大区： </th>
                    <td>
                        <select name="regionId" id="regionId" class="span5">
			            <option value="">-- 选择大区 --</option>
			           		<#if orgList??>
                                <#list orgList as item>
                                    <option value="${item.orgId}" <#if store.regionId??><#if (store.regionId) == item.orgId>selected="selected" </#if></#if> >${(item.orgFullName)!?html}</option>
                                </#list>
                            </#if>
				        </select>
                    </td> -->
                    <th>经销商名称：</th>
                    <td>
                        <input value="${(store.dealerName)!?html}" name="dealerName"  class="input-small control-text">
                    </td>
                </tr>
                
             <!--   <tr>
                    <th>所属分公司： </th>
                    <td>
                        <select name="branchId" id="branchId" class="span5">
			            <option value="">-- 选择分公司 --</option>
			            	<#if branchList??>
                                <#list branchList as item>
                                    <option value="${item.orgId}" <#if store.branchId??><#if (store.branchId) == item.orgId>selected="selected" </#if></#if> >${(item.orgFullName)!?html}</option>
                                </#list>
                            </#if>
			    		</select>
                    </td>
                    <th>所属办事处：</th>
                    <td>
                   		<select name="officeId" id="officeId" class="span5">
			            <option value="">-- 选择办事处--</option>
			            	<#if officeList??>
                                <#list officeList as item>
                                    <option value="${item.orgId}" <#if store.officeId??><#if (store.officeId) == item.orgId>selected="selected" </#if></#if> >${(item.orgFullName)!?html}</option>
                                </#list>
                            </#if>
                            </select>
                    </td>
                </tr> -->
                <tr>
                    <th>配送次数： </th>
                    <td>
                        <input value="${(store.deliveryTimes)!}" name="" disabled="disabled"  class="input-normal control-text">
                    </td>
                    <th>送达次数：</th>
                    <td>
                        <input value="${(store.serviceTimes)!}" name="" disabled="disabled" class="input-small control-text">
                    </td>
                </tr>
                <tr>
                    <th><s style="color: red;padding-right: 5px;">*</s>门店地址： </th>
                    <td>
                        <select name="selectProvince" id="selectProvince" class="span3">
			            <option value="">-- 选择省份 --</option>
			            <#if provinceList?? && provinceList?has_content>
			                <#list provinceList as item>
			                   <option value="${item.id}" <#if (store.provinceId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
			                </#list>
			            </#if>
				        </select>
				        <select name="selectCity" id="selectCity" class="span3">
				            <option value="">-- 选择城市 --</option>
				            <#if cityList?? && cityList?has_content>
			                <#list cityList as item>
			                   <option value="${item.id}" <#if (store.cityId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
			                </#list>
			            </#if>
				        </select>
				        <select name="selectCountry" id="selectCountry" class="span3">
				            <option value="">-- 选择县/区 --</option>
				            <#if countyList?? && countyList?has_content>
			                <#list countyList as item>
			                   <option value="${item.id}" <#if (store.countyId) == item.id>selected="selected" </#if>>${(item.areaName)!?html}</option>
			                </#list>
			            </#if>
				        </select>
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>详细地址：</th>
                    <td>
                        <input data-rules="{required:true}" value="${(store.detailAddress)!?html}" name="detailAddress"  class="input-normal control-text">
                    </td>
                </tr>
                
                <tr>
                    <th>发展会员数： </th>
                    <td>
                        <input value="${(store.deliveryTimes)!?html}" name="deliveryTimes" data-rules="{required:true}" class="input-normal control-text" disabled="disabled">
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>星级：</th>
                    <td>
                        <input data-rules="{required:true}" value="${(store.storeLevelId)!?html}" name="storeLevelId"  class="input-small control-text">
                    </td>
                </tr>
                <tr>
                    <th>备注： </th>
                    <td>
                        <input value="${(store.remark)!?html}" name="remark"  class="input-normal control-text">
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>允许自提： </th>
                    <td>
                        <select name="isSelf" id="isSelf" class="span3" data-rules="{required:true}">
			                    <option value="1" <#if (store.isSelf)?? && store.isSelf==true>selected="selected"</#if>>是</option>
			                    <option value="0" <#if (store.isSelf)?? && store.isSelf==false>selected="selected"</#if>>否</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><s style="color: red;padding-right: 5px;">*</s>经度： </th>
                    <td>
                        <input data-rules="{required:true}" value="${(store.mapLng)!?html}" name="mapLng" id="mapLng" data-rules="{required:true}" class="input-normal control-text" >
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>纬度：</th>
                    <td>
                        <input data-rules="{required:true}" value="${(store.mapLat)!?html}" name="mapLat" id="mapLat"  class="input-small control-text" >
                    </td>
                </tr>
             			
                </tbody>
                
                </table>
                <div class="control-group">
                <label class="control-label" style="width: 50px;">定位：</label>
                <div class="controls">
                    <input value="${(store.detailAddress)!?html}" name="locationAddress" id="locationAddress" type="text" class="input-large control-text">
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
	            <div class="actions-bar">
		            <div class="form-actions">
		               
		                <button type="submit" class="button button-primary">保存</button>
		                <button type="reset" class="button">重置</button>
		            </div>
	        	</div>
        </form>

    <script type="text/javascript" src="${staticPath}/admin/js/jquery.regionMgr.js"></script>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=QQrTioIKwTyMP2CihUoKbEbU"></script>
    <script type="text/javascript">
	//定位坐标
    var destPoint = new BMap.Point(<#if (store.mapLng)??>${store.mapLng}<#else>102.877656</#if>,<#if (store.mapLlat)??>${store.mapLat}<#else>35.179464</#if>);
	
	
    $(function(){
    	 var Form = BUI.Form
         var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
             if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
            }
        });
        //选择大区
    	$("#regionId").on('change',function(){
    		var regionId = $(this).val();
    		if(regionId && regionId != ''){
    			$.ajax({
    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'GET',
    				data : {parentId : regionId },
    				success : function (data){
    					data=JSON.parse(data);
    					if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("branchId", "-- 选择分公司 --");
                            cleanSelectContent("officeId", "-- 选择办事处 --");
							
                            $.each(data.rows, function(i, row){
                                $("#branchId").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }else{
                            cleanSelectContent("branchId", "-- 选择城市 --");
                            cleanSelectContent("officeId", "-- 选择办事处 --");
                        }
    				}
    			});
    		}else{
    			$('#branchId').empty();
               	cleanSelectContent("branchId", "-- 选择城市 --");
                cleanSelectContent("officeId", "-- 选择办事处 --");
    		}
    	
    	});
    	//选择分公司
    	$("#branchId").on('change',function(){
    		var branchId = $('#branchId').val();
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'GET',
    				data : {parentId : branchId },
    				success : function (data){
    				data=JSON.parse(data);
    					if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("officeId", "-- 选择办事处 --");

                            $.each(data.rows, function(i, row){
                                $("#officeId").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }else{
                            cleanSelectContent("officeId", "-- 选择办事处 --");
                        }
    				}
    			});
    		}else{
    			$('#officeId').empty();
                cleanSelectContent("officeId", "-- 选择县/区 --");
    		}
    	
    	});
    	
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
                    url : '${ctx}/admin/network/common/area/findChildByParentId',
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

            $('#maplat').val(destPoint.lat);
            $('#maplng').val(destPoint.lng);
            return true;
        });

        form.render();


   


        /**开始处理百度地图**/
        var locationAddress = "${(store.detailAddress)!}";
        var map = new BMap.Map("map");
        map.centerAndZoom(destPoint, <#if (store.mapLat)?? && (store.mapLng)??>15<#else>5</#if>);//初始化地图
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