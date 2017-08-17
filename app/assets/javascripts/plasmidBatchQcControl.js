$(document).ready(function() {
	
	  $('#assay-modal').on('show.bs.modal', function(e) {

		var $pcr_colony_select = $("#plasmid_batch_qc_pcr_colony_id");

		$pcr_colony_select.on("change.select2", function (e) { 
			
			var status = $pcr_colony_select.val();
			console.log("Value = "+status);
			//
			if(parseInt(status)<3){
					$("#alt-container").show('slow', 'swing');
					$("#conclusion-container").show('slow', 'swing');
					$("#primer-container").show('slow', 'swing');
					$("#date-container").show('slow', 'swing');
			}else{
					$("#alt-container").hide('slow', 'swing');
					$("#conclusion-container").hide('slow', 'swing');
					$("#primer-container").hide('slow', 'swing');
					$("#date-container").hide('slow', 'swing');
			};
			
		});
	});
});