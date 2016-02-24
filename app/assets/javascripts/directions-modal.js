$(document).ready(function(){

  $('header').on("click", "#directions-modal-link", function(event) {
    event.preventDefault();
    $('#modal-directions').css('display', 'block');
  })


  $('.close').on("click", function(event) {

    $('#modal-directions').css('display', 'none');
  })

});
