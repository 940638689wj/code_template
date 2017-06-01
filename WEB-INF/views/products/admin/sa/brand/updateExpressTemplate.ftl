<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="breadcrumb">
            <li><a href="${ctx}/admin/sa/brand/express_list" id ="backMain">运费模板</a> <span class="divider">&gt;&gt;</span></li>
            <li class="active">编辑运费模板</li>
        </ul>
    </div>
    <div class="content-body">
        <form id="newExpress_Form" class="form-horizontal" action="${ctx}/admin/sa/brand/updateExpressTemplateSave" method="post">
        <#list expressTemplateList as expressTemplate>
        <input type="hidden" name="templateId" value="${expressTemplate.templateId}">
            <div class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>运费模板名称：</label>
                        <div class="controls">
                            <input type="text" class="input-normal control-text" name="templateName" value="${expressTemplate.templateName!}">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>计价方式：</label>
                        <div class="controls">
                       	 按重量计算运费
                        </div>
                    </div>
                </div>
            </div>
            
            <table cellspacing="0" class="table table-bordered" id="calcTable">
                <tbody id="calcTableBody">
	                <tr>
	                    <th>运费计算方式</th>
	                    <th>首重（千克）</th>
	                    <th>首价（元）</th>
	                    <th>续重（千克）</th>
	                    <th>续价（元）</th>
	                </tr>
	                <tr id="CalcTableChild">
	                	<input type = "hidden" value = "0" name="areaId">
	                    <th>默认运费</th>
	                    <td><input type="text" class="input-normal control-text" name="firstValue_0" value="${expressTemplate.firstValue!}"></td>
	                    <td><input type="text" class="input-normal control-text" name="firstPrice_0" value="${expressTemplate.firstPrice!}"></td>
	                    <td><input type="text" class="input-normal control-text" name="continueValue_0" value="${expressTemplate.continueValue!}"></td>
	                    <td><input type="text" class="input-normal control-text" name="continuePrice_0" value="${expressTemplate.continuePrice!}"></td>
	                </tr>
                </tbody>
            </table>
            <div class="mb10"><a href="javascript:void(0);" onclick="region(this);">为指定地区设置运费</a></div>
            <table cellspacing="0" class="table table-bordered">
                <tbody id="area_table">
                <tr>
                    <th>运送到</th>
                    <th>首重（千克）</th>
                    <th>首价（元）</th>
                    <th>续重（千克）</th>
                    <th>续价（元）</th>
                    <th width="200">操作</th>
                </tr>
                <#if expressTemplate.expressTemplateDestinationAreaList?has_content>
            	<#list expressTemplate.expressTemplateDestinationAreaList as areaList>
                <tr>
		            <input name="areaId" value="${areaList_index + 1}" type="hidden"/>
		    		<input name="areaIds_${areaList_index + 1}" value="<#if areaList.areaIdList?has_content><#list areaList.areaIdList as areaId>${areaId!}<#if areaId_has_next>$</#if></#list></#if>" type="hidden"/>
		            <input name="areaNames_${areaList_index + 1}" value="<#if areaList.areaNameList?has_content><#list areaList.areaNameList as areaName>${areaName!}<#if areaName_has_next>$</#if></#list></#if>" type="hidden"/>
		            <td>
		            <div style="float: left;" name="allAreaLists">
		            <#if areaList.areaNameList?has_content>
		            <#list areaList.areaNameList as areaName>
		            	${areaName!}<#if areaName_has_next>,</#if>
		            </#list>
		            </#if>
		    		</div><div style="float: right;"><a href="javascript:void(0);" onclick="region(this);" >修改</a><input type="hidden"></div>
		    		</td>
		    		<td><input type="text" class="input-normal control-text" name="firstValue_${areaList_index + 1}" value="${areaList.firstValue!}"></td>
		            <td><input type="text" class="input-normal control-text" name="firstPrice_${areaList_index + 1}" value="${areaList.firstPrice!}"></td>
		            <td><input type="text" class="input-normal control-text" name="continueValue_${areaList_index + 1}" value="${areaList.continueValue!}"></td>
		            <td><input type="text" class="input-normal control-text" name="continuePrice_${areaList_index + 1}" value="${areaList.continuePrice!}"></td>
		            <td><a href="javascript:void(0);" onclick="remove_area(this);">删除</a></td>
                </tr>
                </#list>
            	</#if>
                </tbody>
            </table>
			</#list>
            <div class="actions-bar">
                <button type="submit" id="save" class="button button-primary" >保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </form>
    </div>

    <div id="Content" class="hide">
        <div class="form-horizontal">
        <!--用于判断是修改地区还是设置地区标识,点击时赋不同值 -->
        <input type="hidden" id="out">
        <!--用于判断修改时，选择地区，只给选择除了改行还未被选的地区-->
        <input type="hidden" id="judgeModify">
            <div class="row mb10">
                <div class="control-group">
                	<!-- 用于下面ajax取值 -->
                    <#--<label class="control-label control-label-auto " id="${ctx}"><s>*</s>请选择地区：</label>
                    <div class="controls control-row-auto">
                        <select id="areaList">
                        	<option id="defaultSelect">-请选择-</option>
    						<#list areaChildList as areaList>
                            <option id='${areaList.id!}'>${areaList.childAreaName!}</option>
        					</#list>
                        </select>
                    </div>-->
                </div>
            </div>
        </div>
        <div class="area-list lbdarea-list" id = "lbdarea-list">
        	<!--<div class="item">
            	<label class="checkbox area-label"><input id="selectAll" type="checkbox" /><span>全选</span>&nbsp;&nbsp;&nbsp;&nbsp;</label>
        	</div> -->
            <div class="item" id="areaGrandsonListDiv">
                <div class="bd" id="areaGrandsonListBd">
                    <ul id="areaGrandsonList">
                    	<#list provinceList as provinceList>
                    	<li class="allAreaList"><label class="checkbox" for="${provinceList.id!}"><input onclick="selectChild(this);" type="checkbox" value="${provinceList.areaName!}"id="${provinceList.id!}">${provinceList.areaName!}</input><em>${provinceList.cityCount!}</em><i class="x-caret x-caret-down"></i></label>
		 					<div class="area-droplist" style="min-height:1px;max-height:120px;overflow-y:auto;">
		 						<#if provinceList.cityList?has_content>
		 						<#list provinceList.cityList as city>
		 							<#if city.chosedAreaName?has_content>
		 							<label class="checkbox" for="${city.id!}"><input type="checkbox"  value="${city.chosedAreaName!}" disabled = "disabled" checked="checked" id="${city.id!}">${city.chosedAreaName!}</input></label>
		 							<#else>
		 							<label class="checkbox" for="${city.id!}"><input type="checkbox"  value="${city.areaName!}" id="${city.id!}">${city.areaName!}</input></label>
		 							</#if>
		 						</#list>
		 						</#if>
							</div>
						</li>
						</#list>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
 //延时启用保存按钮
