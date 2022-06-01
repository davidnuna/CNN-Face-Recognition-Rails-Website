class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]).decorate

    @quizzes = Quiz.all.joins(:results).where(results: { user: @user }).paginate(page: params[:page], per_page: 5)
    @user_scores = Result.where(user: @user).group_by(&:quiz_id).map{ |k,v| [k, v.first.score] }.to_h
    @quiz_statuses = Result.where(user: @user).group_by(&:quiz_id).map{ |k,v| [k, v.first.status] }.to_h
  end

  def index
    @users = User.order("created_at ASC").paginate(page: params[:page], per_page: 10)
  end
end
