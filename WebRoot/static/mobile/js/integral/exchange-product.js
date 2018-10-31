/**
 * 监听上下滑动事件，根据开始滑动的位置和移动中的位置进行判断滑动方向,此方法中的执行顺序为touchStart、touchmove、touchend/scroll，
 * 所以会出现轻轻在手机上滑动时，会出发touch事件，但是没有触发到scroll事件，为bug，故放弃该方法
 */
/*var startX, startY, endX, endY;

function touchStart(event) {
	var touch = event.touches[0];
	startY = touch.pageY;
	startX = touch.pageX;
}

function touchMove(event) {
	var touch = event.touches[0];
	endY = startY - touch.pageY;
	endX = startX - touch.pageX;
}

function touchEnd(event) {
	    //向上滑动
	if(endY >0) {
		$(".scrollInfos").show();
		$(".suspend").removeClass("topPic");
		$(".topIcon").hide();
	}else{
		//向下滑动
		$(".scrollInfos").hide();
		$(".suspend").addClass("topPic");
		$(".topIcon").show();
	}
}
//文档监听触摸事件
document.addEventListener("touchstart",touchStart,false);
document.addEventListener("touchmove",touchMove,false);
document.addEventListener("touchend",touchEnd,false);*/


/**
 * 监听滚动开始和停止事件，此事件引用了scrollStop插件，在本项目中与下面的方法重复，故放弃
 */
/*(function() {
	jQuery(window).on('scrollstart', function(){
    });
 
    jQuery(window).on('scrollstop', function(e){
        $(".scrollInfos").hide();
		$(".suspend").addClass("topPic");
		$(".topIcon").show();
    });
 
})();*/



$(function(){
 /**
 * 滚动总数及索引值随之变化
 */
	//总共兑换奖品数量
	var lisLen=$("ul li").length;
	$(".allNum").html(lisLen);
	//滚动过程中随之变化
	$(document).on("scroll",function(){
		var scrollTop=$(document).scrollTop();
		var windowHeight=$(window).height();
		var h=scrollTop+windowHeight;
		for(var i=0;i<lisLen;i++){
			var liHeight=$("ul li").eq(0).height();
			var currentLiHeight=$("ul li").eq(i).offset().top;
			if(currentLiHeight+liHeight<h){
				$(".num").html(i+1);
			}
		}
	})
	
	
	
	/**
	 * 总结，最终用这种方法去实现判断滚动的方向以及停止滚动，定时查看之前的滚动条的值(oldTop)和当前的值(newTop)是否一致，当newTop>oldTop则
	 * 说明是在往上滚动，否则就是往下滚动，当相等说明停止滚动
	 */
var count = 0,
timer = null;
var oldTop = newTop = $(window).scrollTop(); //为了方便起见，使用jquery或者zepto框架
function log() {
	if(timer) { clearTimeout(timer) };
	newTop = $(window).scrollTop();
	if(newTop > oldTop) {
		//向上滑动
		$(".scrollInfos").show();
		$(".suspend").removeClass("topPic");
		$(".topIcon").hide();
	} else {
		//向下滑动或者停止滑动
		$(".scrollInfos").hide();
		$(".suspend").addClass("topPic");
		$(".topIcon").show();
	}
	oldTop = newTop;
	timer = setTimeout(log, 100);
}
$(window).on('scroll', log);


})


 

