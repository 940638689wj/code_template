<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/userLevel/save" method="post">
	    <div class="content-body">
	        <div id="grid"></div>
	    </div>
	    <div class="content-foot">
	        <div class="actions-bar">
	            <button id="save" type="submit" class="button button-primary">保存</button>
	        </div>
	   	</div>
	</form>
</div>
<script type="text/javascript">
   var grid=null;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'会员等级管理',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'ID',dataIndex:'userLevelId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='userLevelId' value='" + value + "'>";
        	}},
         	{title:'状态',dataIndex:'statusCd',width:70, renderer : function(value, rowObj){
         		var defaultChecked = "";
                if(value != null && value == 1){
                    defaultChecked = "checked='checked'";
                }
                return "<input name='statusCd_" + rowObj.userLevelId + "' id='statusCds_" + rowObj.userLevelId + "' " +
						"type='checkbox' "+ defaultChecked + "><label for='statusCd_" + rowObj.userLevelId + "'>启用</label>";
            }},
            {title:'升级',dataIndex:'isAutoupdate',width:120,renderer : function(value,rowObj){
            	var defaultChecked1 = "";
                if(value != null && value == 1){
                    defaultChecked1 = "checked='checked'";
                }
            	return "<input name='isAutoupdate_" + rowObj.userLevelId + "' id='isAutoupdate_" + rowObj.userLevelId + "' " +
						"type='checkbox' "+ defaultChecked1  +"><label for='upgrade_" + rowObj.userLevelId + "'>是否自动升级</label>";
            }},
            {title:'会员等级',dataIndex:'rankName',width:80, renderer : function(value, rowObj){
            	if(null!=value && ""!=value){
                	return app.grid.format.encodeHTML(value+"会员");
            	}
            }},
            {title:'会员等级名称',dataIndex:'userLevelName',width:130,renderer : function(value,rowObj){
            	if(value != null){
            		return "<input id='levelName_" + rowObj.userLevelId + "' class='control-text' type='text' " +
							"name='userLevelName_"+ rowObj.userLevelId +"' style='width: 100px;' value='" + value + "'>";
            	}
            }},
            {title:'等级条件',dataIndex:'',width:220,renderer : function(value,rowObj){
				var str = null;
				if(rowObj.userLevelId==1){
					return str;
				}
				switch (rowObj.userLevelId){
					case 2:
						str = "一级会员";
						break;
					case 3:
						str = "二级会员";
						break;
					case 4:
						str = "三级会员";
						break;
					case 5:
						str = "四级会员";
						break;
					case 6:
						str = "五级会员";
						break;
					case 7:
						str = "六级会员";
						break;
					case 8:
						str = "七级会员";
						break;
					case 9:
						str = "八级会员";
						break;
				}
				return str+	"&nbsp：<input value='"+rowObj.developUserCnt+"' type = 'number' class='control-text' " +
						"style='width:80px;'" +"name='developUserCnt_" + rowObj.userLevelId + "'>"+"个";
            }},
            {title:'折扣',dataIndex:'discount',width:80,renderer : function(value,rowObj){
            	if(value !== null && value < 10){
            		return "<input value='"+value+"' type = 'text' class='control-text' style='width:25px;' " +
							"name='discount_"+ rowObj.userLevelId +"'>折";
            	}else{
            		return "<input value='' type = 'text' class='control-text' style='width:25px;' " +
							"name='discount_"+ rowObj.userLevelId +"'>折";
            	}
            }}/*,
            {title:'会员卡',dataIndex:'rightsInstructions',width:300,renderer : function(value,rowObj){

            		return '<div class="members-cardbox" style="width:130px; display:inline-block;">正面：' +
                '<input type="hidden" id="frontImg_'+ rowObj.userLevelId +'_Url" name="frontImg_'+ rowObj.userLevelId +'_Url" ' +
							'value="" class="input-normal control-text" > '+
                '<div class="members-card"><img src="'+rowObj.frontImgUrl+'" width="80" id="frontImg_'+ rowObj.userLevelId +'" ' +
							'name="frontImg_'+ rowObj.userLevelId +'"/></div>' +
                '<div class="members-card-btn">上传<input type="file" name="file" id="file_frontImg_'+ rowObj.userLevelId +'" class="inp-file"' +
							'onchange="javascript:assetChange(this.value,\'frontImg_'+rowObj.userLevelId+'\');"></div>'+
                '</div>'+
                '<div class="members-cardbox" style="width:130px; display:inline-block;">背面：' +
                '<input type="hidden" id="backImg_'+ rowObj.userLevelId +'_Url"  name="backImg_'+ rowObj.userLevelId +'_Url" ' +
							'value="" class="input-normal control-text" > '+
                '<div class="members-card"><img src="'+rowObj.backImgUrl+'" width="80" id="backImg_'+ rowObj.userLevelId +'"' +
							' name="backImg_'+ rowObj.userLevelId +'"/></div>' +
                '<div class="members-card-btn">上传<input type="file" name="file" id="file_backImg_'+ rowObj.userLevelId +'" class="inp-file" ' +
							'onchange="javascript:assetChange(this.value,\'backImg_'+rowObj.userLevelId+'\');"></div>';
            }},*/
        ];
        var store = Search.createStore('/admin/sa/userLevel/grid_userLevelList',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            tbar:{
                items:[
                    /*{	xclass:'bar-item-text',
                        text:'<div class="tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-volume-up"></i></span><div class="tips-content">提示: 最多可以设置10个会员等级的不同折扣。统一设置会员卡，<a href="${ctx}/admin/sa/userCard">请点击这里&gt;&gt;</a></div></div>'
                    }*/
                ]
            },
        	plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight()
        });
        
        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                });
        grid = search.get('grid');
    grid.render();
    

    }); 
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
                //2.数据返回,延迟打开提交按钮,避免重复显示提示信息！
               	setTimeout("remainTime()",1000);
            }
        });

        form.on('beforesubmit', function(){
        	//1.提交时，屏蔽提交按钮避免重复提交！
            btn=document.getElementById('save');
			btn.disabled=true;
		    //1。1提交前验证会员等级名称
		    var allArray = new Array(); 
		    var i = 0;
		    var j = 0;
		    allArray = $("input[name^='userLevelName_']");
		    for(i=0;i<allArray.length;i++){
		    	if($.trim($(allArray[i]).val())==""){
			   	 	BUI.Message.Alert("会员等级名称不能为空！");
			   	 	//打开提交按钮
        			btn=document.getElementById('save');
					btn.disabled=false;
			   	 	return false;
		    	}
		    	for(j=i+1;j<allArray.length;j++){
		    		if($.trim($(allArray[j]).val()) == ""){
				   	 	BUI.Message.Alert("会员等级名称不能为空！");
				   	 	//打开提交按钮
	        			btn=document.getElementById('save');
						btn.disabled=false;
				   	 	return false;
		    		}
		    		if($.trim($(allArray[i]).val()) == $.trim($(allArray[j]).val())){
		    			BUI.Message.Alert("会员等级名称一样！");
				   	 	//打开提交按钮
	        			btn=document.getElementById('save');
						btn.disabled=false;
				   	 	return false;
		    		}
		    	}
		    }
		    //1.2提交前验证等级条件(不能为空，只能数字,不为负数)
		    var reg = /^(\+)?\d+(\.\d+)?$/;
		    allArray = $("input[name^='developUserCnt_']");
		    for(i=1;i<allArray.length;i++){
		    	if($.trim($(allArray[i]).val())==""){
			   	 	BUI.Message.Alert("下级会员个数不能为空！");
			   	 	//打开提交按钮
        			btn=document.getElementById('save');
					btn.disabled=false;
			   	 	return false;
		    	}
		    	if(!reg.test($.trim($(allArray[i]).val()))){
			   	 	BUI.Message.Alert("下级会员个数不是有效的数字！");
			   	 	//打开提交按钮
        			btn=document.getElementById('save');
					btn.disabled=false;
			   	 	return false;
		    	}
		    }
		    //1.3提交前验证折扣
            statusCdArray = $("input[name^='statusCd_']");
            allArray = $("input[name^='discount_']");
            reg_discount_num = /^\d+(\.\d+)?$/;
            reg_discount_limit = /^(\d|10)(\.\d)?$/;
            for(i=0;i<allArray.length;i++){
                //启用状态下的进行判断
                if($.trim($(allArray[i]).val()) != ""){
                    if($(statusCdArray[i]).attr("checked")=="checked" && $(statusCdArray[i+1]).attr("checked")=="checked"){
                        if(!reg_discount_num.test($.trim($(allArray[i]).val())) || $.trim($(allArray[i]).val()) <= 0
								|| $.trim($(allArray[i]).val()) >= 10){
                            BUI.Message.Alert("折扣大于0且小于10！");
                            //打开提交按钮
                            btn=document.getElementById('save');
                            btn.disabled=false;
                            return false;
                        }
                        if(!reg_discount_limit.test($.trim($(allArray[i]).val()))){
                            BUI.Message.Alert("折扣最多保留1位小数！");
                            //打开提交按钮
                            btn=document.getElementById('save');
                            btn.disabled=false;
                            return false;
                        }
                    }
                }
            }
		    //1.4低等级的折扣不可小于等于高等级会员
            statusCdArray = $("input[name^='statusCd_']");
            allArray = $("input[name^='discount_']");
            for (i = 0; i < allArray.length; i++) {
                if ($(statusCdArray[i]).attr("checked") == "checked" && $(statusCdArray[i + 1]).attr("checked") == "checked") {
                    if (parseFloat($.trim($(allArray[i + 1]).val())) == parseFloat($.trim($(allArray[i]).val()))
							|| parseFloat($.trim($(allArray[i + 1]).val())) > parseFloat($.trim($(allArray[i]).val()))) {
                        BUI.Message.Alert("高级会员折扣要小于低等级");
                        //打开提交按钮
                        btn = document.getElementById('save');
                        btn.disabled = false;
                        return false;
                    }
                }
            }
		    return true;
        });
        form.render();
    });

    //延时启用保存按钮
    function remainTime(){
    		//打开提交按钮
        	btn=document.getElementById('save');
			btn.disabled=false;
    }

   // 图片上传
   function assetChange(fileName,lastFlag){
       if(fileName == null || fileName.trim().length <= 0){
           BUI.Message.Alert("请选择文件!");
           return false;
       }
       var suffixIndex = fileName.lastIndexOf('.');
       if(suffixIndex <= 0){
           BUI.Message.Alert("文件格式错误!");
           return false;
       }
       var suffix = fileName.substr(suffixIndex + 1);
       if(suffix.trim().length <= 0 ||
               ("jpg" != suffix.trim() && "png" != suffix.trim())){
           BUI.Message.Alert("文件格式错误!");
           return false;
       }
       $.ajaxFileUpload({
           url:'${ctx}/common/staticAsset/upload/userCard',
           secureuri: false,
           fileElementId: "file_"+lastFlag,
           dataType: "json",
           method : 'post',
           success: function (data, status) {
               loadImage(data.displayAssetUrl,data.assetUrl,lastFlag);
           },
           error: function (data, status, e) {
               BUI.Message.Alert("上传失败" + e);
           }
       });
       return false;
   }
   //设置预览
   function loadImage(url,assetUrl,lastFlag) {
       $('#'+lastFlag).attr("src", assetUrl);
       $('#'+lastFlag+"_Url").val(assetUrl);
   }
</script>
</body>
</html>  