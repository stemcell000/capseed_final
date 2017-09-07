$(document).ready(function() {
	
	  $('.modal').on('show.bs.modal', function(e) {

		var $pcr_colony_select = $("#clone_batch_qc_pcr_colony_id");

		$pcr_colony_select.on("change.select2", function (e) { 
			
			var status = $pcr_colony_select.val();
			console.log("Value = "+status);
			//
			if(parseInt(status)<3){
					$(".alt-container").show('slow', 'swing');
			}else{
					$(".alt-container").hide('slow', 'swing');
			};
			
		});
	});
});