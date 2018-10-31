	//活动名称验证
	function activityNameValidate() {
		if($("#active-name").val() == "") {
			$(".activity-volidate").show();
		} else {
			$(".activity-volidate").hide();
		}
	}
	//时间验证
	function timeValidate() {
		if($("#startTime").val() == "" && $("#endTime").val() == "") {
			$(".time-volidate").show();
		} else {
			$(".time-volidate").hide();
		}
	}
	//活动介绍验证
	function introduceValidate() {
		if(!$("#textarea").val()) {
			$(".introduce-volidate").show();
		} else {
			$(".introduce-volidate").hide();
		}
	}
	
	//奖品设置是否选择验证
	function awardValidate() {
		if($("#table-outer4 .table-tbody table tr").length == 0) {
			$(".award-volidate").show();
		} else {
			$(".award-volidate").hide();
		}
	}
	
	//将对象转化成字符串
	function objTransform(jsonobj) {
		return JSON.stringify(jsonobj);
	}

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
	$(".qwe .outer ul li").on("click", function(event) {
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
	$(".qwe .outer ul li").on("mouseover", function() {
		//this指当前的这个Li
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
	});

	/*
	 * 模拟下拉框
	 */
	var open = true;
	$("#bargaining-situation1").on("click", function(event) {
		event.stopPropagation(); //阻止冒泡
		if(open) {
			$(".select1").show();
			open = false;
		} else {
			$(".select1").hide();
			open = true;
		}
	});
	$(".addPic-left .outer1 ul li").on("click", function(event) {
		//this指当前的这个Li
		event.stopPropagation(); //阻止冒泡
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
		$("#bargaining-situation1").val($(this).html());
		$(".select1").hide();
		open = true;
	})
	$(document).click(function() {
		$(".select1").hide();
		open = true;
	});
	$(".addPic-left .outer1 ul li").on("mouseover", function() {
		//this指当前的这个Li
		$(this).css("background", "#d0d0d0").siblings().css("background", "white");
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

	

	

	/*点击每一行的delete就会删除该行的数据*/
	var DeleteIndex;

	function deleteTr(obj) {
		var DeleteIndex = $(obj).parent('tr').index();
		if($("#table-outer4 .table-tbody tr").length == 0) {
			/*刪除对应的数组项*/
			billLists.splice(DeleteIndex, 1);
			$(obj).parent('tr').remove();
			awardNumSum();
			billValidate();
		} else {
			$(".tishi1").show();
		}
	}
	$(".tishi1 .yes1").on("click", function() {
		$(".tishi1").hide();
		$("#otherPic").show();
		/*刪除对应的数组项*/
		billLists.splice(DeleteIndex, 1);
		CreateTableWayBill(billLists.length, billLists);
		awardNumSum();
		$("#table-outer4 .table-tbody table").html(""); //清空表格
		addAwards = []; //清空奖品设置数组中的数据
		countAwardTotal();
		billValidate();
		awardValidate();
	});
	$(".tishi1 .no1").on("click", function() {
		$(".tishi1").hide();
	})
	/*点击奖品设置出现/隐藏弹窗*/
	$("#otherPic").on("click", function() {
		//判断点击奖品设置，当运单信息没有内容时，提示
		if(addAwards.length < 2) {
			var billListslen = billLists.length;
			if(billListslen != 0) {
				if(addAwards.length >= $("input[name='awardNum']:checked").val()) {
					$("#otherProduct").hide();
				} else {
					$("#otherProduct").show();
					//清空弹窗里面的输入框
					$("#bargaining-situation").val("");
					$("#proName").val("");
					$("#proNum").val("");
					$("#probability").html("");
					$("#integral").val("");
					$("#money").val("");
					isClickWhere = false;
				}
			} else {
				$(".tishi5").show();
				$(".tishi5 .yes5").on("click", function() {
					$(".tishi5").hide();
				})
			}
		}
	});
	$("#otherPro-close,#otherPic-cancel").on("click", function() {
		$("#otherProduct").hide();
	});
	/*改变奖品类型的下拉框时，分别出现不同数据配置*/
	$(".addPic-left .select li").on("click", function() {
		var awardType = $("#bargaining-situation").val();
		if(awardType == "红包") {
			$(".proName").show();
			$(".redBag").show();
			$(".matter,.integral,.thanks").hide();
			$("#proName").val("红包");
		} else if(awardType == "积分") {
			$(".proName").show();
			$(".integral").show();
			$(".matter,.redBag,.thanks").hide();
			$("#proName").val("积分");
		} else if(awardType == "实物") {
			$(".proName").show();
			$(".matter").show();
			$(".integral,.redBag,.thanks").hide();
			$("#proName").val("");
		} else if(awardType == "谢谢惠顾") {
			$(".thanks").show();
			$(".integral,.redBag,.matter").hide();
			$(".proName").hide();
			$("#proName").val("");
		}
	});
	$(".addPic-left .select1 li").on("click", function() {
		var awardType1 = $("#bargaining-situation1").val();
		if(awardType1 == "一等奖") {
			$(".threshold").hide();
			$(".threshold-add").hide();
			$(".firstPrize").show();
			$(".firstPrize-add").show();
		} else if(awardType1 == "阀值奖") {
			$(".firstPrize").hide();
			$(".firstPrize-add").hide();
			$(".threshold").show();
			$(".threshold-add").show();
		} else {
			alert("点击查看赋值出错");
		}
	});
	var addAwards = [];
	var isClickWhere = false; //false代表点击的奖品设置按钮，true代表点击的修改
	//当点击奖品设置的按钮时
	$("#otherPic-save").on("click", function() {
		if(addAwards.length == 1) {
			$("#otherPic").hide();
		}
		var volidSuccess = false;
		//验证弹窗的输入框信息是否填写完整
		if($("#bargaining-situation1").val() == "" || $("#bargaining-situation").val() == "" || $("#proName").val() == "") {
			$(".tishi4").show();
			$(".tishi4 .yes4").on("click", function() {
				$(".tishi4").hide();
			})
		}
		if($("#bargaining-situation1").val() == "一等奖") {
			if($("#bargaining-situation").val() == "红包") {
				if($("#money").val() != "" && $("#proName").val() != "" && $("#bargaining-situation1").val() != "") {
					$("#otherProduct").hide();
					volidSuccess = true;
				} else {
					$(".tishi4").show();
					$(".tishi4 .yes4").on("click", function() {
						$(".tishi4").hide();
					})
				}
			} else if($("#bargaining-situation").val() == "积分") {
				if($("#integral").val() != "" && $("#proName").val() != "" && $("#bargaining-situation1").val() != "") {
					$("#otherProduct").hide();
					volidSuccess = true;
				} else {
					$(".tishi4").show();
					$(".tishi4 .yes4").on("click", function() {
						$(".tishi4").hide();
					})
				}
			} else if($("#bargaining-situation").val() == "实物") {
				if($("#proName").val() != "" && $("#pic1").attr("src").indexOf("upload") > -1) {
					$("#otherProduct").hide();
					volidSuccess = true;
				} else {
					$(".tishi4").show();
					$(".tishi4 .yes4").on("click", function() {
						$(".tishi4").hide();
					})
				}
			}
		} else if($("#bargaining-situation1").val() == "阀值奖") {
			if($("#bargaining-situation").val() == "红包") {
				if($("#money").val() != "" && $("#proName").val() != "" && $("#bargaining-situation1").val() != "" && $("#proNum").val() != "") {
					$("#otherProduct").hide();
					volidSuccess = true;
				} else {
					$(".tishi4").show();
					$(".tishi4 .yes4").on("click", function() {
						$(".tishi4").hide();
					})
				}
			} else if($("#bargaining-situation").val() == "积分") {
				if($("#integral").val() != "" && $("#proName").val() != "" && $("#bargaining-situation1").val() != "" && $("#proNum").val() != "") {
					$("#otherProduct").hide();
					volidSuccess = true;
				} else {
					$(".tishi4").show();
					$(".tishi4 .yes4").on("click", function() {
						$(".tishi4").hide();
					})
				}
			} else if($("#bargaining-situation").val() == "实物") {
				if($("#proName").val() != "" && $("#proNum").val() != "" && $("#pic1").attr("src").indexOf("upload") > -1) {
					$("#otherProduct").hide();
					volidSuccess = true;
				} else {
					$(".tishi4").show();
					$(".tishi4 .yes4").on("click", function() {
						$(".tishi4").hide();
					})
				}
			}
		}

		if(volidSuccess) {
			/*当验证成功(信息填写完整)的情况，分别从奖品设置弹窗保存和修改保存两种情况保存或者修改数据*/
			if(isClickWhere) {
				/*当点击修改保存时*/
				addAwards[index].type = $("#bargaining-situation").val();
				addAwards[index].grade = $("#bargaining-situation1").val();
				addAwards[index].name = $("#proName").val();
				if(addAwards[index].grade == "一等奖") {
					addAwards[index].total = "第一名"
				} else if(addAwards[index].grade == "阀值奖") {
					addAwards[index].total = $("#proNum").val();
				} else {
					alert("重新获取集赞总数有错")
				}
				var awardType = addAwards[index].type;
				if(awardType == "红包") {
					addAwards[index].money = $("#money").val();
				} else if(awardType == "积分") {
					addAwards[index].integral = $("#integral").val();;
				} else if(awardType == "实物") {
					addAwards[index].pic1Src = $("#pic1").attr("src");
				}
				createTableOtherNew(addAwards.length, addAwards);
			} else {
				var addAwardObj = new Object();
				addAwardObj.name = $("#proName").val();
				addAwardObj.grade = $("#bargaining-situation1").val();
				addAwardObj.type = $("#bargaining-situation").val();
				if($("#bargaining-situation").val() == "实物") {
					addAwardObj.pic1Src = $("#pic1").attr("src");
					addAwardObj.money = "";
					addAwardObj.integral = "";
				} else if($("#bargaining-situation").val() == "红包") {
					addAwardObj.money = $("#money").val();
					addAwardObj.pic1Src = " ";
					addAwardObj.integral = "";
				} else if($("#bargaining-situation").val() == "积分") {
					addAwardObj.integral = $("#integral").val();
					addAwardObj.pic1Src = " ";
					addAwardObj.money = "";
				} else {
					alert("非实物非红包非积分");
				}
				/*当从奖品设置点击弹窗并保存时,分别从一等奖和阀值奖两种类型分别取相应的数据*/
				if($("#bargaining-situation1").val() == "一等奖") {
					addAwardObj.total = $(".firstPrize").html();
				} else if($("#bargaining-situation1").val() == "阀值奖") {
					addAwardObj.total = $("#proNum").val();
				} else {
					alert("既不是一等奖又不是阀值奖")
				}
				addAwards.push(addAwardObj);
			}
			createTableOtherNew(addAwards.length, addAwards);
			awardValidate();
			//console.log(addAwards);
			awardSetTotal();
		}
	})

	/*点击其他奖品表格中每一行的delete就会删除该行的数据*/
	function deleteOtherProduct(obj) {
		if(addAwards.length == 2) {
			$("#otherPic").show();
		}
		var index = $(obj).parent().parent('tr').index();
		/*刪除对应的数组项*/
		addAwards.splice(index, 1);
		$(obj).parent().parent('tr').remove();
		createTableOtherNew(addAwards.length, addAwards);
		var checkedNumber = 0;
		for(var i in addAwards) {
			checkedNumber += parseInt(addAwards[i].number);
		}
		$("#residueAwardNum").html(parseInt($("#awardTotal").html() - checkedNumber));
		$("#needAwardNum").html(parseInt($("input[name='awardNum']:checked").val()) - addAwards.length);
		//console.log(addAwards);
		awardValidate();
	}
	/*点击修改进行的事件*/
	var index; //点击修改时是点击的表格中的第几个修改
	function modify(obj) {
		isClickWhere = true;
		//将修改的弹窗显示出来
		$("#otherProduct").show();
		//改变弹窗里面的输入框的值
		index = $(obj).parent().parent().index();
		console.log(addAwards);
		var awardType = addAwards[index].type;
		var awardName = addAwards[index].name;
		var awardTotal = addAwards[index].total;
		var awardGrade = addAwards[index].grade;
		$("#bargaining-situation").val(awardType);
		$("#bargaining-situation1").val(awardGrade);
		$("#proName").val(awardName);
		/*从奖品等级分*/
		$(".jizan").show();
		if(awardGrade == "一等奖") {
			$(".threshold").hide();
			$(".threshold-add").hide();
			$(".firstPrize").show();
			$(".firstPrize-add").show();
		} else if(awardGrade == "阀值奖") {
			$(".firstPrize").hide();
			$(".firstPrize-add").hide();
			$(".threshold").show();
			$(".threshold-add").show();
			$("#proNum").val(awardTotal);
		} else {
			alert("点击查看赋值出错");
		}
		/*从奖品类型分*/
		if(awardType == "红包") {
			$(".redBag").show();
			$(".matter,.integral").hide();
			var awardMoney = addAwards[index].money;
			$("#money").val(awardMoney);
		} else if(awardType == "积分") {
			$(".integral").show();
			$(".matter,.redBag").hide();
			var awardIntegral = addAwards[index].integral;
			$("#integral").val(awardIntegral);
		} else if(awardType == "实物") {
			$(".matter").show();
			$(".integral,.redBag").hide();
			var awardPic1Src = addAwards[index].pic1Src;
			$("#pic1").attr("src", awardPic1Src);
		} else {
			alert("点击查看赋值出错！")
		}

	}
	//其他奖品动态创建的表格
	function createTableOtherNew(rowCount, content) {
		/*动态创建表格之前先将除表头外的信息清空*/
		$('#table-outer4 .table-tbody table').html("");
		for(var i = 0; i < rowCount; i++) {
			var tr = $("<tr></tr>");
			tr.appendTo($('#table-outer4 .table-tbody table'));
			var td1 = $('<td>' + (i + 1) +
				'</td>');
			var td2 = $('<td>' + content[i].grade +
				'</td>');
			var td3 = $('<td>' + content[i].name +
				'</td>');
			var td4 = $('<td>' + content[i].type +
				'</td>');
			if(content[i].grade == "阀值奖") {
				var td5 = $('<td>' + '集赞总数' + content[i].total + '<span class="qwee" style="display:none">' + '</span>' +
					'</td>');
			} else {
				var td5 = $('<td>' + content[i].total + '<span class="qwee" style="display:none">' + '</span>' +
					'</td>');
			}

			var td6 = $("<td><span class='look' onClick='modify(this)'>修改</span>&nbsp;<span class='del' onclick='deleteOtherProduct(this)'>删除</span></td>");
			td1.appendTo(tr);
			td2.appendTo(tr);
			td3.appendTo(tr);
			td4.appendTo(tr);
			td5.appendTo(tr);
			td6.appendTo(tr);
		}
	};

	/*
	 * 计算奖品总数
	 */
	function countAwardTotal() {
		var times = $("input[name='scanTimes']:checked").val();
		var awardTotalNum = $("#sum").html();
		var result = parseInt(times) * parseInt(awardTotalNum);
		$("#awardTotal").html(result);
		//显示还需设置的奖品个数，剩余奖品数量
		var needAwardNum = $("input[name='awardNum']:checked").val();
		var residueAwardNum = $("#awardTotal").html();
		$("#needAwardNum").html(needAwardNum);
		$("#residueAwardNum").html(residueAwardNum);
	}
	/*
	 * 当奖品数量失去焦点时，进行中奖概率的计算
	 */
	$("#proNum").on("blur", function() {
		if(isClickWhere == false) {
			var proNum = parseInt($("#proNum").val());
			var awardTotal = parseInt($("#awardTotal").html());
			var residueAwardNum = parseInt($("#residueAwardNum").html());
			if(proNum > residueAwardNum) {
				$("#proNum").val(residueAwardNum);
				proNum = parseInt($("#proNum").val());
				var countResult = (proNum / awardTotal * 100).toFixed(2) + "%";
				$("#probability").html(countResult);
			} else {
				var countResult = (proNum / awardTotal * 100).toFixed(2) + "%";
				$("#probability").html(countResult);
			}
		} else {
			var proNum = parseInt($("#proNum").val());
			var awardTotal = parseInt($("#awardTotal").html());
			var residueAwardNum = 0;
			for(var i = 0; i < addAwards.length; i++) {
				residueAwardNum += parseInt(addAwards[i].number);
			}
			residueAwardNum = awardTotal - (residueAwardNum - parseInt(addAwards[index].number));
			if(proNum > residueAwardNum) {
				$("#proNum").val(residueAwardNum);
				proNum = parseInt($("#proNum").val());
				var countResult = (proNum / awardTotal * 100).toFixed(2) + "%";
				$("#probability").html(countResult);
			} else {
				var countResult = (proNum / awardTotal * 100).toFixed(2) + "%";
				$("#probability").html(countResult);
			}
		}
	})
	var awardSetNum = $("input[name='awardNum']:checked").val();

	function awardSetTotal() {
		/*获取选中的展示奖品数*/
		awardSetNum = $("input[name='awardNum']:checked").val();
		var awardSum = 0; //奖品数量之和
		var hasSetAwardNum = addAwards.length;
		for(var i = 0; i < addAwards.length; i++) {
			awardSum += parseInt(addAwards[i].number);
		}
		//显示还需设置的奖品个数，剩余奖品数量
		var needAwardNum = parseInt(awardSetNum) - parseInt(hasSetAwardNum);
		var residueAwardNum = parseInt($("#awardTotal").html()) - awardSum;
		if(needAwardNum >= 0) {
			$("#needAwardNum").html(needAwardNum);
		} else {
			$("#needAwardNum").html("0");
		}
		if(residueAwardNum >= 0) {
			$("#residueAwardNum").html(residueAwardNum);
		} else {
			$("#residueAwardNum").html("0");
		}

		//判断当设置奖品个数(转盘半数)==数组的长度时，判断当奖品数量之和大于或小于奖品总数时
		if(hasSetAwardNum == awardSetNum) {
			if(awardSum < parseInt($("#awardTotal").html())) {
				$(".tishi3").show();
				$(".yes3").on("click", function() {
					$(".tishi3").hide();
				});
			}
		}
		//判断当奖品数量之和大于奖品总数时
		if(awardSum > parseInt($("#awardTotal").html())) {
			$("#setAwardNumber").html(awardSetNum);
		}
	}
	//当改变扫码抽奖次数的时候
	$("input[name='scanTimes']").on("change", function() {
		countAwardTotal();
		if(addAwards.length != 0) {
			$("#table-outer4 .table-tbody table").html(""); //清空表格
			addAwards = []; //清空奖品设置数组中的数据
		}
	})
	//当改变转盘展示奖品数的时候
	$("input[name='awardNum']").on("change", function() {
		countAwardTotal();
		addAwards = []; //清空奖品设置数组中的数据
		$("#table-outer4 .table-tbody table").html(""); //清空表格
	})
	//积分值限制，只能是大于等于1的整数
	$("#integral").on("blur", function() {
		var integral = parseInt($(this).val());
		if(integral <= 0) {
			$(this).val("1");
		}
	});
	//红包值限制，只能是大于等于0.01的数，可以是小数
	$("#money").on("blur", function() {
		var money = parseFloat($(this).val());
		if(money <= 0) {
			$(this).val("0.01");
		}
	})
	/* 输入框限制
	 */
	function clearNoNum(obj) {
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
	}
	