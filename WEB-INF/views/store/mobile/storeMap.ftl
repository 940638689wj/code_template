<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>门店位置</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/module.css" />-->
    <link rel="stylesheet" type="text/css" href="${staticPath}css/storeinstore.css" />
    <!--<script type="text/javascript" src="${staticPath}js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}js/jquery.unveil.js"></script>-->
    <script type="text/javascript" src="${staticPath}js/rateit.js"></script>
          <style>
        #map{
            width: 358px;
            height: 360px;
        }
    </style>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">门店位置</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

         <div class="control-group">
                    <div class="controls">
                        <input value="" name="locationAddress" id="locationAddress" type="text" class="input-large control-text">
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls control-row-auto">
                        <div id="map">
                        </div>
                    </div>
                </div>
     <div class="mui-content">
            <div class="in-header in-storeheader">
                <div class="hd">
                    <div class="info">
                        <h3>${(store.storeName)!}</h3>
                        <p>店铺编号${(store.storeNumber)!}</p>
                    </div>
                </div>
            </div>
            <div class="borderbox">
                <ul class="store-contact">
                    <li><span class="address"></span><p>${(store.provinceName)!}${(store.cityName)!}${(store.countyName)!}${(store.detailAddress)!}</p></li>
                    <li><a href="tel:${(store.telephone)!'0'}"><span class="tell"></span><p>${(store.telephone)!}</p></a></li>
                    <li>营业时间：8:00-23:00</li>
                </ul>
            </div>
    </div>
   </div> 
    <script type="text/javascript" src="${ctx}/static/admin/js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=QQrTioIKwTyMP2CihUoKbEbU"></script>
	<script>
     $(function(){ 
		var normalStoreCountStr='';
   		var chainStoreCountStr='';
 		//地图显示的坐标
   	 	var destPoint = new BMap.Point(<#if (store.mapLng)??>${store.mapLng}<#else>102.877656</#if>,<#if (store.mapLlat)??>${store.mapLat}<#else>35.179464</#if>);
	
	 /**开始处理百度地图**/
        var locationAddress = "${(store.provinceName)!?html}${(store.cityName)!?html}${(store.detailAddress)!?html}";
        var map = new BMap.Map("map"); //创建地图实例
        map.centerAndZoom(destPoint,11);//初始化地图
        map.enableScrollWheelZoom();
        
        map.addControl(new BMap.NavigationControl());
        map.addControl(new BMap.ScaleControl());
        var marker = new BMap.Marker(destPoint);
        map.addOverlay(marker);//添加标注
        
        var local= new BMap.LocalSearch(map,{
       		 renderOptions:{map:map,panel:"result"}
        });
        local.search(locationAddress);
        
        map.addEventListener("click", function(e){
                 destPoint = e.point;
                 map.clearOverlays();
                 var marker1 = new BMap.Marker(destPoint);  // 创建标注
                 map.addOverlay(marker1);
        });
        
        var ac = new BMap.Autocomplete(//建立一个自动完成的对象
                {"input" : "locationAddress"
                    ,"location" : map
                });
                
        ac.addEventListener("onhighlight", function(e) {
            ac.setInputValue(e.toitem.value.business);
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