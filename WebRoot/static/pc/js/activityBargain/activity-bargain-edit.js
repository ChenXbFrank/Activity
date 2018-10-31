var billLists = []; // 复选框已选择的数据集合
var awardlists = []; // 奖品信息列表
var mutualbills = []; // 交互运单信息
var mutualawards = []; // 交互奖品信息
var billListsCopy = [];

/*
 * 改动开始
 */
/*全选与全不选*/
$("#checkAll").on("click",function(){
	if($(this).prop("checked")){
		$(".checkbox input[type='checkbox']").not("input:checked").each(function() {
			$(this).trigger("click")
		});
	}else{
		$(".checkbox input[type='checkbox']:checked").each(function() {
			$(this).trigger("click")
		});
	}
})
/*循环遍历看是否当前页时处于全选*/
function isCheckAll(){
	var checkall=true;
	$(".checkbox input[type='checkbox']").each(function() {
		if(!$(this).prop("checked")){
			$("#checkAll").prop("checked", false);
			 checkall=false;
			return false;
		}
		
	});
	if(checkall){
		$("#checkAll").prop("checked", true);
	}
}

/* 默认选中 */
function isSelected() {
	$(".checkbox input[type='checkbox']").each(function() {
				$(this).prop("checked", false);
			});

	for (var i in billListsCopy) {
		$(".checkbox input[type='checkbox']").each(function() {
					if (billListsCopy[i].recordId == $(this).val()) {
						$(this).prop("checked", "checked");
					}
				})
	}
}

/* 数组中有对象的深拷贝 */
var deepCopy = function(o) {
	if (o instanceof Array) {
		var n = [];
		for (var i = 0; i < o.length; ++i) {
			n[i] = deepCopy(o[i]);
		}
		return n;

	} else if (o instanceof Object) {
		var n = {}
		for (var i in o) {
			n[i] = deepCopy(o[i]);
		}
		return n;
	} else {
		return o;
	}
}

/* 复选框的点击事件 */
function isSelectedCheckbox(currentObj) {
	isCheckAll();
	var isCurrentSelected = $(currentObj).prop("checked");
	if (isCurrentSelected == true) {
		var obj = {};
		obj.recordId = $(currentObj).val();
		obj.outNo = $(currentObj).parent().siblings().eq(0).html();
		obj.recsellerName = $(currentObj).parent().siblings().eq(1).html();
		obj.productName = $(currentObj).parent().siblings().eq(2).html();
		obj.degree = $(currentObj).parent().siblings().eq(3).html();
		obj.volume = $(currentObj).parent().siblings().eq(4).html();
		obj.spec = $(currentObj).parent().siblings().eq(5).html();
		obj.boxCode = $(currentObj).parent().siblings().eq(6).html();
		obj.brandsName = $(currentObj).parent().siblings().eq(7).html();
		obj.outTime = $(currentObj).parent().siblings().eq(8).html();
		obj.status = $(currentObj).parent().siblings().eq(9).html();
		obj.sellerId = $(currentObj).attr("name");
		billListsCopy.push(obj);
	} else {
		for (var i in billListsCopy) {
			if (billListsCopy[i].recordId == $(currentObj).val()) {
				billListsCopy.splice(i, 1);
				return;
			}
		}
	}
}

/* 判断是否点击的是弹窗里面的确定按钮 */
$("#bill-btn").on("click", function() {
	console.log(billListsCopy);
	billLists = deepCopy(billListsCopy);
	CreateTableWayBill(billLists.length, billLists);
	billValidate();
		// awardNumSum();
	})

/*
 * 改动结束
 */

/*
 * 输入框限制
 */
function clearNoNum(obj) {
	// 先把非数字的都替换掉，除了数字和.
	obj.value = obj.value.replace(/[^\d.]/g, "");
	// 保证只有出现一个.而没有多个.
	obj.value = obj.value.replace(/\.{2,}/g, ".");
	// 必须保证第一个为数字而不是.
	obj.value = obj.value.replace(/^\./g, "");
	// 保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$",
			".");
	// 只能输入两个小数
	obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3');
	obj.value = obj.value.replace(/[^\d.]/g, '')
	/*
	 * var b=obj.value; b=(b+'').replace(/^0+\./g,'0.');
	 * b.match(/^0+[1-9]+/)?b=b.replace(/^0+/g,''):b; obj.value=Number(b)?b:0;
	 */
}

