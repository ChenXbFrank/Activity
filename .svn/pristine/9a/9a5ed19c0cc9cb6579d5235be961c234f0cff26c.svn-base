$(function(){
	/*弹窗点击事件*/
	
	$("#receiver-yes").on("click",function(){
		$(".succ-pop").hide();
		$(".billInfos").show();
		
	});
	$("#bill-yes").on("click",function(){
		$(".billInfos").hide();
		$(".delivery-success").show();
	});
	$("#delivery-success-yes").on('click',function(){
		$("#popup").hide();
		$(".succ-pop").hide();
		$(".billInfos").hide();
		$(".delivery-success").hide();
		location.reload();
	});
	$(".cancel").on("click",function(){
		$("#popup").hide();
		$(".succ-pop").hide();
		$(".billInfos").hide();
		$(".delivery-success").hide();
	})
	
		/*
		 * 模拟下拉框
		 */
		/*砍价情况*/
		var open1=true;
		$("#bargaining-situations").on("click",function(event){
			open2=true;
			event.stopPropagation();//阻止冒泡
			if(open1){
				$("#bargain-select").show();
				 open1=false;
			}else{
				$("#bargain-select").hide();
				 open1=true;
			};
			$("#pay-select").hide();
			$("#delivery-select").hide();
		});
		$("#bargain-select li").on("click",function(event){
			 //this指当前的这个Li
			event.stopPropagation();//阻止冒泡
			$("#bargaining-situations").val($(this).html());
			$("#bargain-select").hide();
			open1=true;
		})
		$("#bargain-select li").on("mouseover",function(){
		   //this指当前的这个Li
			$(this).css("background","#d0d0d0").siblings().css("background","white");
		});
		
		
		/*发货情况*/
		var open2=true;
			$("#delivery-situations").on("click",function(event){
				 open1=true;
				 event.stopPropagation();//阻止冒泡
			if(open2){
				 $("#delivery-select").show();
				 open2=false;
			}else{
				$("#delivery-select").hide();
				 open2=true;
			};
				$("#bargain-select").hide();
				$("#pay-select").hide();
			});
		
		$("#delivery-select li").on("click",function(event){
			 //this指当前的这个Li
			  event.stopPropagation();//阻止冒泡
			$("#delivery-situations").val($(this).html());
			$("#delivery-select").hide();
			open2=true;
		})
		
		$("#delivery-select li").on("mouseover",function(){
		   //this指当前的这个Li
			$(this).css("background","#d0d0d0").siblings().css("background","white");
		});
		
		$(document).click(function(){
			$("#bargain-select").hide();
			$("#pay-select").hide();
			$("#delivery-select").hide();
			 open1=true;
			 open2=true;
		});
		
		/*
		 * 模拟下拉框————快递
		 */
		var open=true;
		$("#bargaining-situations1").on("click",function(event){
			 event.stopPropagation();//阻止冒泡
		 	if(open){
		 		$("#express").show();
		 		open=false;
		 	}else{
		 		$("#express").hide();
		 		open=true;
		 	}
		});
		$("#express li").on("click",function(event){
			 //this指当前的这个Li
			  event.stopPropagation();//阻止冒泡
			$(this).css("background","#d0d0d0").siblings().css("background","white");
			$("#bargaining-situations1").val($(this).html());
			$("#express").hide();
			open=true;
		})
		$(document).click(function(){
				$("#express").hide();
				open=true;
		});
		
		$("#express li").on("mouseover",function(){
		   //this指当前的这个Li
			$(this).css("background","#d0d0d0").siblings().css("background","white");
		});	
	
})