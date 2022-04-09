$( document ).on('turbolinks:load', function() {
  $('.row .select_user').click(function () {
    $('.row .select_user').css("background-color", "white")
    $('.row .select_user h2').css("color", "#777")
    $(this).css("background-color", "#337ab7")
    $(this).find('h2').css("color", "white")
    
    $(this).find('.user_image').css("border", "2px solid white")

    let id = $(this).attr('id')
    $("#user_id").val(id)
    console.log(id)
  });
});