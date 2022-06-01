class QuizzesController < ApplicationController
  before_action :load_quiz, only: [:show, :answer]

  def show
    @result = Result.find_or_create_by!(user: current_user, quiz: @quiz)
    @result.update!(status: 1) unless @result.completed?
    @questions = @quiz.questions
    if @result.completed?
      @user_answers = @result.user_answers.group_by(&:question_id).map{ |k,v| [k, v.first.given_answer] }.to_h
    end
  end
  
  def index
    @quizzes = Quiz.all.paginate(page: params[:page], per_page: 5)
    @user_scores = Result.where(user: current_user).group_by(&:quiz_id).map{ |k,v| [k, v.first.score] }.to_h
    @quiz_statuses = Result.where(user: current_user).group_by(&:quiz_id).map{ |k,v| [k, v.first.status] }.to_h
  end
  
  def new
    @quiz = Quiz.new
  end
  
  def add_question
    @question_number = params[:question_number]

    respond_to do |format|
      format.js
    end
  end
  
  def create
    params_quiz = params.require(:quiz).permit!
    redirect_to new_quiz_path, alert: 'The quiz name and difficulty must be filled in!' and return if params_quiz[:name].blank? || params_quiz[:difficulty].blank?
    redirect_to new_quiz_path, alert: 'The quiz must have at least one question!' and return if params_quiz[:questions].blank?
    params_quiz[:questions].each do |_, data|
      redirect_to new_quiz_path, alert: 'All the data regarding a question (name, answers, correct_answer) must be filled in!' and return if data[:name].blank? || data[:answer_1].blank? || data[:answer_2].blank? ||  data[:answer_3].blank? ||  data[:answer_4].blank? ||  data[:correct_answer].blank?
    end

    @quiz = Quiz.create!(created_by: current_user, name: params_quiz[:name], difficulty: params_quiz[:difficulty])
    params_quiz[:questions].each do |_, data|
      correct_answer = data["answer_#{data[:correct_answer]}"]
      Question.create!(quiz: @quiz, name: data[:name], answer_1: data[:answer_1], answer_2: data[:answer_2], answer_3: data[:answer_3], answer_4: data[:answer_4], correct_answer: correct_answer)
    end

    redirect_to quizzes_path, notice: 'Quiz created!'
  end
  
  def answer
    redirect_to quiz_path(@quiz), alert: 'All the questions must be answered!' and return if params.try(:[], :question)&.keys&.count != @quiz.questions.count

    @result = @quiz.results.find_by(user: current_user)
    params[:question].each do |question_id, answer|
      UserAnswer.find_or_create_by!(user: current_user, result: @result, question_id: question_id, given_answer: answer)
    end
    @result.update!(status: 2)
    @result.calculate_score

    redirect_to @quiz, notice: 'Quiz completed!'
  end

  private
  def load_quiz
    @quiz = Quiz.find(params[:id])
  end
end
