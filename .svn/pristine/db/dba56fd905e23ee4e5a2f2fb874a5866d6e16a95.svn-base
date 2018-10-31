$(function() {
	/*
	 * 表格样式
	 */
	var tbodyOuterHeight = $("#table-outer .table-tbody").height();
	var tbodyHeight = $("#table-outer .table-tbody table").height();
	if(tbodyOuterHeight < tbodyHeight) {
		$("#table-outer").css({
			"border-bottom": "1px solid #D4D4D4",
		})
	} else {
		$("#table-outer").css({
			"border-bottom": "none",
		})
	}

	/*
	 * 模拟下拉框
	 */
	var open = true;
	$("#bargaining-situations").on("click", function(event) {
		
		event.stopPropagation(); //阻止冒泡
		if(open) {
			$(".select").show();
			$(".select1").show();
			open = false;
		} else {
			$(".select").hide();
			$(".select1").hide();
			open = true;
		}
	});
	$(".outer ul li").on("click", function(event) {
		//this指当前的这个Li
		event.stopPropagation(); //阻止冒泡
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
		$("#bargaining-situations").val($(this).html());
		$(".select").hide();
		$(".select1").hide();
		open = true;
	})
	$(document).click(function() {
		$(".select").hide();
		$(".select1").hide();
		open = true;
	});

	$(".outer ul li").on("mouseover", function() {
		//this指当前的这个Li
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
	});

})