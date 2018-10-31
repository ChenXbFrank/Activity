var billLists = [];
var resultArr2 = [];

$("#bill-btn #ok").on("click", function() {

	billLists.length = 0;
	$("#billPop1 input[type='checkbox']:checked").each(function(index, value) {
		var obj = {};
		obj.getProductId = $(this).val();
		$(this).parent().siblings().each(function(index, value) {
			/*if(index == 0) {
				obj.serialnumber = $(this).html();
			} else */
			if(index == 1) {
				obj.productname = $(this).html();
			} else if(index == 2) {
				obj.specifications = $(this).html();
			} else if(index == 3) {
				obj.degrees = $(this).html();
			} else if(index == 4) {
				obj.capacity = $(this).html();
			}
		});
		billLists.push(obj);
	//	console.log(billLists);
	})
	var trsLen = billLists.length;
	/*console.log(billLists)*/
	//动态创建表格

	CreateTableWayBill(trsLen, billLists);


});  
$(".addPic").click(function(){

})
/*点击积分关联活动表格中每一行的delete就会删除该行的数据*/
function deleteTr(obj) {
	var index = $(obj).parent('tr').index();
	/*刪除对应的数组项*/
	resultArr.splice(index, 1);
	$(obj).parent('tr').remove();
	/*CreateTableIntegralAssociated(resultArr.length, resultArr);*/
}
/*点击积分关联活动表格中每一行的delete就会删除该行的数据*/
function deleteTwoTr(obj) {
	var index = $(obj).parent('tr').index();
	/*刪除对应的数组项*/
	resultArr2.splice(index, 1);
	$(obj).parent('tr').remove();


/*	CreateTableWayBill();*/
}
/*动态创建积分关联活动表格*/
function createTableOtherNew1(rowCount, content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	$('#table-outer1 .table-tbody table').html("");
	for(var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer1 .table-tbody table'));
		var td1 = $('<td>' + (i + 1) +
		'</td>');
		var td2 = $('<td>' + content[i].name +
			'</td>');
		var td3 = $('<td>' + content[i].type +
			'</td>');
		var td4= $('<td>' + content[i].weight +
			'</td>');
		var td5 = $("<td><span class='look0' onClick='modify(this)'>修改</span>&nbsp;<span class='del' onclick='deleteOtherProduct1(this)'>删除</span></td>");
		td1.appendTo(tr);
		td2.appendTo(tr);
		td3.appendTo(tr);
		td4.appendTo(tr);
		td5.appendTo(tr);
	}
};

/*点击奖品设置出现/隐藏弹窗*/

$("#otherPic9").on("click", function() {
			if(addAwards.length >= 8) {
				$("#otherProduct3").hide();
				$("#otherPic9").hide();
			} else {
				$("#otherProduct3").show();
				//清空弹窗里面的输入框
				$("#bargaining-situation").val("");
				$("#proName3").val("");
				$("#proNum3").val("");
				$("#integral").val("");
				$("#money").val("");
				isClickWhere = false;
			}
		


});
$("#otherPro-close,#otherPic-cancel").on("click", function() {
	$("#otherProduct3").hide();
});
/*
 * 模拟下拉框
 */
