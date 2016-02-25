$(document).ready(function(){
  if($('#login').is(':visible') || $('#login').is(':hidden')) {

      $('#vote-area').on("click", function(event) {

          var cookieVal = $.cookie("cookieValue");  //grab the cookie
          if( cookieVal === null ) {   //see if it is null
              $.cookie( 'cookieValue', '0');  //set default value
              cookieVal = 0;  //set the value to zero
          };
          var cookieValue = parseInt(cookieVal,10);  //convert it to number

              cookieValue++;  //increment the value
              console.log(cookieValue);
              $.cookie("cookieValue", cookieValue); //save new value

          if (cookieValue === 98){
            $.cookie("cookieValue", null);
          }

          if (cookieValue === 2) {
            console.log(cookieValue);

              $('#modal-explain').css('display', 'block');

              event.preventDefault();
              event.stopPropagation();

              $('.close').on("click", function(event) {
                $('#modal-explain').css('display', 'none');
              });
          };
      });
  };
});