$(function() {
			/*
			 * 模拟下拉框
			 */
			var open = true;
			$("#bargaining-situations").on("click", function(event) {
						event.stopPropagation(); // 阻止冒泡
						if (open) {
							$(".select").show();
							open = false;
						} else {
							$(".select").hide();
							open = true;
						}
					});
			$(".outer ul li").on("click", function(event) {
				// this指当前的这个Li
				event.stopPropagation(); // 阻止冒泡
				$(this).css("background", "#d0d0d0").siblings().css(
						"background", "white");
				$("#bargaining-situations").val($(this).html());
				$(".select").hide();
				open = true;
			})
			$(document).click(function() {
						$(".select").hide();
						open = true;
					});

			$(".outer ul li").on("mouseover", function() {
				// this指当前的这个Li
				$(this).css("background", "#d0d0d0").siblings().css(
						"background", "white");
			});
		})

$(function() {
			// 日期开始
			$("#startTime").datepicker({
						minDate : new Date(),
						onSelect : function(startText) {
							startText = $('#startTime').val(); // 开始时间
							$('#endTime').datepicker('option', 'minDate',
									startText);
						}
					});

			// 结束时间
			$("#endTime").datepicker({
						minDate : new Date(),
						onSelect : function(endText) {
							endText = $('#endTime').val();
							$('#startTime').datepicker('option', 'maxDate',
									endText);
						}
					});

			// 日期开始
			$("#startTime2").datepicker({
						onSelect : function(startText) {
							maxDate : new Date(), startText2 = $('#startTime2')
									.val(); // 开始时间
							$('#endTime2').datepicker('option', 'minDate',
									startText2);
						}
					});

			// 结束时间
			$("#endTime2").datepicker({
						onSelect : function(endText) {
							endText2 = $('#endTime2').val();
							$('#startTime2').datepicker('option', 'maxDate',
									endText2);
						}
					});

		})

/*
 * 弹窗显示和隐藏，显示时要反选，反选实现的原理是让其所有的都不选上，然后再遍历循环数组中的id和复选框的val值比较，将相等的选中
 */
