$(document).on('page:fetch', function() {
  $('#spinner').show();
  console.log('spinner show');
});

$(document).on('page:receive', function() {
  $('#spinner').hide();
  console.log('spinner hide');
});