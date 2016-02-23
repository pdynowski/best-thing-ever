$(document).ready(function(){

  $('header').on("click", "#register-modal-link", function(event) {
    event.preventDefault();
    $('#modal-register').css('display', 'block');
  })


  $('.close').on("click", function(event) {

    $('#modal-register').css('display', 'none');
  })

});
