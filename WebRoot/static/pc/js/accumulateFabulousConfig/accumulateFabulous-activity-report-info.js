var index;
var accumulateFabulousWxuserWinningId;
$(".render").on("click", function() {
	$(".receiver span").html("");
	$(".tel span").html("");
	$(".address span").html("");
	$("#popup").show();
	index = $(this).parent().parent().index();
	accumulateFabulousWxuserWinningId = $(this).parent().find(".accumulateFabulousWxuserWinningId").val();
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

/*时间插件*/
jeDate({
	dateCell: "#date",
	format: "YYYY-MM-DD hh:mm:ss",
	isinitVal: true,
	isTime: true, //isClear:false,
	minDate: "2014-09-19 00:00:00"
});