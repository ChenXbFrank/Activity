$(function() {
	//点击活动规则
	$(".rules").on("click", function() {
		$("#puzzle_rules").show();
	});
	
	//点击活动规则中的关闭
	$("#rules_close").on("click", function() {
		$("#puzzle_rules").hide();
	});
	//关闭中奖弹窗
	$("#award_close").on("click", function() {
		$("#puzzle_award").hide();
	})
	//关闭未中奖弹窗
	$("#noAward_close").on("click", function() {
		$("#puzzle_noAward").hide();
	})
	//点击我的奖品关闭按钮
	$("#myAward_close").on("click",function(){
		$("#myAward").hide();
	})
	//点击开始游戏
	$(".gameBegain").on("click", function() {
		$(".shouzhi").show();
		$(".shouzhi").click(function(){
			$(".shouzhi").hide();
			startPlayGame();
			//alert(11);
			$(".doorIner").hide();
			$(".doorInner_pic").show();
			var lookTime = $("#lookTime .times").html();
			timesCount(lookTime)
		})
		
	});
	var maskSuccess = document.getElementById('puzzle_award');
	var maskFail = document.getElementById('puzzle_noAward');
	var imgBox = document.getElementById('imgbox');
	var boxs=document.querySelectorAll('.box');
	var currentMoving = null; //当前正在移动的图片（主要用来限制同时只能移动一张图片）。
	var time = 0,
		timer1;
	var info = {
		x: 0,
		y: 0,
		top: 0,
		left: 0,
		moving: false,
	}
	var isGameOver=false;

	//倒计时
	function timesCount(lookTime) {
		var lookTimes = parseInt(lookTime);
		var lookTimeCount = setInterval(function() {
			if(lookTimes < 1) {
				//看的时间到,开始游戏
				$("#lookTime").hide();
				$("#playTime").show();
				//禁止移动的时候将背景一起移动
				document.body.addEventListener('touchmove', function(e) {
					e.preventDefault();
				});
				init();
				clearInterval(lookTimeCount);
			} else {
				lookTimes = lookTimes - 1;
				$("#lookTime .times").html(lookTimes);
			}

		}, 1000);
	}

	/**
	 * 初始化方法。完成的功能。
	 * 1.打乱原先的顺序。
	 * 2.给每个图片块添加滑动添加监听事件
	 */
	function init() {
		confound();
		var str = "";
		for(var i = 0; i < boxs.length; i++) {
			str += boxs[i].getAttribute("data-index");
		}
		addMoveListenerToAllPic();
		// 计时初始化
		var time = parseInt($("#times").html()); //游戏时间【后台传输】
		timer1 = setInterval(function() {
			var times = document.getElementById('times');
			times.innerHTML = time;
			if(time < 0) {
				times.innerHTML="0";
				//时间到！！！！
				gameOver(maskFail);
			}
			time = time - 1;
		}, 1000);
	}

	//游戏结束方法
	function gameOver(result) {
		if(!isGameOver){
			isGameOver=true;
			result.style.display = "block";
			//alert(result);
			if(result==maskFail){
				failAjax();
			}else if(result==maskSuccess){
				successAward();
			}
			
			
			
			//清除定时器
			clearInterval(timer1);
	
			setTimeout(function() {
				//清除监听事件
				removeAllTouchListener();
			}, 500);
		}
	}

	/*混淆函数。*/
	function confound() {
		for(var i = 1; i < 20; i++) {
			var a = Math.floor(Math.random() * 1000) % 9;
			var b = Math.floor(Math.random() * 1000) % 9;

			if(a != b) {
				//交换boxs[a] 与boxs[b]
				var _left = boxs[a].style.left;
				boxs[a].style.left = boxs[b].style.left;
				boxs[b].style.left = _left;

				var _top = boxs[a].style.top;
				boxs[a].style.top = boxs[b].style.top;
				boxs[b].style.top = _top;

				var _index = boxs[a].getAttribute("data-index");
				boxs[a].setAttribute("data-index", boxs[b].getAttribute("data-index"));
				boxs[b].setAttribute("data-index", _index);
			}
		}

	}

	/*
	 * 移除事件：
	 * 1.触摸开始
	 * 2.移动
	 * 3.触摸结束
	 */
	function removeAllTouchListener() {
		for(var i = 0; i < boxs.length; i++) {
			//解绑click方法！！！！
			$(boxs[i]).off("touchstart");

			$(boxs[i]).off("touchmove");

			$(boxs[i]).off("touchend");
		}
	}

	/*
	 * 给所有图片添加移动事件
	 * 1.touchstart
	 * 2.touchmove
	 * 3.touchend
	 */
	function addMoveListenerToAllPic() {
		for(var i = 0; i < boxs.length; i++) {
			//1.触摸开始
			$(boxs[i]).on("touchstart", function(e) {
				if(currentMoving == null) {
					currentMoving = this;
				}

				if(currentMoving.getAttribute("data-index") == this.getAttribute("data-index") && info.moving == false) {
					info.x = e.targetTouches[0].pageX;
					info.y = e.targetTouches[0].pageY;
					info.top = parseInt(this.style.top);
					info.left = parseInt(this.style.left);
					info.moving = true;

					//缓存起点位置  给元素加了两个属性
					this.oriLeft = info.left;
					this.oriTop = info.top;

					//不要动画
					this.style.transition = "none";
				}
			});

			//2.移动事件
			$(boxs[i]).on("touchmove", function(e) {
				if(currentMoving.getAttribute("data-index") == this.getAttribute("data-index")) {
					//newTop - newY = top - Y
					//newTop = top -y + newY
					this.style["z-index"] = 1000;
					var newTop = info.top - info.y + e.targetTouches[0].pageY;
					var newLeft = info.left - info.x + e.targetTouches[0].pageX;

					this.style.left = newLeft + "px";
					this.style.top = newTop + "px";
				}
			});
			//移动结束事件
			$(boxs[i]).on("touchend", function(e) {
				if(currentMoving.getAttribute("data-index") == this.getAttribute("data-index")) {
					this.style.transition = " all 0.5s";
					this.style["z-index"] = 0;
					//对每 个元素进行检测
					// x > 元素的.offsetLeft && x <元素的.offsetLeft+ 100
					// y > 元素的.offsetTop && x <元素的.offsetTop+ 100
					var x = e.changedTouches[0].pageX - imgBox.offsetLeft,
						y = e.changedTouches[0].pageY - imgBox.offsetTop;
					//console.log(x, y); //.targetTouches[0].pageX,e.targetTouches[0].pageY);
					//通过当前 x,y来找到应该要交换的元素是哪个？
					var obj = findSwtichBox(this, x, y);

					if(obj === this) { //不要交换元素
						//从哪里来就回到哪里去。
						obj.style.left = obj.oriLeft + "px";
						obj.style.top = obj.oriTop + "px";
					} else {
						swtichBoxs(this, obj);
						setTimeout(function(){
							if(isOk()) {
								gameOver(maskSuccess);
							}
						},500)

					}
					currentMoving = null;
					info = {
						x: 0,
						y: 0,
						top: 0,
						left: 0,
						moving: false
					}
				}

			});
		}

	}

	function isOk() {
		// 思路：对每一个box设置一个“序号”（data-index）属性。每次交换后，都检查一下当前的元素的顺序是否与成功的序号是一致的。
		// 获取所有的元素的序号
		var str = "";
		for(var i = 0; i < boxs.length; i++) {
			str += boxs[i].getAttribute("data-index");
		}
		return str == "012345678";

	}
	//交换a，b元素的位置
	function swtichBoxs(oriEle, targetEle) {
		var _top = oriEle.oriTop; // var t = a;
		oriEle.style.top = targetEle.style.top; // a = b;
		targetEle.style.top = _top + "px"; // b = t;

		//把targetEle的top设置为oriEle的oriTop;
		var _left = oriEle.oriLeft; // var t = a;
		oriEle.style.left = targetEle.style.left; // a = b;
		targetEle.style.left = _left + "px"; // b = t;

		//交换data-index值
		var _index = oriEle.getAttribute("data-index");
		oriEle.setAttribute("data-index", targetEle.getAttribute("data-index"));
		targetEle.setAttribute("data-index", _index);

	}
	//根据x,y的值，看当前的x，y落在box中的哪一个元素上。
	function findSwtichBox(obj, x, y) {
		//自己不参与检查
		for(var i = 0; i < boxs.length; i++) {
			if(obj !== boxs[i]) {
				var t1 = x > boxs[i].offsetLeft && x < (boxs[i].offsetLeft + 82.5);
				var t2 = y > boxs[i].offsetTop && y < (boxs[i].offsetTop + 82.5);
				if(t1 && t2) {
					//console.info(boxs[i]); 找到目标
					console.log(boxs[i]);
					return boxs[i];
				}
			}

		}
		return obj; //没有找到目标，即返回自己
	}

})