function beforunload(event) {
	event = event ? event : (window.event ? window.event : null);
	var myIE = myBrowser();
	if(myIE == "IE") { // IE  
		var cy = event.clientY || event.target.event.clientY;
		var ak = event.altKey || event.target.event.altKey;
		if(cy < 0 || ak) {
			return "确定要离开本页面吗？";
		}
	} else {
		// Firefox、Chrome  
		var nodeName = event.currentTarget.document.activeElement.nodeName;
		if(nodeName != "A") {
			return "确定要离开本页面吗？";
		}
	}
}

/*** 
 * 获取当前浏览器类型 
 */
function myBrowser() {
	var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
	var isOpera = userAgent.indexOf("Opera") > -1;
	if(isOpera) { //判断是否Opera浏览器  
		return "Opera"
	};
	if(userAgent.indexOf("Firefox") > -1) { //判断是否Firefox浏览器  
		return "FF";
	};
	if(userAgent.indexOf("Chrome") > -1) {
		return "Chrome";
	};
	if(userAgent.indexOf("Safari") > -1) { //判断是否Safari浏览器  
		return "Safari";
	};
	if(userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) { //判断是否IE浏览器  
		return "IE";
	};
}
//页面离开或者浏览器关闭的时候给予提示 防止用户误操作 离开当前页面未保存数据可能丢失  
window.onbeforeunload = function(event) {
	return beforunload(event);
};
//点击返回时，提醒用户数据会丢失
$(".exit,.backOne,.backHome").on("click", function(e) {
	//获取点击的是返回还是退出的class
	var backClass = $(this).attr("class");
	if(e && e.preventDefault) {
		e.preventDefault();
	} else {
		window.event.returnValue = false;
	}
	window.onbeforeunload = null;
	$("#popup1").show();
	/*点击提示数据丢失的确定按钮*/
	$("#yes").on("click", function() {
		$("#popup1").hide();
		if(backClass == "backOne") {
			location.href = basePath+"/activityApply";
		} else if(backClass == "exit") {
			location.href = basePath+"/exit";
		} else if(backClass == "backHome") {
			location.href = basePath+"/goHomePage";
		} else {
			alert("出错");
		}

	});
	/*点击提示数据丢失的取消按钮*/
	$("#no").on("click", function() {
		$("#popup1").hide();
	})
});
