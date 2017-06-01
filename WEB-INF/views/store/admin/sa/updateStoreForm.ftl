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
    <div class="content-body">
            <table cellspacing="0" class="table table-info">
                <tbody>
                	 <tr>
                    <th >姓名： </th>
                    <td>
                       ${(store.contacts)!?html}
                    </td>
                </tr>
                <tr>
                    <th >门店店名： </th>
                    <td>
                        ${(store.storeName)!?html}
                    </td>
                   
                </tr>
                <tr>
                    <th>门店类型： </th>
                    <td>
                    	<#if (store.storeTypeCd)?? && store.storeTypeCd==1>餐饮店</#if>
                    	<#if (store.storeTypeCd)?? && store.storeTypeCd==2>便利店</#if>
                    </td>
                </tr>
                <tr>
                    <th>创建日期： </th>
                    <td>
                    <#if (store.createTime)?? && store.createTime?has_content>	${store.createTime?string("yyyy-MM-dd HH:mm:ss")}</#if>
                    </td>
                </tr>
                  <tr>
                    <th>最后登录日期： </th>
                    <td>
                    	<#if store.lastLoginTime?? && store.lastLoginTime?has_content>${store.lastLoginTime?string("yyyy-MM-dd HH:mm:ss")}</#if>
                    	
                    </td>
                </tr>
                  <tr>
                    <th>最后登录IP： </th>
                    <td>
                    	<#if store.lastLoginIP?? && store.lastLoginIP?has_content>${store.lastLoginIP!}</#if>
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
	      </div>
	     </div>
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
                    app.page.open({
                        href:"/admin/sa/userStore/storeManageList?storeType="+data,
                        isClose: true,
                        reload: true
                    });
                }
            }
        });
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
    
       
    </script>
</body>
</html>