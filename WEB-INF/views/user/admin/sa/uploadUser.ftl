<#assign ctx = request.contextPath>
<#include "${ctx!}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx!}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#uploadFileForm'
            });
            form.render();
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
        var importUploadPath = "${ctx}/admin/sa/userExcel/importUser";
        function importFile(){
            var productFileName = $("#choiceFileTxt").val();
            var validSuccess = validFileName(productFileName);
            if(!validSuccess){
                return false;
            }
            $("#parseProductBtn").html("正在解析信息...");
            $("#parseProductBtn").attr("disabled","disabled");
            $.ajaxFileUpload({
                url : importUploadPath,
                secureuri: false,
                fileElementId: "uploadProductsFileObj",
                dataType : 'json',
                method : 'post',
                success: function (data, status) {
                    if(data.result == "success"){
                        $("#parseProductBtn").html("下一步");
                        $("#parseProductBtn").removeAttr("disabled");
                        BUI.Message.Alert(data.message);
                        
                         setTimeout(function () { 
							      location.href = "${ctx}/admin/sa/user/userList";
						    }, 2000);
                        
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

        function back(){
           history.go(-1);
        }

        function closeCurrentTab(){
            window.opener=null;
            window.open('','_self');
            window.close();
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="JavaScript:history.go(-1);">返回会员列表</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">导入会员</li>
    </ul>
    <div class="flow-steps">
        <ol class="num5">
            <li class="current"><i class="num">1</i>导入会员文件文件</li>
        </ol>
    </div>
    <form id="uploadFileForm" name="uploadFileForm" class="form-horizontal" action="#" method="post">
        <div class="control-group">
            <label class="control-label">文件选择：</label>
            <div class="controls">
                <input type="file" id="uploadProductsFileObj" name="csvFile" onchange="javascript:fileChoiceChangeEvent(this.value);">
                <input type="text" class="control-text" id="choiceFileTxt" readonly = "true" style="display: none;">
                <a href="${ctx}/static/admin/excel/user.xlsx" style="color: #ff0000">点击这里下载模版</a>
                <p>支持xls格式,大小不超过10M!</p>
            </div>
        </div>
        <div class="row actions-bar">
            <div class="form-actions offset7">
                <button id="parseProductBtn" type="submit" class="button button-primary" onclick="return importFile();">下一步</button>
                <button type="reset" class="button" onclick="goBackList()">返回</button>
            </div>
        </div>
    </form>
</div>
<script>
    function goBackList() {
        history.go(-1);
    }
</script>
</body>
</html>