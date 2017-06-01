<script>
    // 三级地址下拉组件
    avalon.component('ms-addressSelect', {
        template: '<div>' +
        '<div class="hd">所在地区</div>' +
        '<div class="bd">' +
        '<select id="receiverProvinceId"><option value="">选择省</option></select>' +
        '<select id="receiverCityId"><option value="">选择城市</option></select>' +
        '<select id="receiverCountyId"><option value="">选择县/区</option></select>' +
        '</div>' +
        '</div>',
        defaults: {
            callback: null,
            // ---数据---
            $computed: {
            },
            // ---方法---
            // 上一页
            abc: function () {
                alert(1)
            }
        }
    });
</script>