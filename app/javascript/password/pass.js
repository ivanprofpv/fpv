$(document).on('turbolinks:load', function(){
  $(".eye_icon").on('click', function() {
    if ($(".password").attr('type') === 'password') {
        $(".password").attr('type', 'text');
    } else {
        $(".password").attr('type', 'password');
    }
  });
});
