
<#if paymentHtmlText?? && paymentHtmlText?has_content>
<html>
<body>
${paymentHtmlText!}
</body>
</html>
<#else>
${errorMsg!}
</#if>