<#--<script>-->
(function(w){
    "use strict";
    var _extend = function(a, b) {
        var _extend_ = function(a, b) {
            for (var key in b) {
                a[key] = b[key];
            }
            return a;
        };
        return _extend_(_extend_({}, a), b);
    };
    var _options = {
        img_url: (function(cacheData){
            cacheData = cacheData || {};
            var url = cacheData["_pcUrl"] || "",
                    logo = cacheData["_mobileLogo"] || "";
            var imgList = document.getElementsByTagName("img");
            if (imgList && imgList.length > 0) {
                return imgList[0].src;
            } else {
                return url + (logo || "");
            }
        }(window["cache_data"])),                // 分享图片绝对路径
        imgWidth: "200",           // 图片宽度
        imgHeight: "200",          // 图片高度
        link: location.href,       // 分享链接，默认取网站域名(不含端口信息)
        desc: location.href,       // 分享描述
        title: (function(h){
            if (!h || !h.getElementsByTagName("title")) return "";
            return h.getElementsByTagName("title")[0].innerHTML;
        }(document.head))           // 分享标题，默认取网站html中的title值
    };
    var wx = w.wx || {
        config: function (data) {
            console && console.log && console.log("加载官方API失败");
        }
    };
    wx.config({
        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: '${(cache.appId)!}', // 必填，公众号的唯一标识
        timestamp: '${(cache.timestamp)!}', // 必填，生成签名的时间戳
        nonceStr: '${(cache.noncestr)!}', // 必填，生成签名的随机串
        signature: '${(cache.signature)!}',// 必填，签名，见附录1
        jsApiList: ["onMenuShareTimeline", "onMenuShareAppMessage", "onMenuShareQQ", "onMenuShareWeibo", "showOptionMenu", "hideOptionMenu"] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });

    if(wx){
        //alert("wx");

        if(wx.ready){
            //alert("wx.ready");

            wx.ready(function() {
                //alert("wx.ready(function()");

                var wxapi = _extend(wxapi, {
                    sendAppMessage : function (data) {
                        wx.onMenuShareAppMessage(data);
                        return this;
                    },
                    shareTimeline : function(data) {
                        wx.onMenuShareTimeline(data);
                        return this;
                    },
                    shareAll : function(data) {
                        //alert("shareAll function()");

                        if (!wx) return 0;

                        //alert("data.img_url == "+data.img_url);

                        data.imgUrl = data.img_url || "", data = _extend(_options, data || {});
                        this.sendAppMessage(data);
                        this.shareTimeline(data);
                        return this;
                    },
                    showMenu : function() {
                        wx.showOptionMenu();
                    },
                    hideMenu : function() {
                        wx.hideOptionMenu();
                    }
                });
                w.wxapi = wxapi;
                if (window.wxData && window.wxData.showMenu) {
                    wxapi.showMenu();
                } else {
                    //wxapi.hideMenu();
                }
                // 如果有初始化数据则直接从初始化数据获取
                wxapi.shareAll(w["wxData"] || {});
            });
        }else{
            //alert("wx.ready");
        }
    }else{
        //alert("wx 不存在");
    }
}(window));
<#--</script>-->
