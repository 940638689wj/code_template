<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#uploadFileForm'
            });

            form.render();

        <#--<#if showSuccessTip?? && showSuccessTip>-->
            <#--BUI.Message.Alert("商品导入完成！<br>目前正在导入商品图片，请暂时勿编辑商品图片信息。<br>您可以离开该页面进行其它操作，同时在'商品&ndash;&gt;导入商品'模块查看图片导入进度情况。");-->
        <#--</#if>-->
        });

        /**
         * 验证文件类型
         *
         * @param fileName
         */
        function validFileName(fileName){
            if(fileName == ""){
                BUI.Message.Alert("请选择文件!");
                return false;
            }

            var suffixIndex = fileName.lastIndexOf('.');
            if(suffixIndex <= 0){
                BUI.Message.Alert(fileName + "文件格式错误!");
                return false;
            }

            var suffix = fileName.substr(suffixIndex + 1);
            suffix = jQuery.trim(suffix);

            if(jQuery.trim(suffix).length <= 0 ||
                    "csv" != jQuery.trim(suffix.toLowerCase())){
                BUI.Message.Alert(suffix + "文件格式暂不支持!");
                return false;
            }

            return true;
        }

        /**
         * 上传产品文件
         *
         */
        function uploadProductsFile(){
            $("#uploadProductsFileObj").click();
        }

        /**
         * 文件选择发生改变
         *
         * @param fileName
         */
        function fileChoiceChangeEvent(fileName) {
            $("#choiceFileTxt").val(fileName);
        }

        /**
         * 执行上传操作
         *
         */
        var importUploadPath = "${ctx}/admin/sa/importProduct/importProductFiles";
        function importFile(){
            var productFileName = $("#choiceFileTxt").val();
            var validSuccess = validFileName(productFileName);

            if(!validSuccess){
                return false;
            }

            $("#parseProductBtn").html("正在解析商品信息...");
            $("#parseProductBtn").attr("disabled","disabled");

            $.ajaxFileUpload({
                url : importUploadPath,
                secureuri: false,
                fileElementId: "uploadProductsFileObj",
                dataType : 'json',
                method : 'post',
                success: function (data, status) {
                    if(data.result == "success"){
                        app.page.open({
                            href:'${ctx}/admin/sa/importProduct/customPropInfo'
                        });
                    } else {
                        $("#parseProductBtn").html("下一步");
                        $("#parseProductBtn").removeAttr("disabled");
                        BUI.Message.Alert(data.message);
                    }
                },
                error: function (data, status, e) {
                    $("#parseProductBtn").html("下一步");
                    $("#parseProductBtn").removeAttr("disabled");
                    BUI.Message.Alert("上传失败，" + data.message);
                }
            });
            return false;
        }

        function viewProductList(){
            window.location.href = "${ctx}/admin/sa/productManage/list?productStatusCd=1";
        }
    </script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="breadcrumb">
            <li><a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">商品管理</a> <span class="divider">&gt;&gt;</span></li>
            <li class="active">导入商品</li>
        </ul>
    </div>
<#--<#if hasCategory?? && hasCategory>-->
    <div class="content-top">
        <div class="flow-steps">
            <ol class="num5">
                <li class="first current"><i class="num">1</i>导入商品文件</li>
                <li class=""><i class="num">2</i>自定义商品规格</li>
                <li class="last"><i class="num">3</i>自定义商品信息</li>
            </ol>
        </div>
        <form id="uploadFileForm" name="uploadFileForm" class="form-horizontal" action="#" method="post">
            <div class="control-group">
                <label class="control-label" style="width:200px;">文件选择：</label>
                <div class="controls">
                    <input type="file" id="uploadProductsFileObj" name="csvFile" onchange="javascript:fileChoiceChangeEvent(this.value);">
                    <input type="text" class="control-text" id="choiceFileTxt" readonly = "true" style="display: none;">
                    <p>支持CSV&nbsp;(<span style="color: red;">淘宝助理5.5版本</span>)&nbsp;格式,大小不超过10M!</p>
                </div>
            </div>
            <div class="row actions-bar">
                <div class="form-actions offset7">
                    <button id="parseProductBtn" type="submit" class="button button-primary" onclick="return importFile();">下一步</button>
                    <button type="reset" class="button" onclick="javascript:viewProductList();">查看商品列表</button>
                </div>
            </div>
        </form>
        <form id="searchForm" class="form-horizontal span24">
            <input name="sort" value="importTime desc" type="hidden"/>
        </form>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
    <#--<script type="text/javascript">-->
        <#--var search;-->
        <#--var grid;-->
        <#--BUI.use(['common/search','common/page'],function (Search) {-->
            <#--var columns = [-->
                <#--{title:'商品导入时间',dataIndex:'importTime',width:180, renderer:BUI.Grid.Format.datetimeRenderer},-->
                <#--{title:'图片导入总数',dataIndex:'totalImportProductRecordCount',width:120},-->
                <#--{title:'图片已导入数',dataIndex:'haveImportProductRecordCount',width:120},-->
                <#--{title:'图片未导入数(未开始/导入失败)',dataIndex:'unImportProductRecordCount',width:180},-->
                <#--{title:'商品导入状态',dataIndex:'importStatus.friendlyType',width:100}-->
            <#--];-->
            <#--var store = Search.createStore('import/record/grid_json');-->
            <#--var gridCfg = Search.createGridCfg(columns,{-->
                <#--stripeRows : false,-->
                <#--width: '100%',-->
                <#--height: getContentHeight(),-->
                <#--render:'#grid',-->
                <#--columns : columns-->
            <#--});-->

            <#--search = new Search({-->
                <#--store : store,-->
                <#--gridCfg : gridCfg-->
            <#--});-->
            <#--grid = search.get('grid');-->
            <#--grid.render();-->
        <#--});-->
    <#--</script>-->
<#--<#else>-->
    <#--<div class="tips tips-large tips-notice tips-no-icon">-->
        <#--<div class="tips-content">-->
            <#--<h2>系统不存在商品类别!</h2>-->
            <#--<p>导入商品前，请先创建商品类别，<a href="${ctx}/admin/categoryManager/add.html?from=importProduct">马上去创建</a></p>-->
        <#--</div>-->
    <#--</div>-->
<#--</#if>-->
</div>
</body>
</html>