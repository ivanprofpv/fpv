$(document).on('turbolinks:load', function(){
  $('.galleries').on('click', '.add-gallery-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var droneId = $(this).data('droneId');
    $('form#add-gallery-link-' + droneId).removeClass('hidden')
    // $('#component_update').hide();
  })
});
