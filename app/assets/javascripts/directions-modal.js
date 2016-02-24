$(document).ready(function(){

  $('header').on("click", "#directions-modal-link", function(event) {
    event.preventDefault();
    $('#desktop-modal-directions').css('display', 'block');
  });


  $('.close').on("click", function(event) {

    $('#desktop-modal-directions').css('display', 'none');
    $('#mobile-modal-directions').css('display', 'none');
  });

  $('header').on("click", "#mobile-directions-modal-link", function(event) {
    event.preventDefault();
    console.log("clicky clicky")
    $('#mobile-modal-directions').css('display', 'block');
  });

});