$(function() {

	$("#bill-btn,#bill-close").on("click", function() {
				$("#billPop").hide();
			});

	$("#addAward").on("click", function() {

		var Table1TrLen = $("#table-outer1 .table-tbody table tr").length;
		var Table2TrLen = $("#table-outer2 .table-tbody table tr").length;
		/* 判断运单信息表格是否有内容 */
		if (Table1TrLen != 0) {
			if (Table2TrLen == 0) {
				$('#awardPop').show();
				$(".popUp-window input[type='text']").val("");
				// 将已经选择的单选框禁用
				$("#table-outer4 input[type='radio']:checked").each(
						function(index, value) {
							$(this).prop("checked", false);
						});

				$("#table-outer4 input[type='radio']").each(
						function(index, value) {
							$(this).removeAttr("disabled");
						});

				var wardListsLen = $("#table-outer4 input[type='radio']").length;
				// console.log(wardListsLen);
				// console.log(awardlists.length);
				for (var i = 0; i < awardlists.length; i++) {
					for (var j = 0; j < wardListsLen; j++) {
						if (awardlists[i].getProductId == $("#table-outer4 input[type='radio']")
								.eq(j).val()) {
							$("#table-outer4 input[type='radio']").eq(j).attr(
									"disabled", "disabled");
						}

					}
				}
				// 将弹窗信息清空
				$(".awardNumber").val("");
				$(".price input[type='text']").val("");
				// 针对表格4当表格的高度大于外框的高度，让其生成滚动条，负责取消滚动条
				var tbodyOuterHeight4 = $("#table-outer4 .table-tbody")
						.height();
				var tbodyHeight4 = $("#table-outer4 .table-tbody table")
						.height();
				if (tbodyOuterHeight4 < tbodyHeight4) {
					$("#table-outer4").css({
								"border-bottom" : "1px solid #d0d0d0"
							})
				} else {
					$("#table-outer4").css({
								"border-bottom" : "none"
							})
				}
			}
		} else {
			// alert("请先选择运单信息");
			$("#popup").show();
			$(".pop-title").html("请先选择运单信息");
			$("#delivery-success-yes").on("click", function() {
						$("#popup").hide();
					})
		}
	});
	$("#award-close").on("click", function() {
				$("#awardPop").hide();
			});

	/*
	 * 奖品信息弹窗
	 */
	$("#award-btn").on("click", function() {
		var award = new Object();
		award.getProductId = "";
		award.getProductName = "";
		$("#awardPop input[type='radio']:checked").each(function(index, value) {
			award.getProductId = $(this).val();
			award.getProductName = $(this).parent().parent().find("td").eq(0)
					.html(); // 奖品名称
			award.getDegree = $(this).parent().parent().find("td").eq(1).html(); // 度数
			award.getVolume = $(this).parent().parent().find("td").eq(2).html(); // 容量
			award.getSpec = $(this).parent().parent().find("td").eq(3).html(); // 规格
		});

		award.awardAll = $(".awardNumber").val(); // 奖品总数
		award.remainingawardNum = $(".awardNumber").val(); // 剩余数量
		award.oldPrice = $("#oldPrice").val(); // 原价
		award.lowPrice = $("#lowPrice").val(); // 最低价
		award.bargainingInterval = $("#bargaining-low").val() + "-"
				+ $("#bargaining-high").val(); // 砍价区间
		award.bargainingTimes = "10000000"; // 砍价人数
		// 动态创建奖品表单
		var hasnull = hasNull(award);
		if (hasnull && $("#bargaining-low").val() != ""
				&& $("#bargaining-high").val() != "") {
			CreateTableAwardInfo(award);
			awardValidate();
			awardlists.push(award);
			$("#awardPop").hide();
			table2();
		} else {
			// alert("请将所有信息填写完整");
			$("#popup").show();
			$(".pop-title").html("请将信息填写完整！");
			$("#delivery-success-yes").on("click", function() {
						$("#popup").hide();
					})
		}
	});
	// 当最低价失去焦点时
	$("#lowPrice").on("blur", function() {
				$("#bargaining-low").val("");
				$("#bargaining-high").val("");
				var oldPrice = $("#oldPrice").val();
				var lowPrice = $("#lowPrice").val();
				if (oldPrice != "") {
					if (parseFloat(oldPrice) < parseFloat(lowPrice)) {
						$(this).val(oldPrice);
					}
				}
			});
	// 当原价失去焦点时
	$("#oldPrice").on("blur", function() {
				$("#bargaining-low").val("");
				$("#bargaining-high").val("");
				var oldPrice = $("#oldPrice").val();
				var lowPrice = $("#lowPrice").val();
				if (lowPrice != "") {
					if (parseFloat(oldPrice) < parseFloat(lowPrice)) {
						$(this).val(lowPrice);
					}
				}
			});
	// 当砍价区间最低输入框失去焦点时
	$("#bargaining-low").on("blur", function() {
				var bargainingLow = $("#bargaining-low").val();
				var bargainingHigh = $("#bargaining-high").val();
				var oldPrice = $("#oldPrice").val();
				var lowPrice = $("#lowPrice").val();
				var range = (parseFloat(oldPrice) - parseFloat(lowPrice))
						.toFixed(2);
				if (oldPrice != "" && lowPrice != "") {
					if (parseFloat($(this).val()) > range) {
						$(this).val(range);
					}
				};
				if (bargainingHigh != "") {
					if (parseFloat(bargainingHigh) < parseFloat(bargainingLow)) {
						$(this).val(bargainingHigh);
					}
				}
			});
	// 当砍价区间最高输入框失去焦点时
	$("#bargaining-high").on("blur", function() {
				var bargainingLow = $("#bargaining-low").val();
				var bargainingHigh = $("#bargaining-high").val();
				var oldPrice = $("#oldPrice").val();
				var lowPrice = $("#lowPrice").val();
				var range = (parseFloat(oldPrice) - parseFloat(lowPrice))
						.toFixed(2);
				if (oldPrice != "" && lowPrice != "") {
					if (parseFloat($(this).val()) > range) {
						$(this).val(range);
					}
				} else {
					// alert("请先填写原价和最低价。")
					$("#popup").show();
					$(".pop-title").html("请先填写原价和最低价。");
					$("#delivery-success-yes").on("click", function() {
								$("#popup").hide();
							})
				};
				if (bargainingLow != "") {
					if (parseFloat(bargainingHigh) < parseFloat(bargainingLow)) {
						$(this).val(bargainingLow);
					}
				}
			})
})
// 将对象转化成字符串
function objTransform(jsonobj) {
	return JSON.stringify(jsonobj);
}
// 活动名称验证
function activityNameValidate() {
	if ($("#active-name").val() == "") {
		$(".activity-volidate").show();
	} else {
		$(".activity-volidate").hide();
	}
}
// 时间验证
function timeValidate() {
	if ($("#startTime").val() == "" && $("#endTime").val() == "") {
		$(".time-volidate").show();
	} else {
		$(".time-volidate").hide();
	}
}
// 活动介绍验证
function introduceValidate() {
	if (!$("#textarea").val()) {
		$(".introduce-volidate").show();
	} else {
		$(".introduce-volidate").hide();
	}
}
// 运单信息是否选择验证
function billValidate() {
	if ($("#table-outer1 .table-tbody table tr").length == 0) {
		$(".bill-volidate").show();
	} else {
		$(".bill-volidate").hide();
	}
}
// 奖品信息是否选择验证
function awardValidate() {
	if ($("#table-outer2 .table-tbody table tr").length == 0) {
		$(".award-volidate").show();
	} else {
		$(".award-volidate").hide();
	}
}
// 奖品弹窗奖品总数验证
function awardAllValidate() {
	if ($(".awardNumber").val() == "") {
		$(".awardAll-volidate").show();
	} else {
		$(".awardAll-volidate").hide();
	}
}
// 分享标题验证
function shareTitleValidate() {
	if ($("#shareTitle").val() == "") {
		$(".shareTitle-volidate").show();
	} else {
		$(".shareTitle-volidate").hide();
	}
}
// 分享描述验证
function shareDetailValidate() {
	if (!$("#shareDetail").val()) {
		$(".shareDetail-volidate").show();
	} else {
		$(".shareDetail-volidate").hide();
	}
}
// 分享图片验证
function sharePicValidate() {
	var pic1Src = $("#pic1").attr("src");
	if (pic1Src.indexOf("upload") > -1) {
		$(".sharePic-volidate").hide();
	} else {
		$(".sharePic-volidate").show();
	}
}

