//Initialisation des champs select avec Select2 qui se trouvent dans les fenêtres modales.
  $(document).ready(function() {
  $('#box-modal').on('show.bs.modal', function(e) {
    console.debug('select2 is initialized in this modal window!');
    
		$( ".select2-select" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select",
		    tokenSeparators: [',', ' ']
		});
		
  });
});


