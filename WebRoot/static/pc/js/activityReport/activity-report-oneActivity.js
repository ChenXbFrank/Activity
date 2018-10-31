	/*
	 * 模拟下拉框
	 */
	$(function() {
		var open = true;
		$("#bargaining-situations").on("click", function(event) {
			event.stopPropagation(); //阻止冒泡
			if(open) {
				$(".select").show();
				open = false;
			} else {
				$(".select").hide();
				open = true;
			}
		});
		$(".outer ul li").on("click", function(event) {
			//this指当前的这个Li
			event.stopPropagation(); //阻止冒泡
			$(this).css("background", "#d0d0d0").siblings().css("background", "white");
			$("#bargaining-situations").val($(this).html());
			$(".select").hide();
			open = true;
		})
		$(document).click(function() {
			$(".select").hide();
			open = true;
		});

		$(".outer ul li").on("mouseover", function() {
			//this指当前的这个Li
			$(this).css("background", "#d0d0d0").siblings().css("background", "white");
		});

		//日期开始
		$("#startTime").datepicker({
			onSelect: function(startText) {
				maxDate: new Date(),
				startText = $('#startTime').val(); //开始时间
				$('#endTime').datepicker('option', 'minDate', startText);
			}
		});

		//结束时间
		$("#endTime").datepicker({
			onSelect: function(endText) {
				endText = $('#endTime').val();
				$('#startTime').datepicker('option', 'maxDate', endText);
			}
		});
	})