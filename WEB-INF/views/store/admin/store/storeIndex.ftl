<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
   <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=QQrTioIKwTyMP2CihUoKbEbU"></script>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="${ctx}/static/admin/js/Validform_v5.3.2_min.js" type="text/javascript"></script>

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
	 <div class="title-bar">
        <div id="tab"></div>
        <div class="tips-content">
             	提示：如联系方式或地址等信息变更请务必及时与平台客服联系更改。
            </div>
    </div>
	
	<div class="content-top">
      <div class="userinfo-box">
            <div class="pic"><img src="${staticPath}/admin/images/store.png"  width="100" height="100"></div>
               <div class="con">
                <ul>
                    <li>门店编号：${(store.storeId)!}</li>
                </ul>
                 <ul>
                    <li>门店名称： ${(store.storeName)!?html}</li>
                </ul>
                 <ul>
                    <li>门店类型：	<#if (store.storeTypeCd)?? && store.storeTypeCd==1>餐饮店</#if>
                    		<#if (store.storeTypeCd)?? && store.storeTypeCd==2>便利店</#if></li>
                </ul>
                 <ul>
                    <li>账号：${(store.userName)!?html}</li>
                </ul>
            </div>
     </div>
    </div>

<div class="content-body">
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/store/updateStoreForm" method="post">
        <input type="hidden" name="storeId" value="${(store.storeId)!}"/>
        <input type="hidden" name="mapLng" id="mapLng" value="${(store.mapLng)!?html}">
        <input type="hidden" name="mapLat" id="mapLat" value="${(store.mapLat)!?html}">
          <table cellspacing="0" class="table table-info">
                <tbody>
                <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>门店名称： </th>
                    <td>
                        <input value="${(store.storeName)!?html}" name="storeName" data-rules="{required:true}" class="input-normal control-text">
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>门店编号：</th>
                    <td>
                            ${(store.storeId)!}
                    </td>
                </tr>
                
                 <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>联系方式： </th>
                    <td>
                            ${(store.telephone)!}
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>姓名：</th>
                    <td>
                           ${(store.contacts)!}
                    </td>
                </tr>
                
                    <tr>
                    <th ><s style="color: red;padding-right: 5px;">*</s>地区： </th>
                    <td>
                             	莆田市&nbsp;&nbsp;   ${(store.countyName)!}&nbsp;&nbsp;${(store.townName)!}&nbsp;&nbsp;${(store.villageName)!}&nbsp;&nbsp; ${(store.detailAddress)!}
                    </td>
                    <th><s style="color: red;padding-right: 5px;">*</s>地址：</th>
                    <td>
                           ${(store.detailAddress)!}
                    </td>
                </tr>
                
                <tr>
                    <th >加入时间： </th>
                    <td>
                           ${(store.createTime)?string('yyyy-MM-dd HH:mm:ss')}
                    </td>
                    <th>门店类型：</th>
                    <td>
                          	<#if (store.storeTypeCd)?? && store.storeTypeCd==1>餐饮店</#if>
                    		<#if (store.storeTypeCd)?? && store.storeTypeCd==2>便利店</#if>
                    </td>
                </tr>
                
                </tbody>
            </table>
                   <div class="control-group">
                <label class="control-label" style="width: 50px;">定位：</label>
                <div class="controls">
                    <input value="${(store.detailAddress)!?html}" name="detailAddress" id="detailAddress" type="text" class="input-large control-text">
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
                <button type="submit" id="save" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
	
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'门店资料',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt('0'));
    
  
	
	
    //定位坐标
    var destPoint = new BMap.Point(<#if (store.lng)??>${store.lng}<#else>102.877656</#if>,<#if (store.lat)??>${store.lat}<#else>35.179464</#if>);

    $(function(){
    	 
        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!")
                   
                }
                
                //2.数据返回,延迟打开提交按钮,避免重复显示提示信息！
               	setTimeout("remainTime()",1000);
            }
        });
        
       

        form.on('beforesubmit', function(){
        	 //1.提交时，屏蔽提交按钮避免重复提交！
            btn=document.getElementById('save');
			btn.disabled=true;
            $('#lat').val(destPoint.lat);
            $('#lng').val(destPoint.lng);
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
                {"input" : "detailAddress"
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
        $("#detailAddress").keyup(function(event){
            if(event.which == 13){
                $("#locate-btn").click();
            }
        });
        $("#locate-btn").click(function(){
            if($("#detailAddress").val() == ""){
                BUI.Message.Alert("请输入门店地址!");
                return ;
            }
            $("#locate-btn").attr("disabled","disabled");
            local = new BMap.LocalSearch(map, { //智能搜索
                renderOptions:{map: map}
            });
            local.setMarkersSetCallback();
            local.search($("#detailAddress").val());
            
			var point=map.getCenter();
			var longitude = point.lng;  
			var latitude = point.lat;  
            $("#mapLng").val(longitude);
			$("#mapLat").val(latitude); //获取经度和纬度，将结果显示在文本框中
            $("#locate-btn").removeAttr("disabled");
            return false;
        });
        /**结束百度地图处理**/
    });
	
    function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    }
    
    //延时启用保存按钮 
    function remainTime(){
    		//打开提交按钮
        	btn=document.getElementById('save');
			btn.disabled=false;
    }
</script>
</body>
</html>