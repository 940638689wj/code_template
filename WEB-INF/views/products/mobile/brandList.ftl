<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>品牌列表</title>
</head>
<body>
    <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m"></a>
            <h1 class="mui-title"><a href="/m/category/list.html">商品分类</a></h1>
            <h1 class="mui-title"><a href="/m/brand/list.html">品牌馆</a></h1>
            <a class="mui-icon"></a>
        </header>

        <div>
            <ul id="brandList">

            </ul>
        </div>

    </div>
<script>

    $(function(){
        $.get("/m/brand/list/jsonData.html", {}, function (data) {
            if (data && data.productBrandList) {
                $.each(data.productBrandList, function(i,val){
                    var content = '<li data-id="'+val.brandId+'">'+val.brandName+'</li>';
                    $('#brandList').append(content);
                });
            } else {
                console.log(data.message || '加载数据失败!');
            }
        }, "json");
    })
</script>
</body>
</html>