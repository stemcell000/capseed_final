//= require jquery
//= require jquery_ujs
//= require jquery.tokeninput
//= require jquery.remotipart
//= require jquery.ui.all
//= require jquery-fileupload
//= require jquery.iframe-transport
//= require jquery_nested_form
//= require smart_listing
//= require bootstrap-sprockets
//= require bootstrap/modal
//= require bootstrap-datepicker
//= require bootstrap/bootstrap-rails-tooltip
//= require bootstrap/bootstrap-rails-popover
//= require autocomplete
//= update_assays_row_position
//= require select2
//= require multi-select
//= require moment
//= require fetch_clone_data
//= require fetch_pb_data
//= require nprogress
//= require nprogress-ajax
//= loader
//= require d3.min
//= require d3pie.min
//= require_tree .


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
