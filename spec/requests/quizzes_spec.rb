require 'rails_helper'

RSpec.describe "Quizzes", type: :request do
  describe "Test create and show quiz" do
    let(:teacher) { create(:teacher) }
    let!(:authenticate) { login_as teacher, scope: :user }

    it 'create quiz with 2 questions and show it' do
      quiz_params = { quiz: {
          name: "Quiz Test",
          difficulty: 'easy',
          questions: {
            '1': {
              name: 'Question 1?',
              answer_1: 'Question 1 Answer 1',
              answer_2: 'Question 1 Answer 2',
              answer_3: 'Question 1 Answer 3',
              answer_4: 'Question 1 Answer 4',
              correct_answer: 'Question 1 Answer 2'
            },
            '2': {
              name: 'Question 2?',
              answer_1: 'Question 2 Answer 1',
              answer_2: 'Question 2 Answer 2',
              answer_3: 'Question 2 Answer 3',
              answer_4: 'Question 2 Answer 4',
              correct_answer: 'Question 2 Answer 2'
            }
          }
        }
      }

      post quizzes_path, params: quiz_params
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(quizzes_path)
      
      get quiz_path(Quiz.last)
      quiz_body = response.body
      expect(quiz_body).to include('Quiz Test')
      expect(quiz_body).to include('Question 1?')
      expect(quiz_body).to include('Question 2?')
    end
  end
end