var open = true;
$("#bargaining-situation").on("click", function(event) {
	event.stopPropagation(); //阻止冒泡
	if(open) {
		$(".select").show();
		open = false;
	} else {
		$(".select").hide();
		open = true;
	}
});
$(".addPic-left .outer ul li").on("click", function(event) {
	//this指当前的这个Li
	event.stopPropagation(); //阻止冒泡
	$(this).css("background", "#d0d0d0").siblings().css("background", "white");
	$("#bargaining-situation").val($(this).html());
	$(".select").hide();
	open = true;
})
$(document).click(function() {
	$(".select").hide();
	open = true;
});
$(".addPic-left .outer ul li").on("mouseover", function() {
	//this指当前的这个Li
	$(this).css("background", "#d0d0d0").siblings().css("background", "white");
});
/*改变奖品类型的下拉框时，分别出现不同数据配置*/
$(".addPic-left ul li").on("click", function() {
	var awardType = $("#bargaining-situation").val();
	if(awardType == "红包") {
		$(".proName").show();
		$(".redBag").show();
		$(".matter,.integral,.thanks").hide();
		$("#proName3").val("红包");
	} else if(awardType == "积分") {
		$(".proName").show();
		$(".integral").show();
		$(".matter,.redBag,.thanks").hide();
		$("#proName3").val("积分");
	} else if(awardType == "实物") {
		$(".proName").show();
		$(".matter").show();
		$(".integral,.redBag,.thanks").hide();
		$("#proName3").val("");
	} else if(awardType == "谢谢惠顾") {
		$(".thanks").show();
		$(".integral,.redBag,.matter").hide();
		$(".proName").hide();
		$("#proName3").val("");
	}
});
var addAwards = [];
//当点击奖品设置的按钮时
$("#otherPic-save3").on("click", function() {
	if(addAwards.length >= 7) {
		$("#otherPic9").hide();
	}
	var volidSuccess = false;
	//验证弹窗的输入框信息是否填写完整
	if($("#bargaining-situation").val() != "" && $("#proNum3").val() != "" ) {
		if($("#bargaining-situation").val() == "红包") {
			if($("#money").val() != "" && $("#proName3").val() != "") {
				$("#otherProduct3").hide();
				volidSuccess = true;
			} else {
				$(".tishi4").show();
				$(".tishi4 .yes4").on("click", function() {
					$(".tishi4").hide();
				})
			}
		} else if($("#bargaining-situation").val() == "积分") {
			if($("#integral").val() != "" && $("#proName3").val() != "") {
				$("#otherProduct3").hide();
				volidSuccess = true;
			} else {
				$(".tishi4").show();
				$(".tishi4 .yes4").on("click", function() {
					$(".tishi4").hide();
				})
			}
		} else if($("#bargaining-situation").val() == "实物") {
			/**/
			if($("#pic3").attr("src").indexOf("upload") > -1 && $("#proName3").val() != "") {
				$("#otherProduct3").hide();
				volidSuccess = true;
			} else {
				$(".tishi4").show();
				$(".tishi4 .yes4").on("click", function() {
					$(".tishi4").hide();
				})
			}
			/**/
		} else if($("#bargaining-situation").val() == "谢谢惠顾") {
			$("#otherProduct3").hide();
			volidSuccess = true;
		}
	} else {
		$(".tishi4").show();
		$(".tishi4 .yes4").on("click", function() {
			$(".tishi4").hide();
		})
	}

	if(volidSuccess) {
		if(isClickWhere) {
			addAwards[index].type = $("#bargaining-situation").val();
			addAwards[index].name = $("#proName3").val();
			addAwards[index].weight = $("#proNum3").val();
			var awardType = addAwards[index].type;
			if(awardType == "红包") {
				addAwards[index].name = $("#proName3").val('红包');
				addAwards[index].money = $("#money").val();
			} else if(awardType == "积分") {
				addAwards[index].integral = $("#integral").val();;
			} else if(awardType == "实物") {
				addAwards[index].picture = $("#pic3").attr("src");
			} else if(awardType == "谢谢惠顾") {}
			createTableOtherNew1(addAwards.length, addAwards);
		} else {
			var addAwardObj = new Object();
			addAwardObj.type = $("#bargaining-situation").val();
			if($("#bargaining-situation").val() == "谢谢惠顾") {
				addAwardObj.name = "谢谢惠顾";
				addAwardObj.picture = "";
				addAwardObj.money = "";
				addAwardObj.integral = "";
			} else {
				if($("#bargaining-situation").val() == "实物") {
					addAwardObj.picture = $("#pic3").attr("src");
					addAwardObj.money = "";
					addAwardObj.integral = "";
				} else if($("#bargaining-situation").val() == "红包") {
					addAwardObj.money = $("#money").val();
					addAwardObj.picture = " ";
					addAwardObj.integral = "0";
				} else if($("#bargaining-situation").val() == "积分") {
					addAwardObj.integral = $("#integral").val();
					addAwardObj.picture = " ";
					addAwardObj.money = "0";
				}
				addAwardObj.name = $("#proName3").val();
			}
			addAwardObj.weight = $("#proNum3").val();
		
			addAwards.push(addAwardObj);

		}
		createTableOtherNew1(addAwards.length, addAwards);
		awardValidate();
	/*	console.log(addAwards);*/
		
	}
})
//积分关联其他产品动态创建的表格
//其他奖品动态创建的表格
function createTableOtherNew(rowCount, content) {
	$('#table-outer4 .table-tbody table').html("");
	for(var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer4 .table-tbody table'));
		var td1 = $('<td>' + (i + 1) +
			'</td>');
		var td2 = $('<td>' + content[i].productname +
			'</td>');
		var td3 = $('<td>' + content[i].productNumber +
			'</td>');
		var td4 = $('<td>' + content[i].exchange +
			'</td>');
		var td5 = $('<td>' + content[i].productIntroduce +
			'</td>');
		var td6 = $("<td><span class='look' onClick='look(this)'>查看</span>&nbsp;<span class='del' onclick='deleteOtherProduct(this)'>删除</span></td>");
		td1.appendTo(tr);
		td2.appendTo(tr);
		td3.appendTo(tr);
		td4.appendTo(tr);
		td5.appendTo(tr);
		td6.appendTo(tr);
	}
};
	/*点击修改进行的事件*/
	var index; //点击修改时是点击的表格中的第几个修改
	function modify(obj) {
		isClickWhere = true;
		//将修改的弹窗显示出来
		$("#otherProduct3").show();
		//改变弹窗里面的输入框的值
		index = $(obj).parent().parent().index();
		var awardType = addAwards[index].type;
		var awardName = addAwards[index].name;
		var awardNumber = addAwards[index].weight;
		
		$("#bargaining-situation").val(awardType);
		$("#proName3").val(awardName);
		$("#proNum3").val(awardNumber);
		if(awardType == "红包") {
			$(".proName").show();
			$(".redBag").show();
			$(".matter,.integral,.thanks").hide();
			var awardMoney = addAwards[index].money;
			$("#money").val(awardMoney);
			$("#proNum3").val(awardNumber);
		} else if(awardType == "积分") {
			$(".proName").show();
			$(".integral").show();
			$(".matter,.redBag,.thanks").hide();
			var awardIntegral = addAwards[index].integral;
			$("#integral").val(awardIntegral);
			$("#proNum3").val(awardNumber);
		} else if(awardType == "实物") {
			$(".proName").show();
			$(".matter").show();
			$(".integral,.redBag,.thanks").hide();
			var awardPicture = addAwards[index].picture;
			$("#pic3").attr("src", awardPicture);
		} else if(awardType == "谢谢惠顾") {
			$(".thanks").show();
			$(".integral,.redBag,.matter").hide();
			$(".proName").hide();
		}

	}
	/*点击其他奖品表格中每一行的delete就会删除该行的数据*/
	function deleteOtherProduct1(obj) {
		if(addAwards.length <= 8) {
			$("#otherPic9").show();
		}
		index = $(obj).parent().parent('tr').index();
		/*刪除对应的数组项*/
		addAwards.splice(index, 1);
		$(obj).parent().parent('tr').remove();
		createTableOtherNew1(addAwards.length, addAwards);

		//console.log(addAwards);
		awardValidate();
	}
