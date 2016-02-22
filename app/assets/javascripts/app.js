$(document).ready(function() {

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
