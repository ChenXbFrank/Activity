function getDate(){
		var dt=new Date().toLocaleString();
		var index=dt.indexOf(" ");
		var date=dt.substring(0,index);
		var time=dt.substring(index);
		$('#date').html(date);
		$('#week').html('星期' + '日一二三四五六'.charAt(new Date().getDay()));
		$('#time').html(time);
	}
$(function() {
	/**
	 * 判断用户是否已经配置公众号，true表示已经配置了，false表示未配置
	 */
	var result=$("#result").val();
	if(result=="true"){
		$(".popUp").hide();
	}else{
		$(".popUp").show();
	};
	
	$(".title-pic li").on("mousedown", function() {
		$(this).css("background", "#0D58AE").siblings().css("background", "transparent");
	});
	getDate();
	setInterval(function(){
		getDate();
	},1000);
	
	$(".close,.btn-left").on("click", function() {
		$(".popUp").hide();
	})
	
})