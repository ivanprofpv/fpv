$(document).on('turbolinks:load', function(){
  $('.components').on('click', '.edit-component-link', function(e) {
    e.preventDefault();
    $(this).hide();
    $('.add-component-link').hide();
    var componentId = $(this).data('componentId');
    $('form#edit-component-link-' + componentId).removeClass('hidden')
  })
});