/*点击其他产品表格中每一行的delete就会删除该行的数据*/
function deleteOtherProduct(obj) {
	var index = $(obj).parent().parent('tr').index();
	addOtherProducts.splice(index, 1);
	$(obj).parent().parent('tr').remove();
	createTableOtherNew(addOtherProducts.length, addOtherProducts)
}


var IntegralAssociatedActivity = []; //复选框已选择的数据集合
var IntegralAssociatedActivityAjax = []; //传给后台的积分关联活动数据
var addOtherProducts = []; //添加其他产品里面的数据
var Integralinteraction = []; //
/**
 * 积分关联的点击事件，出现弹窗
 */
$("#addBill").on("click", function() {
	$("#billPop").show(); //弹窗遮罩显示出来
	$("#billPop7").hide();
});
/*
 * 积分关联活动弹窗的点击事件
 */
var activitiesCheckedlen;
/**
 * 积分关联弹窗关闭事件
 */
$("#bill-close,#cancel").on("click", function() {
	$("#billPop").hide();
	$("#billPop7").hide();
});

/**
 * 其他产品弹窗保存事件
 */
$("#otherPic-save").on("click", function() {
	var proName = $("#proName").val();
	var proNum = $("#proNum").val();
	var exchangeIntegral = $("#exchangeIntegral").val();
	var proIntroduce = $("#proIntroduce").val();
	var saveObj = new Object();
	saveObj.productname = $("#proName").val();
	saveObj.productNumber = $("#proNum").val();
	saveObj.exchange = $("#exchangeIntegral").val();
	saveObj.productIntroduce = $("#proIntroduce").val();
	saveObj.productImg = $("#pic1").attr("src");
	saveObj.specifications = "";
	saveObj.degrees = "";
	saveObj.capacity = "";
	saveObj.getProductId = "";
	saveObj.sum = "";
	saveObj.agent = "2";

	//console.log(addOtherProducts);
	
	if(proName == "" || proNum == "" || exchangeIntegral == "" || proIntroduce == "" || $("#pic1").attr("src").indexOf("upload") <= -1) {
		
		$(".tishi4").show();
		$(".mask4").show();
	} else {
		$(".tishi4").hide();
		$(".mask4").hide();
		$("#otherProduct").hide();
		addOtherProducts.push(saveObj);
		createTableOtherNew(addOtherProducts.length, addOtherProducts);
	}

	//$(".pic1").attr(saveObj.src);
	//保存验证信息是否已经填写完整

});
//点击查看出现弹窗
function look(obj) {
	var index = $(obj).parent().parent().index();
	//console.log(addOtherProducts[index])
	$("#lookOtherProduct").show();
	$(".no1").html(addOtherProducts[index].productname);
	$(".no2").html(addOtherProducts[index].productNumber);
	$(".no3").html(addOtherProducts[index].exchange);
	$(".no4").html(addOtherProducts[index].productIntroduce);
	$("#pic1").attr("src", addOtherProducts[index].productImg)
}
//点击提示确定按钮
$(".yes4").on("click", function() {
	$(".tishi4").hide();
})
//点击查看里面的关闭及返回，弹窗消失
$("#lookOtherPro-close,#lookBack").on("click", function() {
	$("#lookOtherProduct").hide();
})

