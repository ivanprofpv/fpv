$(document).on('turbolinks:load', function(){
  $('#comments').on('click', '.edit-comment-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var commentId = $(this).data('commentId');
    $('form#edit-comment-' + commentId).removeClass('hidden')
  })
});