<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>我的奖品</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body class="page-login">
<#include "include/header.ftl"/>
<div id="page">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>我的钱包<span><em>_</em>我的奖品</span></h3></div>
                <div class="corder-tab">
                <ul id="awardType">
                    <li id="bigPan"><a href="javascript:gotoBigPan()">幸运大转盘</a></li>
                    <li id="boBing"><a href="javascript:gotoBoBing()">博饼游戏</a></li>
                    <li id="gGL"><a href="javascript:gotoGGL()">幸运刮刮乐</a></li>
                </ul>
            </div>
            <div class="handle">
                <span>处理状态：</span>
                <a href="javascript:findAll()" class="selected" id="all">全部</a>
                <a href="javascript:findReceived()"  id="received">已领取</a>
                <a href="javascript:findReceiving()" id="receiving">未领取</a>
            </div>
            <div class="center-list">
                <table class="orderdatatb orderdatatb2">
                    <thead  id="msg-title">
                    	<td class="td-tal">奖品</td>
                    	<!--td class="td-percent">领奖进度</td-->
                    	<!--td class="td-progress">已分享人数</td-->
                        <!--td class="td-itemPicUrl">分享游戏</td-->
                        <td class="td-status">状态</td>
                        <td class="td-operate">操作</td>
                    </thead>
                    <tbody id="msg-info">               
                   	       
                    </tbody>
                </table>
            </div>
            <input type="hidden" id="pageIndex" name="pageIndex" value="1">                
               <div class="pr-pager">
                <span class="total">共<span id="totalSize"></span>件奖品</span>
                <div class="pager" id="pager"></div>
            	</div>
            </div>    
        </div>
    </div>
</div>


<div id="newddress" class="hidden">
    <div class="reg-form">
    	<input type="hidden" id="awardsResultId">
        <ul>
            <li>
                <div class="hd">姓名</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="username"></div>
                </div>
            </li>
            <li>
                <div class="hd">所在地区</div>
                <div class="bd">
                   <select name="provinceId" id="selectProvince" class="span3">
			            
				    </select>
				    <select name="cityId" id="selectCity" class="span3">		
				           
				    </select>
				    <select name="countyId" id="selectCountry" class="span3">
				         
				     </select>
                </div>
            </li>
            <li>
                <div class="hd">街道</div>
                <div class="bd">
                    <textarea id="addr"></textarea>
                </div>
            </li>
            <li>
                <div class="hd">邮编</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="postCode"></div>
                </div>
            </li>
            <li>
                <div class="hd">手机号码</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="mobile"></div>
                </div>
            </li>
            <li>
                <div class="bd">
                    <a href="javascript:void(0);" class="btn-action addresssure">确定</a>
                </div>
            </li>
        </ul>
    </div>
</div>