/**
 * 其他产品弹窗关闭事件
 */
$("#otherPro-close,#otherPic-cancel").on("click", function() {
	$("#otherProduct").hide();
})

function CreateTableWayBill(rowCount, content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	$('#table-outer2 .table-tbody table').html("");
	for(var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer2 .table-tbody table'));
		var td1 = $('<td>' + (i + 1) +
			'</td>');
		var td2 = $('<td class="list">' + content[i].productname +
			'</td>');
		var td3 = $('<td>' + content[i].specifications +
			'</td>');
		/*var td4 = $('<td>' + content[i].specifications +
		'</td>');*/
		var td5 = $('<td>' + content[i].degrees +
			'</td>');
		var td6 = $('<td>' + content[i].capacity +
			'</td>');
		var td7 = $("<td><input class='total' type='text' name='" + content[i].sum + "'/> 瓶" +
			'</td>');
		var td8 = $("<td><input class='exchange' type='text' name='" + content[i].recordId + "'/> 积分/瓶" +
			'</td>');
		/*var td9 = $("<td style='color:red'  onclick='deleteTwoTr(this)'>"+ '删除' +
		'</td>');*/
		td1.appendTo(tr);
		td2.appendTo(tr);
		td3.appendTo(tr);  
		/*td4.appendTo(tr);*/
		td5.appendTo(tr);
		td6.appendTo(tr);
		td7.appendTo(tr);
		td8.appendTo(tr);
	/*	td9.appendTo(tr);*/
		/*location.reload();*/
	}
};

