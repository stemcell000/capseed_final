$ ->
	$("upload-attachment").fileupload
	add: (e, data) ->
		data.context = $("#submit-data")
		data.submit()
	console.log('submit files')