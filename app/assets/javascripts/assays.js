$(document).ready(function() {
//	
	var clone_id = $('.panel-body').data('params-id');
	
//Activation des chevron sur le bootstrap panel collapse
function toggleChevron(e) {
    $(e.target)
        .prev('.panel-heading')
        .find("i.indicator")
        .toggleClass('glyphicon-chevron-down glyphicon-chevron-right');
	};

$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({
    	"format": "M. dd, yyyy", 
    	"startView": "1",
    	"autoclose": true,
    	"todayBtn": true,
    	"clearBtn": true,
    	"daysOfWeekDisabled": "0,6",
    	"calendarWeeks": true,
    	"todayHighlight": true
    	
    	});
    });
     console.debug('datepicker');

$('#accordion').on('hidden.bs.collapse', toggleChevron);
$('#accordion').on('shown.bs.collapse', toggleChevron);


});

