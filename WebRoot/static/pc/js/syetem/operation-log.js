	$(function(){
			//日期开始
			 $("#startTime").datepicker({
	             onSelect:function(startText){ 
	             	maxDate: new Date(),
                   startText=$('#startTime').val();  //开始时间
                   $('#endTime').datepicker('option','minDate',startText); 
	            }     
            });    

			//结束时间
			 $("#endTime").datepicker({ 
	             onSelect:function(endText){  
                    endText=$('#endTime').val();  
                    $('#startTime').datepicker('option','maxDate',endText);
	            }    
            });  
 		
		})