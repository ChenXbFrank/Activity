$(function() {
	//点击全部和申请中按钮
	$(".btn div").on("click", function() {
		var index = $(this).index();
		$(this).addClass("selected").siblings().removeClass("selected").addClass("noSelected");
	});

	//点击添加活动按钮让弹窗显示和隐藏
	$(".btn .buttonAdd").click(function() {
		$(".popUp").show();
	});
	$(".close,.btn-left").on("click", function() {
		$(".popUp").hide();
	});
	/*
	 * 模拟下拉框
	 */
	var open=true;
	$("#bargaining-situations").on("click",function(event){
		 event.stopPropagation();//阻止冒泡
	 	if(open){
	 		$(".select").show();
	 		open=false;
	 	}else{
	 		$(".select").hide();
	 		open=true;
	 	}
	});
	$(".outer ul li").on("click",function(event){
		 //this指当前的这个Li
		  event.stopPropagation();//阻止冒泡
		$(this).css("background","#d0d0d0").siblings().css("background","white");
		$("#bargaining-situations").val($(this).html());
		$(".select").hide();
		open=true;
	})
	$(document).click(function(){
			$(".select").hide();
			open=true;
	});
	
	$(".outer ul li").on("mouseover",function(){
	   //this指当前的这个Li
		$(this).css("background","#d0d0d0").siblings().css("background","white");
	});	

})