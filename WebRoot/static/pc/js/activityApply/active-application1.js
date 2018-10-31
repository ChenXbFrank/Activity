$(".activities ul li").click(function() {
	var skipObj=new Object();
	skipObj.href=$(this).find(".getHref").val();
	skipObj.activityName=$(this).find(".activity-name").html();
	$("#skip").attr("href",skipObj.href);
	$("#applayActivityName").html(skipObj.activityName);
	$(".popUp").show();
});
$(".close,.btn-left").on("click", function() {
	$(".popUp").hide();
})

