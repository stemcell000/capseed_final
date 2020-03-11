//Initialisation des champs select avec Select2 qui se trouvent dans les fenêtres modales.
  $(document).ready(function() {
  	
  	$('.modal').on('show.bs.modal', function(e){
  		
    	console.debug('select2 is initialized in this modal window!');
    
		$( ".select2-select" ).select2({
		    theme: "bootstrap",
		    tag: true,
		    width: "100%",
		    placeholder: "Select",
		    tokenSeparators: [',', ' ']
		});
		console.debug('select2 is initialized in this modal window!');
		
//Activation du bouton sélectionné/désactivation des autres d'une navbar d'un panel de clone.
		$(" .nav li ").click(function(){
			
			console.debug('Statut actif actualisé');
			
				$(".nav li").removeClass("active");
				$(this).addClass('active');
	
			});
});
});