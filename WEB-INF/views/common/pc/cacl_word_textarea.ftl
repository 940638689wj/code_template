<script type="text/javascript">
    function countStringLength(str){
        var str_length = 0;
        for (var i = 0; i < str.length; i++){
            if (str.charCodeAt(i)<= 256) str_length += 1;
            else str_length += 1;
        }
        return str_length;
    }

    function checkInputLength${textarea_id}(textareaId, maxNum){
        var strErrorObj = $("#strError_" + textareaId);
        var strInfoObj = $("#strInfo_" + textareaId);
        var strLengthObj = $("#strLength_" + textareaId);
        var content = $("#"+textareaId).val();
        var leftNum = Math.floor((maxNum - countStringLength(content)));
        if(leftNum < 0){
            leftNum = 0;
            strInfoObj.hide();
            strErrorObj.show();
        } else {
            strErrorObj.hide();
            strInfoObj.show();
        }
        strLengthObj.text(leftNum);
    }
</script>
<textarea id="${textarea_id}" name="${textarea_name}" onkeydown="checkInputLength${textarea_id}('${textarea_id}', ${maxNum})" onkeyup="checkInputLength${textarea_id}('${textarea_id}', ${maxNum})"></textarea>
<p id="strInfo_${textarea_id}">（还可输入<span id="strLength_${textarea_id}">${maxNum}</span>个字）</p>
<p id="strError_${textarea_id}" style="color: #ff0000; display: none;">字数超过限制</p>