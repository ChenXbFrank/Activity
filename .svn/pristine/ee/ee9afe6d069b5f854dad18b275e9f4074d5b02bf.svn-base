
$.ajax({
	data: {
	},
	type: "GET",
	dataType: "JSON",
	url: basePath+"/express/comPanyList",
	success: function(data) {
		for(var i in data.list){
			var li=$("<li onClick='clickLi(this)' onmouseover='mouseOver(this)'>"+data.list[i].NAME+"</li>");
			li.appendTo($("#express"));
		}
	},
	error: function() {
		alert("网络连接异常，请稍后再试");
	}
});

/*
 * 模拟下拉框————快递
 */
	var open = true;
	$("#bargaining-situations1").on("click", function(event) {
		event.stopPropagation(); //阻止冒泡
		if(open) {
			$("#express").show();
			open = false;
		} else {
			$("#express").hide();
			open = true;
		}
	});
	function clickLi(obj){
		event.stopPropagation(); //阻止冒泡
		$(obj).css("background", "#d0d0d0").siblings().css("background", "white");
		$("#bargaining-situations1").val($(obj).html());
		$("#express").hide();
		open = true;
	}
	$(document).click(function() {
		$("#express").hide();
		open = true;
	});

	function mouseOver(obj){
		$(obj).css("background", "#d0d0d0").siblings().css("background", "white");
	}
