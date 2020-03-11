//Initialisation des champs multiselectselect (JQuery)
$(document).ready(function() {
    console.debug('JQuery-Multiselect is initialized in this DOM!');
    var assay_id = $('.panel-body').data('params-id');
    
		init();	
});

//Initialisation après le re-load d'un partial (via Ajax automatiquement)
$(document).ajaxComplete(function () {
    	var assay_id = $('.panel-body').data('params-id');
    	
    	init();
});

function init(){
	$('[id*="dual_listbox"]').multiSelect(
	);
};

function onElementSelect(){
		$('[id*="dual_listbox"]').multiSelect(
	{
  	afterSelect: function(values){
    console.log("Select value: "+values);
    i = parseInt(values);
    i=i-1;
    str = i+"_promoted";
    console.log("i= "+i);
    console.log("promoted id= "+str);
    $('[id*='+str+']').prop("checked", true);
   	
  		}
  	,
	afterDeselect: function(values){
	console.log("Select value: "+values);
	i = parseInt(values);
	i=i-1;
	str = i+"_promoted";
	console.log("i= "+i);
	console.log("promoted id= "+str);
	$('[id*='+str+']').prop("checked", false);
	}
  	}
  );
}


