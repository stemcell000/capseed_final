//Initialisation des champs select avec Select2 qui se trouvent dans les fenêtres modales.
  $(document).ready(function() {
  $('#assay-modal').on('show.bs.modal', function(e) {
  	
    console.debug('select2 is initialized in this modal window!');
    
		$( ".select2-select-user" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select a user",
		    tokenSeparators: [',', ' ']
		});
		
		$( ".select2-select-unit" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select a unit",
		    tokenSeparators: [',', ' ']
		});
		
		$( "#plasmid_batch_clone_batch_id" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select a unit",
		    tokenSeparators: [',', ' ']
		});
		
  });
});


