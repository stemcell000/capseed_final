$(document).ready(function() {
	
var production_id = $('#production_data_id').data('production-data-id');
	
  $('#pb-modal').on('show.bs.modal', function(e) {
	
		$('#plasmid_batch_number').bind('railsAutocomplete.select', function(event, data){

		var id = data.item.id;
		
	  	console.debug("production_id : " +production_id); 
	  	console.debug("plasmid_batch_id : " +id );

	  
			$.ajax({
			type: 'get',
			url : '/productions/'+production_id+'/plasmid_batches/select_to_prod/',
			data: {id: +id, production_id: +production_id}
			});
		});
	
	
	});	
	
	
});

	
