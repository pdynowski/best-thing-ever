$(document).ready(function() {


   var url = $("#option1 img").attr('src');
   $("#option1").css("background-image", "url("+url+")");
   url = $("#option2 img").attr('src');
   $("#option2").css("background-image", "url("+url+")");

  Mousetrap.bind('left', function(e) {
    $(".option1-vote").trigger("click");
  });
   Mousetrap.bind('right', function(e) {
    $(".option2-vote").trigger("click");
  });
   Mousetrap.bind('down', function(e) {
    location.reload(true);
   });


});
