<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<html>
<head>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href='javaScript:history.back(-1)'></a>
        <h1 class="mui-title">中奖规则</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <table class="cfund-resultTable">
            <tbody><tr>
                <th width="80">参与时间</th>
                <th width="150"></th>
                <th>会员帐号</th>
            </tr>
            <tr class="calcRow">
                <td><span class="date">2017-03-20</span></td>
                <td>
                    <span class="time">15:01:33.422</span>
                </td>
                <td><span class="usr">189****5433</span></td>
            </tr>
            <tr class="calcRow">
                <td><span class="date">2017-03-20</span></td>
                <td>
                    <span class="time">13:11:33.606</span>
                </td>
                <td><span class="usr">177****6732</span></td>
            </tr>
            <tr class="calcRow">
                <td><span class="date">2017-03-20</span></td>
                <td>
                    <span class="time">09:09:33.165</span>
                </td>
                <td><span class="usr">185****3113</span></td>
            </tr>
            <tr class="resultRow">
                <td colspan="3">
                    <ol>
                    	<p>规则说明：</p>
                        <li>求和：<em>422+606+165=1193</em>(将所有购买记录的时间毫秒值累加)</li>
                        <li>取余：<em>1193</em>(毫秒值累加之和)<em> % 3</em>(本商品总需参与人次)<em> = 2</em>(余数)</li>
                        <li>结果：<em>2</em>(余数) + 10000001(第一个众筹码) = <em>10000003</em> (最终结果)</li>
                    </ol>
                </td>
            </tr>
            <#list data as item>
            	<tr>
	            	<td><span class="date">${item.Create_Time?string("yyyy-MM-dd")!}</span></td>
	                <td>
	                    <span class="time">${item.Create_Time?string("HH:mm:ss.")!}${item.Order_Pay_Time_millsec?string('000')}</span>
	                </td>
	                <td><span class="usr">${item.Login_Name?substring(0,3)}****${item.Login_Name?substring(7)}</span></td>
            	</tr>
            </#list>
            </tbody></table>
    </div>
</div>
</body>
</html>