// 判断对象中是否有空
function hasNull(obj) {
	for (var i in obj) {
		if (obj[i] == "") {
			return false;
		}
	}
	return true;
}

/* 记录剩余活动奖品数量,total表示总瓶数，remainingBottle表示剩余瓶数 */
function remainingAward(arr, total) {
	var remainingBottle;
	var activeTotal = 0;
	for (var i = 0; i < arr.length; i++) {
		activeTotal += parseInt(arr[i].remainingawardNum);
	}
	remainingBottle = total - activeTotal;
	return remainingBottle;
};
/*动态创建运单信息表格*/
function CreateTableWayBill(rowCount, content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	$('#table-outer1 .table-tbody table').html("");
	for (var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer1 .table-tbody table'));
		var td1 = $('<td>' + content[i].outNo + '</td>');
		var td2 = $('<td>' + content[i].recsellerName + '</td>');
		var td3 = $('<td>' + content[i].productName + '</td>');
		var td4 = $('<td>' + content[i].degree + '</td>');
		var td5 = $('<td>' + content[i].volume + '</td>');
		var td6 = $('<td class="alcoholTotal">' + content[i].spec + '</td>');
		var td7 = $('<td class="caseNumber">' + content[i].boxCode + '</td>');
		var td8 = $('<td>' + content[i].brandsName + '</td>');
		var td9 = $('<td>' + content[i].outTime.substring(0, 19) + '</td>');
		var td10 = $('<td>' + content[i].status + '</td>');
		var td11 = $("<td class='delete' onclick='deleteTr(this)'>删除</td>");
		td1.appendTo(tr);
		td2.appendTo(tr);
		td3.appendTo(tr);
		td4.appendTo(tr);
		td5.appendTo(tr);
		td6.appendTo(tr);
		td7.appendTo(tr);
		td8.appendTo(tr);
		td9.appendTo(tr);
		td10.appendTo(tr);
		td11.appendTo(tr);
	}
};

