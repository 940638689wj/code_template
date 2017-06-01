<#assign ctx = request.contextPath>
<#include "${ctx!}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
        <#include "${ctx!}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
       <script type="text/javascript">

        function validFile(fileName){
            $("#choiceFileTxt").val(fileName);
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
                    !("xls" == jQuery.trim(suffix.toLowerCase())||
                    "xlsx" == jQuery.trim(suffix.toLowerCase()))){
                BUI.Message.Alert(suffix + "文件格式暂不支持!");
                return false;
            }

            return true;
        }

        function importFile(){
            if(!validFile($("#choiceFileTxt").val())){
                return false;
            }
            $("#parseProductBtn").html("正在解析文件信息...");
            $("#parseProductBtn").attr("disabled","disabled");
            $.ajaxFileUpload({
                url : '${ctx}/admin/sa/regisonProductManage/importFiles',
                secureuri: false,
                fileElementId: "uploadProductsFileObj",
                dataType : 'json',
                method : 'post',
                success: function (data) {
                    if(data.result == "success"){
                        app.page.open({
                            href:'${ctx}/admin/sa/regisonProductManage/preview'
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

        function getTemplate(){
            window.open('/admin/sa/regisonProductManage/getTemplate');
        }

        function goBack() {
        	history.go(-1);
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/regisonProductManage/list">区域管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">批量导入区域</li>
    </ul>
    <div class="flow-steps">
        <ol class="num5">
            <li class="current"><i class="num">1</i>导入区域单</li>
            <li class=""><i class="num">2</i>预览确认</li>
            <li class="last"><i class="num">3</i>入库结果</li>
        </ol>
    </div>
    <form id="uploadFileForm" name="uploadFileForm" class="form-horizontal" action="#" method="post">
        <div class="control-group">
            <label class="control-label" style="width:200px;">文件选择：</label>
            <div class="controls">
                <input type="file" id="uploadProductsFileObj" name="csvFile" onchange="javascript:validFile(this.value);">
                <input type="text" class="control-text" id="choiceFileTxt" readonly = "true" style="display: none;">
                <p>支持xls、xlsx格式,大小不超过10M!</p>
            </div>
            <div><a href="javascript:getTemplate();">点击这里下载模板</a></div>
        </div>
        <div class="row actions-bar">
            <div class="form-actions offset7">
                <button id="parseProductBtn" type="submit" class="button button-primary" onclick="return importFile();">下一步</button>
                <button type="reset" class="button" onclick="javascript:goBack();">返回</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>