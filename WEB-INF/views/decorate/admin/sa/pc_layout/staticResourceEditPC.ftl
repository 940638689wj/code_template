<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<#assign selectedHtml="static_resource_css_pc"/>
<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<style>
    html{overflow: hidden;}
    body,html{margin: 0; padding: 0; height: 100%;}
    .box{height: 100%; padding-left: 170px;}
    iframe{width: 100%; height: 100%;}
    .menu{float:left; margin-left: -170px; width: 160px; _display:inline; font-size: 12px;}
    .content{height: 100%;}
    .clearfix:after{content: ""; display: block; clear: both;}
    .menu a{position: absolute; width: 100%; height: 100%; left: 0; top: 0; color: #3f5465; text-decoration: none;}
    .menu a:hover{background-color: #859cae;}
    .cell{background: #e4e7e9; position: relative; text-align: center; color: #3f5465;}

    .cell-css{height: 50px; line-height: 50px; margin-top: 2px;}
    .cell-js{height: 50px; line-height: 50px; margin-top: 2px;}

    .cell-select{border:1px dashed #00F}
</style>

<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<body>
<div class="box">
    <div class="menu">
        <div id="static_resource_css_pc" class="cell cell-css">
            <a  href="${ctx}/admin/sa/pc/decorate/staticPCResourceShow?platform=pc&key=static_resource_css_pc" target="index_edit_iframe">PC端css</a>
        </div>
        <div id="static_resource_js_pc" class="cell cell-js">
            <a  href="${ctx}/admin/sa/pc/decorate/staticPCResourceShow?platform=pc&key=static_resource_js_pc" target="index_edit_iframe">PC端js</a>
        </div>
    </div>

    <div class="content">
        <iframe name="index_edit_iframe" id="index_edit_iframe" src="${ctx}/admin/sa/pc/decorate/staticPCResourceShow?platform=pc&key=${selectedHtml}" frameborder="0"></iframe>
    </div>
</div>

<script>
    $(function(){
        $("#${selectedHtml}").addClass('cell-select');

        $(".menu").on("click","a",function(){
            $("div.cell").removeClass('cell-select');
            $(this).closest('.cell').addClass('cell-select');
        });
    })
</script>
</body>
</html>