function remainTime(){
	//打开提交按钮
	btn=document.getElementById('save');
	btn.disabled=false;
}

 $(function(){
        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#newExpress_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
               	//返回上一级页面但刷新不了
               	window.location.href=document.referrer;
               	//window.history.go(-1);
               	//$('#backMain').trigger('click');
                }
                //2.数据返回,延迟打开提交按钮,避免重复显示提示信息！
               	setTimeout("remainTime()",1200);
            }
        });

        form.on('beforesubmit', function(){
			//2.写提交前的验证规则
			var isNull = "";
			if(!$.trim($("input[name='templateName']").val())){
				BUI.Message.Alert('模板名称不能为空');
				return false;
			}	
			//2.写提交前的验证规则
			$("#CalcTableChild").find("input").each(function(){
				if($(this).val()==""){
					 BUI.Message.Alert('默认运费不能为空');
					 isNull = "1";
					 return true;
				}
			});
			if(isNull == "1"){
				return false;
			}
		   	//1.提交时，屏蔽提交按钮避免重复提交！
            btn=document.getElementById('save');
			btn.disabled=true;
		    //全部验证成功后提交
		   	 return true;
        });
        form.render();
    });
</script>

<script type="text/javascript">
	//地区li的显示效果,绑定hover事件
	$(".area-list .bd li").each(function(){
        var li = $(this),
                labelbox = li.find(".checkbox").eq(0),
                droplist = li.find(".area-droplist");
        if(droplist[0]){
            li.hover(function(){
                labelbox.addClass("current");
                droplist.show();
            },function(){
                labelbox.removeClass("current");
                droplist.hide();
            })
        }
    });

	//子地区全选实现
	function selectChild(Child){
		var flag = Child.checked;
		var child = $(Child);
		var childrenAreaLabel = child.parent().next().find("input");
		//alert(child.next().find("input"));
		if(flag){
			for(var i=0;i<childrenAreaLabel.length;i++){
				childrenAreaLabel[i].checked = true;
			}
		}else{
			for(var i=0;i<childrenAreaLabel.length;i++){
				if(!$(childrenAreaLabel[i]).attr("disabled")){
					childrenAreaLabel[i].checked = false;
				}
			}
		}
	}
	
	function selectAllChild(AllChild){
		//设置全选按钮的checked值为开关控制所有select
		var flag = AllChild.checked;
		var allChildrenAreaLabel = $("#areaGrandsonList").find("input");
		if(flag){
			for(var j=0;j<allChildrenAreaLabel.length;j++){
				allChildrenAreaLabel[j].checked = true;
			}
		}else{
			for(var j=0;j<allChildrenAreaLabel.length;j++){
				if(!$(allChildrenAreaLabel[j]).attr("disabled")){
					allChildrenAreaLabel[j].checked = false;
				}
			}
		}
	}
	//删除运送地区按钮功能
	function remove_area(reveArea){
		$(reveArea).closest("tr").remove();
	}
