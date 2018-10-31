$(function(){
	var isClick;//触发弹窗的是新增按钮还是修改按钮
	var id;//修改对应的该条数据的id
	/*点击添加物流按钮，出现弹窗*/
	$("#addLogistics").on("click",function(){
		isClick="add";
		$("#otherProduct").show();
		$("#logisticsName").val("");
		$("#remark").val("");
	})
	/*点击弹窗中关闭、取消、保存按钮*/
	$("#pop-close,#otherPic-cancel,#otherPic-save").on("click",function(){
		$("#otherProduct").hide();
	});
	/*点击弹窗中的保存时,将物流信息和备注传给后台*/
	$("#otherPic-save").on("click",function(){
		var name=$("#logisticsName").val();
		var remark=$("#remark").val();
		//如果是新增触发按钮
		if(isClick=="add"){
			$.ajax({
				url: basePath+"/express/add",
				type: "POST",
				dataType: "JSON",
				async: "false",
				data: {
					"name":name ,
					"remark":remark 
				},
				success: function(data) {
					location.reload();
				}
			});
		}else if(isClick=="modify"){
			//获取id
			$.ajax({
				url: basePath+"/express/edit",
				type: "POST",
				dataType: "JSON",
				async: "false",
				data: {
					"name":name ,
					"remark":remark,
					"id":id
				},
				success: function(data) {
					location.reload();
				}
			});
		}
		
	});
	
	/*点击删除*/
	$(".handle .delete").on("click",function(){
		$("#popup1").show();
	});
	/*点击是否删除中的确定和取消*/
	$("#yes,#no").on("click",function(){
		$("#popup1").hide();
	});
	$(".delete").on("click",function(){
		id=$(this).parent().parent().find(".index").attr("name");
	})
	/*点击是否删除中的确定*/
	$("#yes").on("click",function(){
		//获取id
		$.ajax({
			url: basePath+"/express/delete",
			type: "POST",
			dataType: "JSON",
			async: "false",
			data: {
				id:id
			},
			success: function(data) {
				location.reload();
			}
		});
	})
	/*点击修改*/
	$(".modify").on("click",function(){
		isClick="modify";
		$("#otherProduct").show();
		//获取当前这条数据的物流名称和备注信息
		var companyName=$(this).parent().parent().find(".name").html();
		var remark=$(this).parent().parent().find(".remark").html();
		id=$(this).parent().parent().find(".index").attr("name");
		$("#logisticsName").val(companyName);
		$("#remark").val(remark);
	})
	
	$("#search").click(function(){
		var name = $("#userId").val();
		//还需写个时间
		$.ajax({
			data : { 
				name : name,
				currentPage : 1
				},
			type:"GET",
			dataType : "JSON",
			url:basePath+"/express/list",
			success : function(data){
				if( data != false ){
					checkLoad( data );
					$("#input-page").val("");
				} else {
					$(".table-tbody table").html("");
					$("#admin-curent").text( "1/1" );
					$("#admin-total").text( '1' );
					$("#admin-page").text( '1' );
				}
			},
			error : function(){
				alert("网络连接异常，请稍后再试");
			}
		});
	})
	
	    /*分页*/
		adminAjax( 1 );
		$(".manager-second-but").click(function(){//点击下一页
			var total = Number( $("#admin-total").text() );
			var page = Number( $("#admin-page").text() );
			if( total > page ){
				adminAjax( page + 1 );
			}
		});
		
		$(".manager-first-but").click(function(){//点击上一页
			var page = Number( $("#admin-page").text() );
			if( page > 1 ){
				adminAjax( page - 1 );
			}
		});
		$("#input-page").on("keyup",function(e){
			if(e.keyCode==13){
				$(".skip-btn").click();
			}
		});
		
		$(".skip-btn").click(function(){
			var page = Number( $("#input-page").val() );
			if(page==0){
				page=page+1;
			}
			adminAjax( page );
		})
		$("#search").click(function(){
			var name = $("#userId").val();
			var startTime=$("#startTime").val();
			var endTime=$("#endTime").val();
			//还需写个时间
			$.ajax({
				data : { 
					userId : name,
					currentPage : 1
					},
				type:"GET",
				dataType : "JSON",
				url:basePath+"/express/list",
				success : function(data){
					if( data != false ){
						checkLoad( data );
						$("#input-page").val("");
					} else {
						$(".table-tbody table").html("");
						$("#admin-curent").text( "1/1" );
						$("#admin-total").text( '1' );
						$("#admin-page").text( '1' );
					}
				},
				error : function(){
					alert("网络连接异常，请稍后再试");
				}
			});
		});
	})
	
	/* 分页查询 */
	function checkLoad( data ){
			$(".table-tbody table").html("");
			$("#admin-curent").text( data.currentPage + "/" + data.totalPages );
			$("#admin-total").text( data.totalPages );
			$("#admin-page").text( data.currentPage );
			for( var i = 0; i < data.list.length; i++ ){
				var adminObj = $(".admin-obj:eq(0)").clone(true);
				var adminArray = data.list[i];
				adminObj.find(".index").text(i+1);
				adminObj.find(".index").attr("name",adminArray.ID);
				adminObj.find(".name").text( adminArray.NAME);
				adminObj.find(".remark").text( adminArray.REMARK);
				adminObj.find(".handle .delete").text("删除");
				adminObj.find(".handle .modify").text("修改");
				$(".table-tbody table").append( adminObj );
			}
		}
		 
	function adminAjax( page ){
		var name = $("#userId").val();
		$.ajax({
			data : {
				currentPage : page,
				name:name
			},
			type:"GET",
			dataType : "JSON",
			url:basePath+"/express/list",
			success : function(data){
				checkLoad( data );
			},
			error : function(){
				alert("网络连接异常，请稍后再试");
			}
		});
	}
	