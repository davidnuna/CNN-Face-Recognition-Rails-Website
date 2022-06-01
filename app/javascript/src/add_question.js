$(document).on('turbolinks:load', function() {
  
  $("#add_question").on('click', function(event){
    event.preventDefault();

    const question_number = $('.new_question').length + 1;

    $.ajax({
      url: "/quizzes/add_question",
      type: 'GET',
      data: 'question_number=' + question_number,
      dataType: 'script',
      success: function(data) {
        console.log('Done');
      }
    });
  });
});