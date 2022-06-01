require 'rails_helper'

RSpec.describe Result, type: :model do
  context 'Test calculate_score method' do
    let(:student) { create(:student) }
    let(:teacher) { create(:teacher) }
    let(:quiz) { create(:quiz, user_id: teacher.id) }

    it 'calculate_score for quiz with 2 questions and with user giving correct answers to 2 questions' do
      question_1 = create(:question_1, quiz_id: quiz.id)
      question_2 = create(:question_2, quiz_id: quiz.id)
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_1.id, given_answer: 'Question 1 Answer 2')
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_2.id, given_answer: 'Question 2 Answer 4')
      
      result.calculate_score
      expect(result.reload.score).to eq(2)
    end

    it 'calculate_score for quiz with 2 questions and with user giving correct answers to 1 question' do
      question_1 = create(:question_1, quiz_id: quiz.id)
      question_2 = create(:question_2, quiz_id: quiz.id)
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_1.id, given_answer: 'Question 1 Answer Wrong')
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_2.id, given_answer: 'Question 2 Answer 4')

      result.calculate_score
      expect(result.reload.score).to eq(1)
    end

    it 'calculate_score for quiz with 2 questions and with user giving correct answers to 0 questions' do
      question_1 = create(:question_1, quiz_id: quiz.id)
      question_2 = create(:question_2, quiz_id: quiz.id)
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_1.id, given_answer: 'Question 1 Answer Wrong')
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_2.id, given_answer: 'Question 2 Answer Wrong')

      result.calculate_score
      expect(result.reload.score).to eq(0)
    end

    it 'calculate_score for quiz with 1 question and with user giving correct answers to 1 question' do
      question_1 = create(:question_1, quiz_id: quiz.id)
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_1.id, given_answer: 'Question 1 Answer 2')

      result.calculate_score
      expect(result.reload.score).to eq(1)
    end

    it 'calculate_score for quiz with 1 question and with user giving correct answers to 0 question' do
      question_1 = create(:question_1, quiz_id: quiz.id)
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)
      create(:user_answer, user_id: student.id, result_id: result.id, question_id: question_1.id, given_answer: 'Question 1 Wrong Answer')

      result.calculate_score
      expect(result.reload.score).to eq(0)
    end

    it 'calculate_score for quiz with 0 questions and with user giving correct answers to 0 questions' do
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)

      result.calculate_score
      expect(result.reload.score).to eq(0)
    end

    it 'calculate_score for quiz with 2 questions and with user not yet answering to any question' do
      create(:question_1, quiz_id: quiz.id)
      create(:question_2, quiz_id: quiz.id)
      result = create(:result, status: 2, quiz_id: quiz.id, user_id: student.id)

      result.calculate_score
      expect(result.reload.score).to eq(0)
    end
  end
end
