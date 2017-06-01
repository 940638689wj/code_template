<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/Validform_v5.3.2_min.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-body">
       <form id="J_Form11" class="form-horizontal" action="${ctx}/admin/sa/userStore/updateStoreIndroduce" method="post">
       		  <input type="hidden" id="storeId" name="storeId" value="${store.storeId}">
       		  <input type="hidden" name="mapLng" id="mapLng" value="${(store.mapLng)!?html}">
        	<input type="hidden" name="mapLat" id="mapLat" value="${(store.mapLat)!?html}">
       	   <table cellspacing="0" class="table table-info">
                <tbody>
               <tr>
                    <th><s style="color: red;padding-right: 5px;">*</s>用户名： </th>
                    <td>
                        <input value="${(store.userName)!?html}" name="userName" data-rules="{required:true}" class="input-normal control-text">
                    </td>
                </tr>
                 <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>门店店名： </th>
                    <td>
                        <input value="${(store.storeName)!?html}" name="storeName" data-rules="{required:true}" class="input-normal control-text">
                    </td>
                </tr>
                
                
                <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>门店类型： </th>
                    <td>
                    		   <#assign storeTypeCd = store.storeTypeCd?string />
                    	  <select name="storeTypeCd" id="storeOtherType" disabled="disabled">
                        	  <option value="">请选择</option>
                            <#if storeTypeList??>
                                <#list storeTypeList as storeType>
                                    <option <#if (storeTypeCd)?? && storeTypeCd==storeType.codeId>selected="selected"</#if> value="${storeType.codeId}">${(storeType.codeCnName)!?html}</option>
                                </#list>
                            </#if>
                        </select>
                        
                         <#if (orderStoreOperationLst?size > 0)>
                        	<div class="tips-wrap">
     			<div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                        <div class="tips-content">
                         已产生订单的门店，门店类型不可修改。
                        </div>
                    </div>
                </div>
                        	
                        </#if>
                    </td>
                </tr>
                  <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>姓名： </th>
                    <td>
                    	   <input value="${(store.contacts)!}" name="contacts" data-rules="{required:true}" class="input-normal control-text">
                    </td>
                </tr>
                
                  <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>手机： </th>
                    <td>
                    	      <input value="${(store.telephone)!}" name="telephone"
                         data-rules="{required:true,regexp:/^1[3|4|5|7|8]\d{9}$/}"  
                         data-messages="{regexp:'不是有效的手机'}" 
                         class="input-normal control-text">
                    </td>
                </tr>
                
                  <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>身份证号： </th>
                    <td>
                    	    <input value="${(store.identityNum)!}" name="identityNum"
                          datatype="validateIdCardCode"  nullmsg="请输入身份证号!" errormsg="身份证号格式不对!"
                         class="input-normal control-text">
                    </td>
                </tr>
              
                <tr id="saleRatecontrol">
                    <th >售货佣金： </th>
                    <td>
                    	 扣除佣金比例<input value="${(store.saleCommRate)?default('0')}" data-rules="{required:true,min:0,max:100,number:true}" name="saleCommRate" class="input-small control-text">%
                    </td>
                </tr>
                 
	                    <tr id="sendRatecontrol"  <#if store?? && store.storeTypeCd?? && store.storeTypeCd == 1>style="display: none;"<#else></#if>>
		                    <th >配送佣金： </th>
		                    <td>
		                    	  扣除佣金比例<input value="${(store.sendCommRate)?default('0')}" data-rules="{required:true,min:0,max:100,number:true}" name="sendCommRate" class="input-small control-text">%
		                    </td>
	                	</tr>
                	
                <tr>
                    <th><s style="color: red;padding-right: 5px;">*</s>地区： </th>
                    <td>
                         <select name="countyId" id="selectProvince" datatype="validateAddress" nullmsg="请选择所在区/县!" errormsg="请选择所在区/县!"  class="span3">
			            <option value="">区/县</option>
			            <#if countyList?? && countyList?has_content>
			                <#list countyList as county>
			                    <option <#if (store.countyId)?? && store.countyId==county.id>selected="selected"</#if> value="${(county.id)!}">${(county.areaName)!}</option>
			                </#list>
			            </#if>
			        </select>
			        <select name="townId" id="selectCity"  class="span3" datatype="validateAddress" nullmsg="请选择所在街道/镇!" errormsg="请选择所在街道/镇!">
			            <option value="">街道/镇</option>
			            <#if townList?? && townList?has_content>
			                <#list townList as town>
			                    <option <#if (store.townId)?? && store.townId==town.id>selected="selected"</#if> value="${(town.id)!}">${(town.areaName)!}</option>
			                </#list>
			            </#if>
			        </select>
			        <select name="villageId" id="selectCountry" data-rules="{required:true}" class="span3">
			            <option value="">社区/村</option>
			            <#if villageList?? && villageList?has_content>
			                <#list villageList as village>
			                    <option <#if (store.villageId)?? && store.villageId==village.id>selected="selected"</#if> value="${(village.id)!}">${(village.areaName)!}</option>
			                </#list>
			            </#if>
			        </select>
                    </td>
                </tr>
                
                <tr>
                    <th><s style="color: red;padding-right: 5px;">*</s>地址：</th>
                    <td>
                       <input value="${(store.detailAddress)!}" data-rules="{required:true}"  name="detailAddress" id="detailAddress" class="input-large control-text">
                    </td>
                </tr>
               
                </tbody>
            </table>
            <div class="row">
                <div class="span13 offset3 ">
                        <button type="submit" class="button button-primary">保存</button>
                </div>
            </div>
        </form>
        
    </div>
