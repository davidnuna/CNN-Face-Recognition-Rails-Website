$( document ).on('turbolinks:load', function() {
  $('#image_method').click(function () {
    if ($(this).text() === 'Use the camera instead') {
      $(this).text('Upload a picture instead');
      $('#uploaded_image').css('display', 'none');
      $('#camera_content').show();
      $('#image_method_1').text('Please take a photo as clear as possible with you');
      $('#image_method_2').text('The photo taken should contain only contain your whole face');
      $('#login_image_method').val('camera');
    } else {
      $(this).text('Use the camera instead');
      $('#camera_content').hide();
      $('#uploaded_image').css('display', 'block');
      $('#image_method_1').text('Please upload a picture as clear as possible with you');
      $('#image_method_2').text('The picture should be a portrait and only contain your face attributes');
      $('#login_image_method').val('uploaded');
    }
  });
});