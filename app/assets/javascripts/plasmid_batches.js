//
function resetRowColumnSelect(c){
	$("#row").prop("disabled", c);
	$("#row").select2("val", "");
	$("#column").prop("disabled", c);
	$("#column").select2("val", "");
}

function onBoxSelect(){
	$('#box').on("change", function(e) { 
		var value = $("#box").val();
		var text_value = $("#box").select2('data')[0]['text'];
		//
   	console.log("box select");
   	console.log("value is "+value);
   	console.log("text value is "+text_value);
   		//
   	if (text_value == "Garbage"){
   	resetRowColumnSelect(true);
   	}else{
   	resetRowColumnSelect(false);	
   	};
});
}

$(document).ready(function() {
	//
	$('#box-modal').on('show.bs.modal', function(e) {	
	var text_value = $("#box").select2('data')[0]['text'];
	//
	if (text_value == "Garbage"){
   	resetRowColumnSelect(true);
   	};
	//
	onBoxSelect();

});
});