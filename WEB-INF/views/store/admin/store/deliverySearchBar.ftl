<div>
    <input type="hidden" name="dateRange" id="dateRange" value="${dateRange!}">
    <input type="hidden" name="platformType" id="platformType" value="${(platformType.type)!}">
    <input type="hidden" name="type" id="type" value="${(type)!}">
    <input type="hidden" name="typeTemp" id="type" value="${(typeTemp)!}">
    <input type="hidden" name="flag" id="flag" value="${(flag)!}">

    <div class="row">
        <div class="control-group">
            <div class="controls control-row-auto" style="padding-bottom: 10px;">
                <div class="pull-left">
                    <input type="text" class="calendar control-text" name="startDate" id="startDate"
                           value="${startDate!}">
                    <span>&nbsp;至&nbsp;</span>
                    <input type="text" class="calendar control-text" name="endDate" id="endDate"
                           value="${endDate!}">
                    &nbsp;&nbsp;
                    
                    <input type="text" name="like_customer.username" id="username"
                           class="control-text" value="${username!}">
                    &nbsp;&nbsp;
                    <a id="searchLink" class="button button-primary">搜索</a>
                </div>
                <div class="steps steps-small pull-left" id="dateSelectContainer">
                    <ul>
                        <li class="step-first">
                            <div class="stepind" onclick="filterSearchByDateRange('thisWeek',0)">本周</div>
                        </li>
                        <li>
                            <div class="stepind" onclick="filterSearchByDateRange('lastWeek',1)">上周</div>
                        </li>
                        <li>
                            <div class="stepind" onclick="filterSearchByDateRange('thisMonth',2)">本月</div>
                        </li>
                        <li class="step-last">
                            <div class="stepind" onclick="filterSearchByDateRange('lastMonth',3)">上月</div>
                        </li>
                    </ul>
                </div>
                <div class="steps steps-small pull-left" id="plactformSelectContainer">
                    <a class="button" onclick="filterSearchByPlatformType('',0)">全部</a>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $(function () {
            $("#dateSelectContainer").find("li").each(function (index, element) {
                if ("${dateRange!}" == "thisWeek" && index == 0) {
                    $(this).addClass("step-active");
                } else if ("${dateRange!}" == "lastWeek" && index == 1) {
                    $(this).addClass("step-active");
                } else if ("${dateRange!}" == "thisMonth" && index == 2) {
                    $(this).addClass("step-active");
                } else if ("${dateRange!}" == "lastMonth" && index == 3) {
                    $(this).addClass("step-active");
                }
            })

            $("#plactformSelectContainer").find("a").each(function (index, element) {
                if ("${(platformType.type)!}" == "" && index == 0) {
                    $(this).addClass("button-primary");
                }
            })



            $("#searchLink").click(function () {
                $("#dateRange").val("");
                $("#dateSelectContainer").find("li").each(function (index, element) {
                    $(this).removeClass("step-active");
                })
                reload();
            });

            filterSearchByDateRange = function (dateRange, activeIndex) {
                if (dateRange == "thisWeek") {
                    $("#startDate").val("${thisWeek[0]!}");
                    $("#endDate").val("${thisWeek[1]!}");
                } else if (dateRange == "lastWeek") {
                    $("#startDate").val("${lastWeek[0]!}");
                    $("#endDate").val("${lastWeek[1]!}");
                } else if (dateRange == "thisMonth") {
                    $("#startDate").val("${thisMonth[0]!}");
                    $("#endDate").val("${thisMonth[1]!}");
                } else if (dateRange == "lastMonth") {
                    $("#startDate").val("${lastMonth[0]!}");
                    $("#endDate").val("${lastMonth[1]!}");
                }
                $("#dateRange").val(dateRange);

                $("#dateSelectContainer").find("li").each(function (index, element) {
                    if (activeIndex == index) {
                        $(this).addClass("step-active");
                    } else {
                        $(this).removeClass("step-active");
                    }
                })
                reload();
            }
            filterSearchByPlatformType = function (platformType, activeIndex) {
                $("#platformType").val(platformType);
                $("#plactformSelectContainer").find("a").each(function (index, element) {
                    if (activeIndex == index) {
                        $(this).addClass("button-primary");
                    } else {
                        $(this).removeClass("button-primary");
                    }
                })

                reload();
            }
            function reload() {
                if (!($("#dateRange").val()) || $("#dateRange").val() == "") {
                    if (!($("#startDate").val())) {
                        app.showError("开始时间不能为空");
                        return false;
                    }
                    if (!($("#endDate").val())) {
                        app.showError("结束时间不能为空");
                        return false;
                    }

                    var startDate = new Date(Date.parse(($("#startDate").val()).replace(/-/g, "/")));
                    var startDateTemp = new Date(startDate.getFullYear(), startDate.getMonth() + 6, startDate.getDate());
                    var endDate = new Date(Date.parse(($("#endDate").val()).replace(/-/g, "/")));
                    if (startDate.getTime() > endDate.getTime()) {
                        app.showError("选择开始时间必须早于结束时间");
                        return false;
                    }
                    if (startDateTemp.getTime() < endDate.getTime()) {
                        app.showError("开始时间、结束时间相差不能大于六个月，请重新选择时间！");
                        return false;
                    }
                }
                search.load(true);
            }

        });
    </script>
</div>