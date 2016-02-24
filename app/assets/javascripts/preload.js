$(document).ready(function() {
  var option1ImageUrl = $("#option1img").text();
  var option2ImageUrl = $("#option2img").text();
  $("#option1").css("background-image", "url("+ option1ImageUrl +")");
  $("#option2").css("background-image", "url("+ option2ImageUrl +")");

  var preloadImgUrl1 = $("#preload1img").text();
  var preloadImgUrl2 = $("#preload2img").text();
  setTimeout(function(){
  $("#preload").append("<img src="+preloadImgUrl1+">");
  $("#preload").append("<img src="+preloadImgUrl2+">");
  }, 1000);

});