</div>
</body>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
<script type="text/javascript">
 	 $(function(){
 	 	
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
                            cleanSelectContent("selectCity", "街道/镇");
                            cleanSelectContent("selectCountry", "社区/村");

                            $.each(data.rows, function(i, row){
                                $("#selectCity").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectCity", "街道/镇");
                            cleanSelectContent("selectCountry", "社区/村");
                        }
                    }
                });
            }else{
                $('#selectCity').empty();
                cleanSelectContent("selectCity", "街道/镇");
                cleanSelectContent("selectCountry", "社区/村");
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
                            cleanSelectContent("selectCountry", "社区/村");

                            $.each(data.rows, function(i, row){
                                $("#selectCountry").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectCountry", "社区/村");
                        }
                    }
                });
            }else{
                $('#selectCountry').empty();
                cleanSelectContent("selectCountry", "社区/村");
            }
        });

        $("#selectCountry").on('change', function(){
            $("#countryId").val($(this).val());
        });
        
         $("#storeOtherType").on('change', function(){
         	if($(this).val()==""){
         			$("#saleRatecontrol").hide();
         			$("#sendRatecontrol").hide();
             	
			}
         	if($(this).val()=="1"){
         			$("#saleRatecontrol").show();
         			$("#sendRatecontrol").hide();
             		
			}
			
			if($(this).val()=="2"){
				$("#saleRatecontrol").show();
         			$("#sendRatecontrol").show();
				
			}
            
        });
        
     

        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form11',
            submitType: 'ajax',
            callback: function (data) {
                if(data && data.result == "true"){
                	 app.showSuccess("保存成功!")
                    app.page.open({
                        href:"${ctx}/admin/sa/userStore/index",
                        isClose: true,
                        reload: true
                    })
                }else{
                	  BUI.Message.Alert(data.message);
                }
            }
        });
        
          //定位坐标
    	var destPoint = new BMap.Point(<#if (storeForm.lng)??>${storeForm.lng}<#else>102.877656</#if>,<#if (storeForm.lat)??>${storeForm.lat}<#else>35.179464</#if>);
        
        $("#J_Form11").Validform({
            datatype:{
                "validateAddress":function(gets,obj,curform,regxp){
                    /*参数gets是获取到的表单元素值，
                      obj为当前表单元素，
                      curform为当前验证的表单，
                      regxp为内置的一些正则表达式的引用。*/

                    if(gets && gets != ""){
                        return true;
                    }

                    <#--if(obj.attr('name')=="county"){
                        alert(obj.find('option').length);
                    }-->

                    return false;
                },
                "validateAddressCounty":function(gets,obj,curform,regxp){
                    var countyOptionCount = obj.find('option').size();
                    if(countyOptionCount > 1 && gets == ""){
                        return false;
                    }
                    return true;
                },
                "validateIdCardCode":function(gets,obj,curform,regxp){
                	 var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
					  if(reg.test(gets) === false) {
					        return false;
					  }
                    
                    return true;
                }
            }
        });

        form.on('beforesubmit', function(){
            <#--门店所在地区:省市-->
            var province=$('#province').val();
            var city=$('#city').val();
            if(province == ""){
                BUI.Message.Alert("请选择门店所在区/县");
                return false;
            }
            if(city == ""){
                BUI.Message.Alert("请选择门店所在街道/镇");
                return false;
            }

            $('#lat').val(destPoint.lat);
            $('#lng').val(destPoint.lng);
            $("#storeOtherType").removeAttr("disabled"); 
            return true;
        });

        form.render();
        
         /**开始处理百度地图**/
        var locationAddress = "${(store.detailAddress)!}";
        var map = new BMap.Map("map");
        map.centerAndZoom(destPoint, <#if (store.lat)?? && (store.lng)??>15<#else>5</#if>);//初始化地图
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
                BUI.Message.Alert("marker click");
                destPoint = data.target.getPosition(0);
            });
        }
        function callback(posi){
            for(var i=0;i<posi.length;i++){
                if(i==0){
                    destPoint = posi[0].point;
                }
                posi[i].marker.addEventListener("click", function(data){
                    destPoint = data.target.getPosition(0);
                });
            }
        }
      
        $("#locate-btn").click(function(){
            local = new BMap.LocalSearch(map, { //智能搜索
                renderOptions:{map: map}
            });
            local.setMarkersSetCallback();
            local.search($("#locationAddress").val());
            
			var point=map.getCenter();
			var longitude = point.lng;  
			var latitude = point.lat;  
            $("#mapLng").val(longitude);
			$("#mapLat").val(latitude); //获取经度和纬度，将结果显示在文本框中
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