<script>
	//页面加载完成后自动选择幸运大转盘下全部奖品
    $(function () {
        $("#menu_award").addClass("current");
        gotoBigPan();       
    });
    
  	function gotoBigPan(){
  		$("#bigPan").addClass("current").siblings().removeClass("current");
        $("#all").addClass("selected").siblings().removeClass("selected");
        $('.td-percent').hide();
		$('.td-progress').hide();
		$("#msg-info").empty();
  		$.ajax({
        	url:'${ctx}/account/userPromotion/findList',
        	type:'get',
        	data:{'awardTypeCd':1,'statusCd':-1},
        	success:function(data){
        		if(data  && data.result== "success"){
        			renderAwardsList(data);
                	renderPagerBottom(data.pageDTO);
        		}
        	}
        });
  	}
	
	function gotoBoBing(){
		$("#boBing").addClass("current").siblings().removeClass("current");
        $("#all").addClass("selected").siblings().removeClass("selected");
        $('.td-percent').hide();
		$('.td-progress').hide();
		$("#msg-info").empty();
		$.ajax({
        	url:'${ctx}/account/userPromotion/findList',
        	type:'get',
        	data:{'awardTypeCd':3,'statusCd':-1},
        	success:function(data){
        		if(data  && data.result== "success"){        			
        			renderAwardsList(data);//数据渲染到页面
        			renderPagerBottom(data.pageDTO);
        		}
        	}
        });
	}
	
	function gotoGGL(){
		$("#gGL").addClass("current").siblings().removeClass("current");
        $("#all").addClass("selected").siblings().removeClass("selected");
        $('.td-percent').show();
		$('.td-progress').show();
		$("#msg-info").empty();
		$.ajax({
        	url:'${ctx}/account/userPromotion/findList',
        	type:'get',
        	data:{'awardTypeCd':2,'statusCd':-1},
        	success:function(data){
        		if(data && data.result== "success"){
        			renderAwardsList(data);
                	renderPagerBottom(data.pageDTO);
        		}
        	}
        }); 
	}
	
	function renderAwardsList(data){
				var pageDTO=data.pageDTO;
				var awardsList=pageDTO.content;

				$("#msg-info").empty();//清空页面内容
				$("#totalSize").html(pageDTO.totalSize);//奖品总数
	
                var infos='';
                if(awardsList == null || awardsList == ""  || awardsList == undefined){
                	return;
                }
                for(var i=0;i<awardsList.length;i++){
                	var awardsResultId=awardsList[i].id;
                	var userId=awardsList[i].userId;
                	var status='';
                	var oper='';
                	var addr='';
                	var urls=awardsList[i].id;
                	var userId=awardsList[i].userId;
                	var awardsPercent=awardsList[i].collectProgress;
                	var awardsProgress=awardsList[i].progress ? awardsList[i].progress :0;
                	if(awardsList[i].winningTypeCd==4){//是物品
                		if(awardsList[i].awardTypeCd == 3){//是博饼
			               		if(awardsList[i].statusCd==0){//未领取状态
			                		status='未领取';
			                		oper='修改地址';
			                		addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td><td><a href="javascript:toGetInfo('+awardsResultId+','+userId+');" class="v-btn newaddressBtn">'+oper+'</a></td></tr>';
			                	}else if(awardsList[i].statusCd==1){
			                		status='已领取';
			               			oper='查看';
			                		addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td><td><a href="javascript:getInfo('+awardsResultId+');" class="v-btn">'+oper+'</a></td></tr>'
			               		}else{
			                		status='已过期';
			                		addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
			                	}
		                	}else if(awardsList[i].awardTypeCd==1){//大转盘
		                		if(awardsList[i].statusCd==0){//未领取状态
		                			status='未领取';
		                			oper='修改地址';		                			
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td><td><a href="javascript:toGetInfo('+awardsResultId+','+userId+');" class="v-btn newaddressBtn">'+oper+'</a></td></tr>';
		                		}else if(awardsList[i].statusCd==1){
		                			status='已领取';
		                			oper='查看';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td><td><a href="javascript:getInfo('+awardsResultId+');" class="v-btn">'+oper+'</a></td></tr>'
		                		}else{
		                			status='已过期';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
		                		}                		  
		                	}else if(awardsList[i].awardTypeCd==2){//是刮刮卡
		                		if(awardsList[i].statusCd==0){//未领取状态
		                			status='未领取';
		                			oper='修改地址';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td><td><a href="javascript:toGetInfo('+awardsResultId+','+userId+');" class="v-btn newaddressBtn">'+oper+'</a></td></tr>';
		                		}else if(awardsList[i].statusCd==1){
		                			status='已领取';
		                			oper='查看';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td><td><a href="javascript:getInfo('+awardsResultId+');" class="v-btn">'+oper+'</a></td></tr>'
		                		}else{
		                			status='已过期';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
		                		}
                		   }
                	   }else{//不是物品
	                	   	if(awardsList[i].awardTypeCd == 3){//博饼
	                			if(awardsList[i].statusCd==0){//未领取状态
			                		status='未领取';
	                		   		addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
	                		   	}else if(awardsList[i].statusCd==1){
			                		status='已领取';
			                		addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>'
			                	}else{
			                		status='已过期';
			                		addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
			                	}
			                }else if(awardsList[i].awardTypeCd == 1){//大转盘
                		   		if(awardsList[i].statusCd==0){//未领取状态
		                			status='未领取';
                		   			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
                		   		}else if(awardsList[i].statusCd==1){
		                			status='已领取';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>'
		                		}else{
		                			status='已过期';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
		                		} 
			                }else if(awardsList[i].awardTypeCd == 2){//刮刮卡
                		   		if(awardsList[i].statusCd==0){//未领取状态
		                			status='未领取';
                		   			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
                		   		}else if(awardsList[i].statusCd==1){
		                			status='已领取';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>'
		                		}else{
		                			status='已过期';
		                			addr+='<tr><td>'+awardsList[i].name+'</td><td>'+status+'</td></tr>';
		                		}
		                	}
                	  }           		
                	infos+=addr;
                }
            $("#msg-info").append(infos);
	}
	
	function renderPagerBottom(pageDTO){
            $('#pager').empty();
			
            if(pageDTO != undefined){
                var steps = 3;
                var page = pageDTO.page;
                var totalPages = pageDTO.totalPage;
                var startRangeIndex = page - steps;
                if(startRangeIndex < 1){
                    startRangeIndex = 1;
                }

                var endRangeIndex = page + steps;
                if(endRangeIndex >= totalPages){
                    endRangeIndex = totalPages;
                }

                if(page > 1){
                    $('#pager').append('<a href="javascript:goPage('+(page-1)+');">&lt;上一页</a>');
                }

                if(startRangeIndex > 1){
                    $('#pager').append('<a href="javascript:goPage(1);">1</a><a>...</a>');
                }

                for(var i=startRangeIndex;i<=endRangeIndex;i++){
                    if(i == page){
                        $('#pager').append('<a class="cur">'+page+'</a>');
                    }else if(i != 0){
                        $('#pager').append('<a href="javascript:goPage('+i+');">'+i+'</a>');
                    }
                }

                if(endRangeIndex < totalPages){
                    $('#pager').append('<a>...</a><a href="javascript:goPage('+totalPages+');">'+totalPages+'</a>');
                }

                if(page < totalPages){
                    $('#pager').append('<a href="javascript:goPage('+(page+1)+');">下一页&gt;</a>');
                }
            }
        }
        
        
        function goPage(pageNo){
        	submitSearchForm(pageNo);
        }
        
        function submitSearchForm(pageIndex){
        	loadAwardsList(pageIndex);
        }
        
        function loadAwardsList(pageIndex){
        	var awardType=$("#awardType li[class='current']").text();
			var awardTypeCd='';
			if(awardType=='幸运大转盘'){
				awardTypeCd=1;
			}else if(awardType=='博饼游戏'){
				awardTypeCd=3;
			}else if(awardType=='幸运刮刮乐'){
				awardTypeCd=2;
			}
			var status=$(".handle a[class='selected']").text();
			var statusCd='';
			if(status=='全部'){
				statusCd=-1;
			}else if(status=='已领取'){
				statusCd=1;
			}else if(status='未领取'){
				statusCd=0;
			}
			var pageNo=$("#pageIndex").val();
			if(pageIndex){
				pageNo=pageIndex;
				console.log(pageIndex);
			}
			
			$.ajax({
				url:'${ctx}/account/userPromotion/findList',
				type:'get',
				data:{'awardTypeCd':awardTypeCd,'statusCd':statusCd,pageNo:pageNo},
				success:function(data){
					if(data  && data.result== "success"){
						renderAwardsList(data);
						renderPagerBottom(data.pageDTO);
					}
				}
			});
        }
        
	
	
	
	
	function findAll(){
		$("#all").addClass("selected").siblings().removeClass("selected");
		$("#msg-info").empty();
		var awardType=$("#awardType li[class='current']").text();
		var awardTypeCd='';
		var toUrl='';
		if(awardType=='幸运大转盘'){
			awardTypeCd=1;
			toUrl='turn';
		}else if(awardType=='博饼游戏'){
			awardTypeCd=3;
			toUrl='boCake';
		}else if(awardType=='幸运刮刮乐'){
			awardTypeCd=2;
			toUrl='game';
		}
		$.ajax({
			url:'${ctx}/account/userPromotion/findList',
        	type:'get',
        	data:{'awardTypeCd':awardTypeCd,'statusCd':-1},
        	success:function(data){
        		if(data  && data.result== "success"){
        			renderAwardsList(data);
                	renderPagerBottom(data.pageDTO);
        		}
        	}
		});
	}
	
		function findReceived(){
		$("#received").addClass("selected").siblings().removeClass("selected");
		$("#msg-info").empty();
		var awardType=$("#awardType li[class='current']").text();
		var awardTypeCd='';
		var toUrl='';
		if(awardType=='幸运大转盘'){
			awardTypeCd=1;
			toUrl='turn';
		}else if(awardType=='博饼游戏'){
			awardTypeCd=3;
			toUrl='boCake';
		}else if(awardType=='幸运刮刮乐'){
			awardTypeCd=2;
			toUrl='game';
		}
		$.ajax({
			url:'${ctx}/account/userPromotion/findList',
        	type:'get',
        	data:{'awardTypeCd':awardTypeCd,'statusCd':1},
        	success:function(data){
        		if(data && data.result== "success"){
        			renderAwardsList(data);
                	renderPagerBottom(data.pageDTO);
        		}
        	}
		});
	}
    
    
    	function findReceiving(){
    	$("#receiving").addClass("selected").siblings().removeClass("selected");
		$("#msg-info").empty();
		var awardType=$("#awardType li[class='current']").text();
		var awardTypeCd='';
		var toUrl='';
		if(awardType=='幸运大转盘'){
			awardTypeCd=1;
			toUrl='turn';
		}else if(awardType=='博饼游戏'){
			awardTypeCd=3;
			toUrl='boCake';
		}else if(awardType=='幸运刮刮乐'){
			awardTypeCd=2;
			toUrl='game';
		}
		$.ajax({
			url:'${ctx}/account/userPromotion/findList',
        	type:'get',
        	data:{'awardTypeCd':awardTypeCd,'statusCd':0},
        	success:function(data){
        		if(data){
        			renderAwardsList(data);
                	renderPagerBottom(data.pageDTO);
        		}
        	}
		});
	}
    
    
    function getInfo(value){
    	location.href="${ctx}/account/userPromotion/getInfo?id="+value;
    }
    
    function toGetInfo(value1,value2){
    		emptyProvinceCityCountry();//初始化界面,清空下拉选
    		$("#awardsResultId").val(value1);
       		$.ajax({
       			type:'get',
       			url:'${ctx}/account/userPromotion/toGetInfo',
       			data:{'awardsResultId':value1,'userId':value2},
       			success:function(data){
       				if(data){
       					$("#username").val(data.receiverName);
       					$("#addr").val(data.address);
       					$("#postCode").val(data.postCode);
       					$("#mobile").val(data.mobile);
       					var str='请选择';
       					if(!data.nothing){
       						if(data.provinceList){
       						for(var i=0;i<data.provinceList.length;i++){
       							var selp=$("#selectProvince");
       							var pId=data.provinceList[i].id;       							 
       							if(data.provinceId==pId){
       								selp.append('<option selected="selected" value='+pId+'>'+data.provinceList[i].areaName+'</option>');
       							} else{
       								selp.append('<option value='+pId+'>'+data.provinceList[i].areaName+'</option>');
       							}         							    							
       						}       						      						
       					}

       					if(data.cityList){
       						for(var i=0;i<data.cityList.length;i++){       						
       							var selc=$("#selectCity");
       							var cId=data.cityList[i].id;
       							if(data.cityId==cId){
       								selc.append('<option selected="selected" value='+cId+'>'+data.cityList[i].areaName+'</option>');
       							}else{
       								selc.append('<option value='+cId+'>'+data.cityList[i].areaName+'</option>');
       							}	
       							
       						}
       					}
       					if(data.countyList){
       						for(var i=0;i<data.countyList.length;i++){
       							var selco=$("#selectCountry");
       							var coId=data.countyList[i].id;
       							if(data.countyId==coId){
       								selco.append('<option selected="selected" value='+coId+'>'+data.countyList[i].areaName+'</option>');
       							}else{
       								selco.append('<option value='+coId+'>'+data.countyList[i].areaName+'</option>');
       							}       							
       						}
       					}
       				}else{
       					var selp=$("#selectProvince");
       					selp.append('<option value="" selected="selected">'+str+'</option>');
       					for(var i=0;i<data.provinceList.length;i++){       						
       						var pId=data.provinceList[i].id;
       						selp.append('<option value='+pId+'>'+data.provinceList[i].areaName+'</option>');
       					}
       					var selc=$("#selectCity");
       					selc.append('<option value="" selected="selected">'+str+'</option>');
       					
       					var selco=$("#selectCountry");
       					selco.append('<option value="" selected="selected">'+str+'</option>');	
       					
       					
       				}
       					
       					
       				}
       			}
       		})
        	newaddress();
        }
        
        
        //选择改变事件
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


  function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    } 
        
        
        
           $(".mcmenu dt").on("click", function () {
            var parentMenu = $(this).parent();
            parentMenu.toggleClass("mcmenu-closed");
            if(parentMenu.hasClass("mcmenu-closed")){
                parentMenu.animate({
                    height : 40
                },{duration:200});
            }else{
                parentMenu.animate({
                    height : parentMenu.prop("scrollHeight")
                },{duration:200});
            }
        });

		
           	

        $(".addresssure").on("click",function(){//点击确定按钮关闭窗口并保存数据
        
        	//前期的处理
        	var username=$("#username").val();
            var provinceId=$("#selectProvince").val();
            var cityId=$("#selectCity").val();
            var countryId=$("#selectCountry").val();
            var address=$("#addr").val();
            var postCode=$("#postCode").val();
            var mobile=$("#mobile").val();
			var awardsResultId=$("#awardsResultId").val();
			
            if(!username){
            	layer.msg('请输入姓名!');
            	return;
            }
            if(!provinceId){
            	layer.msg('请选择省份!');
            	return;
            }
            if(!cityId){
            	layer.msg('请选择城市!');
            	return;
            }
            if(!countryId){
            	layer.msg('请选择区/县!');
            	return;
            }
            if(!address){
            	layer.msg('请输入详细地址!');
            	return;
            }
            if(!mobile){
            	layer.msg('请输入电话号码!');
            	return;
            }
            if(!(/^1[34578]\d{9}$/.test(mobile))){
            	layer.msg('请输入正确的电话号码!');
            	return;
            }
          	
           emptyProvinceCityCountry();
           layer.close(newAddress);

           
           //发送请求
           var params={'id':awardsResultId,'receiverName':username,'provinceId':provinceId,'cityId':cityId,'countyId':countryId,'address':address,'postCode':postCode,'mobile':mobile};

           $.ajax({
           		type:'POST',
           		url:'${ctx}/account/userPromotion/toUpdateInfo',
           		data:params,
           		success:function(data){
           			if(data.success=='success'){
           				layer.msg('修改成功!');
           			}else{
           				layer.msg('修改失败!');
           			}
           		}
           });
        });
		 //清空下拉选
		function emptyProvinceCityCountry(){			
            $("#selectCountry").empty();
            $("#selectCity").empty();
            $("#selectProvince").empty();
		}
		
        var newAddress;
        function newaddress(){
            newAddress = layer.open({
                type: 1,
                title: '修改地址',
                skin: 'layui-layer-rim',
                shade: [0.6],
                area: ['720px'],
                content: $("#newddress")
            });
        }
</script>
</body>
</html>