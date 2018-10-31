	//活动名称验证
function activityNameValidate(){
	if($("#active-name").val()==""){
		$(".activity-volidate").show();
	} else{
		$(".activity-volidate").hide();
	}
}
//人数名称验证
function activityPersonValidate(){
	if($("#start-person-number").val()==""){
		$(".person-volidate").show();
	} else{
		$(".person-volidate").hide();
	}
}
//时间验证
function timeValidate(){
	if($("#startTime").val()=="" && $("#endTime").val()==""){
		$(".time-volidate").show();
	} else{
		$(".time-volidate").hide();
	}
}
//活动介绍验证
function introduceValidate(){
	if(!$("#textarea").val()){
		$(".introduce-volidate").show();
	} else{
		$(".introduce-volidate").hide();
	}
}
//运单信息是否选择验证
function  billValidate(){
	if($("#table-outer1 .table-tbody table tr").length==0){
		$(".bill-volidate").show();
	}else{
		$(".bill-volidate").hide();
	}
}
//奖品设置是否选择验证
function  awardValidate(){
	if($("#table-outer2 .table-tbody table tr").length==0){
		$(".award-volidate").show();
	}else{
		$(".award-volidate").hide();
	}
}
/*奖品信息中的查找*/
$(".chazhao").click(function(){
	var name = $("#search1").val();
	$(".list-item").each(function(){
		var itemName = $(this).text();
		if( itemName.indexOf(name) > -1 ){
			$(this).parent().show();
		} else {
			$(this).parent().hide();
		}
	})
});






	//将对象转化成字符串
	function objTransform(jsonobj){
		return JSON.stringify(jsonobj);
	}
	
	
		//日期开始
		 $("#startTime").datepicker({
			 minDate:new Date(),
             onSelect:function(startText){ 
               startText=$('#startTime').val();  //开始时间
               $('#endTime').datepicker('option','minDate',startText); 
            }     
        });   

		//结束时间
		 $("#endTime").datepicker({ 
			 minDate:new Date(),
			 onSelect:function(endText){  
                endText=$('#endTime').val();  
                $('#startTime').datepicker('option','maxDate',endText);
            }    
        });
		
		//日期开始
		 $("#startTime2").datepicker({
             onSelect:function(startText){ 
             	maxDate: new Date(),
               startText2=$('#startTime2').val();  //开始时间
               $('#endTime2').datepicker('option','minDate',startText2); 
            }     
        });    

		//结束时间
		 $("#endTime2").datepicker({ 
             onSelect:function(endText){  
                endText2=$('#endTime2').val();  
                $('#startTime2').datepicker('option','maxDate',endText2);
            }    
        });   
		 

