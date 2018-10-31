		$(function() {
			var awards = [{ name: "尖庄酒", angle: "", src: "../../img/turntable/hongbao-0.png", number: "1瓶", id: "0" },
				{ name: "玉米", angle: "", src: "../../img/turntable/hongbao-0.png", number: "10克", id: "1" },
				{ name: "米", angle: "", src: "../../img/turntable/gift-0.png", number: "100克", id: "2" },
				{ name: "高粱糯米", angle: "", src: "../../img/turntable/hongbao-0.png", number: "20克", id: "3" },
				{ name: "糯米", angle: "", src: "../../img/turntable/gift-0.png", number: "30克", id: "4" },
				{ name: "杯子糯中奖", angle: "", src: "../../img/turntable/gift-0.png", number: "40克", id: "5" },
				{ name: "五粮液杯子", angle: "", src: "../../img/turntable/gift-0.png", number: "1套", id: "6" },
				{ name: "华彩人生荣", angle: "", src: "../../img/turntable/gift-0.png", number: "1箱", id: "7" },
			]
			//可抽奖次数后台传值判断
			var clickNum = 3;
			$('#tupBtn').on('click', function() {
				if(clickNum >= 1) {
					//可抽奖次数减一
					clickNum = clickNum - 1;
					var award = "4"; //后台传给我
					var awardProduceInfo = getAngleByNameOnAwards(award);
					var angle = awardProduceInfo.stopAngle;
					//转盘旋转
					if(award == undefined || angle == undefined) {
						alert('加载出错，请重新加载！')
					}
					runCup(angle);
					//转盘旋转过程“开始抽奖”按钮无法点击
					$('#tupBtn').attr("disabled", true);
					//“开始抽奖”按钮无法点击恢复点击
					setTimeout(function() {
						$('#tupBtn').removeAttr("disabled", true);
						$('.awardProduce').attr('src', awardProduceInfo.stopSrc);
						$('.awardProduceName').html(awardProduceInfo.stopName + awardProduceInfo.stopNumber);
						$('body').css("overflow", "hidden");
						if($("#times").html() > 0) {
							$(".onceAgin").css("background-image", "url('../../img/turntable/one-more-time-1.png')")
						} else {
							$(".onceAgin").css("background-image", "url('../../img/turntable/nomore-chance-1.png')")
						}
						$('.award-mask').show();
					}, 3000);
				} else {
					alert("亲，抽奖次数已用光！");
				}
			});

			var colorSix = ['#46B8CD', '#98E5F2'];
			var colorEight = ['#ff8c51', '#feb152'];
			var canvas = document.getElementById('myCanvas');
			var ctx = canvas.getContext('2d');
			//解决canvas的清晰度，画的时候将画布和画的过程扩大两倍
			ctx.scale(2, 2);
			/**
			 * 画外圆
			 */
			function createCircle() {
				//lineWidth:圆环的宽度
				var num = awards.length;
				ctx.lineWidth = 104;
				var line_width = ctx.lineWidth;
				var startAngle = 0; //扇形的开始弧度
				var endAngle = 0; //扇形的终止弧度
				var x = canvas.width / 4,
					y = canvas.height / 4;
				var color = num == 6 ? colorSix : colorEight;
				for(var i = 0; i < num; i++) {
					startAngle = -Math.PI / 2 - Math.PI / num + 2 * Math.PI / num * i;
					endAngle = -Math.PI / 2 + Math.PI / num + 2 * Math.PI / num * i;
					ctx.save();
					ctx.beginPath();
					ctx.arc(x, y, x - 65, startAngle, endAngle, false);
					var colorIndex = i % 2;
					ctx.strokeStyle = color[colorIndex];
					ctx.stroke();
					ctx.closePath();
					ctx.restore();
				}
			}
			/**
			 * 创建文本文字
			 * @param {Object} awards
			 */
			function createCirText() {
				ctx.textAlign = 'start';
				ctx.textBaseline = 'middle';
				var step = 2 * Math.PI / awards.length;
				var textStartOption;
				for(var i = 0; i < awards.length; i++) {
					var awardNameLength = awards[i].name.length;
					if(awardNameLength == 1) {
						textStartOption = -8;
					} else if(awardNameLength == 2) {
						textStartOption = -14;
					} else if(awardNameLength == 3) {
						textStartOption = -18;
					} else if(awardNameLength == 4) {
						textStartOption = -23;
					} else if(awardNameLength == 5) {
						textStartOption = -28;
					}
					ctx.save();
					ctx.beginPath();
					//ctx.translate将坐标向右和向上各平移150，类似将画布移动
					ctx.translate(150, 150);
					//ctx.rotate将画布旋转多少度，旋转中心是画布的原点
					ctx.rotate(i * step);
					awards[i].angle = (-i * step * 180 / Math.PI);
					ctx.font = "10px Microsoft YaHei";
					ctx.fillStyle = 'white';
					ctx.shadowColor = "rgba(52,158,178,0.3)";
					ctx.shadowBlur = 7;
					ctx.shadowOffsetY = 2;
					ctx.fillText(awards[i].name, textStartOption, -120);
					ctx.closePath();
					ctx.restore();
				}
			}
			/**
			 * 画奖品图片
			 */
			function createCirPic() {
				var step = 2 * Math.PI / awards.length;
				for(var i = 0; i < awards.length; i++) {
					(function(i) {
						var img = new Image();
						img.src = awards[i].src;
						img.onload = function() {
							ctx.save();
							ctx.beginPath();
							ctx.translate(150, 150);
							ctx.rotate(i * step);
							if(awards[i].src == '../../img/turntable/hongbao-0.png') {
								ctx.drawImage(img, -9, -100, 18, 24);
							} else if(awards[i].src == '../../img/turntable/gift-0.png') {
								ctx.drawImage(img, -16, -100, 32, 32);
							}
							ctx.closePath();
							ctx.restore();
						}
					})(i)

				}
			}

			function turntable(awards) {
				createCircle();
				createCirText();
				createCirPic();
			}
			/**
			 * 通过中奖id获取角度
			 * @param {Object} name
			 */
			function getAngleByNameOnAwards(id) {
				for(var i = 0; i < awards.length; i++) {
					if(id == awards[i].id) {
						return {
							stopName: awards[i].name,
							stopAngle: awards[i].angle,
							stopSrc: awards[i].src,
							stopNumber: awards[i].number,
							stopId: awards[i].id
						}
					}
				}
			}
			var last = 0;
			var angles = 0;

			function runCup(angle) {
				var num = parseInt(Math.random() * (7 - 0 + 0) + 0);
				//var angles = 2160 * num + angle;
				//转动速度快慢在这里设置
				angles += 1080 + angle - last;
				console.log(angles);
				var degValue = 'rotate(' + angles + 'deg' + ')';
				$('#myCanvas').css('-o-transform', degValue); //Opera
				$('#myCanvas').css('-ms-transform', degValue); //IE浏览器
				$('#myCanvas').css('-moz-transform', degValue); //Firefox
				$('#myCanvas').css('-webkit-transform', degValue); //Chrome和Safari
				$('#myCanvas').css('transform', degValue);
				last = angle;
			}
			turntable(awards);
			/**
			 * 抽奖规则弹窗
			 */
			$('.mask').hide();
			$('#rule-info').on('click', function() {
				$('.mask').show();
			})
			$('#butn').on('click', function() {
				$('.mask').hide();
			});

			/**
			 * 抽奖中积分奖之后的遮罩页面
			 */

			/*$('.award-mask').hide();*/
		})