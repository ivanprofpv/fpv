$(document).on('turbolinks:load', function(){
  $("#password_icon").on('click', function() {
    if ($("#password").attr('type') === 'password') {
        $("#password").attr('type', 'text');
        $("#password_icon").removeClass('fa-eye');
        $("#password_icon").addClass('fa-eye-slash');
    } else {
        $("#password_icon").removeClass('fa-eye-slash');
        $("#password_icon").addClass('fa-eye');
        $("#password").attr('type', 'password');
    }
  });
  $("#confirm_password_icon").on('click', function() {
    if ($("#confirm_password").attr('type') === 'password') {
        $("#confirm_password").attr('type', 'text');
        $("#confirm_password_icon").removeClass('fa-eye');
        $("#confirm_password_icon").addClass('fa-eye-slash');
    } else {
        $("#confirm_password_icon").removeClass('fa-eye-slash');
        $("#confirm_password_icon").addClass('fa-eye');
        $("#confirm_password").attr('type', 'password');
    }
  });
});
