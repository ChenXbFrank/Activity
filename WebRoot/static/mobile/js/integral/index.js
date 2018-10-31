$(function() {
	//此方法能连续，但是在安卓手机上却会卡顿
	/*function rollTwo(){
		$('ul').animate({"margin-top":"-0.48rem"},1000,'linear',function(){
			$("ul li").eq(0).remove().clone().appendTo($("ul"));
			$(this).css("margin-top","0px");
		});
	};
	setInterval(rollTwo,2000);*/

	//有缝轮播
	$('ul li').each(function() {
		$(this).clone().appendTo($("ul"));
	});
	var len = $("ul li").length;
	var i = 0;

	function rollOne() {
		i++;
		if(i > len / 2) {
			i = 0;
			$("ul").css({
				'transform': 'translate3d(0,0,0)',
				"transition": "all 0ms"
			})
		} else {
			var y = -0.48 * i + "rem";
			$("ul").css({
				'transform': 'translate3d(0,' + y + ',0)',
				"transition": "all 1000ms"
			})
		}

	}

	//无缝轮播，此方法会生成很多个标签li ，方法不佳
	/*var i=0;
	function rollOne(){
		i++;
		var y=-0.48*i+"rem";
		$("ul").css({
			'transform':'translate3d(0,'+y+',0)',
			"transition":"all 1000ms"
		})
		$("ul li").eq(i-1).clone().appendTo($("ul"));
	}*/

	setInterval(rollOne, 2000);

	$(".turntable,.integral").on("click", function() {
		$(this).addClass("clickType");
	})
})