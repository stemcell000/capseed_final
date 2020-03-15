//= require rails-ujs
//= require jquery
//= require bootstrap-datepicker
//= require bootstrap/bootstrap-rails-tooltip
//= require bootstrap/bootstrap-rails-popover
//= require bootstrap/modal
//= require jquery_nested_form
//= update_assays_row_position
//= require autocomplete
//= require assays
//= require fetch_clone_data
//= require fetch_pb_data
//= require nprogress
//= require nprogress-ajax
//= loader
//= require d3pie.min
//= require_tree .
//= require smart_listing

NProgress.configure({
  showSpinner: true,
  ease: 'ease',
  speed: 1
});

$(document).on('turbolinks:click', function() {
  NProgress.start();
});
$(document).on('turbolinks:render', function() {
  NProgress.done();
  NProgress.remove();
});

