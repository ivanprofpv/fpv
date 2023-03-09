$(document).on('turbolinks:load', function(){
  $('.components').on('click', '.add-component-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var droneId = $(this).data('droneId');
    $('form#add-component-link-' + droneId).removeClass('hidden')
    $('#component_update').hide();
  })
});
