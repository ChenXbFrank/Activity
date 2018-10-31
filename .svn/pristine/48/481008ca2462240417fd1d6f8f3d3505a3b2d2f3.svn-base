var billLists = []; //复选框已选择的数据集合
var awardlists = []; //奖品信息列表
$(function() {
	//日期开始
	$("#startTime").datepicker({
		onSelect: function(startText) {
			maxDate: new Date(),
			startText = $('#startTime').val(); //开始时间
			$('#endTime').datepicker('option', 'minDate', startText);
		}
	});

	//结束时间
	$("#endTime").datepicker({
		onSelect: function(endText) {
			endText = $('#endTime').val();
			$('#startTime').datepicker('option', 'maxDate', endText);
		}
	});

	//日期开始
	$("#startTime2").datepicker({
		onSelect: function(startText) {
			maxDate: new Date(),
			startText2 = $('#startTime2').val(); //开始时间
			$('#endTime2').datepicker('option', 'minDate', startText2);
		}
	});

	//结束时间
	$("#endTime2").datepicker({
		onSelect: function(endText) {
			endText2 = $('#endTime2').val();
			$('#startTime2').datepicker('option', 'maxDate', endText2);
		}
	});

})

/*
 * 弹窗显示和隐藏，显示时要反选，反选实现的原理是让其所有的都不选上，然后再遍历循环数组中的id和复选框的val值比较，将相等的选中
 */
