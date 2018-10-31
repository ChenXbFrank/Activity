/*弹窗点击事件*/
var index;
var turntableWxUserId;
$(".render").on("click", function() {
	//清空收货人信息
	$(".receiver span").html("");
	$(".tel span").html("");
	$(".address span").html("");
	$("#popup").show();
	//找到收货人信息
	index = $(this).parent().parent().index();
	turntableWxUserId = $(this).parent().find(".turntableWxuserWinningId").val();
	//alert(index);
	var receiverName = $(this).parent().find(".receiverName").val();
	var receiverPhone = $(this).parent().find(".receiverPhone").val();
	var receiverAddress = $(this).parent().find(".receiverAddress").val();
	$(".receiver span").html(receiverName);
	$(".tel span").html(receiverPhone);
	$(".address span").html(receiverAddress);
	$(".succ-pop").show();
})
$("#receiver-yes").on("click", function() {
	$(".succ-pop").hide();
	$(".billInfos").show();
	$(".delivery-success").hide();
});
$("#delivery-success-yes").on('click', function() {
	$("#popup").hide();
	$(".succ-pop").hide();
	$(".billInfos").hide();
	$(".delivery-success").hide();
	location.reload();
});
$(".cancel").on("click", function() {
	$("#popup").hide();
	$(".succ-pop").hide();
	$(".billInfos").hide();
	$(".delivery-success").hide();
})

/*调用日期控件*/
jeDate({
	dateCell: "#date",
	format: "YYYY-MM-DD hh:mm:ss",
	isinitVal: true,
	isTime: true, //isClear:false,
	minDate: "2014-09-19 00:00:00"
});