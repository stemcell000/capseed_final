
//Initialisation des champs select avec Select2 qui se trouvent dans les fenêtres modales.
  $(document).ready(function() {
  	
  
  $('#assay-modal').on('show.bs.modal', function(e) {
    
    console.debug('select2 is initialized in this modal window!');
    
    
		$( ".select2-select" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select",
		    tokenSeparators: [',', ' ']
		});
		
		
		var sma1 = $('#plasmid_batch_qc_sma1');
		
	   		if(sma1.val() == 'Not applicable'){
				$("#tech").attr('class', 'col-lg-3');
				console.log("change to visible "+$(this).val());
				}
		
		
		$('#plasmid_batch_qc_sma1').change(function(){
  			
   				if($(this).val() != 'Yes'){
   		
				$("#tech").attr('class', 'col-lg-3');
				
					console.log("change to visible "+$(this).val());
	
   				}else{
   					
   				$("#tech").attr('class', 'hidden');
				
					console.log("change to hidden "+$(this).val());
   				};
		});
		
		//
		
		$('[id*="_date"]').focus(function(){
			
			console.log("focus on datepicker!");
		
		});
	});
});


