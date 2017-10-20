
//Initialisation des champs select avec Select2 qui se trouvent dans les fenêtres modales.
  $(document).ready(function() {
  	
  
  $('#qc-modal').on('show.bs.modal', function(e) {
    
    console.debug('select2 is initialized in this modal window!');
    
    
		$( ".select2-select" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select",
		    tokenSeparators: [',', ' ']
		});
		
		
		$('#clone_batch_qc_name').change(function(){
  			
   			if($(this).val() == 'Sequencing'){
   				
   				$("#sequencing").attr('class', 'row');
   				$("#pcr-colony").attr('class', 'hidden');
   				$("#contacts").attr('class', 'row');
   				$("#files").attr('class', 'row');
   				$("#add-file").attr('class', 'row');

   			}else if($(this).val() == 'PCR-colony'){

				$("#pcr-colony").attr('class', 'row');
				$("#sequencing").attr('class', 'hidden');
				$("#contacts").attr('class', 'row');
   				$("#files").attr('class', 'row');
   				$("#add-file").attr('class', 'row');

   				};
		});
		
		//
		
		$('[id*="_date"]').focus(function(){
			
			console.log("focus on datepicker!");
		
		});
	});
});