</script>
<script type="text/javascript">
	//全局变量
	var trArray = $("#area_table").find("tr");
	var nameId = trArray.length;
	//地区弹出框-按钮确定-非空-页面地区增加一行
	var create_new_tr  = function (areaValue){
	var areaIds = areaValue[0].join('$');//join:数据元素通过指定分隔符分割
	var areaNames = areaValue[1].join('，');
	var areaNamesInput = areaValue[1].join('$');
	
	var arrayIds = new Array();
	var arrayNames = new Array();
	var arrayNamesInput = new Array();
		arrayIds = areaIds.split("$");
		arrayNames = areaNames.split("，");
		arrayNamesInput = areaNamesInput.split("$");
	var html = "";
	var stringAreaNames = "";
	var stringAreaIds = "";
	var stringNames = "";
	var modifyId = "";
	    for(var i=0;i<arrayNames.length;i++){
	    	if(i == arrayNames.length-1){
	    		stringNames = stringNames + arrayNames[i];
	    	}else{
	    		stringNames = stringNames + arrayNames[i] + "，";
	    	}
	    	if(i == arrayNames.length-1){
	    		stringAreaNames = stringAreaNames + arrayNames[i];
	    	}else{
	    		stringAreaNames = stringAreaNames + arrayNames[i] + '$';
	    	}
	    	if(i == arrayNames.length-1){
	    		stringAreaIds = stringAreaIds + arrayIds[i];	
	    	}else{
	    		stringAreaIds = stringAreaIds + arrayIds[i] + '$';
	    	}
	    	if(i == arrayNames.length-1){
	    		modifyId = modifyId + arrayIds[i];	
	    	}else{
	    		modifyId = modifyId + arrayIds[i] + 'and';
	    	}
	    }
	    nameId = nameId + 1;
	    var html_1 = '<tr>'
	    		+'<input name="areaId" value="'+nameId+'" type="hidden"/>'
	    		+'<input name="areaIds_'+nameId+'" value="'+stringAreaIds+'" type="hidden"/>'
	            +'<input name="areaNames_'+nameId+'" value="'+stringAreaNames+'" type="hidden"/>'
	            +'<td>'
	            +'<div style="float: left;" name="allAreaLists">';
	            
	    var html_2 = '</div><div style="float: right;"><a href="javascript:void(0);" name="'+stringNames+'" onclick="region(this);" >修改</a><input type="hidden"></div>'
	    		+'</td>'
	    		+'<td><input type="text" class="input-normal control-text" name="firstValue_'+nameId+'"></td>'
	            +'<td><input type="text" class="input-normal control-text" name="firstPrice_'+nameId+'"></td>'
	            +'<td><input type="text" class="input-normal control-text" name="continueValue_'+nameId+'"></td>'
	            +'<td><input type="text" class="input-normal control-text" name="continuePrice_'+nameId+'"></td>'
	            +'<td><a href="javascript:void(0);" onclick="remove_area(this);">删除</a></td>'
	            +'</tr>';
	         //&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" onclick = "isCenterPoint(this);">设为中心点</a>
	    html = html_1 + stringNames + html_2;
	    $(html).appendTo('#area_table');
	}
	
	//下拉选判断非空方法
    var get_select_area = function (){
        var ids=[];
        var names=[];
        //点确定的时候只需要push所有被选的村
        var ereaTownArrays = new Array();
        var ereaVillageArrays = new Array();
        ereaTownArrays = $("#areaGrandsonList div");
	        for(var i=0;i<ereaTownArrays.length;i++){
	        	ereaVillageArrays = $(ereaTownArrays[i]).find("input");
	        	for(var j=0;j<ereaVillageArrays.length;j++){
	        		if($(ereaVillageArrays[j]).prop('checked') && !$(ereaVillageArrays[j]).attr("disabled")){
	        			ids.push($(ereaVillageArrays[j]).attr("id"));
	        			names.push($(ereaVillageArrays[j]).val());
	        		}else if($(ereaVillageArrays[j]).prop('checked') && $(ereaVillageArrays[j]).attr("disabled")=="disabled"){
	        			continue;
	        		}
	        	}
	        }
        return [ids,names];
    }
    
    //弹出框-确定/取消按钮退出时-地区隐藏处理
    var boxHide = function(){
    	//1.将所有单纯选择的input或单纯置灰的inpu取消
        $("#selectAll").attr("checked",false);
        $("#areaGrandsonList input").each(function(index,obj){
        	if($(obj).prop("checked") && !$(obj).prop("disabled")){
        		$(obj).attr("checked",false);
        	}
        	if($(obj).prop("disabled") && !$(obj).prop("checked")){
        		$(obj).attr("disabled",false);
        	}
        });
    }
	
	//修改按钮-确定地区-地区input更改
	var modifyConfirm = function(areaValue){
    	//显示修改后的地区内容
    	$("#modifyAreas").closest("div").prev().html(areaValue[1].join('，'));
    	//更新修改后的input表单提交框信息
		$("#modifyAreas").closest("tr").find("input[name^=areaIds_]").val(areaValue[0].join('$'));
		$("#modifyAreas").closest("tr").find("input[name^=areaNames_]").val(areaValue[1].join('$'));
		//去除改修改按钮ID，以便其他修改按钮使用
		$("#modifyAreas").attr("id","");
	}
	
	 function region(newOrMdf){
    	var nom = $(newOrMdf);
    	//判断该节点是修改按钮还是新增地区按钮
    	$("#out").val(nom.html());
    	//若当前是修改节点，赋予ID，以便地区确定后根据ID修改内容
    	if(nom.html() == '修改'){
    		nom.attr('id','modifyAreas');
    		//顺便将要修改的地区存入隐藏input，以便查询地区时过滤显示样式
    		$('#judgeModify').val(nom.closest("tr").find("div[name='allAreaLists']").html());
    	}
    	//隐藏地区框循环所有已选择地区，打钩
    	$("#areaGrandsonList").find("input").each(function(){
    		var _this = this;
    		//每一个村和已选的列表里面对比，若还未被选择可以勾选，反之，disable;
    		$("#area_table div[name='allAreaLists']").each(function(){
	    		if($('#out').val() == '修改'){
					//修改地区:则打钩
					if($(this).html() == $('#judgeModify').val() && $('#judgeModify').val().indexOf($(_this).val()) != -1){
						$(_this).attr("checked","checked");
						return true;
					}
				}else{
					//新增地区:置灰
					if($(this).html().indexOf($(_this).val()) != -1){
						$(_this).attr("disabled","disabled");
						//跳出当前循环
						return true;
					}
				}
    		})
    	});
    	//显示地区选择框
        dialogregion.show();
    }
	
	//为指定地区设置运费弹出框
    BUI.use('bui/overlay',function(Overlay){
        dialogregion = new Overlay.Dialog({
            title:'选择地区',
            width:720,
            height:400,
            mask:true,
            buttons:[
                {
                    text:'确定',
                    elCls : 'button button-primary',
                    handler : function(){
					    //点击选择运送地区-确定-判断地区非空
			            areaValue = get_select_area();
			            if(areaValue==null || areaValue[0].length<1){
			                alert('请选择地区');
			                return false;
			            }
			            if($("#out").val() != "修改"){
			            	//指定地区
				            create_new_tr(areaValue);
			            }else{
			            	//修改地区
			            	modifyConfirm(areaValue);
			            }
			            boxHide();
			            //删除弹出框
       					this.close();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                		boxHide();
                		//删除弹出框
       					this.close();
                    }
                }],
            contentId : 'Content'
        });
    });
</script>
</body>
</html>  