/*
	 * 模拟下拉框
	 */
	var open=true;
	$("#bargaining-situations").on("click",function(event){
		 event.stopPropagation();//阻止冒泡
	 	if(open){
	 		$(".select").show();
	 		open=false;
	 	}else{
	 		$(".select").hide();
	 		open=true;
	 	}
	});
	$(".qwe .outer ul li").on("click",function(event){
		 //this指当前的这个Li
		  event.stopPropagation();//阻止冒泡
		$(this).css("background","#d0d0d0").siblings().css("background","white");
		$("#bargaining-situations").val($(this).html());
		$(".select").hide();
		open=true;
	})
	$(document).click(function(){
			$(".select").hide();
			open=true;
	});
	
	$(".qwe .outer ul li").on("mouseover",function(){
	   //this指当前的这个Li
		$(this).css("background","#d0d0d0").siblings().css("background","white");
	});



    /*
	 * 模拟下拉框
	 */
	var open=true;
	$("#bargaining-situation").on("click",function(event){
		 event.stopPropagation();//阻止冒泡
	 	if(open){
	 		$(".select").show();
	 		open=false;
	 	}else{
	 		$(".select").hide();
	 		open=true;
	 	}
	});
	$(".addPic-left .outer ul li").on("click",function(event){
		 //this指当前的这个Li
		  event.stopPropagation();//阻止冒泡
		$(this).css("background","#d0d0d0").siblings().css("background","white");
		$("#bargaining-situation").val($(this).html());
		$(".select").hide();
		open=true;
	})
	$(document).click(function(){
			$(".select").hide();
			open=true;
	});
	
	$(".addPic-left .outer ul li").on("mouseover",function(){
	   //this指当前的这个Li
		$(this).css("background","#d0d0d0").siblings().css("background","white");
	});	
	

	
	
	
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
			var td9 = $('<td>' + content[i].outTime.substring(0,19) +
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

	/*计算总瓶数*/
	function awardNumSum(){
		var sum=0;
		for(var i=0;i<billLists.length;i++){
			sum=sum+parseInt(billLists[i].spec)*parseInt(billLists[i].boxCode);
		}
		$("#sum").html(sum);
		$("#awardTotal").html(sum);
	}
	
	/*点击每一行的delete就会删除该行的数据*/
	var DeleteIndex;
	function deleteTr(obj) {
		DeleteIndex = $(obj).parent('tr').index();
		if($("#table-outer2 .table-tbody tr").length==0){
			/*刪除对应的数组项*/
			billLists.splice(DeleteIndex, 1);
			$(obj).parent('tr').remove();
			awardNumSum();
			billValidate();
		}else{
			$(".tishi1").show();
		}
	}
	//点击提示1的确定
	$(".tishi1 .yes1").on("click",function(){
		$(".tishi1").hide();
		/*刪除对应的数组项*/
		billLists.splice(DeleteIndex, 1);
		CreateTableWayBill(billLists.length, billLists);
		awardNumSum();
		$("#table-outer2 .table-tbody table").html("");  //清空表格
		addAwards=[];//清空奖品设置数组中的数据
		//countAwardTotal();
		awardValidate();
		billValidate(); 
	});
	//点击提示1的取消
	$(".tishi1 .no1").on("click",function(){
		$(".tishi1").hide();
	})
	
    /* addAwards奖品数据列表*/
	var addAwards=[];
	
	
/*点击奖品设置出现/隐藏弹窗*/

$("#otherPic").on("click",function(){
	//判断点击奖品设置，当运单信息没有内容时，提示
	var billListslen=billLists.length;
	if(billListslen!=0){
		$("#otherProduct").show();
	}else{
		$(".tishi5").show();
		$(".tishi5 .yes5").on("click",function(){
			$(".tishi5").hide();
		})
	}
});

$("#otherPro-close,#otherPic-cancel").on("click",function(){
	$("#otherProduct").hide();
});
//奖品信息动态创建的表格
function createTableOtherNew(rowCount,content) {
	/*动态创建表格之前先将除表头外的信息清空*/
	$('#table-outer2 .table-tbody table').html("");
	for (var i = 0; i < rowCount; i++) {
		var tr = $("<tr></tr>");
		tr.appendTo($('#table-outer2 .table-tbody table'));
		var td1 = $('<td>' + content[i].name
				+ '</td>');
		var td2 = $('<td>' + content[i].spec
				+ '</td>');
		var td3 = $('<td>' + content[i].boxCount  //箱数
				+ '</td>');
		var td4 =$('<td>' + content[i].deep
				+ '</td>');
		var td5 =$('<td>' + content[i].volume
				+ '</td>');
		var td6 = $("<td class='del' onclick='deleteOtherProduct(this)'>删除</td>");
		td1.appendTo(tr);
		td2.appendTo(tr);
		td3.appendTo(tr);
		td4.appendTo(tr);
		td5.appendTo(tr);
		td6.appendTo(tr);
	}
};

/*点击其他奖品表格中每一行的delete就会删除该行的数据*/
function deleteOtherProduct(obj){
	var index=$(obj).parent().parent('tr').index();
	/*刪除对应的数组项*/
	addAwards.splice(index,1);
	$(obj).parent().parent('tr').remove();
	createTableOtherNew(addAwards.length,addAwards);
	console.log(addAwards);
	awardValidate();
}
//针对表格1当表格的高度大于外框的高度，让其生成滚动条，否则取消滚动条
function table2(){
	var tbodyOuterHeight2=$("#table-outer2 .table-tbody").height(); 
	var tbodyHeight2=$("#table-outer2 .table-tbody table").height();
	if(tbodyOuterHeight2<tbodyHeight2){
		$("#table-outer2").css({
			"border-bottom":"1px solid #d0d0d0",
		})
	}else{
		$("#table-outer2").css({
			"border-bottom":"none",
		})
	}
}

/* 输入框限制
*/
	function clearNoNum(obj){    
	    //先把非数字的都替换掉，除了数字和.    
	    obj.value = obj.value.replace(/[^\d.]/g,"");    
	    //保证只有出现一个.而没有多个.    
	    obj.value = obj.value.replace(/\.{2,}/g,".");    
	    //必须保证第一个为数字而不是.    
	    obj.value = obj.value.replace(/^\./g,"");    
	    //保证.只出现一次，而不能出现两次以上    
	    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");    
	    //只能输入两个小数  
	    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); 
	    obj.value= obj.value.replace(/[^\d.]/g,'')
	   /* var b=obj.value;
	    b=(b+'').replace(/^0+\./g,'0.');
	    b.match(/^0+[1-9]+/)?b=b.replace(/^0+/g,''):b;
	    obj.value=Number(b)?b:0;*/
	}  
