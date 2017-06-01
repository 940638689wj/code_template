<script>
    /**
     * 加载下拉菜单
     *
     * @param selectId      下拉菜单id
     * @param parentId      父节点id
     * @param firstLine    下拉菜单的第一行默认数据（如“请选择省份”）
     */
    function findChildByParentId(selectId, parentId, firstLine) {
        $("#" + selectId).empty();
        if (firstLine) {
            $('#' + selectId).append('<option value="">' + firstLine + '</option>');
        }
        if(parentId || parentId == "0") {
            $.ajax({
                url: '${ctx}/product/findChildByParentId',
                dataType: 'json',
                async: false,
                type: 'GET',
                data: {parentId: parentId},
                success: function (data) {
                    if (data.rowCount != null && data.rowCount > 0) {
                        $.each(data.rows, function (i, row) {
                            $('#' + selectId).append("<option value='" + row.id + "'>" + row.areaName + "</option>");
                        });
                        return true;
                    } else {
                        return false;
                    }
                }
            });
        }
    }

    /**
     * 为下拉增加onchange事件
     *
     * @param eleId     目标元素id
     * @param cancelEle 更改下拉时应重置的下拉菜单id（数组）
     * @param calcelEleFirstLine    重置的下拉菜单的第一行默认数据（如“请选择省份”）（数组）
     * @param updateEle     更改下拉时应自动加载的下拉菜单的id
     * @param updateEleFirstLine    自动加载的下拉菜单的第一行默认数据
     */
    function addChangeEven(eleId, cancelEle, calcelEleFirstLine, updateEle, updateEleFirstLine) {
        $("#" + eleId).on("change", function () {
            for (var i = 0; i < cancelEle.length; i++) {
                $("#" + cancelEle[i]).empty();
                $("#" + cancelEle[i]).append('<option value="">' + calcelEleFirstLine[i] + '</option>');
            }
            findChildByParentId(updateEle, $("#" + eleId).val(), updateEleFirstLine);
        });
    }
</script>