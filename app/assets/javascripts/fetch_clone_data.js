var assay_id = $('.panel-body').data('params-id');
var original_clone_id = 0;

//Bloquer/Débloquer les champs du formulaire
function disableFormInputs(c){
		$("#clone_name").prop("readonly", c);
		$("#clone_bbnb").prop("readonly", c);
		$("#clone_insert_ids").prop("disabled", c);
		$("#clone_backbone_ids").prop("disabled", c);
		$("#clone_enzyme_ids").prop("disabled", c);
		$("#clone_cmeth_id").prop("disabled", c);
		$("#clone_primer_f_id").prop("disabled", c);
		$("#clone_primer_r_id").prop("disabled", c);
		$("#clone_comment").prop("readonly", c);
		$("#clone_project_ids").prop("disabled", c);
}

function disableSelectEnzyme(c){

	if(c == true)
	{console.log("Select disabled");}
	else
	{console.log("Select enabled");}
}

$(document).ready(function() {
	
	var assay_id = $('.panel-body').data('params-id');
	
  $('#assay-modal').on('show.bs.modal', function(e) {	
  		
  		$("#reset").click(function(){
  			console.debug("reset");
			$.ajax({
			type: 'get',
			url : '/clones/new',
			data: { assay_id: +assay_id}
			});
		});
	
		$('#clone_name').bind('railsAutocomplete.select', function(event, data){

	  	var id = data.item.id;
	  	original_clone_id = id;
		
	  	console.debug("assay_id : "+ assay_id); 
	  	console.debug("clone id : " + id );
	  
			$.ajax({
			type: 'get',
			url : '/clones/new',
			data: {id: +id, assay_id: +assay_id}
			});
		});
		
});


	
});

	