/* 点击每一行的delete就会删除该行的数据 */
function deleteTr(obj) {
	var index = $(obj).parent('tr').index();
	/* 刪除对应的数组项 */
	billLists.splice(index, 1);
	$(obj).parent('tr').remove();
	table1();
	billValidate();
}

/* 动态创建奖品信息表格 */
function CreateTableAwardInfo(content) {
	/* 动态创建表格之前先将除表头外的信息清空 */
	var tr = $("<tr></tr>");
	tr.appendTo($('#table-outer2 .table-tbody table'));
	var td1 = $('<td>' + content.getProductName + '</td>');
	var td2 = $('<td>' + content.awardAll + '</td>');
	var td3 = $('<td>' + content.remainingawardNum + '</td>');
	var td4 = $('<td>' + content.getDegree + '</td>');
	var td5 = $('<td>' + content.getVolume + '</td>');
	var td6 = $('<td>' + content.getSpec + '</td>');
	var td7 = $('<td>' + content.oldPrice + '</td>');
	var td8 = $('<td>' + content.lowPrice + '</td>');
	var td9 = $('<td>' + content.bargainingInterval + '</td>');
	var td10 = $("<td class='deleteTd' onclick='deleteAwardTr(this)'>删除</td>");
	td1.appendTo(tr);
	td2.appendTo(tr);
	td3.appendTo(tr);
	td4.appendTo(tr);
	td5.appendTo(tr);
	td6.appendTo(tr);
	td7.appendTo(tr);
	td8.appendTo(tr);
	td9.appendTo(tr);
	td10.appendTo(tr);
};

/* 点击每一行的delete就会删除该行的数据 */
function deleteAwardTr(obj) {
	var index = $(obj).parent('tr').index();
	/* 刪除对应的数组项 */
	awardlists.splice(index, 1);
	$(obj).parent('tr').remove();
	table2();
	awardValidate();
}

// 针对表格1当表格的高度大于外框的高度，让其生成滚动条，否则取消滚动条
function table2() {
	var tbodyOuterHeight2 = $("#table-outer2 .table-tbody").height();
	var tbodyHeight2 = $("#table-outer2 .table-tbody table").height();
	if (tbodyOuterHeight2 < tbodyHeight2) {
		$("#table-outer2").css({
					"border-bottom" : "1px solid #d0d0d0"
				})
	} else {
		$("#table-outer2").css({
					"border-bottom" : "none"
				})
	}
}

// 针对表格1当表格的高度大于外框的高度，让其生成滚动条，否则取消滚动条
function table1() {
	var tbodyOuterHeight1 = $("#table-outer1 .table-tbody").height();
	var tbodyHeight1 = $("#table-outer1 .table-tbody table").height();
	if (tbodyOuterHeight1 < tbodyHeight1) {
		$("#table-outer1").css({
					"border-bottom" : "1px solid #d0d0d0"
				})
	} else {
		$("#table-outer1").css({
					"border-bottom" : "none"
				})
	}
}

/* 获取总瓶数=总箱数*每箱多少瓶，再累加之和 */
function getTotalBox() {
	var totalBox = 0;
	var totalbottles;
	var len = billLists.length;
	for (var i = 0; i < len; i++) {
		totalBox += parseInt(billLists[i].getBoxCode)
				* parseInt(billLists[i].getSpec);
	}
	totalbottles = totalBox;
	return totalbottles;
}

// numSub为减法运算损失精度损失
function numSub(num1, num2) {
	var baseNum, baseNum1, baseNum2;
	var precision; // 精度
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch (e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch (e) {
		baseNum2 = 0;
	}
	baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
	precision = (baseNum1 >= baseNum2) ? baseNum1 : baseNum2;
	return ((num1 * baseNum - num2 * baseNum) / baseNum).toFixed(precision);
};
// numAdd为加法运算精度损失
function numAdd(num1, num2) {
	var baseNum, baseNum1, baseNum2;
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch (e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch (e) {
		baseNum2 = 0;
	}
	baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
	return (num1 * baseNum + num2 * baseNum) / baseNum;
};