$(function() {
	$("#addBill").on("click", function() {
		//清除奖品信息中的表格,并将数据清掉
		$("#table-outer2 .table-tbody table").html("");
		awardlists.length = 0;

		/**
		 * 实现反选
		 */
		$("#table-outer3 input[type='checkbox']:checked").each(function() {
			$(this).prop("checked", false);
		});

		var billallLen = $("#table-outer3 .table-tbody tr").length;
		for(var i = 0; i < billLists.length; i++) {
			for(var j = 0; j < billallLen; j++) {
				if(billLists[i].getRecordId != "" && billLists[i].getRecordId == $("input[type='checkbox']").eq(j).val()) {
					$("input[type='checkbox']").eq(j).prop("checked", "checked");
				}
			}
		}

		$("#billPop").show(); //弹窗遮罩显示出来

		//针对表格3当表格的高度大于外框的高度，让其生成滚动条，负责取消滚动条
		var tbodyOuterHeight = $("#table-outer3 .table-tbody").height();
		var tbodyHeight = $("#table-outer3 .table-tbody table").height();
		if(tbodyOuterHeight < tbodyHeight) {
			$("#table-outer3").css({
				"border-bottom": "1px solid #d0d0d0",
			})
		} else {
			$("#table-outer3").css({
				"border-bottom": "none",
			})
		}

	});
	$("#bill-btn,#bill-close").on("click", function() {
		$("#billPop").hide();
	});

	$("#addAward").on("click", function() {
		var Table1TrLen = $("#table-outer1 .table-tbody table tr").length;
		/*判断运单信息表格是否有内容*/
		if(Table1TrLen != 0) {
			//计算剩余瓶数
			var remainingBottle = remainingAward(awardlists, getTotalBox());
			if(remainingBottle > 0) {
				$('#awardPop').show();
				//将已经选择的单选框禁用
				$("#table-outer4 input[type='radio']:checked").each(function(index, value) {
					$(this).prop("checked", false);
				});

				$("#table-outer4 input[type='radio']").each(function(index, value) {
					$(this).removeAttr("disabled");
				});

				var wardListsLen = $("#table-outer4 input[type='radio']").length;
				//console.log(wardListsLen);
				//console.log(awardlists.length);
				for(var i = 0; i < awardlists.length; i++) {
					for(var j = 0; j < wardListsLen; j++) {
						if(awardlists[i].getProductId == $("#table-outer4 input[type='radio']").eq(j).val()) {
							$("#table-outer4 input[type='radio']").eq(j).attr("disabled", "disabled");
						}

					}
				}
				//将弹窗信息清空
				$(".area1").val("");
				$(".area2").val("");

				$("#residue").html(remainingBottle);

				$("#reminder-residue,#reminder").show();
				//针对表格4当表格的高度大于外框的高度，让其生成滚动条，负责取消滚动条
				var tbodyOuterHeight4 = $("#table-outer4 .table-tbody").height();
				var tbodyHeight4 = $("#table-outer4 .table-tbody table").height();
				if(tbodyOuterHeight4 < tbodyHeight4) {
					$("#table-outer4").css({
						"border-bottom": "1px solid #d0d0d0",
					})
				} else {
					$("#table-outer4").css({
						"border-bottom": "none",
					})
				}
			} else {
				alert("运单货物数已全部中奖");
				$('#awardPop').hide();
			}

		} else {
			alert("请先选择运单信息");
		}
	});
	$("#award-close").on("click", function() {
		$("#awardPop").hide();
	});
	/*
	 * 模拟下拉框
	 */
	var open = true;
	$("#area-input").on("click", function(event) {
		event.stopPropagation(); //阻止冒泡
		if(open) {
			$(".select").show();
			open = false;
		} else {
			$(".select").hide();
			open = true;
		}
	});
	$("ul li").on("click", function(event) {
		//this指当前的这个Li
		event.stopPropagation(); //阻止冒泡
		$("#area-input").val($(this).html());
		$(".select").hide();
		open = true;
	})
	$(document).click(function() {
		$(".select").hide();
		open = true;
	});

	/*
	 * 运单信息弹窗复选框事件
	 */
	$("#bill-btn").on("click", function() {
		billLists.length = 0;
		$("#billPop input[type='checkbox']:checked").each(function(index, value) {
			var obj = {};
			obj.getRecordId = $(this).val();
			$(this).parent().siblings().each(function(index, value) {
				if(index == 0) {
					obj.getOutNo = $(this).html();
				} else if(index == 1) {
					obj.getRecsellerName = $(this).html();
				} else if(index == 2) {
					obj.getProductName = $(this).html();
				} else if(index == 3) {
					obj.getDegree = $(this).html();
				} else if(index == 4) {
					obj.getVolume = $(this).html();
				} else if(index == 5) {
					obj.getSpec = $(this).html();
				} else if(index == 6) {
					obj.getBoxCode = $(this).html();
				} else if(index == 7) {
					obj.getBrandsName = $(this).html();
				}
			});
			billLists.push(obj);

		})
		var trsLen = billLists.length;
		//动态创建表格
		CreateTableWayBill(trsLen, billLists);
		table1();
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
			award.getProductName = $(this).parent().parent().find("td").eq(0).html();
		});

		award.awardAll = $(".area1").val();
		award.remainingawardNum = $(".area1").val();
		award.awardProbability = $(".area2").val();
		award.currentAwardProbability = $(".area2").val();

		//动态创建奖品表单
		var hasnull = hasNull(award);
		if(hasnull) {
			CreateTableAwardInfo(award);
			awardlists.push(award);
			$("#awardPop").hide();
			table2();
		}

	})

})
//判断对象中是否有空
function hasNull(obj) {
	for(var i in obj) {
		if(obj[i] == "") {
			return false;
		}
	}
	return true;
}
/*当奖品总数文本框失去焦点时获取中奖率*/
/*計算中獎率*/
function blurJudge() {
	var tableRateTotal = parseFloat(probability(awardlists).toFixed(2)); //表格中的所有概率之和
	var allowMaxRate = numSub(100, tableRateTotal); //当前允许的最大概率
	//计算剩余瓶数
	var remainingBottle = remainingAward(awardlists, getTotalBox());
	//当输入的值大于0时
	if(parseInt($(".area1").val()) > 0) {
		$("#reminder-residue").hide();
		//当输入值<=剩余总瓶数时,取其文本框中的值，否则直接将剩余总瓶数填在文本框中
		if(remainingBottle < parseInt($(".area1").val())) {
			$(".area1").val(remainingBottle);
			//当直接给奖品总数赋予剩余值时，做判断，当值等于0时，直接将弹窗隐藏掉
			if(parseInt($(".area1").val()) == 0) {
				$("#awardPop").hide();
			}
		}
		var rate = parseFloat((parseInt($(".area1").val()) / getTotalBox() * 100).toFixed(2));
		//当概率大于允许的最大概率,否则直接将允许的最大概率填在文本框中
		if(rate > allowMaxRate) {
			rate = allowMaxRate;
		}
		$(".area2").val(rate + "%");
		//当输入的值小于等于0时
	} else {
		$("#residue").html(remainingBottle);
		$("#reminder-residue").show();
	}

}
/*计算在表格中的概率以及弹窗概率之和*/
function probability(arr) {
	var popProbability = 0;
	for(var i in arr) {
		popProbability = numAdd(popProbability, parseFloat(arr[i].awardProbability));
	}
	return popProbability;
}

