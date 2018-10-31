var billLists = []; //复选框已选择的数据集合
var awardlists = []; //奖品信息列表
var mutualbills = [];
var billListsCopy;
var a;
var sum2 = 0;
var b;
var sum3 = 0;
var sum6 = 0;
var sum7 = 0;
var sum9 = 0;
var alcoholTotal;
var caseNumber;
var bonusAmount;
var bonusNumber;
var bonusNumber1;
var bonusProbability;
var bonusProbability1;
var cishu=1;
var jifen;
var subtotal;
var zhongJR;
var sum5 = 0;
var alcoholTotal;
var awardAmount;
var awardWinners;
var prizeProbability;
var tt;
var ppp;
var winning; //积分和一等奖被填写时剩余的概率
var winningTwo; //积分和一等奖和二三四等等奖都被填写时的剩余概率
var gg; //单单时中奖的人数不算积分人数
var niu;
var pp;
var alcoholTotal;
var caseNumber;
var bonusAmount;
var bonusNumber;
var cccc;
var dd;
var bonusNumber1;
var bonusProbability;
var bonusProbability1;
var jifen;
var subtotal;
var zhongJR;
var onegai = 0;
var twogai = 0;
var Rsum=0;
var hougai;
var alcoholTotal;
var awardAmount;
var awardWinners;
var prizeProbability;
var subtotal = b;
var subtotal1;
var we;
var qe;
var rt;
/*点击每一行的delete就会删除该行的数据*/

var DeleteIndex;

function deleteTr(obj) {
	$(".tishi").css({ "display": "block" });
	DeleteIndex = $(obj).parent('tr').index();
}
/*
 * 改动开始
 */
/*默认选中*/
function isSelected(){
	$(".checkbox input[type='checkbox']").each(function(){
		$(this).prop("checked",false);
	});
	
	for(var i in billListsCopy){
		$(".checkbox input[type='checkbox']").each(function(){
			if(billListsCopy[i].recordId==$(this).val()){
				$(this).prop("checked","checked");
			}
		})
	}
}


/*数组中有对象的深拷贝*/
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



/*复选框的点击事件*/
function isSelectedCheckbox(currentObj){
	isCheckAll();
	var isCurrentSelected=$(currentObj).prop("checked");
	if(isCurrentSelected==true){
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
		billListsCopy.push(obj);
	}else{
		for(var i in billListsCopy){
			if(billListsCopy[i].recordId==$(currentObj).val()){
				billListsCopy.splice(i,1);
				return;
			}
		}
	}
}
		
/*判断是否点击的是弹窗里面的确定按钮*/
$("#bill-btn").on("click",function(){
	clear();
	$("#billPop").hide();
	console.log(billListsCopy);
	billLists=deepCopy(billListsCopy);
	console.log(billLists)
	CreateTableWayBill(billLists.length, billLists);
	/*billValidate();*/
	/*awardNumSum();*/
})


/*
 * 改动结束
 */


//活动名称验证
function activityNameValidate(){
	if($("#active-name").val()==""){
		$(".tian").show();
	} else{
		$(".tian").hide();
	}
}
/*运单信息验证*/
function billValidate() {
	if($("#table-outer1 .table-tbody table tr").length == 0) {
		$(".tian0").show();
	} else {
		$(".tian0").hide();
	}
}
//时间验证
function timeValidate(){
	if($("#startTime").val()=="" && $("#endTime").val()==""){
		$(".xuan").show();
	} else{
		$(".xuan").hide();
	}
}

