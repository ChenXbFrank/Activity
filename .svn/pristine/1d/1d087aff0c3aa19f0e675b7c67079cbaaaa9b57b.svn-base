$(function(){
	var windowWidth=$(window).width();
	var windowHeight=$(window).height();
	if(windowWidth<=360 || windowHeight<=520){
		$(".index_nine .nine").css({
			"height":"3rem",
			"margin":"0 1% 0"
		});
		$(".btns").css({
			"margin-top":"0.2rem"
		});
		$(".shareInfo").css({
			"top":"8.46rem"
		});
		$(".thank .close").css({
			'margin-top':'1rem'
		});
		$(".award_background .close").css({
			"margin-top": "1.33rem"
		});
	}
	
	var breakEggWinningId1;
	//音乐自动播放
    $(document).ready(function(){
        autoPlayMusic();
        audioAutoPlay();
    });
    function audioAutoPlay() {
        var audio = document.getElementById('bg-music');
        audio.play();
        document.addEventListener("WeixinJSBridgeReady", function () {
            audio.play();
        }, false);
    }
    // 音乐播放
    function autoPlayMusic() {
        // 自动播放音乐效果，解决浏览器或者APP自动播放问题
        function musicInBrowserHandler() {
            musicPlay(true);
            document.body.removeEventListener('touchstart', musicInBrowserHandler);
        }
        document.body.addEventListener('touchstart', musicInBrowserHandler);
        // 自动播放音乐效果，解决微信自动播放问题
        function musicInWeixinHandler() {
            musicPlay(true);
            document.addEventListener("WeixinJSBridgeReady", function () {
                musicPlay(true);
            }, false);
            document.removeEventListener('DOMContentLoaded', musicInWeixinHandler);
        }
        document.addEventListener('DOMContentLoaded', musicInWeixinHandler);
    }
    function musicPlay(isPlay) {
        var media = document.querySelector('#bg-music');
        if (isPlay && media.paused) {
            media.play();
        }
        if (!isPlay && !media.paused) {
            media.pause();
        }
    }
     $(".music").click(function(){
        if($(".icon-music").attr("num") == "1"){
            $(".icon-music").removeClass("open");
            $(".icon-music").attr("num","2")
            $(".music-span").css("display","none");
            document.getElementById("bg-music").pause();//关闭音乐
            /*setTimeout(musicHide,2000);*/
        }else{
            $(".icon-music").attr("num","1");
            $(".icon-music").addClass("open");
            $(".music-span").css("display","block");
           document.getElementById("bg-music").play();//开启音乐
           /* setTimeout(musicHide,2000);*/
        }

	  });
	
	
	
	/*点击弹窗关闭*/
	$(".close").on("click",function(){
		$(".award_mask,.share_success,.share_success_second,.award_background,.rule_background,.myAward_bg,.finish,.run_out,.thank").hide();
	});
	$(".share_success .close,.award_background .close,.get_money_success .close,.finish .close,.run_out .close,.get_money_fail .close,.share_award_info,.thank .close").on("click",function(){
		location.reload();
	})
	/*点击活动规则*/
	$(".rule").on("click",function(){
		$(".award_mask,.rule_background").show();
	});
	/*点击立即分享按钮*/
	$(".nowShare").on("click",function(){
		$(".award_background,.thank,.award_mask").hide();
		$(".award_mask_share").show();
	})
	/*点击分享按钮*/
	$(".share").on("click",function(){
		$(".award_mask_share").show();
	})
	/*点击分享界面*/
	$('.award_mask_share,.share_award_info').on("click",function(){
		$(this).hide();
	})
})
