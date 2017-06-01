<script>
    // 分页组件
    avalon.component('ms-pager', {
        template: '<div class="pr-pager noborder">' +
        '<div class="pager">' +
        '<a href="#" :click="@prev">&lt;上一页</a>' +
        '<span :for="pageNum in @pageNumList">' +
        '<a :if="pageNum != pageNo && pageNum != omit" href="javascript:void(0)" :click="toPage(pageNum)">{{pageNum}}</a>' +
        '<a :if="pageNum == pageNo" class="cur">{{pageNum}}</a>' +
        '<a :if="pageNum == omit">{{pageNum}}</a>' +
        '</span>' +
        '<a href="#" :click="@next">下一页&gt;</a>' +
        '</div>' +
        '</div>',
        defaults: {
            pageNo: 1,
            pageSize: 5,
            pageCount: 0,
            callback: null,
            // ---数据---
            $computed: {
                omit: function() {
                    return "...";
                },
                // 总页数
                pageNumCount: function () {
                    return Math.ceil(this.pageCount / this.pageSize);
                },
                // 真正显示在页面上的页码
                pageNumList: function () {
                    var pageNumList = [];
                    // 少于五个直接打印所有页码
                    if (this.pageNumCount <= 5) {
                        for (var i = 1; i <= this.pageNumCount; i++) {
                            pageNumList.push(i)
                        }
                    } else {
                        var startIndex = this.pageNo - 2; // 起始页码
                        var endIndex = this.pageNo + 2; // 结束页码
                        // 处理页码越界
                        if (startIndex < 1) {
                            startIndex = 1;
                        } else if (endIndex > this.pageNumCount) {
                            startIndex = this.pageNumCount - 4;
                        }
                        // 生成五条页码
                        for (var i = startIndex; i < startIndex + 5; i++) {
                            pageNumList.push(i);
                        }
                    }

                    // 起始页码大于1
                    if (startIndex > 1) {
                        // 大于2时加省略号
                        if (startIndex > 2) {
                            pageNumList.unshift(this.omit)
                        }
                        // 加第一页页码
                        pageNumList.unshift(1);
                    }
                    // 结束页码小于最大页数
                    if (endIndex < this.pageNumCount) {
                        // 结束页码小于最大页数减1时加省略号
                        if (endIndex < this.pageNumCount - 1) {
                            pageNumList.push(this.omit)
                        }
                        // 加最后一页页码
                        pageNumList.push(this.pageNumCount);
                    }
                    return pageNumList;
                }
            },
            // ---方法---
            // 上一页
            prev: function () {
                if (this.pageNo != 1) {
                    this.callback(this.pageNo - 1);
                }
            },
            // 下一页
            next: function () {
                if (this.pageNo != this.pageNumCount) {
                    this.callback(this.pageNo + 1);
                }
            },
            // 点击页码跳转
            toPage: function (pageNum) {
                this.callback(pageNum);
            }
        }
    });
</script>