/*记录剩余活动奖品数量,total表示总瓶数，remainingBottle表示剩余瓶数*/
function remainingAward(arr, total) {
	var remainingBottle;
	var activeTotal = 0;
	for(var i = 0; i < arr.length; i++) {
		activeTotal += parseInt(arr[i].remainingawardNum);
	}
	remainingBottle = total - activeTotal;
	return remainingBottle;
};
/*动态创建运单信息表格*/
function CreateTableWayBill(rowCount, content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	$('#table-outer1 .table-tbody table').html("");
	for(var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer1 .table-tbody table'));
		var td1 = $('<td>' + content[i].getOutNo +
			'</td>');
		var td2 = $('<td>' + content[i].getRecsellerName +
			'</td>');
		var td3 = $('<td>' + content[i].getProductName +
			'</td>');
		var td4 = $('<td>' + content[i].getDegree +
			'</td>');
		var td5 = $('<td>' + content[i].getVolume +
			'</td>');
		var td6 = $('<td>' + content[i].getSpec +
			'</td>');
		var td7 = $('<td>' + content[i].getBoxCode +
			'</td>');
		var td8 = $('<td>' + content[i].getBrandsName +
			'</td>');
		var td9 = $("<td class='delete' onclick='deleteTr(this)'>删除</td>");
		td1.appendTo(tr);
		td2.appendTo(tr);
		td3.appendTo(tr);
		td4.appendTo(tr);
		td5.appendTo(tr);
		td6.appendTo(tr);
		td7.appendTo(tr);
		td8.appendTo(tr);
		td9.appendTo(tr);
	}
};

/*点击每一行的delete就会删除该行的数据*/
function deleteTr(obj) {
	var index = $(obj).parent('tr').index();
	/*刪除对应的数组项*/
	billLists.splice(index, 1);
	$(obj).parent('tr').remove();
	table1();
}
/* 动态创建奖品信息表格 */
function CreateTableAwardInfo(content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	var tr = $("<tr></tr>");
	tr.appendTo($('#table-outer2 .table-tbody table'));
	var td1 = $('<td>' + content.getProductName +
		'</td>');
	var td2 = $('<td>' + content.awardAll +
		'</td>');
	var td3 = $('<td>' + content.remainingawardNum +
		'</td>');
	var td4 = $('<td>' +
		content.awardProbability +
		'</td>');
	var td5 = $('<td>' +
		content.currentAwardProbability +
		'</td>');
	var td6 = $("<td class='deleteTd' onclick='deleteAwardTr(this)'>删除</td>");
	td1.appendTo(tr);
	td2.appendTo(tr);
	td3.appendTo(tr);
	td4.appendTo(tr);
	td5.appendTo(tr);
	td6.appendTo(tr);
};

/*点击每一行的delete就会删除该行的数据*/
function deleteAwardTr(obj) {
	var index = $(obj).parent('tr').index();
	/*刪除对应的数组项*/
	awardlists.splice(index, 1);
	$(obj).parent('tr').remove();
	table2();

}
//针对表格1当表格的高度大于外框的高度，让其生成滚动条，否则取消滚动条
function table2() {
	var tbodyOuterHeight2 = $("#table-outer2 .table-tbody").height();
	var tbodyHeight2 = $("#table-outer2 .table-tbody table").height();
	if(tbodyOuterHeight2 < tbodyHeight2) {
		$("#table-outer2").css({
			"border-bottom": "1px solid #d0d0d0",
		})
	} else {
		$("#table-outer2").css({
			"border-bottom": "none",
		})
	}
}

//针对表格1当表格的高度大于外框的高度，让其生成滚动条，否则取消滚动条
function table1() {
	var tbodyOuterHeight1 = $("#table-outer1 .table-tbody").height();
	var tbodyHeight1 = $("#table-outer1 .table-tbody table").height();
	if(tbodyOuterHeight1 < tbodyHeight1) {
		$("#table-outer1").css({
			"border-bottom": "1px solid #d0d0d0",
		})
	} else {
		$("#table-outer1").css({
			"border-bottom": "none",
		})
	}
}

/*获取总瓶数=总箱数*每箱多少瓶，再累加之和*/
function getTotalBox() {
	var totalBox = 0;
	var totalbottles;
	var len = billLists.length;
	for(var i = 0; i < len; i++) {
		totalBox += parseInt(billLists[i].getBoxCode) * parseInt(billLists[i].getSpec);
	}
	totalbottles = totalBox;
	return totalbottles;
}

//numSub为减法运算损失精度损失
function numSub(num1, num2) {
	var baseNum, baseNum1, baseNum2;
	var precision; // 精度
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch(e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch(e) {
		baseNum2 = 0;
	}
	baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
	precision = (baseNum1 >= baseNum2) ? baseNum1 : baseNum2;
	return((num1 * baseNum - num2 * baseNum) / baseNum).toFixed(precision);
};
//numAdd为加法运算精度损失
function numAdd(num1, num2) {
	var baseNum, baseNum1, baseNum2;
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch(e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch(e) {
		baseNum2 = 0;
	}
	baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
	return(num1 * baseNum + num2 * baseNum) / baseNum;
};