/******************************************************************************************************
 ************************************运单中心弹窗公用js****************************************************
 ******************************************************************************************************/

/************************************************1.运单中心先关js*****************************************************/
var billLists = []; //在运单中心选中的数据：复选框已选择的数据集合
var billListsCopy = []; //复制billLists的数据，与其一样
var clickSendOrSell; //表示点击的是接收的货(sell)还是发出的货(send)

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


/*默认选中：弹出运单中心后，对立面的数据，如果被选中，则默认选中*/
function isSelected() {
	$(".checkbox input[type='checkbox']").each(function() {
		$(this).prop("checked", false);
	});

	for ( var i in billListsCopy) {
		$(".checkbox input[type='checkbox']").each(function() {
			if (billListsCopy[i].recordId == $(this).val()) {
				$(this).prop("checked", "checked");
			}
		})
	}
}

/**
 * 数组中有对象的深拷贝, o为被拷贝的数组
 */
var deepCopy = function(o) {
	if (o instanceof Array) {
		var n = [];
		for (var i = 0; i < o.length; ++i) {
			n[i] = deepCopy(o[i]);
		}
		return n;

	} else if (o instanceof Object) {
		var n = {}
		for ( var i in o) {
			n[i] = deepCopy(o[i]);
		}
		return n;
	} else {
		return o;
	}
}