function clearNoNum(obj) {
	//输入的数字只能是大于等于0
	obj.value = obj.value.replace("^([1-9]\\d*(\\.[0-9]*[1-9])?)|(0\\.[0-9]*[1-9])|0$");
	//先把非数字的都替换掉，除了数字和.    
	obj.value = obj.value.replace(/[^\d.]/g, "");
	//保证只有出现一个.而没有多个.    
	obj.value = obj.value.replace(/\.{2,}/g, ".");
	//必须保证第一个为数字而不是.    
	obj.value = obj.value.replace(/^\./g, "");
	//保证.只出现一次，而不能出现两次以上    
	obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
	//只能输入两个小数  
	obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3');
	obj.value = obj.value.replace(/[^\d.]/g, '')
	/* var b=obj.value;
	 b=(b+'').replace(/^0+\./g,'0.');
	 b.match(/^0+[1-9]+/)?b=b.replace(/^0+/g,''):b;
	 obj.value=Number(b)?b:0;*/
}
$(function() {
	//日期开始
	$("#startTime").datepicker({
		minDate: new Date(),
		onSelect: function(startText) {
			startText = $('#startTime').val(); //开始时间
			$('#endTime').datepicker('option', 'minDate', startText);
		}
	});

	//结束时间
	$("#endTime").datepicker({
		minDate: new Date(),
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

	/*
	 * 模拟下拉框
	 */
	var open = true;
	$("#bargaining-situations").on("click", function(event) {
		event.stopPropagation(); //阻止冒泡
		if(open) {
			$(".select").show();
			open = false;
		} else {
			$(".select").hide();
			open = true;
		}
	});
	$(".outer ul li").on("click", function(event) {
		//this指当前的这个Li
		event.stopPropagation(); //阻止冒泡
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
		$("#bargaining-situations").val($(this).html());
		$(".select").hide();
		open = true;
	})
	$(document).click(function() {
		$(".select").hide();
		open = true;
	});

	$(".outer ul li").on("mouseover", function() {
		//this指当前的这个Li
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
	});
})

/*
 * 弹窗显示和隐藏，显示时要反选，反选实现的原理是让其所有的都不选上，然后再遍历循环数组中的id和复选框的val值比较，将相等的选中
 */
//将对象转化成字符串
function objTransform(jsonobj) {
	return JSON.stringify(jsonobj);
}
$(function() {
	$("#addBill").on("click", function() {
		//alert("dsd")
		//清除奖品信息中的表格,并将数据清掉
		/**
		 * 实现反选
		 */
		$("#table-outer3 input[type='checkbox']:checked").each(function() {
			$(this).prop("checked", false);
		});

		var billallLen = $("#table-outer3 .table-tbody tr").length;
		for(var i = 0; i < billLists.length; i++) {
			for(var j = 0; j < billallLen; j++) {
				if(billLists[i].recordId != "" && billLists[i].recordId == $("input[type='checkbox']").eq(j).val()) {
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
		billValidate();
		sum2 = 0;
		var trsLen = billLists.length;
		//动态创建表格
		sum2 = 0;
		CreateTableWayBill(trsLen, billLists);
		table1();
		$("#table-outer1 .table-tbody").find("tr").each(function() {
			var $this = $(this);
			var caseNumber = $this.find(".caseNumber").html();
			var alcoholTotal = $this.find(".alcoholTotal").html();
			caseNumber = parseInt(caseNumber);
			alcoholTotal = parseInt(alcoholTotal);
			if(!(isNaN(caseNumber) || isNaN(alcoholTotal))) {
				sum2 += (caseNumber * alcoholTotal);
			}
			$(".sum").html(sum2);
			$(".surplus").html(sum2);
		});
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
		subtotal = 0;
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
		var td1 = $('<td>' + content[i].outNo +
			'</td>');
		var td2 = $('<td>' + content[i].recsellerName +
			'</td>');
		var td3 = $('<td>' + content[i].productName +
			'</td>');
		var td4 = $('<td>' + content[i].degree +
			'</td>');
		var td5 = $('<td>' + content[i].volume +
			'</td>');
		var td6 = $('<td class="alcoholTotal">' + content[i].spec +
			'</td>');
		var td7 = $('<td class="caseNumber">' + content[i].boxCode +
			'</td>');
		var td8 = $('<td>' + content[i].brandsName +
			'</td>');
		var td9 = $('<td>' + content[i].outTime.substring(0, 19) +
			'</td>');
		var td10 = $('<td>' + content[i].status +
			'</td>');
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
$(".prompt1 .yes").click(function() {
	$(".tishi").css({ "display": "none" });
	billLists.splice(DeleteIndex, 1);
	CreateTableWayBill(billLists.length, billLists);
	if($("#table-outer1 .table-tbody table tr").length == 0) {
		$(".sum").html(0)
		$(".tian0").show();
	}
	sum2 = 0;
	$("#table-outer1 .table-tbody").find("tr").each(function() {
		var $this = $(this);
		var caseNumber = $this.find(".caseNumber").html();
		var alcoholTotal = $this.find(".alcoholTotal").html();
		caseNumber = parseInt(caseNumber);
		alcoholTotal = parseInt(alcoholTotal);
		if(!(isNaN(caseNumber) || isNaN(alcoholTotal))) {
			sum2 += (caseNumber * alcoholTotal);
		}
	});

	sum2 = 0;
	$("#table-outer1 .table-tbody").find("tr").each(function() {
		var $this = $(this);
		var caseNumber = $this.find(".caseNumber").html();
		var alcoholTotal = $this.find(".alcoholTotal").html();
		caseNumber = parseInt(caseNumber);
		alcoholTotal = parseInt(alcoholTotal);
		if(!(isNaN(caseNumber) || isNaN(alcoholTotal))) {
			sum2 += (caseNumber * alcoholTotal);
		}
		$(".sum").html(sum2)
	});
	$(".awardAmount").val(""); //清空积分金额
	$(".awardWinners").val(""); //清空积分人数
	$(".prizeProbability").html(""); //清空积分概率
	$(".bonusAmount").val(""); //清空？等奖金额
	$(".bonusNumber").val(""); //清空？等奖人数
	$(".subtotal").html(""); //清空小计
	$(".bonusProbability").html(""); //清空奖品概率
	$(".bonusNumber1").val("")
	$(".bonusProbability1").html("")
	$(".bonus1").html("")
	$(".zhongjiangG1").html("")
	$(".shenx").html("")
	$(".zhongJR").val("")
	$(".jifenJ").val("")
	$(".bonusProbability2").html("")
	$(".prizeProbability1").html("")
	$(".shenx1").html("")
	$(".bonusAmount1").val("")
	$(".frequency").val("")
	$(".dd").val("")
	$(".cccc").val("")
	$(".qianqian").html("")
	$(".hougai").html("")
})
/*点击否 */
$(".prompt1 .no").click(function() {
	$(".tishi").css({ "display": "none" });
	isClickYes=false;
});
function clear(){
	$(".awardAmount").val(""); //清空积分金额
	$(".awardWinners").val(""); //清空积分人数
	$(".prizeProbability").html(""); //清空积分概率
	$(".bonusAmount").val(""); //清空？等奖金额
	$(".bonusNumber").val(""); //清空？等奖人数
	$(".subtotal").html(""); //清空小计
	$(".bonusProbability").html(""); //清空奖品概率
	$(".bonusNumber1").val("")
	$(".bonusProbability1").html("")
	$(".bonus1").html("")
	$(".bonus").html("")
	$(".zhongjiangG1").html("")
	$(".zhongjiangG").html("")
	$(".shenx").html("")
	$(".zhongJR").val("")
	$(".jifenJ").val("")
	$(".bonusProbability2").html("")
	$(".prizeProbability1").html("")
	$(".shenx1").html("")
	$(".bonusAmount1").val("")
	$(".frequency").val("")
}
$(".yes").click(function() {
	billValidate();
	clear();
})
$(".yes1").click(function() {
	$(".surplus").html(sum2)
	$(".tishi1").css({ "display": "none" })
	$(".awardAmount").val(""); //清空积分金额
	$(".awardWinners").val(""); //清空积分人数
	$(".prizeProbability").html(""); //清空积分概率
	$(".bonusAmount").val(""); //清空？等奖金额
	$(".bonusNumber").val(""); //清空？等奖人数
	$(".subtotal").html(""); //清空小计
	$(".bonusProbability").html(""); //清空奖品概率
	$(".bonus").html("");
	$(".zhongjiangG").html("");
	$(".prizeProbability").html("");
	$(".shenx").html("");
	$(".dd").val("")
	$(".cccc").val("")
	$(".qianqian").html("")
	$(".hougai").html("")
	$(".surface2").css({ "display": "block" });
	$(".surface1").css({ "display": "none" });
})

$(".yes2").click(function(e) {
	$(".surplus").html(sum2)
	$("input[name=shu]").attr("checked", false);
	$(".tishi2").css({ "display": "none" })
	$(".bonusAmount1").val(""); //清空积分金额
	$(".bonusNumber1").val(""); //清空积分人数
	$(".bonusProbability1").html(""); //清空积分概率
	$(".jifenJ").val(""); //
	$(".zhongJR").val(""); //
	$(".bonusProbability2").html(""); // 
	$(".bonus1").html("");
	$(".zhongjiangG1").html("");
	$(".prizeProbability1").html("");
	$(".shenx1").html("");
	$(".surface2").css({ "display": "none" });
	$(".surface1").css({ "display": "block" });
	$(".frequency").val("");
})
$(".yes3").click(function() {
	$(".tishi3").hide()
	$(".bonusAmount1").val(""); //清空积分金额
	$(".bonusNumber1").val(""); //清空积分人数
	$(".bonusProbability1").html(""); //清空积分概率
	$(".jifenJ").val(""); //
	$(".zhongJR").val(""); //
	$(".bonusProbability2").html(""); // 
	$(".bonus1").html("");
	$(".zhongjiangG1").html("");
	$(".prizeProbability1").html("");
	$(".shenx1").html("");
	$(".awardAmount").val(""); //清空积分金额
	$(".awardWinners").val(""); //清空积分人数
	$(".prizeProbability").html(""); //清空积分概率
	$(".bonusAmount").val(""); //清空？等奖金额
	$(".bonusNumber").val(""); //清空？等奖人数
	$(".subtotal").html(""); //清空小计
	$(".bonusProbability").html(""); //清空奖品概率
	$(".bonus").html("");
	$(".zhongjiangG").html("");
	$(".prizeProbability").html("");
	$(".shenx").html("");
	$(".frequency").val("");
})
$(".yes4").click(function() {
	$(".tishi4").hide()
	$(".surplus").html(sum2)
})
$(".yes6").click(function() {
	$(".tishi6").hide()
	$(".bonusAmount1").val("")
	$(".bonusNumber1").val("")
	$(".bonusProbability1").html("")
	$(".bonus1").html("")
	$(".zhongjiangG1").html("")
	$(".shenx1").html("")
})
$(".no1").click(function() {
	$(".tishi1").css({ "display": "none" })
	$(".tishi2").css({ "display": "none" })
	$("input[name='Pattern']").eq(0).attr("checked", "checked");
	$("input[name='Pattern']").eq(1).removeAttr("checked");
	$("input[name='Pattern']").eq(0).click();
	$(".surface2").css({ "display": "none" });
	$(".surface1").css({ "display": "block" });
	$(".add").show();
})
$(".no2").click(function() {
	$(".tishi2").css({ "display": "none" })
	$("input[name='Pattern']").eq(1).attr("checked", "checked");
	$("input[name='Pattern']").eq(0).removeAttr("checked");
	$("input[name='Pattern']").eq(1).click();
	$(".surface2").css({ "display": "block" });
	$(".surface1").css({ "display": "none" });
})
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
	alcoholTotal = a; //中奖总瓶数
	/*没积分但是也有一二三四五等奖*/
	if(parseInt($('.prizeProbability').html())==0 || $("#table-outer2 .table-tbody .jiji").length == 0 && $("#table-outer2 .table-tbody table tr").length >= 2){
		//alert("meijifen")
			cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
							dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
							hougai = parseFloat(cccc / sum2) * 100; //获奖概率.
							subtotal1 = parseFloat(cccc * dd); //小计
							subtotal =parseFloat(bonusAmount * bonusNumber) ; //小计
							$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
							$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
							$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
							$(".surplus").html(sum2-$(".bonusNumber").val()-sum7)
							sum6=0
							$(".qianqian").each(function() { //获奖金额总和
								sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							twogai = 0;
							$(".hougai").each(function() { //获奖概率总和
								twogai += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
							$(".zhongjiangG").html((twogai+onegai).toFixed(2) + "%");
							$(".shenx").html((100-twogai-onegai).toFixed(2) + "%")
							sum7=0
							$(".cccc").each(function() {
								sum7 += parseFloat(parseFloat($(this).val()).toFixed(2));
							})
							$(".surplus").html(sum2-bonusNumber-sum7)
	}else if(parseInt($('.prizeProbability').html())!=0 || $("#table-outer2 .table-tbody .jiji").length != 0 && $("#table-outer2 .table-tbody table tr").length >= 3){
		/*有积分但是也有一二三四五等奖*/
	//	alert("youjifen")
		cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
							dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
							hougai = parseFloat(cccc / sum2) * 100; //获奖概率.
							subtotal1 = parseFloat(cccc * dd); //小计
							subtotal =parseFloat(bonusAmount * bonusNumber) ; //小计
							$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
							$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
							$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
						
						
							sum6=0
							$(".qianqian").each(function() { //获奖金额总和
								sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							twogai = 0;
							$(".hougai").each(function() { //获奖概率总和
								twogai += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
							$(".zhongjiangG").html((twogai+onegai).toFixed(2) + "%");
							$(".shenx").html((100-twogai-prizeProbability-onegai).toFixed(2) + "%")
							sum7=0
							$(".cccc").each(function() {
								sum7 += parseFloat(parseFloat($(this).val()).toFixed(2));
							})
							$(".surplus").html(sum2-bonusNumber-sum7-awardWinners)
	}
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

/*红包模式一、模式二*/
function getRadio(evt) {
	var evt = evt || window.event;
	var e = evt.srcElement || evt.target;
	if(e.value == "1") {
		if($(".bonusAmount1").val() != "" || $(".bonusNumber1").val() != "") {
			$(".tishi2").css({ "display": "block" });
			$(".surface1").css({ "display": "block" });
			$(".add").css({ "display": "block" });
			$(".surface2").css({ "display": "none" });
		} else {
			$(".surface1").css({ "display": "block" });
			$(".surface2").css({ "display": "none" });
			$(".add").css({ "display": "block" });
		}
	} else if(e.value == "2") {
		if($(".prizeProbability").html() != "" || $(".awardAmount").val() != "" || $(".bonusAmount").val() != "" || $(".bonusNumber").val() != "") {
			$(".tishi1").css({ "display": "block" });
			$(".surface1").css({ "display": "none" });
			$(".add").css({ "display": "none" });
			$(".surface2").css({ "display": "block" });
		} else {
			$(".surface1").css({ "display": "none" });
			$(".surface2").css({ "display": "block" });
		}
	}
}
/*点击当前td删除当前tr*/
$(".delete").click(function() {
	$(this).parent().remove();
	$(".prizeProbability").html('0.00'+'%');
	if($("#table-outer2 .table-tbody table tr").length <= 1){
		//alert("小于1")
		bonusNumber=$(".bonusNumber").val()
		onegai = parseFloat(bonusNumber / sum2) * 100;
	
		$(".shenx").html(100-onegai.toFixed(2)+ "%");
		$(".surplus").html(sum2-bonusNumber.toFixed(2))
	}else if($("#table-outer2 .table-tbody table tr").length > 1){
		//alert("dayu1")
		$(".shenx").html(100-(twogai.toFixed(2))-onegai.toFixed(2)+ "%");
		$(".surplus").html(sum2-bonusNumber.toFixed(2)-sum7.toFixed(2))
	}
});
$(function() {
	$(document).ready(function() {
		/*模式二*/
		/*计算奖金的获奖概率*/
		$(".bonusNumber1").blur(function() {
			var bonusAmount1 = parseFloat($(this).parent().parent().find(".bonusAmount1").val()); //获奖金额
			$(".bonus1").html(bonusAmount1 + "元")
			if($(".bonusNumber1").val()!="" && $(".bonusAmount1").val()!=""){
				if(bonusAmount1<($(".bonusNumber1").val()*0.01)){
					$(".tishi6").show();
				}
			}
			if($("#table-outer1 .table-tbody table tr").length == 0) {
				$(".sum").html(0);
				$(".tishi3").css({ "display": "block" });
				$(".zhongjiangG").html("");
				$(".shenx").html("");
				$(".prizeProbability").html("");
				$(".bonus").html("");
			}
			var subtotal1 = b;
			var bonusAmount1 = parseFloat($(this).parent().parent().find(".bonusAmount1").val()); //获奖金额
			if($(".bonusNumber1").val() == "" || ($(this).parent().parent().find(".bonusAmount1").val() == "") || sum2 == "") {
				$(".bonusProbability").html("");
				$(".subtotal").html("");
			} else {
				bonusNumber1 = parseFloat($(this).parent().parent().find(".bonusNumber1").val()); //获奖人数
				bonusProbability1 = (bonusNumber1 / (sum2 * cishu)) * 100; //获奖概率.
				subtotal = bonusAmount1 * bonusNumber1; //小计
				$(this).parent().parent().find(".bonusProbability1").html((bonusProbability1).toFixed(2) + "%");
				$(this).parent().parent().find(".subtotal").html((subtotal).toFixed(2) + "元");
				$(".bonus1").html(bonusAmount1 + "元")
				$(".surplus").html(sum2-bonusNumber1)
				$(".bonusProbability1").html((bonusProbability1).toFixed(2) + "%"); //奖项获奖概率
				$(".zhongjiangG1").html((bonusProbability1).toFixed(2) + "%") //奖项获奖概率
			}
			if($(".bonusNumber1").val() != "") {
				if(bonusProbability1 > 100 && bonusNumber1 > sum2 * cishu) {
					$(".tishi4").css({ "display": "block" });
					$(".bonusProbability1").html("");
					$(".zhongjiangG1").html("");
					$(".bonus1").html("");
					$(".shenx1").html("");
					$(".bonusNumber1").val("");
				}
				if(((bonusProbability1 + jifen) > 100) && bonusNumber1 > (sum2 * cishu)) {
					$(".tishi4").css({ "display": "block" })
					$(".bonusNumber1").val("")
					$(".bonusProbability1").html("")
					$(".bonus1").html("")
					$(".zhongjiangG1").html("")
					$(".shenx").html("")
					$(".zhongJR").val("")
					$(".jifenJ").val("")
					$(".bonusProbability2").html("")
					$(".prizeProbability1").html("")
					$(".shenx1").html("")
					$(".bonusAmount1").val("")
					$(".surplus").html(sum2)
				}
			}
		})

		$(".bonusNumber1,.bonusAmount1").blur(function() {
			var subtotal1 = b;
			var bonusAmount1 = parseFloat($(this).parent().parent().find(".bonusAmount1").val()); //获奖金额
			if($(".bonusNumber1").val() == "" || ($(this).parent().parent().find(".bonusAmount1").val() == "") || sum2 == "") {
				$(".bonusProbability").html("");
				$(".subtotal").html("");
			} else {
				bonusNumber1 = parseFloat($(this).parent().parent().find(".bonusNumber1").val()); //获奖人数
				bonusProbability1 = (bonusNumber1 / (sum2 * cishu)) * 100; //获奖概率.
				subtotal = bonusAmount1 * bonusNumber1; //小计
				$(this).parent().parent().find(".bonusProbability1").html((bonusProbability1).toFixed(2) + "%");
				$(this).parent().parent().find(".subtotal").html((subtotal).toFixed(2) + "元");
				$(".bonus1").html((bonusAmount1).toFixed(2) + "元")
				$(".bonusProbability1").html((bonusProbability1).toFixed(2) + "%"); //奖项获奖概率
				$(".zhongjiangG1").html((bonusProbability1).toFixed(2) + "%") //奖项获奖概率
				$(".shenx1").html((100 - ((bonusProbability1).toFixed(2))).toFixed(2) + "%")
			}
		});
		/*判断运单信息是否为空弹出层*/
		$(".zhongJR").blur(function() {
			if($("#table-outer1 .table-tbody table tr").length == 0) {
				$(".tishi3").css({ "display": "block" })
			}
		});
		/*模式一*/
		$(".bonusNumber,.awardWinners").blur(function() {
			if($("#table-outer1 .table-tbody table tr").length == 0) {
				$(".tishi3").css({ "display": "block" })
			}
		});
		/*计算积分的获奖概率*/
		$(".awardWinners").blur(function() {
			if($("#table-outer1 .table-tbody table tr").length == 0) {
				$(".tishi3").css({ "display": "block" })
			} else {
				
				/*只有积分被填写时发生事件*/
				if($(".awardWinners").val() != "" && $(".awardAmount").val() != "" && $(".bonusAmount").val() == "" && $(".bonusNumber").val() == "") {
					awardAmount = parseFloat($(".awardAmount").val()); //积分获奖金额
					awardWinners = parseFloat($(".awardWinners").val()); //积分获奖人数
					prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
					$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
					$(".shenx").html((100-prizeProbability).toFixed(2)+'%')
					$(".surplus").html(sum2-awardWinners);
					if($(".awardWinners").val() > sum2) {
						$(".tishi4").css({ "display": "block" });
						$(".bonusNumber").val("");
						$(".awardWinners").val("");
						$(".prizeProbability").html("");
						$(".zhongjiangG").html("");
						$(".bonus").html("");
						$(".subtotal").html("");
						$(".bonusProbability").html("");
						$(".shenx").html("");
					}
				};
				/*积分和一等奖都被填写时*/
				if($(".awardWinners").val() != "" && $(".awardAmount").val() != "" && $("#table-outer2 .table-tbody table tr").length == 2 && $(".bonusNumber").val() != "" && $(".bonusAmount").val() != "") {
					awardAmount = parseFloat($(".awardAmount").val()); //积分获奖金额
					awardWinners = parseFloat($(".awardWinners").val()); //积分获奖人数
				    onegai = (bonusNumber / sum2) * 100; //获奖概率.
					prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
					$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
					$(".shenx").html((100-prizeProbability-onegai).toFixed(2)+'%')
					$(".surplus").html(sum2-awardWinners-$(".bonusNumber").val());
					if(awardWinners + gg > sum2) {//一等奖人数+积分人数>总瓶数
						$(".tishi4").css({ "display": "block" });
						$(".prizeProbability").html("");
						$(".shenx").html("");
						$(".awardWinners").val("");
					}
				}
				/*积分和一等奖和二三四等等奖都被填写时*/
				if($("#table-outer2 .table-tbody table tr").length >= 3 && $(".awardWinners").val() != "" && $(".awardAmount").val() != "" ) {
					awardAmount = parseFloat($(".awardAmount").val()); //积分获奖金额
					awardWinners = parseFloat($(".awardWinners").val()); //积分获奖人数
					onegai = (bonusNumber / sum2) * 100; //获奖概率.
					prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
					$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
					$(".shenx").html((100-prizeProbability-twogai-onegai).toFixed(2)+'%')
					$(".surplus").html(sum2-awardWinners-$(".bonusNumber").val()-cccc);
					if(awardWinners + Rsum > sum2) {
						$(".tishi4").css({ "display": "block" });
						$(".prizeProbability").html("");
						$(".shenx").html("");
						$(".awardWinners").val("");
					}
				};
			}
		});
		/*计算奖金的获奖概率*/
		$(".bonusNumber,.bonusAmount").blur(function() {
			/*当积分第一行被删除或者各项等于0时且只有一等奖*/
			if(parseInt($('.prizeProbability').html())==0 || $("#table-outer2 .table-tbody .jiji").length == 0 && $("#table-outer2 .table-tbody table tr").length == 1 && $(".bonusNumber").val()!='' && $(".bonusAmount").val()!='' && $("#table-outer2 .table-tbody .ersan").length == 0  ){
				//alert("没有积分且只有一等奖")
				if($(".bonusNumber").val()!=''){//判断奖项人数为不为空(防止触发人数失焦时所有数据为NAN)
					$('.prizeProbability').html('0.00'+'%') //积分概率
					bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
					bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
					onegai = (bonusNumber / sum2) * 100; //获奖概率.
					subtotal =parseFloat(bonusAmount * bonusNumber) ; //小计
					$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
					$(this).parent().parent().find(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
					/*$(".zhongjiangG").html(onegai.toFixed(2) + "%");
					$(".shenx").html((100-onegai).toFixed(2)+'%');//剩余概率
*/				}else{
					
				}
				/*当积分第一行被删除或者各项等于0时且有一二三四等奖*/
			}else if(parseInt($('.prizeProbability').html())==0 || $("#table-outer2 .table-tbody .jiji").length == 0 &&  $(".bonusNumber").val()!='' && $(".bonusAmount").val()!='' && $("#table-outer2 .table-tbody .ersan").length != 0 ){
				//alert("没有积分有一二三四等奖")
				if($(".bonusNumber").val()!=''){ //判断奖项人数为不为空(防止触发人数失焦时所有数据为NAN)
						bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
						bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
						hougai = (cccc / sum2) * 100; //获奖概率.
						subtotal1 = parseFloat(cccc * dd); //小计
						onegai = (bonusNumber / sum2) * 100; //获奖概率.
						subtotal = parseFloat(bonusAmount * bonusNumber); //小计
						$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
						$(this).parent().parent().find(".subtotal").html((subtotal).toFixed(2) + "元");
						$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
						$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
						$(".subtotal").html((subtotal).toFixed(2) + "元");
						$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
						/*$(".zhongjiangG").html((onegai+twogai).toFixed(2) + "%");
						$(".shenx").html((100-onegai-twogai).toFixed(2)+'%')*/
						
						ppp=onegai.toFixed(2) ;
						tt = onegai;
						gg = bonusNumber;
					}else{
						
					}
					/*当积分第一行没有删除时且有一等奖*/
			}else if(parseInt($('.prizeProbability').html())!=0 || $("#table-outer2 .table-tbody .jiji").length != 0  && $(".bonusNumber").val()!='' && $(".bonusAmount").val()!='' && $("#table-outer2 .table-tbody .ersan").length == 0  ){
			//	alert("有积分且只有一等奖")
				if($(".bonusNumber").val()!=''){ //判断奖项人数为不为空(防止触发人数失焦时所有数据为NAN)
					prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
					$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
					bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
					bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
					onegai = (bonusNumber / sum2) * 100; //获奖概率.
					subtotal = parseFloat(bonusAmount * bonusNumber); //小计
					$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
					$(this).parent().parent().find(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
					/*$(".zhongjiangG").html((onegai).toFixed(2) + "%");
					$(".shenx").html((100-prizeProbability-onegai).toFixed(2)+'%')*/
					ppp=onegai.toFixed(2) ;
					tt = onegai;
					gg = bonusNumber;
				}else{
					
				}
				/*当积分第一行没有删除时且有一二三四等奖*/
		}else if(parseInt($('.prizeProbability').html())!=0 || $("#table-outer2 .table-tbody .jiji").length != 0  && $(".bonusNumber").val()!='' && $(".bonusAmount").val()!='' && $("#table-outer2 .table-tbody .ersan").length != 0 ){
			//alert("有积分有一二三四等奖")
			if($(".bonusNumber").val()!=''){ //判断奖项人数为不为空(防止触发人数失焦时所有数据为NAN)
				prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
				$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
				bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
				bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
				hougai = (cccc / sum2) * 100; //获奖概率.
				subtotal1 = parseFloat(cccc * dd); //小计
				onegai = (bonusNumber / sum2) * 100; //获奖概率.
				subtotal = parseFloat(bonusAmount * bonusNumber); //小计
				$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
				$(this).parent().parent().find(".subtotal").html((subtotal).toFixed(2) + "元");
				$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
				$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
				$(".subtotal").html((subtotal).toFixed(2) + "元");
				$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
				/*$(".zhongjiangG").html((onegai+twogai).toFixed(2) + "%");
				$(".shenx").html((100-prizeProbability-onegai-twogai).toFixed(2)+'%')*/
				ppp=onegai.toFixed(2) ;
				tt = onegai;
				gg = bonusNumber;
			}else{
				
			}
	}
		});
		
		/*判断人数大不大于总瓶数*/
		$(".bonusNumber").blur(function() {
			
			if($("#table-outer2 .table-tbody .ersan").length == 0  && $("#table-outer2 .table-tbody .jiji").length == 0  &&  $(".bonusProbability").html()!='' ){ //没有积分且只有一等奖 
				$(".surplus").html(sum2-$(".bonusNumber").val())
				if($(".bonusNumber").val()>sum2){ //人数不能大于总瓶数的弹出层	
					$(".tishi4").css({ "display": "block" });
					$(".bonusNumber").val("");
					$(".zhongjiangG").html("");
					$(".bonus").html("");
					$(".subtotal").html("");
					$(".bonusProbability").html("");
					$(".shenx").html("");
				}else{//正常情况(人数小于总瓶数的)
					//alert("one")
					if($(".bonusNumber").val()!=''){
						$('.prizeProbability').html('0.00'+'%') //积分概率
						bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
						bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
						onegai = (bonusNumber / sum2) * 100; //获奖概率.
						$(".subtotal").html((subtotal).toFixed(2) + "元");
						$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
						$(".zhongjiangG").html((onegai+twogai).toFixed(2) + "%");
						$(".shenx").html((100-onegai-twogai.toFixed(2)).toFixed(2)+'%');//剩余概率
					}
				}
			}else if($("#table-outer2 .table-tbody .ersan").length == 0  && $("#table-outer2 .table-tbody .jiji").length != 0  &&  $(".bonusProbability").html()!=''){//有积分也有一等奖
				$(".surplus").html(sum2-$(".bonusNumber").val()-awardWinners)
				if((bonusNumber + awardWinners) > sum2) {//人数大于总瓶数的弹出层
					$(".tishi4").css({ "display": "block" });
					$(".bonusNumber").val("");
					$(".zhongjiangG").html("");
					$(".shenx").html("");
					$(".subtotal").html("");
					$(".bonus").html("");
					$(".bonusProbability").html("");
				}else{//人数小于总瓶数(正常的)
					prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
					$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
					bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
					bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
					onegai = (bonusNumber / sum2) * 100; //获奖概率.
					$(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
					$(".zhongjiangG").html((onegai+twogai).toFixed(2) + "%");
					$(".shenx").html((100-prizeProbability.toFixed(2)-onegai.toFixed(2)).toFixed(2)+'%')
					ppp=bonusProbability.toFixed(2) ;
					tt = bonusProbability;
					gg = bonusNumber;
				}
			}else if($("#table-outer2 .table-tbody .ersan").length != 0  && $("#table-outer2 .table-tbody .jiji").length != 0  &&  $(".bonusProbability").html()!=''){//有积分但是有一二三四等奖
				$(".surplus").html(sum2-$(".bonusNumber").val()-awardWinners-cccc)
				if((bonusNumber + awardWinners+sum7) > sum2) {//人数大于总瓶数的弹出层
					$(".tishi4").css({ "display": "block" });
					$(".bonusNumber").val("");
					$(".zhongjiangG").html("");
					$(".shenx").html("");
					$(".subtotal").html("");
					$(".bonus").html("");
					$(".bonusProbability").html("");
				}else{//人数小于总瓶数(正常的)
					prizeProbability = (awardWinners / sum2) * 100; //积分获奖概率(获奖人数/中奖总瓶数)
					$(".prizeProbability").html((prizeProbability).toFixed(2) + "%");
					bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
					bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
					bonusProbability = (bonusNumber / sum2) * 100; //获奖概率.
					$(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
					$(".zhongjiangG").html((onegai+twogai).toFixed(2) + "%");
					$(".shenx").html(100-prizeProbability-onegai-twogaitoFixed(2)+'%')
					ppp=bonusProbability.toFixed(2) ;
					tt = bonusProbability;
					gg = bonusNumber;
				}
			}else if($("#table-outer2 .table-tbody .ersan").length != 0  && $("#table-outer2 .table-tbody .jiji").length == 0  &&  $(".bonusProbability").html()!=''){//没积分也有二三四等奖
				$(".surplus").html(sum2-$(".bonusNumber").val()-cccc)
				if((bonusNumber+sum7) > sum2) {//人数大于总瓶数的弹出层
					$(".tishi4").css({ "display": "block" });
					$(".bonusNumber").val("");
					$(".zhongjiangG").html("");
					$(".shenx").html("");
					$(".subtotal").html("");
					$(".bonus").html("");
					$(".bonusProbability").html("");
				}else{//人数小于总瓶数(正常的)
					$('.prizeProbability').html('0.00'+'%') //积分概率
					bonusNumber = parseFloat($(this).parent().parent().find(".bonusNumber").val()); //一等奖获奖人数
					bonusAmount = parseFloat($(this).parent().parent().find(".bonusAmount").val()); //一等奖获奖金额
					onegai = (bonusNumber / sum2) * 100; //获奖概率.
					$(".subtotal").html((subtotal).toFixed(2) + "元");
					$(".bonus").html((subtotal+sum6).toFixed(2) + "元")
					$(".zhongjiangG").html((onegai+twogai).toFixed(2) + "%");
					$(".shenx").html((100-onegai-twogai).toFixed(2)+'%')
					ppp=onegai.toFixed(2) ;
					tt = onegai;
					gg = bonusNumber;
				}
			}
			
		});
		var i;
		var arr3 = ["一", "二", "三", "四"]
		for(i = 0; i < arr3.length; i++) {

		};
		/*动态添加奖品tr*/
		var level = 1;
		var levelCaps = "";
		$(".add img").click(function() {
			level++;
			if(level == 2) {
				levelCaps = "二";
			} else if(level == 3) {
				levelCaps = "三";
			} else if(level == 4) {
				levelCaps = "四";
			} else if(level == 5) {
				levelCaps = "五";
			} else if(level == 6) {
				levelCaps = "六";
			} else if(level == 7) {
				levelCaps = "七";
				$(this).off("click");
			}
			var tr = $("<tr class='ersan'></tr>");
			tr.appendTo($('#table-outer2 .table-tbody table'));

			var td1 = $('<td>' + levelCaps + "等奖" +
				'</td>');
			var td2 = $('<td >' + '<input type="text" class=" dd" oninput="clearNoNum(this)" onblur="clearNoNum(this)"/> 元' +
				'</td>');
			var td3 = $('<td >' + '<input type="text" class=" cccc" oninput="clearNoNum(this)" onblur="clearNoNum(this)"/> 人' +
				'</td>');
			var td4 = $('<td class=" qianqian">' +
				'</td>');
			var td5 = $('<td class=" hougai">' +
				'</td>');
			var td6 = $("<td class='deleteTd' onclick='deleteAwardTr(this)'>删除</td>");
			td1.appendTo(tr);
			td2.appendTo(tr);
			td3.appendTo(tr);
			td4.appendTo(tr);
			td5.appendTo(tr);
			td6.appendTo(tr);
			/*计算动态的获奖概率*/
		$(".dd,.cccc").blur(function() {
				if(parseInt($('.prizeProbability').html())==0 || $("#table-outer2 .table-tbody .jiji").length == 0){//没有积分
					if($(".cccc").val()!=''){
						//alert("one")
						cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
						dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
						hougai = (cccc / sum2) * 100; //获奖概率.
						subtotal1 = parseFloat(cccc * dd); //小计
						$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
						
						sum5 = 0;
						$(".cccc").each(function() { //获奖人数总和
							sum5 += parseFloat(parseFloat($(this).html()).toFixed(2));
						})
						sum6 = 0;
						$(".qianqian").each(function() { //获奖金额总和
							sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
						})
						twogai = 0;
						$(".hougai").each(function() { //获奖概率总和
							twogai += parseFloat(parseFloat($(this).html()).toFixed(2));
						})
						if((dd!='')&&(!isNaN(cccc))){
							$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
							$(".zhongjiangG").html((twogai+onegai).toFixed(2) + "%");
							$(".shenx").html((100-onegai-twogai).toFixed(2) + "%")
							$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
							$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
							
						}else{
							//alert("有个串串")
						}
						sum7 = 0;
						$(".cccc").each(function() {
							sum7 += parseFloat(parseFloat($(this).val()).toFixed(2));
						})
						
					}else{
						
					}
					
				}else{//有积分
						cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
						dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
						cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
						dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
						sum5=0
						$(".bonusProbability").each(function() {
							sum5 += parseFloat(parseFloat($(this).html()).toFixed(2));
						})
						sum6=0
						$(".qianqian").each(function() { //获奖金额总和
							sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
						})
						twogai = 0;
						$(".hougai").each(function() {
							twogai += parseFloat(parseFloat($(this).html()).toFixed(2));
						})
						if((dd!='')&&(!isNaN(cccc))){
							$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
							hougai = parseFloat(cccc / sum2) * 100; //获奖概率.
							subtotal1 = parseFloat(cccc * dd); //小计
							$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
							$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
							$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
						}else{
							//alert("有个串串")
						}
						sum7=0
						$(".cccc").each(function() {
							sum7 += parseFloat(parseFloat($(this).val()).toFixed(2));
						})
				}
			});
		
			/*判断人数大不大于总瓶数*/
			$(".cccc").blur(function() {
				if(parseInt($('.prizeProbability').html())==0 || $("#table-outer2 .table-tbody .jiji").length == 0){ //判断第一行为空或者各项为o 
					$(".surplus").html(sum2-$(".bonusNumber").val()-sum7)
					if(bonusNumber+sum7>sum2){ //只有一等奖和二三四等奖(没有积分)
						$(".tishi4").css({ "display": "block" });
						parseFloat($(this).parent().parent().find(".cccc").val(''));
						$(".zhongjiangG").html("");
						$(".bonus").html("");
						$(".shenx").html("");
						parseFloat($(this).parent().parent().find(".qianqian").html('')); //删除当前的小计
						parseFloat($(this).parent().parent().find(".hougai").html(''));//删除当前的获奖概率
					}else{//正常情况(人数小于总瓶数的)
						if($(".cccc").val()!=''){
							cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
							dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
							cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
							dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
							hougai = parseFloat(cccc / sum2) * 100; //获奖概率.
							subtotal1 = parseFloat(cccc * dd); //小计
							$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
							$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
							$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
							sum5 = 0;
							$(".bonusProbability").each(function() {
								sum5 += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							sum6=0
							$(".qianqian").each(function() { //获奖金额总和
								sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							twogai = 0;
							$(".hougai").each(function() { //获奖概率总和
								twogai += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							if((dd!='')&&(!isNaN(cccc))){
								$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
								$(".zhongjiangG").html((twogai+onegai).toFixed(2) + "%");
								$(".shenx").html((100-onegai-twogai).toFixed(2) + "%")
								$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
								$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
								
							}else{
								//alert("有个串串")
							}
							
							sum7 = 0;
							$(".cccc").each(function() {
								sum7 += parseFloat(parseFloat($(this).val()).toFixed(2));
							})
							
						}else{
							//alert("3")
						}
					}
				}else{//有积分也有一二三四等奖
					$(".surplus").html(sum2-$(".bonusNumber").val()-sum7-awardWinners)
					
					
					if((bonusNumber + awardWinners+sum7) > sum2) {//有积分和一二三四等奖
						$(".tishi4").css({ "display": "block" });
						parseFloat($(this).parent().parent().find(".cccc").val(''));
						$(".zhongjiangG").html("");
						$(".bonus").html("");
						$(".shenx").html("");
						parseFloat($(this).parent().parent().find(".qianqian").html('')); //删除当前的小计
						parseFloat($(this).parent().parent().find(".hougai").html(''));//删除当前的获奖概率
					}else{//人数小于总瓶数(正常的)
						if($(".cccc").val()!=''){
							//alert("four")
							cccc = parseFloat($(this).parent().parent().find(".cccc").val()); //一等奖获奖人数
							dd = parseFloat($(this).parent().parent().find(".dd").val()); //一等奖获奖金额
							hougai = parseFloat(cccc / sum2) * 100; //获奖概率.
							subtotal1 = parseFloat(cccc * dd); //小计
							$(this).parent().parent().find(".bonusProbability").html((onegai).toFixed(2) + "%");
							
							sum5=0
							$(".bonusProbability").each(function() {
								sum5 += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							sum6=0
							$(".qianqian").each(function() { //获奖金额总和
								sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
							twogai = 0;
							$(".hougai").each(function() { //获奖概率总和
								twogai += parseFloat(parseFloat($(this).html()).toFixed(2));
							})
						//	alert(dd+'第二个')
						//	alert(cccc+'第二个')
							if((dd!='')&&(!isNaN(cccc))){
								$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
								$(".zhongjiangG").html((twogai+onegai).toFixed(2) + "%");
								$(".shenx").html((100-twogai-prizeProbability-onegai).toFixed(2) + "%")
								$(this).parent().parent().find(".hougai").html((hougai).toFixed(2) + "%");
								$(this).parent().parent().find(".qianqian").html((subtotal1).toFixed(2) + "元");
							}else{
								//alert("有个串串+1+1+1")
							}
							sum7=0
							$(".cccc").each(function() {
								sum7 += parseFloat(parseFloat($(this).val()).toFixed(2));
							})
							//Rsum=sum7+bonusNumber;
						}else{
							//alert("4")
						}
					}
				}
			});

			$(".dd").blur(function() {
				
				sum6=0
				$(".qianqian").each(function() { //获奖金额总和
					sum6 += parseFloat(parseFloat($(this).html()).toFixed(2));
				})
				if((dd!='')&&(!isNaN(cccc))){
				$(".bonus").html((sum6+subtotal).toFixed(2) + "元");
				}
			})
		});
	});
})
