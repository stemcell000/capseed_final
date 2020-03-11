$(document).ready(function() {
//	
/*$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({
    	"format": "yyyy-mm-dd", 
    	"startView": "1",
    	"autoclose": true,
    	"todayBtn": true,
    	"clearBtn": true,
    	"daysOfWeekDisabled": "0,6",
    	"calendarWeeks": true,
    	"todayHighlight": true,
    	"showButtonPanel": true,
    	
    	});
    });
     console.debug('datepicker');*/
    $( function() {
    $( "#start_date" ).datepicker({
	    format: "mm/dd/yyyy",
	    clearBtn: true,
	    autoclose: true,
	    todayHighlight: true
    });
    
    $( "#end_date" ).datepicker({
	    format: "mm/dd/yyyy",
	    clearBtn: true,
	    autoclose: true,
	    todayHighlight: true
    });
    
    console.debug('datepicker prod');
  } ); 

});