/**
 * 点击，运单中心数据的复选框，需要用下面的函数处理：
 * 1.如果是【选中】，需要将这条数据一对象的形式，存到集合billListsCopy中。
 * 2.如果是【取消】，需要将这条数据从集合billListsCopy中删除（根据数据的id来匹配）
 * @param currentObj 当前操作的数据
 */
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
		billListsCopy.push(obj);
	} else {
		for ( var i in billListsCopy) {
			if (billListsCopy[i].recordId == $(currentObj).val()) {
				billListsCopy.splice(i, 1);
				return;
			}
		}
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

//奖品设置是否选择验证
function awardValidate() {
	if ($("#table-outer4 .table-tbody table tr").length == 0) {
		$(".award-volidate").show();
	} else {
		$(".award-volidate").hide();
	}
}

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

/**
 * <pre>
 * 点击运单中心页面的确认按钮，应该触发的事件： 
 * 1.将临时数组（billListsCopy）中的数据，深拷贝给：billLists；
 * 2.在父页面创建Table，根据用户选中的数据（billLists）；
 */
$("#bill-btn").on("click", function() {
	billLists = deepCopy(billListsCopy);
	//console.log(billLists);
	CreateTableWayBill(billLists.length, billLists);
	billValidate(); // XXX 引用的其他地方的？？
	awardNumSum(); // XXX 引用的其他地方的？？
})

/* 计算总瓶数 */
function awardNumSum() {
	var sum = 0;
	for (var i = 0; i < billLists.length; i++) {
		sum = sum + parseInt(billLists[i].spec)
				* parseInt(billLists[i].boxCode);
	}
	$("#sum").html(sum);
	countAwardTotal();
}

/**
 * <pre>
 * 通用弹出运单中心窗口： json必须包含的属性: 
 * 1.url: 弹窗数据的URL地址 
 * 2.clickSendOrSell
 */
function addBillCommon(json) {
	billListsCopy = deepCopy(billLists);

	clickSendOrSell = json.clickSendOrSell;
	// 清空跳转页
	$("#input-page").val("");

	// 查询条件
	var BillProductName = $("#search2").val();
	var startTime2 = $("#startTime2").val();
	var endTime2 = $("#endTime2").val();
	var json1 = new Object();
	json1.condition = {
		pageNumber : 1,
		name : BillProductName,
		startTime2 : startTime2,
		endTime2 : endTime2
	};
	json1.url = json.url;

	// 获取弹窗数据
	pageCommonAjax(json1);

	// 绑定分页点击事件
	pageManager(json1);

	if (json.openTips == null) {
		openTips();
	} else {
		json.openTips();
	}

	// 针对表格3当表格的高度大于外框的高度，让其生成滚动条，负责取消滚动条
	var tbodyOuterHeight = $("#table-outer3 .table-tbody").height();
	var tbodyHeight = $("#table-outer3 .table-tbody table").height();
	if (tbodyOuterHeight < tbodyHeight) {
		$("#table-outer3").css({
			"border-bottom" : "1px solid #d0d0d0",
		})
	} else {
		$("#table-outer3").css({
			"border-bottom" : "none",
		})
	}
}

/**
 * 当奖品设置表格中有数据没有数据时，将数据弹窗弹出，当有数据时，则弹出提示信息，点击提示信息的确定将清空数据，点击取消隐藏提示信息
 * @returns
 */
function openTips() {
	if ($("#table-outer4 .table-tbody tr").length == 0) {
		$("#billPop").show(); // 弹窗遮罩显示出来
		$("#search2").val("");
		$("#startTime2").val("");
		$("#endTime2").val("");
	} else {
		$(".tishi1").show();
		$(".tishi1 .yes1").on("click", function() {
			$(".tishi1").hide();
			/* $("#billPop").show(); */
			$("#table-outer4 .table-tbody table").html(""); // 清空表格
			addAwards = []; // 清空奖品设置数组中的数据
			countAwardTotal();
		});
		$(".tishi1 .no1").on("click", function() {
			$(".tishi1").hide();
		})
	}
}

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

/**
 * 运单中心的搜索功能
 * @param json 查询参数，json中必须包含的属性：
 * url
 */
function searchBill(json) {
	//运单号
	var BillProductName = $("#search2").val();
	var startTime2 = $("#startTime2").val();
	var endTime2 = $("#endTime2").val();

	var ajaxJson = new Object();
	ajaxJson.url = json.url;
	ajaxJson.condition = {
		pageNumber : 1,
		name : BillProductName,
		startTime2 : startTime2,
		endTime2 : endTime2
	}

	pageCommonAjax(ajaxJson);
}

/**
 * 创建运单中心的table
 * @param rowCount  当前页一共多少数据
 * @param content	当前页数据相信信息
 */
function CreateTableBill(rowCount, content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	$('#table-outer3 .table-tbody table').html("");
	for (var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer3 .table-tbody table'));
		var td1 = $('<td>' + content[i].OUTNO + '</td>');
		var td2 = $('<td>' + content[i].RECSELLERNAME + '</td>');
		var td3 = $('<td>' + content[i].PRODUCTNAME + '</td>');
		var td4 = $('<td>' + content[i].DEGREE + '</td>');
		var td5 = $('<td>' + content[i].VOLUME + '</td>');
		var td6 = $('<td>' + content[i].SPEC + '</td>');
		var td7 = $('<td>' + content[i].BOXCODE + '</td>');
		var td8 = $('<td>' + content[i].BRANDSNAME + '</td>');
		var td9 = $('<td>' + content[i].OUTDATE + '</td>');
		if (clickSendOrSell == "sell") {
			var td10 = $('<td>接受的货</td>');
		} else if (clickSendOrSell == "send") {
			var td10 = $('<td>发出的货</td>');
		}
		var td11 = $("<td class='checkbox'><input type='checkbox' name="
				+ content[i].SELLERID + " value=" + content[i].RECORDID
				+ " onClick='isSelectedCheckbox(this)' /></td>");
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

/**
 * 给运单中心面板的，关闭和确定按钮，添加事件
 */
$("#bill-btn,#bill-close").on("click", function() {
	$("#billPop").hide();
	removePageOnclick();
});

/** ******************************************2.分页相关的公用js********************************************************************** */
/**
 * <pre>
 * 弹窗分页，绑定事件，JSON对象包含的属性必须有： 
 *  1.url查询接口
 */
function pageManager(json) {
	// 点击下一页
	$(".manager-second-but").click(function() {
		var total = Number($("#admin-total").text());
		var page = Number($("#admin-page").text());
		if (total > page) {
			json.page = page + 1;
			paging(json);
		}
	});

	// 点击上一页
	$(".manager-first-but").click(function() {
		var page = Number($("#admin-page").text());
		if (page > 1) {
			json.page = page - 1;
			paging(json);
		}
	});

	// 监听回车键
	$("#input-page").on("keyup", function(e) {
		if (e.keyCode == 13) {
			$(".skip-btn").click();
		}
	});

	// 跳转到指定页
	$(".skip-btn").click(function() {
		var page = Number($("#input-page").val());
		var total = Number($("#admin-total").text());
		if (page == 0) {
			json.page = 1;
		} else {
			json.page = page;
		}

		if (page <= total) {
			paging(json);
		}
	});

	// 给查询按钮指定url
	$(".chazhao2").on("click", function() {
		searchBill(json);
	});
}

/**
 * <pre>
 * 分页查询，JSON对象的属性至少包括： 
 * 1.url：查询的接口地址 
 * 2.page：查询第几页
 */
function paging(json) {
	// 获取查询条件
	var BillProductName = $("#search2").val();
	var startTime2 = $("#startTime2").val();
	var endTime2 = $("#endTime2").val();

	// 构建分页参数
	var ajaxJson = new Object();
	ajaxJson.condition = {
		pageNumber : json.page,
		name : BillProductName,
		startTime2 : startTime2,
		endTime2 : endTime2
	}

	ajaxJson.url = json.url;

	// ajax查询
	pageCommonAjax(ajaxJson);
}

/**
 *通用Ajax查询，JSON对象至少包含如下属性:
 * 1.url:接口地址
 * 2.condition:请求的条件
 */
function pageCommonAjax(json) {
	$("#loadingInfo").show();
	$.ajax({
		data : json.condition,
		type : "GET",
		dataType : "JSON",
		url : basePath + "/" + json.url,
		success : function(data) {
			$("#loadingInfo").hide();
			//调用接口查询数据，并展示在页面上
			initPageData(data);

			//对数据进行默认选中
			isSelected();
			isCheckAll();
		},
		error : function() {
			$("#loadingInfo").hide();
			alert("网络连接异常，请稍后再试");
		}
	});
}

/**
 * 根据查询结果数据，
 * 1.初始化分页栏的基础数据。一共多少页，当前多少页
 * 2.根据接口返回的分页数据，动态创建表格
 * @param data 接口返回的查询数据。
 */
function initPageData(data) {
	$("#table-outer3 .table-tbody table").html("");
	$("#admin-curent").text(data.pageNumber + "/" + data.totalPageSize);
	$("#admin-total").text(data.totalPageSize);
	$("#admin-page").text(data.pageNumber);

	var rowCount = data.soiList.length;
	for (var i = 0; i < rowCount; i++) {
		CreateTableBill(rowCount, data.soiList);
		//针对表格3当表格的高度大于外框的高度，让其生成滚动条，负责取消滚动条
		var tbodyOuterHeight = $("#table-outer3 .table-tbody").height();
		var tbodyHeight = $("#table-outer3 .table-tbody table").height();
		if (tbodyOuterHeight < tbodyHeight) {
			$("#table-outer3").css({
				"border-bottom" : "1px solid #d0d0d0",
			})
		} else {
			$("#table-outer3").css({
				"border-bottom" : "none",
			})
		}
	}
}

/**
 * 移除分页绑定的事件
 */
function removePageOnclick() {
	$(".manager-second-but").off("click");
	$(".manager-first-but").off("click");
	$(".skip-btn").off("click");
	$(".chazhao2").off("click");
}