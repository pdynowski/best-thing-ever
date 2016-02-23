$(document).ready(function(){

  $('header').on("click", "#login-modal-link", function(event) {
    event.preventDefault();
    $('#modal-login').css('display', 'block');
  })


  $('.close').on("click", function(event) {

    $('#modal-login').css('display', 'none');
  })

});
